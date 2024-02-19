Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720282376C
	for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333939; cv=none; b=KjhR1utSmeyvdWxExsDF0dJkcciNyH8rFgsbBseaE9BxfiIa4XnEdLEeXiKzv8ShlvFMIjMYauSAViAcTgybZkZCQWJRGurAQiTOtm9l87+i33fBG3RYY3XVgf1AWHDyG1WD8+S/oMn/ZeCbsTrrubms0ASrSL+nJ27OLZqlnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333939; c=relaxed/simple;
	bh=+fPC026a1YxalC3u3lIYMAP7D25zBT6KPc6bp1aHRI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nohmj8nOmJc8/FIYWKrNjC/6Qzwx6yhDEnYVJWr1Xg1C82DMsTdpM1kKe0V+COV7g0bll73gP593nO0W039HnQ3JS7b/zBi88ORbEaezMEDnsy/sDrm1cgfJ77q4jgTtE22bk6aBgXZ8MNbPOx6rAnvVkYG8tpSztazuZ2i3CeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZe1VyR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZe1VyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53ABC433F1;
	Mon, 19 Feb 2024 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708333939;
	bh=+fPC026a1YxalC3u3lIYMAP7D25zBT6KPc6bp1aHRI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKZe1VyRlSh1UJQ75G20wv6FxXcry3D9eFhGaLKwgvE898ryGCxq7VLiu+AkR20KZ
	 DKX1eSRIy8mNG3judSzQqrkJ19h6sA0uSEaME/dADjC5i/X1hgGtXP6f/kERoPvcrX
	 LNnuFgGQ1rzOy8bN7SCU7G1xOKTLdV6el2n6HrlLNLBiy+wBkPFCol91JP0QPthejV
	 aXI6RmBSd/zDQe+Hg/k5ejHI+KpClAn90MFpCPWeccOpWnE8go8/gl84OTGjTgwjtX
	 t0But8cUx37bXGgC2qYgiiwHaxDCDUeihkwa1ejCinrYGKnszAiVRpibZF3W7Dw5x3
	 aKkN9Aa8iEPCQ==
Date: Mon, 19 Feb 2024 10:12:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ahci minor quirk cleanups
Message-ID: <ZdMbbmOfp5W5VpyX@x1-carbon>
References: <20240214130015.952685-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214130015.952685-1-cassel@kernel.org>

On Wed, Feb 14, 2024 at 02:00:08PM +0100, Niklas Cassel wrote:
> Hello all,
> 
> Here comes some minor AHCI quirk cleanups.
> 
> Kind regards,
> Niklas
> 
> 
> Changes since V1:
> -Renamed boards to start with board_ahci_pcs_quirk_* as suggested by
>  Damien.
> -Moved the entries futher down to keep them alphabetically with the new
>  names.
> -Changed the order of the HFLAGS for the boards to match the new names.
> -Added underscore in _no_sntf to make the name more clear and to match
>  board_ahci_no_debounce_delay.
> -Added new patches 3/4 and patch 4/4.
> -Dropped Reviewed-by tags because of too many changes.
> 
> 
> Niklas Cassel (4):
>   ahci: rename board_ahci_nosntf
>   ahci: clean up ahci_broken_devslp quirk
>   ahci: drop unused board_ahci_noncq
>   ahci: rename board_ahci_nomsi
> 
>  drivers/ata/ahci.c | 46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
> 
> -- 
> 2.43.0
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.9
