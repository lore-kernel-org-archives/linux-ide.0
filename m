From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RESEND 4/8] MIPS: au1xxx: au1xxx-ide: remove
 pb1200/db1200 header dep
Date: Thu, 18 Aug 2011 04:03:41 -0700 (PDT)
Message-ID: <20110818.040341.498460978855618496.davem@davemloft.net>
References: <1313658718-14144-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:59323 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1HRLDt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Aug 2011 07:03:49 -0400
In-Reply-To: <1313658718-14144-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: manuel.lauss@googlemail.com
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-ide@vger.kernel.org

From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Thu, 18 Aug 2011 11:11:58 +0200

> au1xxx-ide uses defines from the pb1200/db1200 headers:
> get DBDMA ID through platform resource information,
> hardcode register spacing.  The only 2 users of this driver (and
> the only boards it can really work on realiably) use the same
> register layout.
> 
> Cc: linux-ide@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> Resend: adding old-IDE Maintainer David Miller to CC's
> I'd like for this to go through the MIPS tree, as other changes in it
> depend on it.

Acked-by: David S. Miller <davem@davemloft.net>
