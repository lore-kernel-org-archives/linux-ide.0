From: "James Rose" <james.o.rose@gmail.com>
Subject: Re: sata_sil24 test support
Date: Thu, 17 Nov 2005 13:50:42 -0600 (CST)
Message-ID: <52128.137.32.101.32.1132257042.squirrel@www.stubbornroses.com>
References: <46377.137.32.101.32.1132172329.squirrel@www.stubbornroses.com>
    <437C0F2D.1000406@gmail.com>
    <200511162351.30872.james.o.rose@gmail.com>
    <437C2AD7.7030703@gmail.com>
Reply-To: "James Rose" <james.o.rose@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf39.cluster1.charter.net ([209.225.28.166]:12732 "EHLO
	mxsf39.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S964824AbVKQTup (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Nov 2005 14:50:45 -0500
Received: from mxip16a.cluster1.charter.net (mxip16a.cluster1.charter.net [209.225.28.146])
	by mxsf39.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jAHJohV8012914
	for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 14:50:43 -0500
In-Reply-To: <437C2AD7.7030703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "James O. Rose, III" <james.o.rose@gmail.com>

> James O. Rose, III wrote:
>>
>> Thanks for getting back to me on this.  I'll try to set something up
>> tomorrow.  BTW, is there any particular filesystem you'd prefer I
>> test on (at least initially)?  I've currently got ext3 compiled in,
>> but I can reconfigure to whatever.  I'll send results as I get them.
>>
>
> Thank you.  :-)  I'll be expecting to hear from you.
>
> --
> tejun
>

Results for first test (other badblock runs still going):

/dev/sdd is 100GB Hitachi Travelstar in a Rancho Technologies MiniStor 3
(Sil 3726), connected to internal SATA connector on Sil 3132

Hope this helps.  I'll continue to post results. Let me know if you need
more information, or if this is enough.

James
-------------------------------------
debian:~# time badblocks -w -t random /dev/sdd > badblocks.sdd.txt

real    106m1.969s
user    2m49.635s
sys     1m6.408s

debian:~# cat badblocks.sdd.txt
debian:~#

debian:~# fdisk -l /dev/sdd

Disk /dev/sdd: 100.0 GB, 100030242816 bytes
255 heads, 63 sectors/track, 12161 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/sdd doesn't contain a valid partition table
-------------------------------------------------------

