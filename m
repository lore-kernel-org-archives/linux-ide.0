Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF517579;
	Fri, 12 Jul 2024 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804611; cv=none; b=tUXyqPiGiTtoKFSJr4itqo42asN1oNUcMxsCJ5AODK/dOqeRWDj15lUMyvakcX9OUcW/jKbDw08TpRzWNSJDmvOiuAU7bsjAKjiiN3VPF8w1ErmnC25hva3cmRoEK/0dD0LRZH7qufLExvRH2UrAh5+7NcGFCbumd65v87btnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804611; c=relaxed/simple;
	bh=1HMKtHrbTRqVh0VC6CZwij+dHqjPZkIs46totRtmgzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7qIj2I25XlEv/P9LFDUpRCNUy+g5pinoIR2qnV+8ZX+BQS52KnKpQ8DxQNfCIp06sLRZIyITr5uKd2XIVLAomRsWyuAOlCkPgf4OupH/zpPlxV6kZ2KWpDU6DU9cXBTcjtk8beUFY6oq1/6qGVghYuxGYph1EVJkPLyeET9AsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IysmM+IT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IysmM+IT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD71C32782;
	Fri, 12 Jul 2024 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720804610;
	bh=1HMKtHrbTRqVh0VC6CZwij+dHqjPZkIs46totRtmgzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IysmM+ITUnx8j944Fj1MNfy9GOr8CVZFuUkD7v9Y84X5wZz6423UunaadvlNPFZv0
	 MEt33EJEeSsDRV1rpkffUIMbxr70PAedldRsdd+IeOz4JCxil3VoaBUAfx1EpwENhZ
	 LQ2M3qiDrRegebSSwsu37AEAi6BaYmmcfQH1FqekZoKTVaaKV54pJTRqPU2LrvQr8H
	 fWGth+jOg+ta5EbYKpX6eEoFJLzXG+ktVBaSlAiFhHMWfZVAFDd3xXbmWMyemRxLzt
	 9ZCv27Hem0NH2ksveb1GYhp1v7br/vIkrBjUNfrmishdqmhgFBJOnJLQAHpwW8clBY
	 f6Hx1mNPpEK4w==
Date: Fri, 12 Jul 2024 19:16:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZpFk_aypJG1PAB_7@ryzen.lan>
References: <20240712142922.3292722-1-Frank.Li@nxp.com>
 <ZpFJhk_HgQhGAQMU@ryzen.lan>
 <ZpFT8mdkQTrixIvA@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpFT8mdkQTrixIvA@lizhi-Precision-Tower-5810>

On Fri, Jul 12, 2024 at 12:04:02PM -0400, Frank Li wrote:
> On Fri, Jul 12, 2024 at 05:19:34PM +0200, Niklas Cassel wrote:
> > On Fri, Jul 12, 2024 at 10:29:22AM -0400, Frank Li wrote:
> > > Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> > > 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> > > 'fsl,ls1043a-ahci'.
> > > 
> > > Fix below CHECK_DTB warnings
> > > arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci']
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v1 to v2
> > > - rework commit message to show fix CHECK_DTB warning.
> > > ---
> > >  .../devicetree/bindings/ata/fsl,ahci.yaml     | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > > index 162b3bb5427ed..a244bc603549d 100644
> > > --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > > +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > > @@ -11,13 +11,18 @@ maintainers:
> > >  
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - fsl,ls1021a-ahci
> > > -      - fsl,ls1043a-ahci
> > > -      - fsl,ls1028a-ahci
> > > -      - fsl,ls1088a-ahci
> > > -      - fsl,ls2080a-ahci
> > > -      - fsl,lx2160a-ahci
> > > +    oneOf:
> > > +      - items:
> > > +          - const: fsl,ls1012a-ahci
> > > +          - const: fsl,ls1043a-ahci
> > > +      - enum:
> > > +          - fsl,ls1021a-ahci
> > > +          - fsl,ls1043a-ahci
> > > +          - fsl,ls1046a-ahci
> > > +          - fsl,ls1028a-ahci
> > > +          - fsl,ls1088a-ahci
> > > +          - fsl,ls2080a-ahci
> > > +          - fsl,lx2160a-ahci
> > 
> > I think that you should add the following Fixes-tag:
> > Fixes: e58e12c5c34c ("dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format")
> 
> I am not sure if need it because e58e12c5c34c still not release yet.
> Needn't backport. You may squash into e58e12c5c34c if you like.

Fixes tags are used to indicate that the commit Fixes another commit that
introduced a bug. e58e12c5c34c introduced a bug that wasn't there before,
namely a CHECK_DTB warning.

Cc: stable@vger.kernel.org
is used to indicate that the patch should be backported.

In your case, I would use Fixes:, but without Cc: stable.

Anyway, I could add the Fixes tag if we get a R-b tag from a DT maintainer.


> 
> > 
> > Considering that the commit that your are fixing is only in libata for-6.11,
> > and has thus never been in a released kernel version, perhaps the following
> > patch would be better (if it also solves the warnings):
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > index 162b3bb5427e..8953b1847305 100644
> > --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > @@ -12,8 +12,10 @@ maintainers:
> >  properties:
> >    compatible:
> >      enum:
> > +      - fsl,ls1012a-ahci
> >        - fsl,ls1021a-ahci
> >        - fsl,ls1043a-ahci
> > +      - fsl,ls1046a-ahci
> >        - fsl,ls1028a-ahci
> >        - fsl,ls1088a-ahci
> >        - fsl,ls2080a-ahci
> 
> driver have not support "fsl,ls1012a-ahci", which have to fall back to
> "fsl,ls1043a-ahci". and DTS already use 
>      compatible = "fsl,ls1012a-ahci", "fsl,ls1046a-ahci".
> 
> It can't fix 1012's warning. Only fix 1046's warning.
> DT team also don't want to remove fsl,ls1012a-ahci in dts file.

That is not fully true.

Before my proposed patch:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=y freescale/fsl-ls1012a-qds.dtb
arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible:0: 'fsl,ls1012a-ahci' is not one of ['fsl,ls1021a-ahci', 'fsl,ls1043a-ahci', 'fsl,ls1028a-ahci', 'fsl,ls1088a-ahci', 'fsl,ls2080a-ahci', 'fsl,lx2160a-ahci']
        from schema $id: http://devicetree.org/schemas/ata/fsl,ahci.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci'] is too long
        from schema $id: http://devicetree.org/schemas/ata/fsl,ahci.yaml#


After my proposed patch:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=y freescale/fsl-ls1012a-qds.dtb
arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci'] is too long
        from schema $id: http://devicetree.org/schemas/ata/fsl,ahci.yaml#


So it would only fix one of the two warnings for fsl-ls1012a platforms. I see.
Perhaps you should add this additional warning to your commit message.

So the patch has to look like your suggested patch.

You could possible add '- description: PCIe controller in ls1012a'
in front of:
+      - items:
+          - const: fsl,ls1012a-ahci
+          - const: fsl,ls1043a-ahci

Too make it even clearer that this ugly item-list is only needed for ls1012a,
see e.g.:
https://github.com/torvalds/linux/blob/v6.10-rc7/Documentation/devicetree/bindings/pci/ti%2Cj721e-pci-host.yaml#L18-L21


Kind regards,
Niklas
