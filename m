From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv: platform driver allocs dma without create
Date: Mon, 11 Feb 2008 14:31:40 -0500
Message-ID: <47B0A29C.6000508@pobox.com>
References: <alpine.DEB.1.00.0802102117150.9668@git.byronbradley.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760953AbYBKTb5@vger.kernel.org>
In-Reply-To: <alpine.DEB.1.00.0802102117150.9668@git.byronbradley.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Byron Bradley <byron.bbradley@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, saeed@marvell.com, mlord@pobox.com
List-Id: linux-ide@vger.kernel.org

Byron Bradley wrote:
> When the sata_mv driver is used as a platform driver,
> mv_create_dma_pools() is never called so it fails when trying
> to alloc in mv_pool_start().
> 
> Signed-off-by: Byron Bradley <byron.bbradley@gmail.com>
> Acked-by: Mark Lord <mlord@pobox.com>
> ---
> 
> Mark, based on the comment from Andrew Morton on the "sata_mv: fix loop
> with last port" patch I have changed your Signed-off-by to an Acked-by.
> Hopefully thats correct.

applied
