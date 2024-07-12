Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD312E4D;
	Fri, 12 Jul 2024 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818962; cv=none; b=IJv7eDzjlS3aHOMixnGEScx2afAd9zzRw0TuOIFTQvZ6Wa0kp+IGMZVkcyDohX6BxqsQmd370sdLU/sPdiLQo61M9WZWm7u7cEG2yai9P4D+StUgC3tbtxuuNo08pDG8ulV/sPkNavM5yJUECMlWPvfE/TApOdftLjIxwWU7KXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818962; c=relaxed/simple;
	bh=0K/OuAnHb6QiF3qFrZxIfx6aj5rwCqwMKgDvfJ4duTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHOHBwZYLmmJKidTvVwJ17NUfa2q139ZlH6b3sC0rx6jXIbfni0wNUKtIQO8YWkiax6vMe/Oy/OkIbFrX8MNI/Y5xqicxEN0KWHg6YLm2VQWvGnoBApc+wIhGEyNB2ciVVl3pTXrWL4g6y/uHS1whmkN1MDS8FpO7LvhPL5NlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYW1tYY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYW1tYY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E5DC32782;
	Fri, 12 Jul 2024 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720818962;
	bh=0K/OuAnHb6QiF3qFrZxIfx6aj5rwCqwMKgDvfJ4duTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYW1tYY7vvgr8ACVIax6iBLHMV9UHYp1tReXUYiL1Ok+0TJdAoYTffJS7t55HNSw3
	 XhrXfxR5fpSrc7dBlQFsdiRHxyNBbNiJjZx2mbWjH9AgbS/kcJ4ynjQ6dQcAXEGra+
	 WnbvEIY2SPmFATmhBIU34ICXJO3ixSLscCq8CfWl8f9HpGzXGUeItNcbviDyvYknyJ
	 /O+9UysxLG9b4LpW1gXvY7bsDutwlScl3QcwU3aJUX87kHDJqRiAFmpIRTsYtAgNII
	 q/KLxwFyrhEuHd7wmnfeLUHWGDme7pzgZo6YzMCBphztSxYgSfQyZF5fCplMsFQRgU
	 OtbBrQgaCNthg==
Date: Fri, 12 Jul 2024 23:15:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZpGdDcuKNcX-Bcir@ryzen.lan>
References: <20240712185740.3819170-1-Frank.Li@nxp.com>
 <ZpGXl7W4h-sCjeGz@ryzen.lan>
 <ZpGZOtjjlcpPBp5d@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpGZOtjjlcpPBp5d@lizhi-Precision-Tower-5810>

On Fri, Jul 12, 2024 at 04:59:38PM -0400, Frank Li wrote:
> On Fri, Jul 12, 2024 at 10:52:39PM +0200, Niklas Cassel wrote:
> > On Fri, Jul 12, 2024 at 02:57:40PM -0400, Frank Li wrote:
> > > Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> > > 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> > > 'fsl,ls1043a-ahci'.
> > > 
> > > Fix below CHECK_DTB warnings
> > > arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible:0: 'fsl,ls1012a-ahci' is not one of ['fsl,ls1021a-ahci', 'fsl,ls1043a-ahci', 'fsl,ls1028a-ahci', 'fsl,ls1088a-ahci', 'fsl,ls2080a-ahci', 'fsl,lx2160a-ahci']
> > > arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci'] is too long
> > 
> > These lines should have been wrapped to 75 lines IMO.
> > I will fixup when applying.
> 
> Thanks, according to my knowledge, computer generate warning, error, log...
> doesn't require wrap.

Yes, that is correct, especially for critical things like a kernel oops etc.

In this case, I don't think a simple CHECK_DTB warning is critical enough to
warrant keeping a line length of 232 columns, but I agree that 'critical
enough' is subjective.


Kind regards,
Niklas
