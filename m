From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/8] ata: ahci_imx: warn when disabling ahci link
Date: Tue, 24 Jun 2014 18:05:48 -0400
Message-ID: <20140624220548.GH14909@htj.dyndns.org>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
 <E1WzNp6-0005dk-Iq@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:37153 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbaFXWFw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 18:05:52 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so916693qgd.35
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2014 15:05:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1WzNp6-0005dk-Iq@rmk-PC.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>

On Tue, Jun 24, 2014 at 11:19:32AM +0100, Russell King wrote:
> When the AHCI link is disabled, it can't be re-enabled except by
> resetting the entire SoC.  Rather than doing this silently print
> some kernel messages to inform the user, along with how to avoid
> this.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The same patch from an earlier posting got applied to
libata/for-3.16-fixes.

Thanks.

-- 
tejun
