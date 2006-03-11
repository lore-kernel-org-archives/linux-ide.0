From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 10:02:37 +0800
Message-ID: <44122FBD.9000909@tw.ibm.com>
References: <20060310013604.1acac722.pegasus@nerv.eu.org> <4411BCB6.5080108@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:49288 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751512AbWCKCDG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 21:03:06 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2B22xP1015467
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 21:02:59 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2B25pQP164670
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 19:05:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2B22w9c014684
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 19:02:59 -0700
In-Reply-To: <4411BCB6.5080108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: =?UTF-8?B?SnVyZSBQZcSNYXI=?= <pegasus@nerv.eu.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jure Pe=C4=8Dar wrote:
>=20
>>
>> I just got a gigabyte solid state disk on a test. However, it is not
>> seen by linux. The problem is described well here:
>> http://www.linuxquestions.org/questions/showthread.php?t=3D411600
>>
>> What can one do when there *is* something on the sata port but the
>> driver doesn't recognize it? It's not even in the /sys/block/ or
>> /sys/bus/scsi/ ...  If I don't have the device, I can't use sg utils
>> to ask it how it feels ...
>> I'd really want to use this ssd under linux, but I don't know how to
>> debug the problem from here.
>>
>=20
> Please set up either a vanialla kernel (preferably the latestet one,
> 2.6.16-rc5) or, if you can use git, #upstream branch of libata-dev
> repository. Before compiling the kernel, change #undef ATA_DEBUG in
> include/linux/libata.h to #define ATA_DEBUG. You might also need to
> increase the size of printk buffer size (kernel hacking -> kernel log
> buffer size).
>=20
> After booting with such kernel, please post the result of dmesg.
>=20
>=20

This pseudo SATA drive looks interesting. There is a SATA connector
on the PCI adapter. At the first glance, I thought it is a new
SATA adapter, but it is not.
(http://www6.tomshardware.com/2005/09/07/can_gigabyte/page2.html)

I am curious how it response to things like reset and IDENTIFY
DEVICE. Looking forward to Jure's dmesg.

--
Albert

