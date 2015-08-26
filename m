From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: linux: sata_nv: adma support
Date: Tue, 25 Aug 2015 22:01:27 -0600
Message-ID: <CADLC3L1hCDAySma0dtxJXjZOqzZOy0=7MmmBaxTDCJ7k7xrdbw@mail.gmail.com>
References: <201412232051.07067@pali>
	<CADLC3L2N2TcO4FR1Bqt2n=g5G+i=dv_y_OhYHA9yXg79Bb6JPg@mail.gmail.com>
	<201508012209.27974@pali>
	<CADLC3L01LMS4yTXBMj7Xke90aP=LK-HhUH9vM80_sMgLk+sg_w@mail.gmail.com>
	<55DC4F65.70402@start.ca>
	<20150825125804.GE16715@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:33998 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbHZEB2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2015 00:01:28 -0400
In-Reply-To: <20150825125804.GE16715@pali>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Mark Lord <kernel@start.ca>, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Aug 25, 2015 at 6:58 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> On Tuesday 25 August 2015 07:20:05 Mark Lord wrote:
>> On 15-08-01 09:45 PM, Robert Hancock wrote:
>> >On Sat, Aug 1, 2015 at 2:09 PM, Pali Roh=C3=A1r <pali.rohar@gmail.c=
om> wrote:
>> >>On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
>> >>>On Tue, Dec 23, 2014 at 1:51 PM, Pali Roh=C3=A1r <pali.rohar@gmai=
l.com>
>> >>>wrote:
>> >>>>Hello,
>> >>>>
>> >>>>I have nvidia nforce4 motherboard with nvidia sata controller:
>> ..
>> >>>It looks like something is trying to issue a command to disable A=
PM
>> >>>power management on the drive, and the command fails (likely beca=
use
>> >>>it doesn't support that command).
>> ..
>> >>  /sbin/hdparm -B254 $DRIVE
>> >>
>> >>And that -B254 cause above error message in dmesg log. Output from
>> >>hdparm is:
>> >>
>> >>  /dev/sda:
>> >>   setting Advanced Power Management level to 0xfe (254)
>> >>   APM_level      =3D not supported
>> ..
>> >>  $ sudo hdparm -I /dev/sda | grep -i power
>> >>             *    Power Management feature set
>>
>> That's not the same as APM ("Advanced" Power Management).
>>
>> >However, these NVIDIA SATAs are black boxes, and rather buggy ones =
at that,
>> >so it's possible there's an unknown issue there.
>>
>> I wonder if NVIDIA simply bought out the IP from Pacific Digital
>> when they went bust?  Pacific Digital invented the original "ADMA",
>> and the pdc_adma.c driver in the kernel knows all about it.
>> If the IP is pretty similar (identical?) then we could probably
>> improve things.
>>
>
> Can you check if nvidia ADMA code and that Pacific Digital ADMA code =
is
> similar or not?

The ADMA spec that Pacific Digital adapter (somewhat) implements was
documented in a standard, T13 1510D, ATA/ATAPI Host Adapters Standard.
My guess is that is where NVIDIA got the ideas for this controller
setup. I would be fairly surprised if the controller actually
contained any Pacific Digital IP, as the NVIDIA controllers are quite
different (the original ADMA spec didn't envision SATA, NCQ or 64-bit
DMA while the NVIDIA controllers support these for example).

Even if there is some shared IP, the issues with these controllers
seem to be more controller bugs than issues with how the controller is
being used. In fact, the later NVIDIA Windows drivers suspiciously
removed all references to NCQ support in the control panel, which
suggests that maybe even they gave up on it. Even if you don't use any
ADMA features at all (even when using the default Microsoft IDE driver
in Windows), the error handling is very shaky - things like disc read
errors on an optical drive connected to the controller will sometimes
hard-lock the machine.
