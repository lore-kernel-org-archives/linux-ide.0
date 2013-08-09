From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 3/5] devicetree: create a separate binding description
 for sata_highbank
Date: Fri, 9 Aug 2013 12:10:15 -0400
Message-ID: <20130809161015.GQ20515@mtj.dyndns.org>
References: <1375890758-30265-1-git-send-email-mark.langsdorf@calxeda.com>
 <1375890758-30265-3-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:62775 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933806Ab3HIQKV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 12:10:21 -0400
Content-Disposition: inline
In-Reply-To: <1375890758-30265-3-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob.herring@calxeda.com, sergei.shtylyov@cogentembedded.com

On Wed, Aug 07, 2013 at 10:52:36AM -0500, Mark Langsdorf wrote:
> The Calxeda sata_highbank driver has been adding its descriptions to the
> ahci driver. Separate them properly.
> 
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Will wait for the update.  I suppose this doesn't need to go in to
for-3.11-fixes?  I'd really appreciate what impact each patch has.

Thanks.

-- 
tejun
