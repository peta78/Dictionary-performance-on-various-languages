from os import listdir, cpu_count
from os.path import isfile, join
from datetime import datetime, date, timedelta
import platform

def procdt(inp):
    inp = inp.replace('\n','')
    p = inp.index('.')
    inp = inp[:p+4]

    ret = datetime.strptime(inp, "%Y-%m-%d %H:%M:%S.%f")

    return ret

def process(fn):
    f = open(fn, 'rt')
    lines = f.readlines()
    f.close()
    ret = []
    ret2 = []

    ret.append(fn.replace('.perf',''))
    ret2.append(fn.replace('.perf',''))

    for i in range(len(lines)-1):
        tmp = (procdt(lines[i+1])-procdt(lines[i])).total_seconds()
        ret.append(tmp)

    ret2.append(procdt(lines[0]))
    ret2.append(procdt(lines[-1]))

    return ret, ret2

def readusage():
    t = []
    c = []
    m = []

    f = open('usage.txt')
    lines = f.readlines()
    f.close()

    for l in lines:
        tmp = l.split(',')
        t.append(procdt(tmp[0]))
        c.append(float(tmp[1]))
        m.append(float(tmp[2]))

    return t, c, m

def pickmedian(x):
    x = sorted(x, key=lambda x: x[0])

    return x[len(x)//2]

def get_name():
    return "arch most likely"

def get_version():
    info = distro.os_release_info()
    version = ''
    try:
        version = info['version']
    except:
        pass

    return version

def distroname():
    return '{} {}\n{}'.format(geturl(get_name(), 'operating system'), get_version(), platform.platform())
    
def getLangVer(lang):
    ret = ''
    try:
        f = open(lang + '.version')
        ret = f.readline().strip().replace('\n','')
        if len(ret)==0:
            ret = f.readline().strip().replace('\n','')        
        f.close()
    except:
        pass

    retnoletters = ''

    for l in ret:
        if not((l>='a' and l<='z') or (l>='A' and l<='Z')):
            retnoletters += l
    
    return retnoletters

today = date.today()
dicAll = {}
round = 0
while True:
    round += 1
    perffiles = [f for f in listdir('./') if isfile(join('./', f)) and f.endswith('.perf' + str(round))]
    if len(perffiles) == 0:
        break

    stats = []
    dic = {}
    times = []

    for fn in perffiles:
        try:
            ret, ret2 = process(fn)

            print(ret2)

            stats.append(ret)
            dic[ret2[0]] = [ret2[1], ret2[2]]
            times.append(ret2[1])
            times.append(ret2[2])
        except:
            pass


    stats = sorted(stats, key=lambda x: sum(x[1:]))

    t, c, m = readusage()
    x = []
    for s in stats:
        aa = 0.0
        ac = 0.0
        am = 0.0
        for i in range(len(t)):
            if t[i] >= dic[s[0]][0] and t[i] <= dic[s[0]][1]:
                aa += 1.0
                ac += c[i]
                am += m[i]
        x.append([s[0], sum(s[1:])/5.0 * ac/aa / (100.0 / cpu_count()), sum(s[1:])/5.0, ac/aa, am/aa])
        if s[0][:-1] not in dicAll:
            dicAll[s[0][:-1]] = []
        dicAll[s[0][:-1]].append([sum(s[1:])/5.0 * ac/aa / (100.0 / cpu_count()), sum(s[1:])/5.0, ac/aa, am/aa])

    print(x)

results = []
for d in dicAll:
    results.append([d, pickmedian(dicAll[d])])

final = []
ff = []
for r in results:
    final.append([r[0], r[1][0], r[1][1], r[1][2], r[1][3]])

    print('***', r[0], r[1][0])

    ff.append([r[0] +'\n' + getLangVer(r[0])[:12], r[1][0]])

final = sorted(final, key=lambda s: s[1])

ff = sorted(ff, key=lambda s: s[1])
x = []
x.append(['Language', 'Version', 'Adjusted time based on CPU usage (seconds)', 'Average time (seconds)', 'Average CPU usage[^1] (%)', 'Average memory usage[^1] (%)'])
for f in final:
    x.append([f[0], getLangVer(f[0]),"{:.3f}".format(f[1]), "{:.3f}".format(f[2]), "{:.3f}".format(f[3]), "{:.3f}".format(f[4])])
yy = 'Lower is better - on {} on {}:\n'.format("arch most likely", today.strftime("%Y-%m-%d"))
print(yy)

f = open("./results_os/{}.txt".format(get_name()), "wt")
for xx in x:
    print(xx)
    f.write(str(xx))
    f.write('\n')
f.close()
