From: Tejun Heo <htejun@gmail.com>
Subject: Re: spurious completions during NCQ on rt kernel
Date: Wed, 28 Nov 2007 09:37:42 +0900
Message-ID: <474CB856.6060807@gmail.com>
References: <1A9B2DB3B3ED841DFF005BAC23AE96A51195946069AEEFCB86C1DAE1638E@webmail.aster.pl> <474A4C7B.1060804@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.180]:14113 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617AbXK1AiA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 19:38:00 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2093551roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 16:37:58 -0800 (PST)
In-Reply-To: <474A4C7B.1060804@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jozwicki <jozwicki@aster.pl>, jgarzik@pobox.com, linux-ide@vger.kernel.org, mingo@elte.hu

Hello,

Mark Lord wrote:
> Mmmm.. that's interesting.  I suppose a big difference between -rt and
> vanilla
> is in latency between interrupt signal and the interrupt handler
> actually running.
> 
> I think in -rt it is slightly *longer*, since the handler is run by a
> scheduled
> thread instead of directly.
> 
> Anyway, for me, the intriguing point of data here, is that there could
> be some
> tight soft timing issue that sometimes can make NCQ fail.  And our
> response to date
> with this is to blacklist the drives.. which may or may not be correct now.

I think it's interrupt timing problem too.  I just received my order of
problematic drives.  I'll try to reproduce it and find out.  At any
rate, I think we'll probably have to drop spurious NCQ completion check.

Thanks.

-- 
tejun
