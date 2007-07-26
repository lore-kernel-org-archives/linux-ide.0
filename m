From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/11] ide-pmac: remove pmac_ide_do_setfeature() (take 2)
Date: Thu, 26 Jul 2007 20:04:15 +0200
Message-ID: <200707262004.15566.bzolnier@gmail.com>
References: <200707240029.02584.bzolnier@gmail.com> <1185230714.5439.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbXGZT7i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591339ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:35 -0700 (PDT)
In-Reply-To: <1185230714.5439.150.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Tuesday 24 July 2007, Benjamin Herrenschmidt wrote:
> On Tue, 2007-07-24 at 00:29 +0200, Bartlomiej Zolnierkiewicz wrote:
> > Use ide_config_drive_speed() instead of pmac_ide_do_setfeature() and remove
> > the latter, also  ide-iops.c::__ide_wait_stat() could be static again.
> > 
> > Since for IDE PMAC host driver IDE_CONTROL_REG is always true, device's
> > ->quirk_list is always zero and ->ide_dma_host_{on,off} are nops than
> > the only changes in behavior are:
> > 
> > * if PIO mode is set then ->dma_off_queitly is called to disable DMA
> > 
> > * if setting transfer mode fails ide_dump_status() is called to dump status
> 
> I'll test that today.

ping?
