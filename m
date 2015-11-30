From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] AHCI: Fix softreset failed issue of Port Multiplier
Date: Mon, 30 Nov 2015 10:01:59 -0500
Message-ID: <20151130150159.GD3535@mtj.duckdns.org>
References: <1448540822-24175-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35839 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbbK3PCE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2015 10:02:04 -0500
Content-Disposition: inline
In-Reply-To: <1448540822-24175-1-git-send-email-Xiangliang.Yu@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com

On Thu, Nov 26, 2015 at 08:27:02PM +0800, Xiangliang Yu wrote:
> Current code doesn't update port value of Port Multiplier(PM) when
> sending FIS of softreset to device, command will fail if FBS is
> enabled.
> 
> There are two ways to fix the issue: the first is to disable FBS
> before sending softreset command to PM device and the second is
> to update port value of PM when sending command.
> 
> For the first way, i can't find any related rule in AHCI Spec. The
> second way can avoid disabling FBS and has better performance.
> 
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>

Applied to libata/for-4.4-fixes w/ stable cc'd.

Thanks.

-- 
tejun
