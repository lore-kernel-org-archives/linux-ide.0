From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-pmac: fix drive->init_speed reporting
Date: Mon, 23 Jul 2007 23:20:51 +0200
Message-ID: <200707232320.51869.bzolnier@gmail.com>
References: <200707222019.03684.bzolnier@gmail.com> <1185141037.5439.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:53048 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbXGWVZZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:25 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40025ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:23 -0700 (PDT)
In-Reply-To: <1185141037.5439.54.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Sunday 22 July 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-07-22 at 20:19 +0200, Bartlomiej Zolnierkiewicz wrote:
> > pmac_ide_tune_chipset() don't set drive->init_speed.
> > 
> > Fix it by setting drive->{current,init}_speed in pmac_ide_do_setfeature()
> > and clean up pmac_ide_{tune_chipset,mdma_enable,udma_enable}().
> > 
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

added
