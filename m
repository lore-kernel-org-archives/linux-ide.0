From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/15] ide: make ide_hwif_t.ide_dma_host_on void
Date: Tue, 20 Feb 2007 00:21:07 +0100
Message-ID: <200702200021.07419.bzolnier@gmail.com>
References: <20070203135301.2546.54884.sendpatchset@localhost.localdomain> <20070203135307.2546.94874.sendpatchset@localhost.localdomain> <20070219222028.GA9297@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:51071 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965529AbXBSXPE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 18:15:04 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2558616nfa
        for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2007 15:15:02 -0800 (PST)
In-Reply-To: <20070219222028.GA9297@aepfle.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Monday 19 February 2007 23:20, Olaf Hering wrote:
> On Sat, Feb 03, Bartlomiej Zolnierkiewicz wrote:
> 
> > [PATCH] ide: make ide_hwif_t.ide_dma_host_on void
> 
> > +++ b/drivers/ide/ppc/pmac.c
> > @@ -1984,10 +1984,8 @@ static void pmac_ide_dma_host_off(ide_dr
> >  {
> >  }
> >  
> > -static int
> > -pmac_ide_dma_host_on (ide_drive_t *drive)
> > +static int pmac_ide_dma_host_on(ide_drive_t *drive)
> >  {
> > -	return 0;
> >  }
> >  
> >  static int
> 
> This missed the s/int/void/

yes, sorry for that

akpm has fixed this along with other things in pmac driver
and the patch is already in the IDE quilt tree

Bart
