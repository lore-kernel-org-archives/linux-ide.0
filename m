From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: qoriq: enable snoopable sata read and write
Date: Wed, 10 Aug 2016 00:04:32 -0400
Message-ID: <20160810040432.GG25053@mtj.duckdns.org>
References: <1470707482-13421-1-git-send-email-yuantian.tang@nxp.com>
 <1470707482-13421-2-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35236 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcHJEEf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2016 00:04:35 -0400
Content-Disposition: inline
In-Reply-To: <1470707482-13421-2-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yuantian.tang@nxp.com
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com

On Tue, Aug 09, 2016 at 09:51:22AM +0800, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> By default the SATA IP on the qoriq SoCs does not generating
> coherent/snoopable transactions.  This patch enable it in the
> sata axicc register.
> In addition, the dma-coherent property must be set on the
> SATA controller nodes.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Applied 1-2 to libata/for-4.9.

Thanks.

-- 
tejun
