From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 5/7] clk: tegra: Add SATA clocks to Tegra124 initialization
 table
Date: Tue, 24 Jun 2014 13:32:27 -0600
Message-ID: <53A9D24B.4040301@wwwdotorg.org>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com> <1403101406-15439-6-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47549 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaFXTca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 15:32:30 -0400
In-Reply-To: <1403101406-15439-6-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com, tj@kernel.org, pdeschrijver@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org

On 06/18/2014 08:23 AM, Mikko Perttunen wrote:
> This adds two clocks, SATA and SATA_OOB, to the Tegra124 clock initialization
> table. The clocks are needed for working SATA support.

Acked-by: Stephen Warren <swarren@nvidia.com>
(When I wrote that for v1, it applied to both patches 4 and 5, not just
patch 4)

Peter, can you please pick up patches 4 and 5, and get them into
linux-next. Thanks.
