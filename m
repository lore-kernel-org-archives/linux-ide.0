From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] ide: <asm-sparc64/ide.h>: use %r0 for outw_be()
Date: Mon, 21 Jul 2008 16:50:09 -0700 (PDT)
Message-ID: <20080721.165009.168239842.davem@davemloft.net>
References: <20080714153825.9085.98433.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60195
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754902AbYGUXuJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2008 19:50:09 -0400
In-Reply-To: <20080714153825.9085.98433.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 14 Jul 2008 17:38:25 +0200

> Use %r0 for outw_be() to make it match __raw_writew().
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> against ide tree
> 
> I'm a bit confused by this optimization but since __raw_write* use it...

This allows the compiler to use the "zero" register %g0
when storing a zero value.

Applied, thanks Bart.
