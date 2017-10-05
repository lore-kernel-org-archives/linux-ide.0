From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ata: sata_rcar: Use of_device_get_match_data() helper
Date: Thu, 5 Oct 2017 11:13:56 +0200
Message-ID: <20171005091355.GL26369@verge.net.au>
References: <1507119187-12297-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33687 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdJEJOX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2017 05:14:23 -0400
Content-Disposition: inline
In-Reply-To: <1507119187-12297-1-git-send-email-geert+renesas@glider.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Oct 04, 2017 at 02:13:07PM +0200, Geert Uytterhoeven wrote:
> Use the of_device_get_match_data() helper instead of open coding.
> Note that the sata_rcar driver is used with DT only, so there's always a
> valid match.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

