From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ata: add missing ATA_ID_* defines (take 2)
Date: Thu, 24 Jul 2008 20:53:37 +0200
Message-ID: <200807242053.38082.bzolnier@gmail.com>
References: <200807222249.32242.bzolnier@gmail.com> <48879938.8010803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:16705 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbYGXTOc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 15:14:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1150115nfc.21
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 12:14:30 -0700 (PDT)
In-Reply-To: <48879938.8010803@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 23 July 2008, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Add missing ATA_ID_* defines and update {ata,atapi}_*()
> > inlines accordingly.  The currently unused defines are
> > needed for the forthcoming drivers/ide/ changes.
> > 
> > v2:
> > Add ATA_ID_SPG.
> > 
> > Cc: Jeff Garzik <jgarzik@pobox.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > v2 was needed because one define got lost :/
> > 
> >  include/linux/ata.h |  122 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 76 insertions(+), 46 deletions(-)
> 
> ACK, and I'll send this one upstream myself.  It shouldn't conflict with 
> the patches just ACK'd.

OK.
