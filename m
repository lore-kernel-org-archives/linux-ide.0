From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 42/64] via82cxxx: workaround h/w bugs
Date: Tue, 19 Jan 2010 01:42:47 -0800 (PST)
Message-ID: <20100119.014247.243968259.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118172000.14623.73749.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756097Ab0ASJml@vger.kernel.org>
In-Reply-To: <20100118172000.14623.73749.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:20:00 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] via82cxxx: workaround h/w bugs
> 
> Add custom struct ide_tp_ops instance to fix the internal bug of some VIA
> chipsets which will reset the device register after changing the nIEN bit
> in the device control register.
> 
> Based on commit bfce5e0 for pata_via host driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
