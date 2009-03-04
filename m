From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes, -stable] ata_piix: add workaround for
 Samsung DB-P70
Date: Wed, 04 Mar 2009 11:36:36 +0900
Message-ID: <49ADE934.6080105@kernel.org>
References: <49ACB780.1070604@kernel.org> <49AD2DCD.60807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40049 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbZCDCg0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 21:36:26 -0500
In-Reply-To: <49AD2DCD.60807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, stable@kernel.org, josephjang@gmail.com, mrsohn@gmail.com

Hello, Mark.

Mark Lord wrote:
> A suggestion, then.  As a follow-up patch, would it be possible
> to drop the workaround kludge, and restore the missing SCR access,
> __after the first time that a drive is detected on that port__?

Hmmm... yeah.  Maybe but it would either involve changing ap->ops on
the fly (which is a big no no) or wrap SCR access such that it returns
-EOPNOTSUPP if the kludge is in effect.

> This way, there won't be any funny business for cases where
> the same ID might occur on different (non-botched) hardware ?
>
> Probably overkill, though.  :)

Missing SCR access doesn't impact direct usage too much, so yeah I
think it should be fine as it is until there's some evidence that the
subsystem IDs are in far wider use.

Thanks.

-- 
tejun
