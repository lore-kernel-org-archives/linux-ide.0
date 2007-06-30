From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: device error via SDB FIS
Date: Sat, 30 Jun 2007 13:12:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706301311150.2608@p34.internal.lan>
References: <46868E82.8010906@dschroeder.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:44568 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213AbXF3RMU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Jun 2007 13:12:20 -0400
In-Reply-To: <46868E82.8010906@dschroeder.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Schroeder <sec@dschroeder.info>
Cc: linux-ide@vger.kernel.org

Run smart tests yet?

1. smartctl -d ata -t short /dev/sda
2. smartctl -d ata -a /dev/sda (after  few min)

also replace short with long

and then paste the output:

smartctl -d ata -a /dev/sda

There have been lots of reports on newegg concerning the HD501 DOA after 
several hours.

Justin.

On Sat, 30 Jun 2007, Daniel Schroeder wrote:

> hello list,
>
> i do not know, what this could mean, but i have never seen it before.
> System is 2.6.22-rc6, sil3132, samsung hd501lj (new hd under 10 power on 
> hours)
>
> time line:
> 1: power on (single esata enclosure)
> 2: system recognizes and configures the disk
> 3: mount disk
> 4: use disk
> 5: device error via SDB FIS
> 6: mount is still there, everything looks good except of this entry in logs
>
> <quote>
> ata3: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0x2 frozen
> ata3: (irq_stat 0x01140010, PHY RDY changed)
> ata3: soft resetting port
> ata3: SATA link down (SStatus 0 SControl 300)
> ata3: EH complete
> ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata3: (irq_stat 0x00b00090, PHY RDY changed)
> ata3: soft resetting port
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
> ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: configured for UDMA/100
> ata3: EH complete
> scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
> DPO or FUA
> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
> DPO or FUA
> sdc: sdc1
> sd 2:0:0:0: [sdc] Attached SCSI disk
> sd 2:0:0:0: Attached scsi generic sg2 type 0
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on dm-4, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> ata3.00: exception Emask 0x0 SAct 0x2ef SErr 0x0 action 0x0
> ata3.00: (irq_stat 0x00020002, device error via SDB FIS)
> ata3.00: cmd 61/28:30:17:83:68/00:00:1f:00:00/40 tag 6 cdb 0x0 data 20480 out
>        res 51/04:30:17:83:68/50:04:1f:00:00/40 Emask 0x1 (device error)
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> ata3.00: configured for UDMA/100
> ata3: EH complete
> sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
> DPO or FUA
> </quote>
>
> daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
