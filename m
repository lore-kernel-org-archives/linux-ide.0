From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-cd: signedness warning fix again
Date: Sat, 11 Jun 2011 15:07:06 -0700 (PDT)
Message-ID: <20110611.150706.985438181862065028.davem@davemloft.net>
References: <1306993925-26044-1-git-send-email-cmdkhh@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:58325 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab1FKWIW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Jun 2011 18:08:22 -0400
In-Reply-To: <1306993925-26044-1-git-send-email-cmdkhh@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cmdkhh@gmail.com
Cc: bp@alien8.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Connor Hansen <cmdkhh@gmail.com>
Date: Wed,  1 Jun 2011 22:52:05 -0700

> One of the legit warnings 'make W=3 drivers/ide/ide-cd.c'
> generates is:
> drivers/ide/ide-cd.c: In function ide_cd_do_request
> drivers/ide/ide-cd.c:828:2: warning: conversion to int from \
> unsigned int may change the sign of the result
> drivers/ide/ide-cd.c:833:2: warning: conversion to int from \
> unsigned int may change the sign of the result
> 
> nsectors is declared int, should be unsigned int.
> 
> blk_rq-sectors() returns unsigned int, and ide_complete_rq
> expects unsigned int as well.  Fixes both warnings.
> 
> Signed-off-by: Connor Hansen <cmdkhh@gmail.com>

Applied, thanks.
