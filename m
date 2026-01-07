Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746792E8B75
	for <linux-ide@vger.kernel.org>; Wed,  7 Jan 2026 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780874; cv=none; b=iXfIfJbPQ8YrVjS7Bmpnaj+G+hYV8rzTAEFW26FDtF6ibEj62gfnjGl7FqsU3tN83HR3xBs7zOvA/arCUZWqxPIF/4F0XqPnd4jMKoD9AglXKtnt8y/KxkewZcdM6VYNCuon8wUEYL5jIPMUDtRS4gcCRMz11lzFteiG1t4uWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780874; c=relaxed/simple;
	bh=X0SbD+jGDnDmdAfVbyL54612ctjbhoNjF7WZhCDYMZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSV5E+nSAhH832RS5O0acCEz7tJ1EXXE0ziG1Nz4Jsoaews37WzmhODle+MeSA6cBb0Li316loht/xLbm+hxToBFssAGhisNUDMmlONvkTVySUzq+ttIxFavcjqOc4nyys5aF/eX0S98W7C306iI9BGYQVbyKgl/GWZNOD1xRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfmgptDR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfmgptDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC63C4CEF7;
	Wed,  7 Jan 2026 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767780874;
	bh=X0SbD+jGDnDmdAfVbyL54612ctjbhoNjF7WZhCDYMZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfmgptDRT0MMwUUeLX1cjAWTfca6fXVt1mI+tyYDnYzMSX0IM+Zere0xCRLkmUkmj
	 8S2FTK17cvRlaq7rbHsi+Eq6K2bMziw3Y118DwELwiUU0+GTgQ+mCuXTTt7WEDEkuK
	 PlokdIj2/0pO5du/1EQZ+W3MAPNEuwVp0UYE6CQ/SdOIdiEsS/GzM2NAifNuCcjtcF
	 mlBkMghoy6lPFG50ShELN7HW29FUgqwU+zlcqvKyumFithqXZGh1IVaSjNDQ6EfTZm
	 Onsv2o9ZkJ8jy6qhQseVKAMQ2v9FjjlczlJ4bATm0ZDNBDz3TVIFApTDnbQDQtQe/3
	 IoLpFp0ZdQreQ==
Date: Wed, 7 Jan 2026 11:14:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: wolf@yoxt.cc
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, tj@kernel.org
Subject: Re: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Raptor
 Lake since Linux 6.14.
Message-ID: <aV4yBZkxVD2Olg3X@ryzen>
References: <605b34a7723436284699c9a8e524907b@yoxt.cc>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605b34a7723436284699c9a8e524907b@yoxt.cc>

On Tue, Jan 06, 2026 at 08:57:07PM +0100, wolf@yoxt.cc wrote:
> Hello,
> 
> I am reporting a power-management regression in libata affecting the Intel
> Raptor Lake SATA AHCI Controller, introduced after Linux 6.14.

(snip)

> and 4 apparent dummy ports might be unexpected?
> 
> Manually setting LPM on the affected hosts fails with:
> echo med_power_with_dipm >
> /sys/class/scsi_host/host*/link_power_management_policy
> -bash: echo: write error: Operation not supported

This is most likely because your ports are marked as External / Hotplug
capable by BIOS.

LPM and Hotplug are mutually exlusive in SATA.
So in order allow your ports to detect a hotplug event, LPM cannot be
disabled.


Things you can do:
-Go into your BIOS settings and disable the hot-plugging capability for the
 ports.
-If you don't have such a setting, you can use the mask_port_ext AHCI module
 parameter. Simply add:
 ahci.mask_port_ext=<your portmask here> to your kernel command line


For more info, see this thread:
https://lore.kernel.org/linux-ide/5a74106a-d9db-4e63-b3e6-3857f30a1190@interia.pl/T/


Kind regards,
Niklas
