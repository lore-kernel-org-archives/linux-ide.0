From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI UDMA - first in Linux
Date: Fri, 14 May 2004 16:35:53 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A52DA9.6040200@pobox.com>
References: <1084563800.8752.53.camel@patibmrh9><40A52683.8050604@pobox.com> <1084565990.3084.36.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262766AbUENUgF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 16:36:05 -0400
In-Reply-To: <1084565990.3084.36.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> Perhaps I should blame my Silicon Image 3611CT80 1.4 bridge, and buy
> another?

This is very possible.

Silicon Image has introduced an addition to ATA called the "DMADIR" bit. 
  Their bridges require this bit in order to use DMA.

If your OS driver does not know about DMADIR (read: most OS drivers), 
then it will fall back _unconditionally_ to PIO.

Try a Marvell bridge, maybe.


> Do we all agree SATA ATAPI UDMA is missing from Linux-2.6.6 `make
> defconfig`?

No.  No need for new options, if you are using the IDE driver.

Once libata ATAPI support is working, it can simply be turned on.  No 
need for a config option there, either.


> Can any of us suggest other .config options to try?

CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y


# CONFIG_SCSI_SATA is not set


