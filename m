From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: assume no device is attached if
 both IDENTIFYs are aborted
Date: Wed, 26 Mar 2008 15:44:24 +0000
Message-ID: <20080326154424.0d523ab0@core>
References: <47E5F5D5.6050203@gmail.com>
	<47EA583C.8070501@rtr.ca>
	<47EA6128.9000006@gmail.com>
	<47EA6230.1090301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37802 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753342AbYCZQCE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2008 12:02:04 -0400
In-Reply-To: <47EA6230.1090301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, jb.faq@gmx.de, IDE/ATA development list <linux-ide@vger.kernel.org>

> > How did they work anyway?  By specifying geometry manually to the
> > driver?  I think we can do that.  We just need another cute HORKAGE.
> > ATA_HORKAGE_NO_IDENITFY and some massaging around EH to handle it.
> > Heh... That's gonna be a silly but fun project.  :-)
> ..
> 
> Geometry from CMOS, BIOS, partition table, or kernel command line.

Thats the only bit we really need - I've already got the rest of the
support code back to MFM drives sitting in my test tree waiting a finish
and polish. The actual probe code for the initial detect is quite
different anyway - you either rely on BIOS settings or you watch TRKZ and
try to restore to track zero.

The needed fake block is pretty small

        memset(buf, 0, 512);
        id[0] = 0x8000; /* ATA */  
        id[1] = d->cyls;
        id[2] = 0xC837;
        id[3] = d->heads;
        id[6] = d->sectors;
        memset(id + 10, " ", 20);
        /* FIXME: Set some kind of unique serial */
        memcpy(id + 23, "ATAHD001", 8);
        memcpy(id + 27, "ATA HD EMULATION OF MFM/RLL             ", 40);
        id[47] = 0x8000;
        id[49] = 0x30;

In fact if we had the proposed memcpy_to_sg/memcpy_from_sg type
interfaces discussed between Matthew Wilcox and Jeff in the download
microcode thread we could actually intercept IDENTIFY in the MFM driver
and fix it up there (after all we can't issue it to the
MFM/RLL controller).

Alan
