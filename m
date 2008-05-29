From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 22:19:22 +0100
Message-ID: <20080529221922.48c9fcb8@core>
References: <20080529161453.24735.805.stgit@core>
	<alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org>
	<483EEBE5.5030708@garzik.org>
	<20080529191920.12609c32@core>
	<alpine.LFD.1.10.0805291403030.3873@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49614 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754611AbYE2VeE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 17:34:04 -0400
In-Reply-To: <alpine.LFD.1.10.0805291403030.3873@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> 	void ata_sff_pause(struct ata_port *ap)
> 	{
> 		ata_sff_altstatus();
> 		ndelay(400);
> 	}
> 
> and again, if there is no altstatus register, that's a low-level driver 
> issue.

This takes away the ability to shoot yourself directly in the foot and
replaces it with the ability to shoot yourself in the foot in a more
abstract way. The dma_pause case still needs to check as that is the one
where you can make an actual mess but yes it certainly cleans up the
others.

(Next rev brewing ;))
