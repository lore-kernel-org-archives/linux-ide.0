From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 21/27] drivers/ide: Use memdup_user
Date: Fri, 04 Jun 2010 16:13:06 -0700 (PDT)
Message-ID: <20100604.161306.102569610.davem@davemloft.net>
References: <Pine.LNX.4.64.1005221024470.13021@ask.diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35032
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757395Ab0FDXM5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2010 19:12:57 -0400
In-Reply-To: <Pine.LNX.4.64.1005221024470.13021@ask.diku.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: julia@diku.dk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Sat, 22 May 2010 10:25:03 +0200 (CEST)

> From: Julia Lawall <julia@diku.dk>
> 
> Use memdup_user when user data is immediately copied into the
> allocated region.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
 ...
> Signed-off-by: Julia Lawall <julia@diku.dk>

Applied, t hanks Julia.
