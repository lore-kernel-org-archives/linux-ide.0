From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0063/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 14:27:25 -0400
Message-ID: <20160802182725.GG2542@mtj.duckdns.org>
References: <20160802103759.17958-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36705 "EHLO
	mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbcHBS1a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2016 14:27:30 -0400
Content-Disposition: inline
In-Reply-To: <20160802103759.17958-1-baolex.ni@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: b.zolnierkie@samsung.com, lenb@kernel.org, x86@kernel.org, hpa@zytor.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, travis@sgi.com

Hello,

On Tue, Aug 02, 2016 at 06:37:59PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>

I don't see the point.  This actually makes code harder to read.
Sure, in general, we want to avoid using magic raw numbers but the
octal permission numbers are pretty much canonical.  These conversions
are pure noises.

Nacked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
