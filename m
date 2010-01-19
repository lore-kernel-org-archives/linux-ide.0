From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 41/64] via82cxxx: fix SATA cable detection
Date: Tue, 19 Jan 2010 01:42:39 -0800 (PST)
Message-ID: <20100119.014239.114818350.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171953.14623.7914.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756069Ab0ASJmf@vger.kernel.org>
In-Reply-To: <20100118171953.14623.7914.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:19:53 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] via82cxxx: fix SATA cable detection
> 
> Add VIA_SATA_PATA flag for cx700, vx800 and vx855 chipsets
> (the first port is SATA).
> 
> Based on commits 7585eb1, bfce5e0 and e4d866c for pata_via
> host driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
