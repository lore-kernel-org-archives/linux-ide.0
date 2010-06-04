From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] tx493xide: use min_t() macro instead of min()
Date: Fri, 04 Jun 2010 16:19:33 -0700 (PDT)
Message-ID: <20100604.161933.232764916.davem@davemloft.net>
References: <1275406118-14581-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39808
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932583Ab0FDXTX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2010 19:19:23 -0400
In-Reply-To: <1275406118-14581-1-git-send-email-anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: anemo@mba.ocn.ne.jp
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date: Wed,  2 Jun 2010 00:28:38 +0900

> This fixes a warning ("comparison of distinct pointer types lacks a
> cast") introduced by the commit
> 040f6b4f14adb2ca5babb84e9fb2ebc6661e0be2 ("tx493xide: use ->pio_mode
> value to determine pair device speed").
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Applied, thank you.
