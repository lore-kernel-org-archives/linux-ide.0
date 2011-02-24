From: Sylvain LEVEQUE <kag@laposte.net>
Subject: Re: Performance issue with SATA port multiplier
Date: Thu, 24 Feb 2011 17:30:54 +0100
Message-ID: <AANLkTikhAYkuhPWBfuSJquzWjLPETTgAnRMohSUq2orC@mail.gmail.com>
References: <AANLkTimWhSbb8i1qPUCiZhGjQpdx1kWG_wyE3-hVScY+@mail.gmail.com> <20110224152152.GR7840@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51926 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab1BXQbP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 11:31:15 -0500
Received: by wwb39 with SMTP id 39so957342wwb.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2011 08:31:14 -0800 (PST)
In-Reply-To: <20110224152152.GR7840@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, justin@jmicron.com

Hello

2011/2/24 Tejun Heo <tj@kernel.org>:
>
> (cc'ing Justin)
>
> Hello,
>
> On Thu, Feb 24, 2011 at 03:32:50PM +0100, Sylvain LEVEQUE wrote:
>> I own a Venus T5C mini box based on a JMicron JM393 controller, used
>> in pure port multiplier mode (no JBOD, no RAID). It is plugged in
>> eSATA to a QNAP TS-119 NAS which runs a 2.6.37 kernel on a Marvell
>> Kirkwood 88F6281.
>>
>> When I first started copying data on any disk of the external box, I
>> realized the write speed was low (read speed is OK). Testing with dd
>> and various block sizes shows that the larger the block size, the
>> higher the throughput is. On my NAS, I determined the work buffer si=
ze
>> of the cp command to be approximately 8KB.
>>
>> With a 8KB blocksize, when writing a 16MB file with dd on one of the
>> disks, I average at 6,5 MB/s write speed. It is already a great
>> improvement compared to the 393 KB/s write speed I obtained on a
>> 2.6.36 kernel, but it is low compared to results I obtain with highe=
r
>> blocksizes (52,4 MB/s with 4MB blocksize) or using other hardware
>> (laptop with Intel ICH9M-E/M controller reaches 286 MB/s with 8KB
>> blocksize using a 2.6.31 kernel).
>>
>> When I take one of the disks out and connect it in eSATA with a basi=
c
>> external case, I reach 37,6 MB/s with 8KB blocksize. This result is
>> pretty constant whatever the blocksize value I tested (from 1KB to
>> 16MB, doubling each time).
>
> Sounds like a latency related issue. =C2=A0Is NCQ being used?

I actually already tried disabling it but I didn't see much change so
moved on to other tests.

This is what I get for the three drives:
$ cat /sys/block/sd[c-e]/device/queue_depth
1
31
31

$ ls -l /dev/disk/by-label/
lrwxrwxrwx 1 root root 10 2011-02-21 20:36 NASBACKUP -> ../../sdc1
lrwxrwxrwx 1 root root 10 2011-02-21 20:36 HDD2_SAMSUNG640 -> ../../sdd=
1
lrwxrwxrwx 1 root root 10 2011-02-21 20:36 HDD4_SAMSUNG640 -> ../../sde=
1

$ dd if=3Dtestfile of=3D/media/NASBACKUP/testfile bs=3D8K
2048+0 records in
2048+0 records out
16777216 bytes (17 MB) copied, 7,34586 s, 2,3 MB/s

$ dd if=3Dtestfile of=3D/media/HDD2_SAMSUNG640/testfile bs=3D8K
2048+0 records in
2048+0 records out
16777216 bytes (17 MB) copied, 2,77398 s, 6,0 MB/s

$ dd if=3Dtestfile of=3D/media/HDD4_SAMSUNG640/testfile bs=3D8K
2048+0 records in
2048+0 records out
16777216 bytes (17 MB) copied, 2,62296 s, 6,4 MB/s

Read throughput is ca 30MB/s for all disks.

Now, without NCQ:

# echo 1 > /sys/block/sdd/device/queue_depth
# echo 1 > /sys/block/sde/device/queue_depth
$ cat /sys/block/sd[c-e]/device/queue_depth
1
1
1

$ dd if=3Dtestfile of=3D/media/HDD2_SAMSUNG640/testfile bs=3D8K
2048+0 records in
2048+0 records out
16777216 bytes (17 MB) copied, 2,31012 s, 7,3 MB/s

I confirm the observed improvement on the second disk as well.

Thanks
--=20
Sylvain
