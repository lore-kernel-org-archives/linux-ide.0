From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
Date: Fri, 17 Oct 2008 02:29:10 +0900 (JST)
Message-ID: <20081017.022910.95501548.anemo@mba.ocn.ne.jp>
References: <48F7391D.8050109@ru.mvista.com>
	<20081017.013101.128619577.anemo@mba.ocn.ne.jp>
	<48F7787B.2060807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:63171 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759762AbYJPR3E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 13:29:04 -0400
In-Reply-To: <48F7787B.2060807@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Thu, 16 Oct 2008 21:23:07 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>>+	if ((dma_stat & 7) == 0 &&
> >>>+	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
> >>>+	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
> >>
> >>   Parens around & and | are hardly needed...
> 
> > You mean more parens are needed?
> 
>     I mean less. :-)

Well, I think all above parens are required.  '&' and '|' are weaker
than '==', no?

---
Atsushi Nemoto
