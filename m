From: Jeff Garzik <jgarzik@pobox.com>
Subject: PATA drivers in libata?
Date: Sun, 13 Feb 2005 13:51:37 -0500
Message-ID: <420FA1B9.6030100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49552 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261292AbVBMSv6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Feb 2005 13:51:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>


I wanted to open a discussion on libata and PATA.

libata-dev now has two drivers that support PATA, pata_pdc2027x and 
ata_piix, and the core is getting close (DMA blacklist in, C/H/S support 
close).

What are the opinions on issues relating to making PATA libata support 
available in the upstream kernel?  Here's my random list.

* I think CONFIG_IDE should continue to be the default answer for "what 
driver do I use for PATA?"

* Should there be a config option similar to CONFIG_BLK_DEV_IDE_SATA, 
called CONFIG_SCSI_ATA_PATA?  A runtime 'pata' module option?  Should we 
include 'DANGER DANGER conflicts with CONFIG_IDE' in the Kconfig 
description?

* With ATA passthru (in libata-dev currently), libata supports SMART and 
the HDIO_CMD/HDIO_TASK generalized ioctls.  Should I care about 
supporting other ioctls?

* pci_enable_device() issues?

* power management differences?

