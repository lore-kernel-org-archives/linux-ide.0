From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/5] ata: ahci_imx: warn when disabling ahci link
Date: Tue, 24 Jun 2014 18:00:06 -0400
Message-ID: <20140624220006.GG14909@htj.dyndns.org>
References: <E1Wz2tw-0000eE-Ml@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:58553 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbaFXWAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 18:00:09 -0400
Received: by mail-qg0-f51.google.com with SMTP id z60so906778qgd.10
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2014 15:00:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1Wz2tw-0000eE-Ml@rmk-PC.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, linux-ide@vger.kernel.org

On Mon, Jun 23, 2014 at 12:59:08PM +0100, Russell King wrote:
> When the AHCI link is disabled, it can't be re-enabled except by
> resetting the entire SoC.  Rather than doing this silently print
> some kernel messages to inform the user, along with how to avoid
> this.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied to libata/for-3.16-fixes w/ the printf format string put on a
single line.

Thanks.

-- 
tejun
