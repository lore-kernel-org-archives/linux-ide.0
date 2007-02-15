From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_promise: new EH conversion for 20619 chips, take
 2
Date: Thu, 15 Feb 2007 18:09:40 -0500
Message-ID: <45D4E834.6000502@garzik.org>
References: <200702112219.l1BMJr88026358@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60326 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161674AbXBOXJl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 18:09:41 -0500
In-Reply-To: <200702112219.l1BMJr88026358@harpo.it.uu.se>
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
> 
> Tested on a TX4000 with both modern working disks and old/quirky
> disks. Also used a CD-RW drive to test reading and writing CDs.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> ---
> 
> Changes since first version: pdc_pata_cbl_detect() is not removed
> since it's now called from pdc_error_handler() via pdc_pre_reset().
> 
>  drivers/ata/sata_promise.c |   55 +++------------------------------------------
>  1 files changed, 4 insertions(+), 51 deletions(-)

applied


