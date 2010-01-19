From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 49/64] ide: change ->set_dma_mode method parameters
Date: Tue, 19 Jan 2010 01:45:52 -0800 (PST)
Message-ID: <20100119.014552.133883369.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118172050.14623.98373.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756152Ab0ASJpq@vger.kernel.org>
In-Reply-To: <20100118172050.14623.98373.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:20:50 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: change ->set_dma_mode method parameters
> 
> Change ->set_dma_mode method parameters to match ->set_dmamode method
> used in struct ata_port_operations.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
