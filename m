From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_macio: Fix module autoload for OF platform
 driver
Date: Tue, 15 Sep 2015 11:52:10 -0400
Message-ID: <20150915155210.GG2905@mtj.duckdns.org>
References: <20150915154552.GA3060@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33221 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbbIOPwP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Sep 2015 11:52:15 -0400
Content-Disposition: inline
In-Reply-To: <20150915154552.GA3060@goodgumbo.baconseed.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

On Tue, Sep 15, 2015 at 05:45:52PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
> 
> Hello,
> 
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
> 
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519

Can you please include that in the patch description?  Or at least add
Link: tag?  Also, should this be routed through -stable?

Thanks.

-- 
tejun
