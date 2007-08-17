From: Petr Vandrovec <petr@vandrovec.name>
Subject: Re: sata_sil, sil3512, and PMP?
Date: Fri, 17 Aug 2007 05:26:26 -0700
Message-ID: <46C593F2.60201@vandrovec.name>
References: <E8F452C423BB2E439AA9E397EB8A95F3038D9875@telegraph.siliconimage.com> <1187229341.46c3ae9d6f1ff@imap.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:39628 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbXHQM0b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Aug 2007 08:26:31 -0400
In-Reply-To: <1187229341.46c3ae9d6f1ff@imap.vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Eunice Chen <Eunice.Chen@siliconimage.com>

vandrove@vc.cvut.cz wrote:
> Quoting Eunice Chen <Eunice.Chen@siliconimage.com>:
> 
>> 3512/3112/3114 controllers do not support PMP. 3124/3132 controllers do.
> 
> Um...  Well, that's bad.  Can you update datasheet then?  
> 
> http://www.siliconimage.com/docs/SiI-DS-0102-D.pdf says on page 77:

Hello,
   it seems that there is some hope ;-)  It is currently in 
ugly-nasty-hack-with-screwed-exception-handling state, but it seems to 
work as advertised in documentation.

Only thing I noticed during development was that SError on 3726's port 5 
(SEMB) reports 0x04050000, and if code attempts to clear bit 26 then 
multiplier responds with status 0x00 instead of 0x50, and seems a bit 
unhappy (like returning 0xFF in all registers (including reserved device 
bits) on subsequent read from SError).  Apparently sil24 driver does not 
notice as it does not look at DRDY (and always-one) bit in PMP 
read/write responses (doc says DRDY should be 1, so I tested it, and it 
ended up in repeated resets and disabled port #5)...
								Petr

# dmesg | tail -2000 | grep ^[as]
sata_sil 0000:02:01.0: version 2.2
scsi6 : sata_sil
scsi7 : sata_sil
ata5: SATA max UDMA/100 cmd 0xffffc20002f5ec80 ctl 0xffffc20002f5ec8a 
bmdma 0xffffc20002f5ec00 irq 24
ata6: SATA max UDMA/100 cmd 0xffffc20002f5ecc0 ctl 0xffffc20002f5ecca 
bmdma 0xffffc20002f5ec08 irq 24
ata5: SATA link down (SStatus 0 SControl F0310)
ata6: SATA link down (SStatus 0 SControl F0310)
ata5: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xa frozen
ata5: hard resetting link
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl F0310)
ata5.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata5.15: SDB_NOTIFY not supported on host port, hotplug won't work on
ata5.00: hard resetting link
ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.01: hard resetting link
ata5.01: SATA link down (SStatus 0 SControl 300)
ata5.02: hard resetting link
ata5.02: SATA link down (SStatus 0 SControl 300)
ata5.03: hard resetting link
ata5.03: SATA link down (SStatus 0 SControl 300)
ata5.04: hard resetting link
ata5.04: SATA link down (SStatus 0 SControl 300)
ata5.05: hard resetting link
ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
ata5.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/100
ata5: EH complete
scsi 6:0:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
sd 6:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 6:0:0:0: [sdd] Write Protect is off
sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 6:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 6:0:0:0: [sdd] Write Protect is off
sd 6:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 6:0:0:0: [sdd] Attached SCSI disk
sd 6:0:0:0: Attached scsi generic sg4 type 0


