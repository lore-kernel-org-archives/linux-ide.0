Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C900407575;
	Thu, 30 Apr 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553317; cv=none; b=pUuVWHgNCerlcBtjpPn0oMyAh1umgbTE39sVjP8QyEX3HuI/4++7atdke32etboVLwoaNJe2vEqPBXShQjoiaXWl5Haykl4jApVzJm1+O+Rq3gQbHQDiemnAQc3erPVL6PU1SheCBVtHIQ8Kep6yoz/H9P2w/LVg3az9vI8ee/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553317; c=relaxed/simple;
	bh=/hNyPlR1yP8uL5nQkqngnOmReWAfP6PDqPiI+kJEThc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKl217QGDIbjaMGfOt7DFk1ytridZ7byNB4t/x9vcgIIT7jsL1ghHSL2oJYWhXOLANrcj1i+lFgkEGcDFNzBtsED8qO0T7Dpd20wZHWHf3JQDN917ZR/kj/lR1PdsxAxHkulVX7AVw/VGGJ5JwMHE7yESkslBaEK7b7RQB+3lP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivr62qPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivr62qPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394F5C2BCB9;
	Thu, 30 Apr 2026 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777553317;
	bh=/hNyPlR1yP8uL5nQkqngnOmReWAfP6PDqPiI+kJEThc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivr62qPxgF2KlaaJ0RIqSNgydjnPfCTCu6cd0ALBdMEDiGTAv4LNKMt4O3ECUVFgm
	 ZUEOU4Ycwn6eS2riwp87Dy1qqhtLELoyE+HBtrhMXIBbhLWNrzwxknAIItAr9lRTcr
	 ZFKrGqx2QrmA+LjK7xnQqk2du14FMhYcBDV20eaYoOnK4lSjijPXhr3zXqUmxQe/gZ
	 n/lRcpKPjQv+2tSTpEbqrYRzZTV+i22d3vHjJku65YOpzl9/5Xs4kgq/DX5wWyuWIj
	 DQvUkCX8gpeJcHE8fC3brcFxCcZ4U8kbav2InIuXjMld08kxjOoK1koLjIiiQ628Lb
	 QyzTb8CNL/zig==
Date: Thu, 30 Apr 2026 14:48:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: dayou5941@163.com, dlemoal@kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, liyouhong@kylinos.cn
Subject: Re: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO
 region
Message-ID: <afNPoLj-CbigNxRz@ryzen>
References: <20260422080322.1006592-1-dayou5941@163.com>
 <202604300815.6kpEidbJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202604300815.6kpEidbJ-lkp@intel.com>

On Thu, Apr 30, 2026 at 08:59:57AM +0800, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v7.1-rc1 next-20260429]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/dayou5941-163-com/ata-libahci-fix-panic-when-accessing-ports-beyond-MMIO-region/20260422-192119
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20260422080322.1006592-1-dayou5941%40163.com
> patch subject: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO region
> config: arm64-randconfig-003-20260430 (https://download.01.org/0day-ci/archive/20260430/202604300815.6kpEidbJ-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300815.6kpEidbJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604300815.6kpEidbJ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/ata/libahci.c:614:18: warning: missing terminating '"' character [-Winvalid-pp-token]
>      614 |                         dev_warn(dev, "Port %d (offset 0x%llx) exceeds MMIO region (0x%llx),
>          |                                       ^
>    drivers/ata/libahci.c:615:44: warning: missing terminating '"' character [-Winvalid-pp-token]
>      615 |                                        truncating port map at port %d\n",
>          |                                                                        ^
> >> drivers/ata/libahci.c:614:18: error: expected expression
>      614 |                         dev_warn(dev, "Port %d (offset 0x%llx) exceeds MMIO region (0x%llx),
>          |                                       ^
>    2 warnings and 1 error generated.

Thank you dear kernel test robot,

However, this report is for V1, we have applied V5 of this patch:
https://lore.kernel.org/linux-ide/177735961706.2183577.4033506737290437474.b4-ty@b4/T/#t

Which does not have this problem.


Kind regards,
Niklas
