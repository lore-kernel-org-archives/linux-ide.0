From: Jens Axboe <axboe@suse.de>
Subject: Re: Problem: DMA on PIIX4 controller for LiteON 851S DVDRW Drive
Date: Mon, 14 Jun 2004 17:21:42 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040614152141.GD8694@suse.de>
References: <N1-OQ8ech2f@SAFe-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:11447 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261369AbUFNPVu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2004 11:21:50 -0400
Content-Disposition: inline
In-Reply-To: <N1-OQ8ech2f@SAFe-mail.net>
List-Id: linux-ide@vger.kernel.org
To: qdot@SAFe-mail.net
Cc: linux-ide@vger.kernel.org

On Mon, Jun 14 2004, qdot@SAFe-mail.net wrote:
> Hi
> 
> Sorry to bother you with such a question but I got into some sort of trouble with DMA settings on PIIX4 controller for LiteON 851S DVDRW Drive on Linux 2.6.6 (vanilla).
> 
> When dma has been setup (either using bios, boot parameters or hdparm) on first access to drive system ends up with:
> 
> Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: status=0x51 { DriveReady SeekCom
> plete Error }
> Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04

Looks like a hardware error (the sense indicates so), it might just not
like dma.

-- 
Jens Axboe

