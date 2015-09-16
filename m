From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: pata_macio: Fix module autoload for OF platform
 driver
Date: Wed, 16 Sep 2015 15:23:16 -0400
Message-ID: <20150916192316.GA4921@mtj.duckdns.org>
References: <20150915163114.GA5152@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34017 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbIPTXU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Sep 2015 15:23:20 -0400
Content-Disposition: inline
In-Reply-To: <20150915163114.GA5152@goodgumbo.baconseed.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

On Tue, Sep 15, 2015 at 06:31:14PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
> 
> Link: https://lkml.org/lkml/2015/7/30/519
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Applied to libata/for-4.3-fixes.

Thanks!

-- 
tejun
