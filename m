From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 4/9] clk: tegra: Enable hardware control of SATA PLL
Date: Mon, 16 Jun 2014 15:49:18 -0600
Message-ID: <539F665E.3060007@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1401881559-18469-5-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40779 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbaFPVtV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2014 17:49:21 -0400
In-Reply-To: <1401881559-18469-5-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: pdeschrijver@nvidia.com
Cc: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com, tj@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This makes the SATA PLL be controlled by hardware instead of software.
> This is required for working SATA support.

Peter, could you please take patches 4 and 5 through the clock tree. As
far as I can tell, there's no compile-time dependency in the clock
patches, so they can go through a different tree to the rest of the
series without issue. These 2 patches look fine to me, so consider them:

Acked-by: Stephen Warren <swarren@nvidia.com>
