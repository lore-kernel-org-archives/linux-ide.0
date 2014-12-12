From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers: ide: Fix mostly harmless off-by-one hardcoded
 value
Date: Fri, 12 Dec 2014 15:31:27 -0500 (EST)
Message-ID: <20141212.153127.41600648682351296.davem@davemloft.net>
References: <1417125449-6007-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:38231 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbaLLUb3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Dec 2014 15:31:29 -0500
In-Reply-To: <1417125449-6007-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@rasmusvillemoes.dk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 27 Nov 2014 22:57:29 +0100

> The string "IOMEGA Clik!" has length 12, not 11. Using strstarts
> avoids the error-prone hardcoding of the prefix length. For
> consistency, also change the occurence just above.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied.
