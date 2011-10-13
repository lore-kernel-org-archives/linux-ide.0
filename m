From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] icside: DMA support fix
Date: Thu, 13 Oct 2011 17:05:19 -0400 (EDT)
Message-ID: <20111013.170519.1844447293057298087.davem@davemloft.net>
References: <201110111933.48430.bzolnier@gmail.com>
	<20111011.145523.1844316617273586111.davem@davemloft.net>
	<201110121645.47490.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:37382 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab1JMVFW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 17:05:22 -0400
In-Reply-To: <201110121645.47490.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 12 Oct 2011 16:45:34 +0200

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH v2] icside: DMA support fix
> 
> Fix problem introduced by commit 5e37bdc ("ide: add struct
> ide_dma_ops (take 3)"): d.dma_ops shouldn't be cleared if
> we are going to use DMA.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
