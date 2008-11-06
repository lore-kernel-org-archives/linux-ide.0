From: Evgeni Golov <sargentd@die-welt.net>
Subject: Re: Odd behaviour of device in response to idleimmediate with
 unload
Date: Thu, 6 Nov 2008 12:23:34 +0100
Message-ID: <20081106112336.1D2FE1FDF7@chi.die-welt.net>
References: <871vxrzssj.fsf@denkblock.local>
	<491026AB.1090704@kernel.org>
	<20081104123211.A86321FD5A@chi.die-welt.net>
	<49108120.6000205@rtr.ca>
	<491083CC.5050508@rtr.ca>
	<49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca>
	<20081104185444.3BE721FDF7@chi.die-welt.net>
	<4910A509.1030307@rtr.ca>
	<49116811.5000109@kernel.org>
	<873ai6cmio.fsf@denkblock.local>
	<4911A8EA.8030605@kernel.org>
	<87mygeypcf.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chi.die-welt.net ([84.246.123.210]:42872 "EHLO chi.die-welt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbYKFLXm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Nov 2008 06:23:42 -0500
In-Reply-To: <87mygeypcf.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Tejun Heo <tj@kernel.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, 05 Nov 2008 19:55:44 +0100 Elias Oltmanns wrote:

> # hdparm --idle-immediate /dev/sda
> # hdparm --idle-unload /dev/sda
> # hdparm --idle-immediate /dev/sda
> # echo 1000 > /sys/block/sda/device/unload_heads
> # hdparm --idle-immediate /dev/sda

Here come my test results:

shinkupaddo# ./hdparm --idle-immediate /dev/sda

/dev/sda:
 issuing idle_immediate command
shinkupaddo# dmesg -c
ata1.00: SError: 0x0


shinkupaddo# ./hdparm --idle-unload /dev/sda

/dev/sda:
 issuing idle_immediate_unload command
shinkupaddo# dmesg -c
ata1.00: SError: 0x0


shinkupaddo# ./hdparm --idle-immediate /dev/sda

/dev/sda:
 issuing idle_immediate command
shinkupaddo# dmesg -c 
ata1.00: SError: 0x0

shinkupaddo# echo 1000 > /sys/block/sda/device/unload_heads 
shinkupaddo# dmesg -c
ata1: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xf
ata1: SError: { PHYRdyChg CommWake }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: SError: 0x0
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


shinkupaddo# ./hdparm --idle-immediate /dev/sda            

/dev/sda:
 issuing idle_immediate command
shinkupaddo# dmesg -c
ata1.00: SError: 0x0

Any additional
shinkupaddo# echo 1000 > /sys/block/sda/device/unload_heads

Gives only                                        
ata1.00: SError: 0x0


Regards
Evgeni
