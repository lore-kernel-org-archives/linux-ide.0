From: qdot@SAFe-mail.net
Subject: Re: Problem: DMA on PIIX4 controller for LiteON 851S DVDRW Drive
Date: Mon, 14 Jun 2004 12:13:46 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <N1-QP6XU55g@SAFe-mail.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tapuz.safe-mail.net ([212.68.149.115]:63972 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S263169AbUFNQNs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 12:13:48 -0400
List-Id: linux-ide@vger.kernel.org
To: axboe@suse.de
Cc: linux-ide@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
> On Mon, Jun 14 2004, qdot@SAFe-mail.net wrote:
> > Hi
> > 
> > Sorry to bother you with such a question but I got into some sort of trouble with DMA settings on PIIX4 controller for LiteON 851S DVDRW Drive on Linux 2.6.6 (vanilla).
> > 
> > When dma has been setup (either using bios, boot parameters or hdparm) on first access to drive system ends up with:
> > 
> > Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: status=0x51 { DriveReady SeekCom
> > plete Error }
> > Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04
> 
> Looks like a hardware error (the sense indicates so), it might just not
> like dma.

Rather not hardware error. Works slowly, but reliably without DMA. Works with DMA on other controllers well. Works on usb-storage enclosure. 

Tomasz Mloduchowski

