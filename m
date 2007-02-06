From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_promise: new EH conversion for 20619 chips
Date: Tue, 06 Feb 2007 16:19:58 -0500
Message-ID: <45C8F0FE.90201@garzik.org>
References: <200702042144.l14LisBO003772@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54638 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965514AbXBFVUA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 16:20:00 -0500
In-Reply-To: <200702042144.l14LisBO003772@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This patch updates the sata_promise driver to use new-style
> libata error handling for 20619 (TX4000) chips. sata_promise
> already uses new EH for the other chips it supports, so the
> patch is quite simple:
> 
> * remove ->phy_reset and ->eng_timeout ops from pdc_pata_ops,
>   and instead bind ->freeze, ->thaw, ->error_handler, and
>   ->post_internal_cmd to existing new EH functions
> * drop ATA_FLAG_SRST from board_20619's flags
> * remove now unused pdc_pata_phy_reset() and pdc_eng_timeout()
> * pdc_pata_cbl_detect() is now unused, but it contains a cable
>   detection procedure that I don't think is mentioned in public
>   documentation, so for now I just wrapped it with #if 0/#endif
> 
> Tested on a TX4000 with both modern working disks and old/quirky
> disks. Also used a CD-RW drive to test reading and writing CDs.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

The lack of cable detection definitely sounds like a bug...?

The standard procedure is to set ap->cbl in your 'prereset' EH hook, as 
is done in drivers/ata/pata_sil680.c.

	Jeff



