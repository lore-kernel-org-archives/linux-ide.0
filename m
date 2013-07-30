From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ATA: sata_mv: Remove unneeded CONFIG_HAVE_CLK ifdefs
Date: Tue, 30 Jul 2013 09:04:11 -0400
Message-ID: <20130730130411.GC12016@htj.dyndns.org>
References: <1375152363-3451-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:60754 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab3G3NEP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jul 2013 09:04:15 -0400
Received: by mail-qc0-f173.google.com with SMTP id z10so1556102qcx.32
        for <linux-ide@vger.kernel.org>; Tue, 30 Jul 2013 06:04:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375152363-3451-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Mon, Jul 29, 2013 at 11:46:03PM -0300, Ezequiel Garcia wrote:
> If CONFIG_HAVE_CLK is not selected, then all the clk API turn out
> into no-ops. In other words, there's no need to have the ifdefs.
> 
> The only side-effect of this patch is the extra tiny kmalloc,
> but that's not enough reason to have such ugly ifdefs all around
> the code.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Applied to libata/for-3.12 with Andrew's comment suggestion applied
and acked-by added.

Thanks.

-- 
tejun
