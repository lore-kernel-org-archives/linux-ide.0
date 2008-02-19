From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Problem with ahci and a external sata disk
Date: Tue, 19 Feb 2008 16:46:39 +0100
Message-ID: <200802191646.39277.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmailhost.telefonica.net ([213.4.149.242]:40138 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751026AbYBSPwJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 10:52:09 -0500
Received: from jar.dominio (80.25.230.35) by ctsmtpout4.frontal.correo (7.2.056.6) (authenticated as jareguero$telefonica.net)
        id 47B4747A0022F9CB for linux-ide@vger.kernel.org; Tue, 19 Feb 2008 16:46:41 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

When I try to make a ext3 fs in the disk I got a lot of erros:

Disk:

Feb 18 22:10:44 jar kernel: ata4: irq_stat 0x02400000, PHY RDY changed
Feb 18 22:10:44 jar kernel: ata4: hard resetting link
Feb 18 22:10:56 jar kernel: ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 
300)
Feb 18 22:10:56 jar kernel: ata4.00: ATA-6: Seagate FreeAgent Pro, 3.AFM, max 
UDMA/133
Feb 18 22:10:56 jar kernel: ata4.00: 1465149168 sectors, multi 0: LBA48
Feb 18 22:10:56 jar kernel: ata4.00: configured for UDMA/133
Feb 18 22:10:56 jar kernel: ata4: EH complete
Feb 18 22:10:56 jar kernel: scsi 3:0:0:0: Direct-Access     ATA      Seagate 
FreeAgen 3.AF PQ: 0 ANSI: 5
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: [sdd] 1465149168 512-byte hardware 
sectors (750156 MB)
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: [sdd] Write Protect is off
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: [sdd] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: [sdd] 1465149168 512-byte hardware 
sectors (750156 MB)
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: [sdd] Write Protect is off
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: [sdd] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
Feb 18 22:10:56 jar kernel:  sdd: sdd1
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: [sdd] Attached SCSI disk
Feb 18 22:10:56 jar kernel: sd 3:0:0:0: Attached scsi generic sg4 type 0

Errors:

Feb 18 22:12:48 jar kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x2
Feb 18 22:12:48 jar kernel: ata4.00: irq_stat 0x40000001
Feb 18 22:12:48 jar kernel: ata4.00: cmd ca/00:00:65:2d:00/00:00:00:00:00/e0 
tag 0 dma 131072 out
Feb 18 22:12:48 jar kernel:          res 51/84:00:64:2e:00/00:00:00:00:00/e0 
Emask 0x10 (ATA bus error)
Feb 18 22:12:48 jar kernel: ata4.00: status: { DRDY ERR }
Feb 18 22:12:48 jar kernel: ata4.00: error: { ICRC ABRT }
Feb 18 22:12:48 jar kernel: ata4: hard resetting link

Feb 18 22:12:48 jar kernel: ata4.00: configured for UDMA/133Feb 18 22:12:48 
jar kernel: ata4: EH complete                                                       
Feb 18 22:12:48 jar kernel: sd 3:0:0:0: [sdd] 1465149168 512-byte hardware 
sectors (750156 MB)                                                                  
Feb 18 22:12:48 jar kernel: sd 3:0:0:0: [sdd] Write Protect is off              
Feb 18 22:12:48 jar kernel: sd 3:0:0:0: [sdd] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA                                             
Feb 18 22:12:49 jar kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x2                                                                           
Feb 18 22:12:49 jar kernel: ata4.00: irq_stat 0x40000001                        
Feb 18 22:12:49 jar kernel: ata4.00: cmd ca/00:00:4f:06:28/00:00:00:00:00/e0 
tag 0 dma 131072 out                                                               
Feb 18 22:12:49 jar kernel:          res 51/84:00:4e:07:28/00:00:00:00:00/e0 
Emask 0x10 (ATA bus error)
Feb 18 22:12:49 jar kernel: ata4.00: status: { DRDY ERR }
Feb 18 22:12:49 jar kernel: ata4.00: error: { ICRC ABRT }
Feb 18 22:12:49 jar kernel: ata4: hard resetting link

Feb 18 22:12:49 jar kernel: ata4.00: configured for UDMA/133
Feb 18 22:12:49 jar kernel: ata4: EH complete
Feb 18 22:12:49 jar kernel: sd 3:0:0:0: [sdd] 1465149168 512-byte hardware 
sectors (750156 MB)
Feb 18 22:12:49 jar kernel: sd 3:0:0:0: [sdd] Write Protect is off
Feb 18 22:12:49 jar kernel: sd 3:0:0:0: [sdd] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
Feb 18 22:12:50 jar kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
actio
n 0x2
Feb 18 22:12:50 jar kernel: ata4.00: irq_stat 0x40000001
Feb 18 22:12:50 jar kernel: ata4.00: cmd ca/00:00:4f:08:60/00:00:00:00:00/e0 
tag 0 dma 131072 out
Feb 18 22:12:50 jar kernel:          res 51/84:00:4e:09:60/00:00:00:00:00/e0 
Emask 0x10 (ATA bus error)
Feb 18 22:12:50 jar kernel: ata4.00: status: { DRDY ERR }
Feb 18 22:12:50 jar kernel: ata4.00: error: { ICRC ABRT }
Feb 18 22:12:50 jar kernel: ata4: hard resetting link

Jose Alberto
