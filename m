From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/8] ide: add struct ide_port_info instances to legacy host drivers
Date: Sun, 10 Feb 2008 18:04:48 +0100
Message-ID: <200802101804.49154.bzolnier@gmail.com>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain> <20080106170310.6861.14522.sendpatchset@localhost.localdomain> <20080211.010729.115910395.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:47795 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbYBJQvA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 11:51:00 -0500
Received: by an-out-0708.google.com with SMTP id d31so1063172and.103
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 08:50:59 -0800 (PST)
In-Reply-To: <20080211.010729.115910395.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 10 February 2008, Atsushi Nemoto wrote:
> On Sun, 06 Jan 2008 18:03:10 +0100, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > +	/* reset DMA masks only for SFF-style DMA controllers */
> > +	if ((d->host_flags && IDE_HFLAG_NO_DMA) == 0 && hwif->dma_base == 0)
> > +		hwif->swdma_mask = hwif->mwdma_mask = hwif->ultra_mask = 0;
> 
> It might be too late, but "host_flags && IDE_HFLAGS_NO_DMA" seems
> wrong for me.

It is too late for -git but not too late for 2.6.25-rc1. ;-)

Could you make a patch please?

Thanks,
Bart
