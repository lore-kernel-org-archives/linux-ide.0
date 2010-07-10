From: =?ISO-8859-1?Q?T=F6r=F6k_Edvin?= <edwintorok@gmail.com>
Subject: Re: ata: failed to IDENTIFY / SRST failed (errno = -16) problems
	on/after booting 2.6.35-rc3
Date: Sat, 10 Jul 2010 12:58:09 +0300
Message-ID: <AANLkTinqjTdICdUoY2Qin6w14UxfOxl6dhOcZbnNhmoA@mail.gmail.com>
References: <20100627232347.2f1dc4fd@debian>
	<20100705224627.3a158e8c@debian>
	<4C326FE1.2020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45049 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab0GJJ6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jul 2010 05:58:12 -0400
In-Reply-To: <4C326FE1.2020005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

2010/7/6 Robert Hancock <hancockrwd@gmail.com>:
>> Also I noticed that the BIOS sometimes hanged during boot (probably
>> trying to establish a link to the CDROM too), resetting it a couple of
>> times allowed it to reach Linux, but then Linux hanged.
>> It could be a hardware failure of the CDROM that just happened to occur
>> after I installed 2.6.35-rc3, I don't know.
>
> It does sound like a hardware problem, yes, from those symptoms.

So from the 2 CDROM drives this one works:
ata9.00: ATAPI: ASUS CRW-5232AS, 1.01, max UDMA/33

If I plug in just the other CDROM drive (on same cable/power
connector, and unplug the working CDROM) then it hangs in the BIOS
"Detecting IDE drives....". Looks like faulty hardware.

If I have both CDROMs plugged in (on same data cable, order doesn't
seem to matter) then it hangs in the  BIOS for a while.
It eventually boots Linux, at which point I get those SRST failed
messages, and at some point it brings up the link to both CDROMs
(after 76 seconds for example):
ata9.00: ATAPI: ASUS CRW-5232AS, 1.0.1, max UDMA/33
ata9.01: ATAPI: SAMSUNG CD-ROM SH-152A, C503, max UDMA/33

In this case load average starts to climb (2.39 already) for a while,
I'll reply with more details in the other thread about that.

So this is not a regression, or a bug in Linux, it is just faulty
hardware and Linux retrying multiple times  when it fails.

Best regards,
--Edwin
