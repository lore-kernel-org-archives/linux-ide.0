From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata PATA todo list
Date: Thu, 11 Aug 2005 16:54:40 -0400
Message-ID: <42FBBB10.9020407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:49320 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932353AbVHKUyt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:54:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>


Since there's been some recent interest in the subject, I thought I 
would post the PATA todo list for libata.  Some of these items are from 
my memory, and some are from a list Alan was kind enough to create.  The 
items verbatim from Alan are prefixed "Alan: ".


1) Locked device/host speed

To support devices such as those in the ide/pci/generic.c list, we need 
to ensure that libata -never- attempts to change the device speed 
(ata_dev_set_xfermode should be avoided).


2) Simplex DMA

PCI IDE specification has a 'simplex' DMA bit, which should be tested. 
Simplex means that only one command can be outstanding, for BOTH port0 
and port1, at any given time.

Possibly some hosts also need Simplex DMA, but may not assert the 
standard PCI IDE Simplex DMA capability bit.  I don't know.


3) Speed change on error

Downshift device to a slower UDMA speed, and eventually from DMA->PIO, 
as errors persist.  There is no 'specified way' to do this, this is 
purely hueristic.


4) Alan:  Command filter

Alan -- explanation?

I know one line item here, at least:  Promise controllers snoop SET 
FEATURES - XFER MODE command.  We must stop command processing on ALL 
ports when this command is issued, to avoid corruption.


5) Alan:  MWDMA broken still?  is piix doc correct?


6) Alan:  some PATA LBA48 devices cannot do > 256 sectors.


7) Alan:  Some ALi requires LBA48 be done via PIO.  LBA28 DMA is OK.


8) ATAPI device CDB interrupt

Some older ATAPI devices require the OS driver to wait for an interrupt, 
after CDB is written, before command processing proceeds.


9) ATAPI devices may delay setting DRQ=1 for up to 3ms.

Make sure we honor the delay noted in IDENTIFY PACKET DEVICE word 0.


10) ATAPI DMA alignment (discussed elsewhere)

Needed even for PATA, AFAICT.



