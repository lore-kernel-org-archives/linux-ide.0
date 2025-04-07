Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EE229B05;
	Mon,  7 Apr 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015943; cv=none; b=XCPAAjJSOeu8/BXuyYvWCJ8+tmIj81M73lRPtWUj1rV7PscTGH2zE+IU68M/0z5q7NhxzBb5xLSADnSD6GaW2c55ka3kAdU4GafXghIUQDCT9oLmf1BUSs2m43gGgWjxWEqIr3ebnM/hpVGGQeHQHz5RkurJmyyJ+108twvvA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015943; c=relaxed/simple;
	bh=4/G3cvGEe4xvan0oxm+xYHqwj2powhM/UZfAPhtWJ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYnhBv8zDjNFR8DlfAMcnIp83srj7mco3y+/Y2/ROAvDAfW7I9cBzZMRbrYTU/AZRoU5lfBDTXtUa8gkMrZhFB0L+dbPPEPLDBI6G7sEE8QLScZveX2YlgIbcgBl8ig5c6ZaOACSp9E9BIQROTL4jvZoE6Cd7mqBaN81C3x+4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSaTxST1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSaTxST1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D4EC4CEDD;
	Mon,  7 Apr 2025 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744015943;
	bh=4/G3cvGEe4xvan0oxm+xYHqwj2powhM/UZfAPhtWJ3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSaTxST16kcog8W4yae36eNy9kf+EKj5Q4FVVUE9RJw33lKkZrv/CoGcqrVXEUsb/
	 kS5bCdWRPvS4DXrGmNLlZ6vuHq8GaXYsiJ5gGZ2UtptfCpPqagll93wSLwd6wSrSmn
	 IWMx9t8BduZt5xOleeCW8xm0t5+qiubb4WrMRSn+jDd75DgSZUVnJpyGis8MR+nLXO
	 yLYo9om3WFOaTJThZWAbbAFWHBQ9tCwPHIEJyob2DV1sULN2ZZiIYrVpoP6nY7Uqc6
	 oiul9bwSFMNAQf4Vxl/Fg1s/lA4sTx0PocefjLuWdVmt7In6L/gspNAnPo+OcbkkuO
	 2r7+IZsieUTqw==
Date: Mon, 7 Apr 2025 10:52:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: Set INFORMATION sense data field
 consistently
Message-ID: <Z_OSQzA04-5v7SR0@ryzen>
References: <20250403212924.306782-1-ipylypiv@google.com>
 <Z-_JExGDyO9pVTON@ryzen>
 <Z_AweMPLRJgBIBF3@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_AweMPLRJgBIBF3@google.com>

On Fri, Apr 04, 2025 at 12:18:16PM -0700, Igor Pylypiv wrote:
> 
> Agree. ATA Status Return sense data descriptor for ATA PASS-THOUGH commands
> already contains the ATA LBA in bytes [6..11] so it seems redundant to
> also include the same in the Information sense data descriptor.   

Damien and I talked about this.

Since this patch only affects non-PT commands, what it this patch actually
solving?

Since for non-PT commands, sense data is not returned to the user.

So unless SCSI core does some specific handling based on the INFORMATION
field (and AFAICT, SCSI core only looks at SK/ASC/ASCQ), I can't see how
this patch can actually solve anything.


Kind regards,
Niklas
