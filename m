From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] tx4939ide: Do not use zero count PRD entry
Date: Fri, 16 Jan 2009 23:25:27 +0900 (JST)
Message-ID: <20090116.232527.59651191.anemo@mba.ocn.ne.jp>
References: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
	<497082D1.5030504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:64550 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936116AbZAPOZa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 09:25:30 -0500
In-Reply-To: <497082D1.5030504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, linux-mips@linux-mips.org, stable@kernel.org

On Fri, 16 Jan 2009 15:51:29 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +			 * This workaround for zero count seems required.
> > +			 * (standard ide_build_dmatable do it too)
> 
>     s/do/does/

Thanks!

> > +			if ((bcount & 0xffff) == 0x0000)
> 
>    Why not just bcount == 0x10000?

Indeed.  It is just because ide_build_dmatable does so :)

I will prepare another patch, while the patch is already mainlined and
queued for stable, and this time changes are not suitable for stable
tree.

---
Atsushi Nemoto
