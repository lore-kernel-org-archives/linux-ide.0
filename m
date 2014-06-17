From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 4/9] clk: tegra: Enable hardware control of SATA PLL
Date: Tue, 17 Jun 2014 12:59:13 +0300
Message-ID: <20140617095913.GE3407@tbergstrom-lnx.Nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-5-git-send-email-mperttunen@nvidia.com>
 <539F665E.3060007@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8224 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaFQJ7S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2014 05:59:18 -0400
Content-Disposition: inline
In-Reply-To: <539F665E.3060007@wwwdotorg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "tj@kernel.org" <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, Jun 16, 2014 at 11:49:18PM +0200, Stephen Warren wrote:
> On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> > This makes the SATA PLL be controlled by hardware instead of software.
> > This is required for working SATA support.
> 
> Peter, could you please take patches 4 and 5 through the clock tree. As
> far as I can tell, there's no compile-time dependency in the clock
> patches, so they can go through a different tree to the rest of the
> series without issue. These 2 patches look fine to me, so consider them:
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Ok. Will do.

Cheers,

Peter.
