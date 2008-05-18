From: Paolo <paoletto@gmail.com>
Subject: Re: libata sata_via unusual behaviour
Date: Sun, 18 May 2008 09:07:45 +0200
Message-ID: <3bbeafe90805180007w39c9a072qe4807697136bac8@mail.gmail.com>
References: <3bbeafe90805011018o28f46794h369242ccb02b7ced@mail.gmail.com>
	 <3bbeafe90805011158n5b45283awd43a7a534ba11456@mail.gmail.com>
	 <20080501195823.79786815@core>
	 <3bbeafe90805011216l1780cf5bm9bad77a414062643@mail.gmail.com>
	 <20080501211019.21b0701d@core>
	 <3bbeafe90805170656v58ad2dc5nb6c1efcf55b8f2cf@mail.gmail.com>
	 <20080517230443.2a3eedff@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:26010 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbYERHHp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 03:07:45 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1184862waf.23
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 00:07:45 -0700 (PDT)
In-Reply-To: <20080517230443.2a3eedff@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

So, let me clarify a bit:

i did the same test in 3 different configuration:
"cat bigfile >/dev/null"

3 configuration were

1) Machine A (the slow one) from the big partition (1000gb) - got 5mb/s
2) Machine A from the small partition - got 16mb(s
3) Machine B from 300gb partition - got 28mb/s

Machine A: AthlonXP 800 -Via KT600 - SATA disk western digital -
direct ext3 filesystems (no raid-no lvm-no nothing)

Machine B: Pentium 2 350 - i440bx - seagate IDE drive - direct ext3 filesystems

I also did another test: putting a cpu intensive process  in the
background with nice -n 20. The test showed the process was not being
executed almost at all, so those %wa cpu cycles are somehow cpu cycles
since they dont let other processes execute. (in fact when i do stuff
with the disk my system became incredibly slow)

Finally  i tried the test you suggested me
root@rivendell:~# time dd if=/dev/zero of=/tmp/testfile bs=1024000 count=1000
1000+0 records in
1000+0 records out
1024000000 bytes (1,0 GB) copied, 16,9609 s, 60,4 MB/s

real    0m17.119s
user    0m0.010s
sys     0m12.890s

with a sample cpu usage of:
Cpu(s):  0.7%us, 15.0%sy,  0.0%ni, 76.1%id,  6.6%wa,  0.0%hi,  1.7%si,  0.0%st


root@rivendell:~# time dd if=/dev/zero of=/local/testfile bs=1024000 count=1000
1000+0 records in
1000+0 records out
1024000000 bytes (1,0 GB) copied, 23,3957 s, 43,8 MB/s

real    0m23.898s
user    0m0.010s
sys     0m14.090s

with a sample cpu usage of
Cpu(s):  1.3%us, 50.7%sy,  0.0%ni,  0.0%id, 45.4%wa,  0.7%hi,  2.0%si,  0.0%st


( / was the 30gb partition, /local the 900gb)




On 5/18/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> real    5m16.352s
>> user    0m0.132s
>> sys     0m6.244s
>
> So the CPU usage is ok
>
>> root@ubuntu:/media/disk/movies# ls -la Lo\ squalo.avi
>> -rw-r----- 1 1000 1001 1559521280 2008-03-30 06:37 Lo squalo.avi
>>
>> it means roughly those old 5mb/sec.
>> In the meanwhile i checked with top, and all the cpu cycles were taken
>> by the disk (about 98.0%wa and 0.0%id)
>
> 98.0%wa - wait time, not CPU time.
>
> Its still a very slow copy rate unless the disks are on the same IDE
> channel. How is the disk set up - ext3 direct or via raid/lvm ?
>
> Also is a copy of the movie to /dev/null slow or fast, ditto a copy
> from /dev/zero to disk of that sort of size ?
>
> Alan
>
