From: Luis de Bethencourt <luis@debethencourt.com>
Subject: Re: [PATCH v2] ata: pata_macio: Fix module autoload for OF platform
 driver
Date: Wed, 16 Sep 2015 20:58:05 +0200
Message-ID: <20150916185805.GA32745@goodgumbo.baconseed.org>
References: <20150915163114.GA5152@goodgumbo.baconseed.org>
 <20150916174823.GG3243@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33163 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbIPS6I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Sep 2015 14:58:08 -0400
Content-Disposition: inline
In-Reply-To: <20150916174823.GG3243@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

On Wed, Sep 16, 2015 at 01:48:23PM -0400, Tejun Heo wrote:
> On Tue, Sep 15, 2015 at 06:31:14PM +0200, Luis de Bethencourt wrote:
> > This platform driver has a OF device ID table but the OF module
> > alias information is not created so module autoloading won't work.
> > 
> > This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> > that information so modules have the correct aliases built-in and
> > autoloading works correctly.
> > 
> > Link: https://lkml.org/lkml/2015/7/30/519
> > Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> 
> Where should this patch be applied?  for-4.4?  for-4.3-fixes w/ or w/o
> stable cc'd?
> 
> Thanks.
> 
> -- 
> tejun

Hi Tejun,

Other drivers with the same problem are applying this in 4.3-fixes.

I don't think it is critical enough to deserve a cc: Stable.

Thanks for review,
Luis
