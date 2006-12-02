From: Wayne Sherman <Wayne@SystemDesignWorks.com>
Subject: AHCI support on Intel chipsets (confusion?)
Date: Sat, 02 Dec 2006 02:20:49 -0800
Message-ID: <45715381.80206@SystemDesignWorks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ev1s-69-57-152-63.ev1servers.net ([69.57.152.63]:59814 "EHLO
	server.monsterhosting.org") by vger.kernel.org with ESMTP
	id S1759431AbWLBKUw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Dec 2006 05:20:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff Garzik,

First of all, thank you for your work on the SATA implementation for 
Linux.  I am looking forward to using NCQ.  On that topic, I just 
purchased a motherboard thinking I could use SATA NCQ.  I partly based 
my decision on the kernel source code.  It seems to indicate the Intel 
ICH7 is AHCI compatible:

/linux-2.6.19/drivers/ata/ata_piix.c (lines  226-227):

   /* 82801GB/GR/GH (ICH7, identical to ICH6) */
   { 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },

/linux-2.6.19/drivers/ata/ahci.c (starting at line 300):

static const struct pci_device_id ahci_pci_tbl[] = {
/* Intel */
...
   { PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */

I am running Fedora Core 5 w/ kernel 2.6.18, but I didn't see any AHCI 
messages in the dmesg output that were described here:

   http://blog.kovyrin.net/2006/08/11/turn-on-ncq-on-ich-linux/

So I did some more searching and found this Intel page:

   http://www.intel.com/support/chipsets/imst/sb/CS-012304.htm

Where it says clearly:

"ICH8, ICH7 and ICH6-based chipsets, as well as ICH5 and ICH5R-based 
chipsets, do not use AHCI."

So, does the kernel source code incorrectly indicate some of these 
chipsets are AHCI compatible?

Thanks,

Wayne Sherman
System Design Works
Las Vegas

