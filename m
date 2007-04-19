From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Thu, 19 Apr 2007 13:55:02 +0300 (EEST)
Message-ID: <5741.194.237.142.10.1176980102.squirrel@ncircle.nullnet.fi>
References: <200704132121.l3DLLRDb020449@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:49183 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993226AbXDSKzI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Apr 2007 06:55:08 -0400
In-Reply-To: <200704132121.l3DLLRDb020449@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org


Hi,

> My theory is that either TBG clocking (which drives the SATA interfaces)
> or SET FEATURE snooping (which adjusts internal parameters for different
> PIO/(U)DMA modes) is borked for SATAII/3Gbps. I hope to have time to
> investigate that soon. If you can limit transfer speeds to 1.5Gpbs then
> that may provide a workaround for now.

For your information, a friend of mine has the exact same SATA-card &
hard-disk combination (Promise Sata300TX4 + 2*Seagate 7200.10) with Intel
P4 & 875P chipset and gets similar error messages every once in a while
when there is above average disk I/O in the system (for example
raid-recheck).

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata4.00: cmd 25/00:00:bf:0f:87/00:04:05:00:00/e0 tag 0 cdb 0x0 data 524288 in
res 50/00:00:be:13:87/00:00:05:00:00/e0 Emask 0x1 (device error)

So at least it doesn't seem like my hard-disks or SATA-card are
faulty/broken.

Regards,
Tomi Orava


