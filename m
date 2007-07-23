From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/11] ide-pmac: fix set_timings_mdma()
Date: Mon, 23 Jul 2007 23:21:15 +0200
Message-ID: <200707232321.15308.bzolnier@gmail.com>
References: <200707222022.41386.bzolnier@gmail.com> <1185141437.5439.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:53048 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100AbXGWVZb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:31 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40025ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:30 -0700 (PDT)
In-Reply-To: <1185141437.5439.62.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Sunday 22 July 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-07-22 at 20:22 +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Move adjusting of cycle time for devices providing explicit DMA cycle time
> >   from pmac_ide_mdma_enable() to set_timings_mdma().
> > 
> > * Remove no longer needed drive_cycle_time argument.
> > 
> > * BUG() if unsupported speed argument value is passed (shouldn't happen).
> > 
> > * Matching access/recovery timings always exist so remove redundant check.
> > 
> > * Make set_timings_mdma() void.
> > 
> > * Update pmac_ide_tune_chipset()'s comment.
> > 
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

added
