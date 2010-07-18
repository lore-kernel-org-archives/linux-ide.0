From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] via82cxxx: fix typo for VT6415 PCIE PATA IDE Host
 Controller support.
Date: Sun, 18 Jul 2010 16:11:32 -0700 (PDT)
Message-ID: <20100718.161132.84396255.davem@davemloft.net>
References: <1279494644-3762-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43101
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757475Ab0GRXLQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jul 2010 19:11:16 -0400
In-Reply-To: <1279494644-3762-1-git-send-email-ydirson@altern.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ydirson@altern.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org

From: Yann Dirson <ydirson@altern.org>
Date: Mon, 19 Jul 2010 01:13:24 +0200

> Without this fix, init of the via82cxxx driver causes a oops with a
> stack resembling the one below, and the boot blocks between init of
> USB devices and launch of init (was easy to bisect by booting with
> init=/bin/sh).
...
> The typo was introduced in a354ae8747d0687093ce244e76b15b6174d2f098,
> and affects 2.6.33-rc4 and later.
> 
> Signed-off-by: Yann Dirson <ydirson@altern.org>

Applied, thanks!
