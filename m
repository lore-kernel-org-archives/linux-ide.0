From: Mark Lord <kernel@start.ca>
Subject: Re: linux: sata_nv: adma support
Date: Tue, 25 Aug 2015 07:20:05 -0400
Message-ID: <55DC4F65.70402@start.ca>
References: <201412232051.07067@pali>
 <CADLC3L2N2TcO4FR1Bqt2n=g5G+i=dv_y_OhYHA9yXg79Bb6JPg@mail.gmail.com>
 <201508012209.27974@pali>
 <CADLC3L01LMS4yTXBMj7Xke90aP=LK-HhUH9vM80_sMgLk+sg_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.start.ca ([64.140.120.243]:53060 "EHLO mail3.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbbHYL2g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Aug 2015 07:28:36 -0400
In-Reply-To: <CADLC3L01LMS4yTXBMj7Xke90aP=LK-HhUH9vM80_sMgLk+sg_w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 15-08-01 09:45 PM, Robert Hancock wrote:
> On Sat, Aug 1, 2015 at 2:09 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
>> On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
>>> On Tue, Dec 23, 2014 at 1:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail.=
com>
>>> wrote:
>>>> Hello,
>>>>
>>>> I have nvidia nforce4 motherboard with nvidia sata controller:
=2E.
>>> It looks like something is trying to issue a command to disable APM
>>> power management on the drive, and the command fails (likely becaus=
e
>>> it doesn't support that command).
=2E.
>>   /sbin/hdparm -B254 $DRIVE
>>
>> And that -B254 cause above error message in dmesg log. Output from
>> hdparm is:
>>
>>   /dev/sda:
>>    setting Advanced Power Management level to 0xfe (254)
>>    APM_level      =3D not supported
=2E.
>>   $ sudo hdparm -I /dev/sda | grep -i power
>>              *    Power Management feature set

That's not the same as APM ("Advanced" Power Management).

> However, these NVIDIA SATAs are black boxes, and rather buggy ones at=
 that,
> so it's possible there's an unknown issue there.

I wonder if NVIDIA simply bought out the IP from Pacific Digital
when they went bust?  Pacific Digital invented the original "ADMA",
and the pdc_adma.c driver in the kernel knows all about it.
If the IP is pretty similar (identical?) then we could probably
improve things.

