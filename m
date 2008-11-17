From: Evgeni Golov <sargentd@die-welt.net>
Subject: Re: Odd behaviour of device in response to idleimmediate with
 unload
Date: Mon, 17 Nov 2008 08:48:24 +0100
Message-ID: <20081117074825.322BE1FD5F@chi.die-welt.net>
References: <491083CC.5050508@rtr.ca>
	<49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca>
	<20081104185444.3BE721FDF7@chi.die-welt.net>
	<4910A509.1030307@rtr.ca>
	<49116811.5000109@kernel.org>
	<873ai6cmio.fsf@denkblock.local>
	<4911A8EA.8030605@kernel.org>
	<87k5bhxerq.fsf@denkblock.local>
	<4913BF3D.3090704@kernel.org>
	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>
	<4917F822.5060204@kernel.org>
	<20081110102607.094281FD7C@chi.die-welt.net>
	<87r65ju83r.fsf@denkblock.local>
	<20081113113345.12E2D1FD80@chi.die-welt.net>
	<491FEA3C.4090906@kernel.org>
	<20081117071552.D25291FD5F@chi.die-welt.net>
	<49211B1F.7040900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chi.die-welt.net ([84.246.123.210]:55416 "EHLO chi.die-welt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbYKQHs2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Nov 2008 02:48:28 -0500
In-Reply-To: <49211B1F.7040900@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Elias Oltmanns <eo@nebensachen.de>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, 17 Nov 2008 16:19:59 +0900 Tejun Heo wrote:

> Evgeni Golov wrote:
> > On Sun, 16 Nov 2008 18:39:08 +0900 Tejun Heo wrote:
> > 
> >> So, this comes before actually issuing the park.  It sounds like it has
> >> nothing to do with park command itself.  If you do "echo - - - >
> >> /sys/class/scsi_host/host0/scan" right after boot, what does the kernel say?
> > 
> > # echo - - - > /sys/class/scsi_host/host0/scan
> > echo: write error: invalid argument
> 
> Eh... strange.  It works perfectly fine here.  Can you play with quoting
> and -n?

Heh, did try -n but no quoting, damn - :)
Get the same reset too:

shinkupaddo# dmesg
ata1: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xf
ata1: SError: { PHYRdyChg CommWake }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
ata1.00: configured for UDMA/100
ata1.00: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors: (100 GB/93.1 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors: (100 GB/93.1 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Btw, unload heads isn't even enabled at the moment...

Regards
