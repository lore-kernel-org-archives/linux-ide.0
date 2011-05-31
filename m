From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] ide-cd: Fix another signedness warning
Date: Tue, 31 May 2011 15:24:45 -0700 (PDT)
Message-ID: <20110531.152445.44639723.davem@davemloft.net>
References: <1306740418-565-1-git-send-email-cmdkhh@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:56705 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932498Ab1EaWZ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 May 2011 18:25:57 -0400
In-Reply-To: <1306740418-565-1-git-send-email-cmdkhh@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cmdkhh@gmail.com
Cc: bp@alien8.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Connor Hansen <cmdkhh@gmail.com>
Date: Mon, 30 May 2011 00:26:58 -0700

> One of the legit warnings 'make W=3 drivers/ide/ide-cd.o generates is
> 
> drivers/ide/ide-cd.c: In function ide_cd_queue_pc:
> drivers/ide/ide-cd.c:451:3: warning: conversion to unsigned int from
>       int may change the sign of the result
> 
> timeout is passed as an int, but is declared as an unsigned int in
> struct request in include/linux/blkdev.h
> 
> Signed-off-by: Connor Hansen <cmdkhh@gmail.com>

This is beyond academic and may in fact introduce strange things.

All except one call site passes "0" for the timeout.

And that one call site passes packet_command->timeout from userspace
which is an 'int'.

I'm not applying this.
