From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Wed, 24 Sep 2008 02:04:59 +0900 (JST)
Message-ID: <20080924.020459.128619366.anemo@mba.ocn.ne.jp>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
	<48D57245.8060606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:61897 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbYIWREj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Sep 2008 13:04:39 -0400
In-Reply-To: <48D57245.8060606@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Sun, 21 Sep 2008 01:59:33 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +static int tx4939ide_dma_test_irq(ide_drive_t *drive)
> > +{
> > +	ide_hwif_t *hwif = HWIF(drive);
> > +	void __iomem *base = TX4939IDE_BASE(hwif);
> > +	u16 ctl = tx4939ide_readw(base, TX4939IDE_int_ctl);
> > +	u8 dma_stat, stat;
> > +	u16 ide_int;
> > +	int found = 0;
> > +
> > +	tx4939ide_check_error_ints(hwif, ctl);
> > +	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);
> 
>    Well, since you're effectively ignoring the BUSERR interrupt, there's 
> no point in enabling it...

The BUSERR is not ignored.  tx4939ide_check_error_ints() will print a
message.  It would be better than just ignoring.

---
Atsushi Nemoto
