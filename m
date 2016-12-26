From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver
 (trial #2)
Date: Mon, 26 Dec 2016 11:47:24 -0500 (EST)
Message-ID: <20161226.114724.642220063641900983.davem@davemloft.net>
References: <20161012011245.GA22684@giustizia>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:52850 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754341AbcLZQrZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Dec 2016 11:47:25 -0500
In-Reply-To: <20161012011245.GA22684@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lramos.prof@yahoo.com.br
Cc: linux-ide@vger.kernel.org

From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Date: Tue, 11 Oct 2016 22:12:45 -0300

> This humble patch was sent one or two months before, and had no actions,
> except for a colleague reply which friendly pointed out some formatting
> problems (which were solved in a second message).
> 
> It relates to an old code, the legacy IDE driver, but the bug it
> addresses is real. The code, although rarely used, is
> still there to be compiled if one chooses to do so (like me).
> 
> Also, the fix has a very low risk of present collateral effects IMHO.
> It is already compiled and tested in some embedded machines.
> 
> So, again IMHO, it is worth be fixed.
> 
> This email is a second trial with it. I hope it can help the one or two
> guys out there which are still running the legacy IDE driver and
> haven't noticed the former email.
> 
> Best regards,
> 
> Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>

This bug was introduced by commit
20df429dd6671804999493baf2952f82582869fa ("ide-generic: handle probing
of legacy io-ports v5") which seems poorly tested.

Applied and queued up for -stable, th anks.
