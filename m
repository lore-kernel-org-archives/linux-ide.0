From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Fix division by zero
Date: Wed, 8 Apr 2015 16:04:19 +0100
Message-ID: <20150408160419.00284e21@lxorguk.ukuu.org.uk>
References: <20150408125114.29925.841.stgit@localhost.localdomain>
	<5105249.IaGgeTGhXs@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:33253 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbbDHPEk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2015 11:04:40 -0400
In-Reply-To: <5105249.IaGgeTGhXs@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

> Please note that we should not end up with the division by zero with
> existing host drivers.  EZ(v, unit) checks for v being zero and t->udma
> is non-zero only for XFER_UDMA_* xfer modes.  Currently none of host
> drivers calls ata_timing_compute() on xfer mode >= XFER_UDMA_0 with
> the zero UT argument.  Such usage will be an error and while the old
> code explodes immediately, the new one will silently accept it (which
> could theoretically result in the wrong timing being set)..

Having gone back over them with your additional point I missed noted all
seems to be good. I'll drop the patch from my queue. I don't see any
point adding extra checks - it's not as if anyone is writing many new
PATA drivers.

Alan
