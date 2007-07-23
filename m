From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/11] ide-pmac: pmac_ide_tune_chipset() fixes
Date: Mon, 23 Jul 2007 23:21:11 +0200
Message-ID: <200707232321.11494.bzolnier@gmail.com>
References: <200707222021.38796.bzolnier@gmail.com> <1185141328.5439.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:51030 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233AbXGWVZ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:28 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40027ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:27 -0700 (PDT)
In-Reply-To: <1185141328.5439.60.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Sunday 22 July 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-07-22 at 20:21 +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Don't check check for pmif == NULL (it should never be NULL if we got here).
> > 
> > * Make a local copy of the timings and set the pmif->timings[] only after
> >   setting the transfer mode on the device (otherwise SELECT_DRIVE() call in
> >   pmac_ide_do_setfeature() will program new timings before the transfer mode
> >   is set on the device - this was pointed out by Sergei).  This change makes
> >   pmac_ide_tune_chipset() behavior match this of pmac_ide_{m,u}dma_enable().
> > 
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

added
