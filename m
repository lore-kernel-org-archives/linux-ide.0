From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: icside.c: Fix compile with
 CONFIG_BLK_DEV_IDEDMA_ICS=n
Date: Wed, 06 Jun 2012 10:37:41 -0700 (PDT)
Message-ID: <20120606.103741.1134656571479190113.davem@davemloft.net>
References: <86lik87jgw.fsf@gandalf.zerties.org>
	<20120602.171210.1245211360510437081.davem@davemloft.net>
	<864nqq3q2v.fsf@gandalf.zerties.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:37661 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab2FFRhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jun 2012 13:37:42 -0400
In-Reply-To: <864nqq3q2v.fsf@gandalf.zerties.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: christian.dietrich@informatik.uni-erlangen.de
Cc: sshtylyov@mvista.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@lists.cs.fau.de

From: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
Date: Tue, 05 Jun 2012 14:23:20 +0200

> The icside driver can be configured without DMA support, but it
> doesn't compile then, because DMA operations are referenced.
> 
> drivers/ide/icside.c:523: error: 'icside_v6_port_ops' undeclared
> drivers/ide/icside.c:522: error: 'icside_dma_init' undeclared
> 
> Signed-off-by: Christian Dietrich<christian.dietrich@informatik.uni-erlangen.de>

Applied.
