From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Sat, 03 Feb 2007 11:09:19 +0900
Message-ID: <45C3EECF.2080100@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:54741 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946219AbXBCCJZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 21:09:25 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1009165wxd
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 18:09:24 -0800 (PST)
In-Reply-To: <20070202211441.GA2933@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

(cc'ing Albert, Mark and Sergei.  Hi!)

Art Haas wrote:
> Hi. Sorry to say the CD-ROM is still not found. Full 'dmesg' output
> listed below in hopes it provides clues.

Erggghh.. I'm sorry too.  I thought I found it this time.

> ata_piix 0000:00:07.1: version 2.00ac7
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15

You have UDMA/33 PATA port.

> ata2.00: ATAPI, max MWDMA1

The initial reset and PACKET_IDENTIFY went well.

> ata2.00: revalidation failed (errno=-2)

Then, PACKET_IDENTIFY after configuring transfer mode fails with
-ENOENT.  Meaning it saw (status & (ATA_BUSY|ATA_DRQ|ATA_ERR|ATA_DF)) ==
0 in HSM_ST.

libata resets silently and tries to revalidate the device.

> ata2.00: limiting speed to PIO4
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: revalidation failed (errno=-2)
> ata2.00: limiting speed to PIO0
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: revalidation failed (errno=-2)
> ata2.00: disabled

All of those tries fail and libata gives up the device.

* Something went wrong with mode programming.  It seems pretty old
(reporting max UDMA/33).  Art, can you post the result of 'lspci -nn'?

* After mode programming, it might need some delay between clearing
ATA_BUSY and setting ATA_DRQ.  Dunno if this is possible.  Just throwing
out thoughts here.

So, PATA gurus, can you bless us with enlightenment?  :-)

-- 
tejun
