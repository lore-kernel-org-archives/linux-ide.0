From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: SATA driver sata_sil24
Date: Fri, 23 Apr 2010 23:16:13 -0500
Message-ID: <4BD2708D.5050408@hardwarefreak.com>
References: <20100422083226.GA6018@crow.mawsonit.co.uk>	 <4BD0203C.7010903@gmail.com>	 <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com>	 <20100422223309.GA1883@crow.mawsonit.co.uk>	 <4BD1129E.6030104@gmail.com>	 <20100423203446.GF1883@crow.mawsonit.co.uk> <y2i51f3faa71004231734hbcda3ad5p61798db712cc87c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:51705 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0DXEQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Apr 2010 00:16:15 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 5BC496C359
	for <linux-ide@vger.kernel.org>; Fri, 23 Apr 2010 23:16:14 -0500 (CDT)
In-Reply-To: <y2i51f3faa71004231734hbcda3ad5p61798db712cc87c5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

My reply-list plugin sometimes has problems.  Apologies for the double hit
to your inbox Robert.

Robert Hancock put forth on 4/23/2010 7:34 PM:
> On Fri, Apr 23, 2010 at 2:34 PM, Richard Mawson
> <richard@crow.mawsonit.co.uk> wrote:

>> .. but as this is clearly later on from the previously mentioned stack, I'm
>> starting to suspect that this is failing in random places when talking across
>> this pci-pcie bridge. Do you agree that this sounds plausible?
> 
> I suspect it's something like that - not sure what else could cause
> things to explode at that point..

Hay Richard, if you've not already, try booting with the eSATA cable _not_
connected to the HBA and see if that prevents the lock up.  If it boots,
make sure both the server and disk box PSUs are both plugged into the same
AC circuit, preferably the same UPS, and that all equipment shares the same
earth ground, and give it another go.  Having equipment like this on
different earth ground paths can cause issues like what you're seeing due to
voltage differences on the eSATA wire.  Or, at least, this used to occur on
occasion with external SCSI array boxen, so I'm guessing eSATA isn't immune
given the interconnect is copper, not fiber.

Replace the eSATA cable with a "known good" cable if you haven't already.
Just helping you dot all the Ts and cross all the Is.  I know I've
overlooked small "simple" stuff on at least more than one occasion--happens
to all of us at one point or another.

Would you mind supplying the specific branded server or mobo model # so I
can do some research on possible board and/or chipset errata, known bad
card/slot combinations, etc?

-- 
Stan
