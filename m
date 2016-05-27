From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Use IS_ENABLED() instead of checking for built-in
 or module
Date: Fri, 27 May 2016 11:27:46 -0400
Message-ID: <20160527152746.GL23194@mtj.duckdns.org>
References: <1463602288-10393-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35667 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbcE0P1s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2016 11:27:48 -0400
Content-Disposition: inline
In-Reply-To: <1463602288-10393-1-git-send-email-javier@osg.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, May 18, 2016 at 04:11:28PM -0400, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied to libata/for-4.8.

Thanks.

-- 
tejun
