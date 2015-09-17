From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ata: pata_macio: Fix module autoload for OF platform
 driver
Date: Thu, 17 Sep 2015 11:16:17 -0400
Message-ID: <20150917151617.GC7205@mtj.duckdns.org>
References: <20150917111945.GA11761@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34472 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbbIQPQV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2015 11:16:21 -0400
Content-Disposition: inline
In-Reply-To: <20150917111945.GA11761@goodgumbo.baconseed.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

On Thu, Sep 17, 2015 at 01:19:45PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
> 
> Link: https://lkml.org/lkml/2015/7/30/519
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Replaced the original patch with this one.  We all make mistakes but
please make sure that at least the minimum amount of verification is
done before submitting patches.

Thanks.

-- 
tejun
