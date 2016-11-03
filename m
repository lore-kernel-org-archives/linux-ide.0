From: Bram Matthys <syzop@vulnscan.org>
Subject: Re: Write performance 50% compared to Windows
Date: Thu, 03 Nov 2016 15:43:19 +0100
Message-ID: <ac45324476e1b4003ad3de993935b7ff@mail.vulnscan.org>
References: <adf65b5b8edfe0c1c99bc55a2827a68d@mail.vulnscan.org>
 <CAJVOszDeJSXgdMuA-f6=JDSL78SBSz+-uDNp2PX=VTjeNyz4Bg@mail.gmail.com>
 <0852f6ee-0535-aebe-c326-fb33edb42a13@vulnscan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vulnscan.org ([149.210.174.15]:56131 "EHLO
        mail.vulnscan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbcKCOnZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2016 10:43:25 -0400
Received: from mail.vulnscan.org ([149.210.174.15])
        by mail.vulnscan.org with esmtp (Exim 4.84_2)
        (envelope-from <syzop@vulnscan.org>)
        id 1c2JEd-0000vB-Fq
        for linux-ide@vger.kernel.org; Thu, 03 Nov 2016 15:43:21 +0100
In-Reply-To: <0852f6ee-0535-aebe-c326-fb33edb42a13@vulnscan.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Bram Matthys schreef op 2016-11-03 08:46:
> Shaun Tancheff wrote on 2-11-2016 18:50:
>> On Tue, Nov 1, 2016 at 5:37 AM, Bram Matthys <syzop@vulnscan.org
>> <mailto:syzop@vulnscan.org>> wrote:
>>
>>     Hi,
>>
>>     I have a Samsung SSD 850 EVO 4TB and under Linux I'm only 
>> getting ~240MB/s
>>     write speed. On Windows it's 490MB/s (yes, without cache).
>>     The read speed is the same on both Linux and Windows, though. 
>> Both are
>>     512MB/s.
>>
>>     Any ideas what this could be? It can't be a slow SATA link as 
>> read speed
>>     are fine. And since write performance is fine on Windows so I'm 
>> kinda
>>     stunned. Not sure how to proceed / debug this any further.
>>
>>     I'm testing with dd if=/dev/zero of=/dev/sdX bs=1M count=65536
>>     conv=fdatasync. Results are similar without the conv=fdatasync. 
>> On Windows
>>     I test with AS SSD.
>>     Prior to testing I do a ATA security erase to make sure the SSD 
>> isn't
>>     clearing any cells during the benchmark. (Previously I used 
>> blkdiscard but
>>     then realized this would only 'mark' the cells as unused so it 
>> might do
>>     the actual erasing in the background)
>>     I tested this both with a 4.4.0 and 4.8.4 Linux kernel. Another 
>> machines
>>     (different hardware) has the same results. All have a SATA III 
>> interface.
>>
>>
>> May I suggest that dd is unlikely to give you an accurate 
>> measurement of
>> throughput.
>> I would suggest using something like 'fio' instead.
>>
>> sudo fio --ioengine=sync --direct=1 --iodepth=32 --numjobs=1 
>> --rw=write \
>>   --bsrange=1M-1M --filename=/dev/sdb --runtime=1000 --name=fio
>>
>> I routinely see 500+MB/s with the 2TB SSD I have here ...
>
> Thanks Shaun for your suggestion. I tried this and unfortunately the
> results are not much better with fio:
>
> To summarize, on Linux (4.8.5):
> * fio sync:
>   * READ: 478MB/s
>   * WRITE: 118MB/s
> * fio libaio:
>   * READ: 511MB/s
>   * WRITE: 163MB/s
> * dd:
>   * READ: 526MB/s
>   * WRITE: 235MB/s

I just installed FreeBSD on the system for testing purposes and I'm
getting 444MB/s write speed. That's almost double of Linux.

root@fbsd:/dev # time dd if=/dev/zero of=/dev/ada1 bs=1M count=131072 
conv=sync
131072+0 records in
131072+0 records out
137438953472 bytes transferred in 308.931389 secs (444885041 bytes/sec)
12.941u 27.742s 5:08.93 12.1%   29+169k 0+1048576io 0pf+0w
Sorry didn't have fio on the system, but in in any case the 444MB/s is 
a minimum.
Read speed is 500MB/s by the way.

So this slow write performance issue seems Linux-specific.

Any (other) tips to get write speeds at the same level as FreeBSD or 
Windows would be highly appreciated.

Regards,

Bram



>
> On Windows (7):
> * AS SSD http://imgur.com/ygCINXF :
>   * READ: 512MB/s
>   * WRITE: 493MB/s
> * ATTO SSD (32GB data 1M/2M/4M bsize) http://imgur.com/46cbogr :
>   * READ: 560MB/s
>   * WRITE: 533MB/s
> (And a quick ATTO block size test http://imgur.com/MhuLjno )
>
> Output of the fio and dd commands are below.
>
> # fio --ioengine=sync --direct=1 --iodepth=32 --numjobs=1 --rw=read
> --bsrange=1M-1M --runtime=1000 --name=fio --filename=/dev/sda
> fio: (g=0): rw=read, bs=1M-1M/1M-1M/1M-1M, ioengine=sync, iodepth=32
> fio-2.2.10
> Starting 1 process
> Jobs: 1 (f=1): [R(1)] [100.0% done] [472.0MB/0KB/0KB /s] [472/0/0
> iops] [eta 00m:00s]
> fio: (groupid=0, jobs=1): err= 0: pid=14727: Thu Nov  3 07:40:58 2016
>   read : io=467388MB, bw=478604KB/s, iops=467, runt=1000002msec
>     clat (usec): min=1901, max=10352, avg=2136.75, stdev=147.57
>      lat (usec): min=1901, max=10353, avg=2137.03, stdev=147.59
>     clat percentiles (usec):
>      |  1.00th=[ 2024],  5.00th=[ 2064], 10.00th=[ 2064], 20.00th=[ 
> 2096],
>      | 30.00th=[ 2128], 40.00th=[ 2128], 50.00th=[ 2128], 60.00th=[ 
> 2128],
>      | 70.00th=[ 2160], 80.00th=[ 2160], 90.00th=[ 2192], 95.00th=[ 
> 2192],
>      | 99.00th=[ 2320], 99.50th=[ 2352], 99.90th=[ 3568], 99.95th=[ 
> 6624],
>      | 99.99th=[ 7776]
>     bw (KB  /s): min=286147, max=495616, per=100.00%, avg=479047.45,
> stdev=11395.42
>     lat (msec) : 2=0.23%, 4=99.68%, 10=0.09%, 20=0.01%
>   cpu          : usr=0.21%, sys=5.20%, ctx=467427, majf=0, minf=265
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%,
> >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      issued    : total=r=467388/w=0/d=0, short=r=0/w=0/d=0, 
> drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=32
>
> Run status group 0 (all jobs):
>    READ: io=467388MB, aggrb=478604KB/s, minb=478604KB/s,
> maxb=478604KB/s, mint=1000002msec, maxt=1000002msec
>
> Disk stats (read/write):
>   sda: ios=934688/0, merge=0/0, ticks=1594452/0, in_queue=1594292,
> util=95.27%
>
> # fio --ioengine=libaio --direct=1 --iodepth=32 --numjobs=1 --rw=read
> --bsrange=1M-1M --runtime=1000 --name=fio --filename=/dev/sda
> fio: (g=0): rw=read, bs=1M-1M/1M-1M/1M-1M, ioengine=libaio, 
> iodepth=32
> fio-2.2.10
> Starting 1 process
> Jobs: 1 (f=1): [R(1)] [100.0% done] [507.0MB/0KB/0KB /s] [507/0/0
> iops] [eta 00m:00s]
> fio: (groupid=0, jobs=1): err= 0: pid=14761: Thu Nov  3 07:58:01 2016
>   read : io=499290MB, bw=511241KB/s, iops=499, runt=1000062msec
>     slat (usec): min=29, max=606, avg=56.90, stdev=21.02
>     clat (msec): min=5, max=148, avg=64.03, stdev= 1.71
>      lat (msec): min=5, max=148, avg=64.09, stdev= 1.71
>     clat percentiles (msec):
>      |  1.00th=[   63],  5.00th=[   63], 10.00th=[   63], 20.00th=[   
> 64],
>      | 30.00th=[   64], 40.00th=[   64], 50.00th=[   64], 60.00th=[   
> 64],
>      | 70.00th=[   66], 80.00th=[   67], 90.00th=[   67], 95.00th=[   
> 67],
>      | 99.00th=[   67], 99.50th=[   67], 99.90th=[   76], 99.95th=[   
> 78],
>      | 99.99th=[  123]
>     bw (KB  /s): min=406738, max=521197, per=100.00%, avg=511739.76,
> stdev=11240.18
>     lat (msec) : 10=0.01%, 20=0.01%, 50=0.01%, 100=99.97%, 250=0.03%
>   cpu          : usr=0.60%, sys=3.67%, ctx=499374, majf=0, minf=538
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%,
> >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
> >=64=0.0%
>      issued    : total=r=499290/w=0/d=0, short=r=0/w=0/d=0, 
> drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=32
>
> Run status group 0 (all jobs):
>    READ: io=499290MB, aggrb=511241KB/s, minb=511241KB/s,
> maxb=511241KB/s, mint=1000062msec, maxt=1000062msec
>
> Disk stats (read/write):
>   sda: ios=514818/0, merge=0/0, ticks=32910900/0, in_queue=32911656,
> util=100.00%
>
> # time fio --ioengine=sync --direct=1 --iodepth=32 --numjobs=1
> --rw=write --bsrange=1M-1M --runtime=1000 --name=fio
> --filename=/dev/sda
> fio: (g=0): rw=write, bs=1M-1M/1M-1M/1M-1M, ioengine=sync, iodepth=32
> fio-2.2.10
> Starting 1 process
> Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/101.0MB/0KB /s] [0/101/0
> iops] [eta 00m:00s]
> fio: (groupid=0, jobs=1): err= 0: pid=14207: Wed Nov  2 20:48:09 2016
>   write: io=116047MB, bw=118831KB/s, iops=116, runt=1000006msec
>     clat (msec): min=4, max=24, avg= 8.58, stdev= 2.26
>      lat (msec): min=4, max=24, avg= 8.61, stdev= 2.26
>     clat percentiles (usec):
>      |  1.00th=[ 5024],  5.00th=[ 5152], 10.00th=[ 5280], 20.00th=[ 
> 5664],
>      | 30.00th=[ 6944], 40.00th=[ 9152], 50.00th=[ 9280], 60.00th=[ 
> 9536],
>      | 70.00th=[ 9792], 80.00th=[10048], 90.00th=[10560], 
> 95.00th=[11328],
>      | 99.00th=[14400], 99.50th=[17280], 99.90th=[19328], 
> 99.95th=[20352],
>      | 99.99th=[21120]
>     bw (KB  /s): min=91610, max=202752, per=100.00%, avg=119006.32,
> stdev=31198.56
>     lat (msec) : 10=79.69%, 20=20.24%, 50=0.06%
>   cpu          : usr=0.43%, sys=0.73%, ctx=116061, majf=0, minf=11
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%,
> >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      issued    : total=r=0/w=116047/d=0, short=r=0/w=0/d=0, 
> drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=32
>
> Run status group 0 (all jobs):
>   WRITE: io=116047MB, aggrb=118831KB/s, minb=118831KB/s,
> maxb=118831KB/s, mint=1000006msec, maxt=1000006msec
>
> Disk stats (read/write):
>   sda: ios=0/116037, merge=0/0, ticks=0/985368, in_queue=985316, 
> util=98.61%
>
> real    16m40.461s
> user    0m5.472s
> sys     0m8.992s
>
> # time fio --ioengine=libaio --direct=1 --iodepth=32 --numjobs=1
> --rw=write --bsrange=1M-1M --runtime=1000 --name=fio
> --filename=/dev/sda
> fio: (g=0): rw=write, bs=1M-1M/1M-1M/1M-1M, ioengine=libaio, 
> iodepth=32
> fio-2.2.10
> Starting 1 process
> Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/141.0MB/0KB /s] [0/141/0
> iops] [eta 00m:00s]
> fio: (groupid=0, jobs=1): err= 0: pid=14469: Wed Nov  2 21:22:17 2016
>   write: io=159168MB, bw=162952KB/s, iops=159, runt=1000219msec
>     slat (usec): min=34, max=621, avg=109.71, stdev=23.32
>     clat (msec): min=78, max=539, avg=200.98, stdev=86.51
>      lat (msec): min=78, max=539, avg=201.09, stdev=86.51
>     clat percentiles (msec):
>      |  1.00th=[   83],  5.00th=[   86], 10.00th=[   89], 20.00th=[  
> 105],
>      | 30.00th=[  176], 40.00th=[  188], 50.00th=[  200], 60.00th=[  
> 212],
>      | 70.00th=[  227], 80.00th=[  237], 90.00th=[  255], 95.00th=[  
> 408],
>      | 99.00th=[  469], 99.50th=[  482], 99.90th=[  498], 99.95th=[  
> 502],
>      | 99.99th=[  519]
>     bw (KB  /s): min=104160, max=389120, per=100.00%, avg=166894.31,
> stdev=63045.67
>     lat (msec) : 100=19.30%, 250=69.43%, 500=11.20%, 750=0.08%
>   cpu          : usr=0.97%, sys=0.83%, ctx=5748, majf=0, minf=11
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%,
> >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
> >=64=0.0%
>      issued    : total=r=0/w=159168/d=0, short=r=0/w=0/d=0, 
> drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=32
>
> Run status group 0 (all jobs):
>   WRITE: io=159168MB, aggrb=162952KB/s, minb=162952KB/s,
> maxb=162952KB/s, mint=1000219msec, maxt=1000219msec
>
> Disk stats (read/write):
>   sda: ios=0/159136, merge=0/0, ticks=0/31683824, in_queue=31685776,
> util=100.00%
>
> real    16m40.684s
> user    0m10.840s
> sys     0m9.996s
>
> # time dd if=/dev/zero of=/dev/sda bs=1M count=65536 conv=fdatasync
> 65536+0 records in
> 65536+0 records out
> 68719476736 bytes (69 GB, 64 GiB) copied, 292.338 s, 235 MB/s
>
> real    4m52.342s
> user    0m0.024s
> sys     0m38.048s
>
> # echo 3 >/proc/sys/vm/drop_caches
>
> # time dd if=/dev/sda of=/dev/null bs=1M count=65536
> 65536+0 records in
> 65536+0 records out
> 68719476736 bytes (69 GB, 64 GiB) copied, 130.537 s, 526 MB/s
>
> real    2m10.543s
> user    0m0.028s
> sys     0m28.604s
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

