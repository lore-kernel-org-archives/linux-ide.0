From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] sata_rcar: Document deprecated "renesas,rcar-sata"
Date: Tue, 4 Nov 2014 09:16:23 -0500
Message-ID: <20141104141623.GC14459@htj.dyndns.org>
References: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
 <1414591131-21771-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:56639 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbaKDOQ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2014 09:16:28 -0500
Content-Disposition: inline
In-Reply-To: <1414591131-21771-3-git-send-email-geert+renesas@glider.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 02:58:50PM +0100, Geert Uytterhoeven wrote:
> Commit e67adb4e669db834 ("sata_rcar: Add R-Car Gen2 SATA PHY support")
> deprecated "renesas,rcar-sata" in favor of "renesas,sata-r8a7779", but
> the deprecated value was never documented in the binding documentation,
> while it is still in active use.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This one doesn't apply anymore.  Can you please refresh it against
libata/for-3.19.

Thanks.

-- 
tejun
