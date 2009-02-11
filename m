From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/6] ide: add ->dma_expiry method and remove ->dma_exec_cmd one
Date: Wed, 11 Feb 2009 17:30:39 +0100
Message-ID: <200902111730.39460.bzolnier@gmail.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <20090209232012.32406.88338.sendpatchset@localhost.localdomain> <4991C4F3.2040404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:50389 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285AbZBKQt4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 11:49:56 -0500
In-Reply-To: <4991C4F3.2040404@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

On Tuesday 10 February 2009, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Rename dma_timer_expiry() to ide_dma_sff_expiry() and export it.
> 
> > * Add ->dma_expiry method
> 
>     This name doesn't seem to make much sense. Why not leave it dma_timer_expiry?

Well, the name matches with hwif->expiry one + the downside of leaving it at
dma_timer_expiry is a need to reformat all struct ide_dma_ops instances...

Thanks,
Bart
