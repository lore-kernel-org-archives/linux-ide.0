From: Chisato Yamauchi <cyamauch@plamo.linet.gr.jp>
Subject: PIO mode of sata_sil.c
Date: Wed, 22 Feb 2006 09:25:38 +0900 (JST)
Message-ID: <20060222.092538.74739539.cyamauch@plamo.linet.gr.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from PPPbf382.hyogo-ip.dti.ne.jp ([210.170.214.132]:7997 "EHLO
	plamo.linet.gr.jp") by vger.kernel.org with ESMTP id S1161286AbWBVAZ4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Feb 2006 19:25:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com


  Hi,

  I have a defective device, ARAID 99 2000 (RAID0 mode).  
I want to use this RAID system connected with the Sil3112A PCI
card.  However, this RAID system does not work on DMA mode.  

  So I modified the kernel code (sata_sil.c) to use the PIO 
mode as follows. However, the kernel reports `kernel NULL pointer 
dereference at virtual address 0000002c' in the dmesg.  The
screen shot is here:
  http://www.a.phys.nagoya-u.ac.jp/~cyamauch/p1030021.jpg


  Doesn't Sil3112A support PIO mode?


*** /usr/src/linux-2.4.31/drivers/scsi/sata_sil.c._orig_	Wed Jun  1 09:56:34 2005
--- /usr/src/linux-2.4.31/drivers/scsi/sata_sil.c	Wed Feb 22 08:49:03 2006
***************
*** 67,72 ****
--- 67,73 ----
  	SIL_INTR_STEERING	= (1 << 1),
  	SIL_QUIRK_MOD15WRITE	= (1 << 0),
  	SIL_QUIRK_UDMA5MAX	= (1 << 1),
+ 	SIL_QUIRK_ARAID		= (1 << 2),
  };
  
  static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
***************
*** 106,111 ****
--- 107,113 ----
  	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
  	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
  	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
+ 	{ "ASI ARAID99 2000",	SIL_QUIRK_ARAID },
  	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
  	{ }
  };
***************
*** 345,350 ****
--- 347,360 ----
  		ap->udma_mask &= ATA_UDMA5;
  		return;
  	}
+ 
+ 	if (quirks & SIL_QUIRK_ARAID) {
+ 		printk(KERN_INFO "ata%u(%u): applying ASI ARAID99 errata fix %s\n",
+ 		       ap->id, dev->devno, s);
+ 		ap->udma_mask = 0;
+ 		ap->mwdma_mask = 0;
+ 		return;
+ 	}
  }
  
  static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)


==  Chisato Yamauchi  =================================
