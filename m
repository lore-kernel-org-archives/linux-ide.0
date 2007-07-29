From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide patches
Date: Sun, 29 Jul 2007 16:39:08 +0200
Message-ID: <200707291639.08317.bzolnier@gmail.com>
References: <200707222019.03684.bzolnier@gmail.com> <200707232322.22129.bzolnier@gmail.com> <46AC709A.6060002@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:44316 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765027AbXG2SFL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so123524nfb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:09 -0700 (PDT)
In-Reply-To: <46AC709A.6060002@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Sunday 29 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>Ok, there's a combination of things here:
> 
> >>> - First, doing a set_pio from userland (hdparm -p XX) causes the kernel
> >>>to disable DMA, which I think is incorrect. It's not the case with
> >>>2.6.22 from my quick tests. The problem is that ide_config_drive_speed
> >>>disables DMA, but only re-enables it when setting a DMA speed. I think
> 
> > The problem is that _many_ chipsets don't support separate PIO and DMA
> > timings so disabling DMA while programming chipset for PIO timings is a
> > necessity for them.
> 
>     Actually, I didn't quite follow (as I'm afraid Ben also :-). Do you mean 
> the fact that the DMA timings may get overwritten (which happens due to the 
> failure of the drivers to handle the shared PIO/DMA timing registers, and in 
> some cases by "coupling" PIO to UltraDMA timings for no apparent reasons which 
> leads to disabling UltraDMA when PIO is being programmed)?

Yes, in particular I meant cases like cmd64x (shared MWDMA/PIO timing
registers) so doing "hdparm -p" on a drive currently using DMA without
ide_config_drive_speed() disabling DMA would result in DMA operations
using PIO timings and possible data corruptions.

BTW all PIO to (U)DMA "couplings" should be fixed now

Bart
