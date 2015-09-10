From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_pxa: dmaengine conversion
Date: Thu, 10 Sep 2015 17:03:46 -0400
Message-ID: <20150910210346.GM8114@mtj.duckdns.org>
References: <1441912069-620-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33646 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbIJVDu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Sep 2015 17:03:50 -0400
Content-Disposition: inline
In-Reply-To: <1441912069-620-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>

On Thu, Sep 10, 2015 at 09:07:49PM +0200, Robert Jarzmik wrote:
> The PXA architecture was offered a slave dmaengine support. As a
> consequence the direct DMA registers are progressively replaced by
> dmaengine support.
> 
> This makes the pata_pxa change, which brings this driver to almost a
> generic ATA 40-wires driver relying on dmaengine for transfers.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied to libata/for-4.4.

Thanks.

-- 
tejun
