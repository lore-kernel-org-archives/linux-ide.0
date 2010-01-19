From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 54/64] alim15x3: fix handling of UDMA enable bit
Date: Tue, 19 Jan 2010 01:53:40 -0800 (PST)
Message-ID: <20100119.015340.116942294.davem@davemloft.net>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118172126.14623.55960.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756232Ab0ASJxf@vger.kernel.org>
In-Reply-To: <20100118172126.14623.55960.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 18 Jan 2010 18:21:26 +0100

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] alim15x3: fix handling of UDMA enable bit
> 
> Clear UDMA enable bit also for PIO modes.
> 
> Based on libata pata_ali host driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
