Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596A305693;
	Tue, 28 Jul 2026 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207686; cv=none; b=Xyt4VrXPTTM4gFJJijAyGkgdpDo4koyXXrJkABjtzzp4ODIYuAdxHTqCaBqPWFXZhloz5ZpuGRL462q6arbExOmdhb4HpW5FXJ1OyQiyAyhmM626GE3I13HmjrfOXQ74NGiMaUacCrVZ0LBzDuhLu3r1fDZsO3QixlVKBmeRW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207686; c=relaxed/simple;
	bh=79wpCi0XhDLZsBu3U1ruJBiEzaMCptoC9Vqd72L2LPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XST68VArSTbggfI8dFGx0WkB+Aw+xBAtWtdUnad9HCO+ZFpZnFF9aDRAzkaQjFyaFYfba/i3pmrWsz67H1PaZMAJ4P3XZX9I4uoIsFDQjIhaTSUdbOUWpn+yD8buzeeQBOjdslnLnirUb+z+SLP8aH2PimOUjhTjC8xhWn8avqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzdIYCVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzdIYCVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCD61F000E9;
	Tue, 28 Jul 2026 03:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785207685;
	bh=wuiLbxTHJoli190B04z7DNmHQThkD+2KjWgPlu44or0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jzdIYCVxRV4e/vaHVCroDluwtl2rBCEB0AaKwNFJ2YzfVzVCl6DP95Qi1pDEvyMRs
	 jd6zqyqyUVyq88I5l33wjkpkQwIc5OnHnHta3dLEL0rATzY6DowobTlFVd4cjiT+J+
	 f2KoD2V9FjtP2s9kjRL8r2cxuqxDu9rbcmGTeYXbRpLyVuT0r9a2AfCfD1vOdB9PoZ
	 Op9nxt21XcatwWQIdWc4iEPo1K5qe6sVQb0twTdIcMXhfQfsFHBb+1oGgv5ARXDiUR
	 wbbmpIrJzZfdIpXhwAx0ravr7CSsUSFvX6TNBiGIVn7XxOQcPUpubXeDNDRqRwxP3a
	 rMuI9qai1VRGQ==
Message-ID: <b6018f00-020a-46eb-b74f-2b0f42019fff@kernel.org>
Date: Tue, 28 Jul 2026 12:01:22 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ata: pata_parport: KASAN slab-use-after-free in driver_find
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260728024015.2014674-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260728024015.2014674-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 11:40, Shuangpeng Bai wrote:
> Hi Kernel Maintainers,
> 
> I hit the following report while testing current upstream kernel:
> 
> KASAN: slab-use-after-free in driver_find
> 
> on commit: 62efbc768363bc7bb00f0915ad265f34b40d414e (2026-07-27)
> 
> To help trigger the bug more reliably, we applied a minimal diagnostic patch
> that only adds a delay.

Can you share that patch/diff? That would make it easier to figure out where the
race is because you are not describing anything here. The stack trace helps, but
without being able to reproduce (I do not have the hardware), this will be hard
to fix.

> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/a8a1b5339bc41944c2f80d9f87e01a7e

This site has a broken certificate and Firefox does not want (rightly so) to get
me there. So not touching this.

> 
> I'm happy to test debug patches or provide additional information.
> 
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> 
> [  755.753286][ T8297] BUG: KASAN: slab-use-after-free in driver_find (drivers/base/bus.c:1430)
> [  755.754175][ T8297] Read of size 8 at addr ffff88812200f490 by task repro.sh/8297
> [  755.755320][ T8297] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  755.755331][ T8297] Call Trace:
> [  755.755341][ T8297]  <TASK>
> [  755.755344][ T8297]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> [  755.755393][ T8297]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
> [  755.755478][ T8297]  kasan_report (mm/kasan/report.c:595)
> [  755.755487][ T8297]  driver_find (drivers/base/bus.c:1430)
> [  755.755502][ T8297]  new_device_store (drivers/ata/pata_parport/pata_parport.c:649)
> [  755.755610][ T8297]  kernfs_fop_write_iter (fs/kernfs/file.c:345)
> [  755.755615][ T8297]  vfs_write (fs/read_write.c:595 fs/read_write.c:687)
> [  755.755678][ T8297]  ksys_write (fs/read_write.c:739)
> [  755.755703][ T8297]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> [  755.755717][ T8297]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> [  755.779923][ T8297] Freed by task 8297 on cpu 0 at 755.752571s:
> [  755.780598][ T8297]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
> [  755.781128][ T8297]  kasan_save_free_info (mm/kasan/generic.c:584)
> [  755.781700][ T8297]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
> [  755.782222][ T8297]  kfree (./include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
> [  755.782658][ T8297]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 ./include/linux/kref.h:65 lib/kobject.c:737)
> [  755.783163][ T8297]  driver_find (drivers/base/bus.c:1429)
> [  755.783659][ T8297]  new_device_store (drivers/ata/pata_parport/pata_parport.c:649)
> [  755.787092][ T8297] The buggy address belongs to the object at ffff88812200f400
> [  755.787092][ T8297]  which belongs to the cache kmalloc-192 of size 192
> [  755.788598][ T8297] The buggy address is located 144 bytes inside of
> [  755.788598][ T8297]  freed 192-byte region [ffff88812200f400, ffff88812200f4c0)
> 
> Best,
> Shuangpeng


-- 
Damien Le Moal
Western Digital Research
