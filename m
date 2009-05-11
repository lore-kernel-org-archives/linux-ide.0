From: Vassilis Virvilis <v.virvilis@biovista.com>
Subject: Re: SATA disks resets in a md setup
Date: Mon, 11 May 2009 13:24:38 +0300
Message-ID: <200905111324.38715.v.virvilis@biovista.com>
References: <200905081739.46206.v.virvilis@biovista.com> <4A053229.5010406@garzik.org>
Reply-To: v.virvilis@biovista.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a2s31.a2hosting.com ([69.39.67.40]:51331 "EHLO
	a2s31.a2hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZEKKYm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 06:24:42 -0400
In-Reply-To: <4A053229.5010406@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Saturday 09 May 2009, Jeff Garzik wrote:
> 
> For hardware details, see 
> http://ata.wiki.kernel.org/index.php/Libata_error_messages

thanks for the link

> 
> The ATA bus is the cable connection, so an ATA bus error typically means
> 
> - problem with your cable, or
> - your motherboard's SATA port, or
> - your drive's SATA port, or
> - "dirty power" supply, or
> - some other cause for cable interference
> 

Ok I changed
	M/B,
	PSU
	and cables.

Now the stress test passes only one SATA reset instead of 3 or 4 before the fatal one.


[ 1804.915319] ata1.01: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
[ 1804.915319] ata1.01: ST-ATA: DRQ=1 with device error, dev_stat 0x0
[ 1804.915319] ata1: SError: { PHYRdyChg }
[ 1804.915319] ata1.01: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/10 tag 0 pio 512 in
[ 1804.915319]          res 00/00:01:09:4f:c2/00:00:00:00:00/10 Emask 0x212 (ATA bus error)
[ 1804.915319] ata1: hard resetting link
[ 1810.279540] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1810.305230] ata1.00: configured for UDMA/133
[ 1810.314698] ata1.01: configured for UDMA/133
[ 1810.314698] ata1: EH complete
[ 1810.318713] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
[ 1810.318713] sd 0:0:0:0: [sda] Write Protect is off
[ 1810.318713] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1810.318713] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1810.322654] sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
[ 1810.326655] sd 0:0:1:0: [sdb] Write Protect is off
[ 1810.326655] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[ 1810.326655] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1810.330758] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
[ 1810.330758] sd 0:0:0:0: [sda] Write Protect is off
[ 1810.330758] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1810.330758] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1810.334656] sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
[ 1810.334656] sd 0:0:1:0: [sdb] Write Protect is off
[ 1810.334656] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[ 1810.334656] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

 Regards

   .bill
