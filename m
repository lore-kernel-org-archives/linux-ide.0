From: Paolo <paoletto@gmail.com>
Subject: Re: libata sata_via unusual behaviour
Date: Sat, 17 May 2008 15:56:57 +0200
Message-ID: <3bbeafe90805170656v58ad2dc5nb6c1efcf55b8f2cf@mail.gmail.com>
References: <3bbeafe90805011018o28f46794h369242ccb02b7ced@mail.gmail.com>
	 <3bbeafe90805011158n5b45283awd43a7a534ba11456@mail.gmail.com>
	 <20080501195823.79786815@core>
	 <3bbeafe90805011216l1780cf5bm9bad77a414062643@mail.gmail.com>
	 <20080501211019.21b0701d@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:36990 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbYEQN46 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 09:56:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so817704waf.23
        for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 06:56:57 -0700 (PDT)
In-Reply-To: <20080501211019.21b0701d@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Alan, hi all

so far, i did some more tests.

First of all, i'm using ext3 filesystem (and it might happen it's very
slow, according with my tests results)

What i did:

Trying ubuntu Hardy LiveCD (to check it's not because
1) im using a hand made compiled kernel
2) i might have removed some package which is actually needed for disk
performances
3) the upgrade screwed something )

So far, from LiveCD i did the same i did before, that is:

root@ubuntu:/media/disk/movies# time cat Lo\ squalo.avi >/dev/null

real    5m16.352s
user    0m0.132s
sys     0m6.244s
root@ubuntu:/media/disk/movies# ls -la Lo\ squalo.avi
-rw-r----- 1 1000 1001 1559521280 2008-03-30 06:37 Lo squalo.avi

it means roughly those old 5mb/sec.
In the meanwhile i checked with top, and all the cpu cycles were taken
by the disk (about 98.0%wa and 0.0%id)

ok so not my fault. Maybe ext3? my volumes looks like:
root@rivendell:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1             28834716  17088924  10281068  63% /
[...]
/dev/sda3            931618688 613099244 314519444  67% /local

So i got a 30gb partition, and a 900gb partition (roughly).

I tried to copy the file into the smaller partition ( into / )
and:

root@rivendell:/# time cp -rf /local/movies/Lo\ squalo.avi /

real    6m21.978s
user    0m0.150s
sys     0m18.170s
root@rivendell:/# time cat /Lo\ squalo.avi >/dev/null

real    1m33.913s
user    0m0.150s
sys     0m5.370s
root@rivendell:/# time cat /local/movies/Lo\ squalo.avi >/dev/null

real    6m13.549s
user    0m0.230s
sys     0m5.930s

During this tests, the first and the last command still showed like 98.0%wa
while with the second, (reading the file from the / fs) i had about
50-60%wa and some idle cycles (about 20% or so, sometimes 0% but not
always) with about 16mb/sec transfer rate (which is still slow, to
me.. again, hdparm -tT shows:
root@rivendell:/# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   476 MB in  2.00 seconds = 237.68 MB/sec
 Timing buffered disk reads:  220 MB in  3.02 seconds =  72.80 MB/sec )

This test shows to me that it might be a filesystem issue, but still,
is it possible it's so expensive? i mean, even from a 30gb partition
(which is the norm) reading operations take almost all the cpu power
(even if it's finally faster).
Ok, my cpu is not lighting fast (AthlonXP 800mhz) but i had almost
better performances on a pentiumII 350mhz and 320gb IDE hard drive
(debian testing on ext3).

do you have any clue about what could i do to improve fs performances?
Thank you in advance and excuse me for the boring mail!
Paolo

On 5/1/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 1 May 2008 21:16:24 +0200
> Paolo <paoletto@gmail.com> wrote:
>
>> Umh..
>>
>> Thank you for your answer!
>> Actually, i think the same. Hdparm tests shows good results.
>
> hdparm results mean the disk setup is ok
>
>> what i dont get is why the cpu load raise to keep idle to 0% like if
>> it was pio mode, even if it is in udma6..
>> What else could be, other than the libata layer not setted in dma
>> (which is not)?
>
> Anything above the disk driver layer - file system, block queue setup
> or something happening which causes a lot of I/O in small chunks (which
> ruins a disks performance). This is usually distro level stuff so best
> analysed by the distribution people.
>
>> ps: no, im not using LVM. But ubuntu is using their uuid stuff in
>> fstab to boot which i quite dont know at all..
>> maybe that?
>
> No that wouldn't explain it at all. The uuid/fstab stuff is just boot
> time stuff so doesn't get in the way.
>
> What file system are you using ?
>
