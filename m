From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ata: sata_rcar: Remove obsolete platform_device_id
 entries
Date: Thu, 8 Oct 2015 11:11:55 +0900
Message-ID: <20151008021154.GC8756@verge.net.au>
References: <1444215442-27269-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44908 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbJHCL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Oct 2015 22:11:57 -0400
Content-Disposition: inline
In-Reply-To: <1444215442-27269-1-git-send-email-geert+renesas@glider.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Oct 07, 2015 at 12:57:22PM +0200, Geert Uytterhoeven wrote:
> Since commit c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy
> SoC code"), R-Car SoCs are only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the remaining platform_device_id
> entries and platform device support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

