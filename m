From: Marc Bevand <mb@opensc.org>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Tue, 6 Sep 2005 11:36:59 +0200
Message-ID: <20050906093659.GB14270@est.epita.fr>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org> <20050906011254.GA23144@est.epita.fr> <20050906015428.GA13521@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.255.125]:16133 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S964778AbVIFJhW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Sep 2005 05:37:22 -0400
Content-Disposition: inline
In-Reply-To: <20050906015428.GA13521@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello Tejun,

Tejun Heo wrote:
|  I'll backport new sil24 to sil24-original tree so that we can
| eliminate all other factors and compare two drivers again to find the
| offending difference.  I'm currently in the middle of something so it
| may take me a day or so.

Ok.

By the way, I tried a 32-bit kernel (libata-dev.git current, ALL branch).
Here is what it gives (dmesg hand-recopied [2]):

  ata1: SATA max UDMA/100 cmd 0xF8820000 ctl 0x0 bmdma 0x0 irq 169
  ata2: SATA max UDMA/100 cmd 0xF8822000 ctl 0x0 bmdma 0x0 irq 169
  ata3: SATA max UDMA/100 cmd 0xF8824000 ctl 0x0 bmdma 0x0 irq 169
  ata4: SATA max UDMA/100 cmd 0xF8826000 ctl 0x0 bmdma 0x0 irq 169
  ata1: no device found (phy stat 00000000)
  scsi0 : sata_sil24
  ata2: no device found (phy stat 00000000)
  scsi1 : sata_sil24
  ata3: dev 0 not supported, ignoring
  scsi2 : sata_sil24
  ata4: dev 0 not supported, ignoring
  scsi3 : sata_sil24

The disks are still not recognized. But the line [1] that usually displays
the most important words of the IDENTIFY DEVICE reply is not present. This
is interesting because it is probably a clue that an early error is occuring
somewhere before the IDENTIFY DEVICE reply is received. I immediately did
another test with ATA_DEBUG enabled (dmesg still hand-recopied [2]):

  ata_device_add: ata1: probe begin
  ata1: no device found (phy stat 00000000)
  ata_device_add: ata1: probe end
  scsi0 : sata_sil24
  ata_device_add: ata2: probe begin
  ata2: no device found (phy stat 00000000)
  ata_device_add: ata2: probe end
  scsi1 : sata_sil24
  ata_device_add: ata3: probe begin
  ata_dev_identify: ENTER, host 3, dev 0
  ata_dev_identify: do ATA identify
  ata_sg_setup_one: mapped buffer of 512 bytes for read
  ata_sg_clean: unmapping 1 sg elements
  ata3: dev 0 not supported, ignoring
  ata_dev_identify: EXIT, err
  ata_dev_identify: ENTER/EXIT (host 3, dev 1) -- nodev
  ata_device_add: ata3: probe end
  scsi2 : sata_sil24
  [...
    skipped the part for ata4 (similar to ata3)
  ...]
  ata_device_add: probe begin
  ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,1,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,2,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,3,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,4,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,5,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,6,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,7,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,8,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,9,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,10,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,11,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,12,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,13,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,14,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:0,15,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,0,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,1,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,2,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,3,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,4,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,5,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,6,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,7,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,8,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,9,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,10,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,11,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,12,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,13,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,14,0) 12 00 00 00 24 00 00 00 00
  ata_scsi_dump_cdb: CDB (1:1,15,0) 12 00 00 00 24 00 00 00 00
  [...
    then the above block composed of 32 "CDB" lines was basically
    replicated 3 more times like:
    ata_scsi_dump_cdb: CDB (2:x,y,z) 12 00 00 00 24 00 00 00 00
    ...
    ata_scsi_dump_cdb: CDB (3:x,y,z) 12 00 00 00 24 00 00 00 00
    ...
    ata_scsi_dump_cdb: CDB (4:x,y,z) 12 00 00 00 24 00 00 00 00
    ...
    I paid attention to the "12 00 00 00 24 00 00 00 00" bytes,
    they never change
  ...]

I lack the knowledge to fully interpret this dmesg correctly, but at least
I know I need to direct my investigations toward ata_dev_identify(). That
is what is on my TODO list for tomorrow...

[1] ataX: dev Y cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 [...]
[2] Yes I know, next time I will use a serial console

-- 
 Marc Bevand                              http://epita.fr/~bevand_m
 Computer Science School EPITA - System, Network and Security Dept.
