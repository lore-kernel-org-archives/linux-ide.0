From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: constify ide_dma_ops structures
Date: Mon, 18 Jan 2016 14:12:59 -0500 (EST)
Message-ID: <20160118.141259.2240054190302250383.davem@davemloft.net>
References: <1447619790-5203-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1447619790-5203-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia.Lawall@lip6.fr
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 15 Nov 2015 21:36:30 +0100

> The ide_dma_ops structures are never modified, so declare these as const,
> as is already done for the others.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.
