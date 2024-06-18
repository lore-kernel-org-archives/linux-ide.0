Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A71B29A7;
	Tue, 18 Jun 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700326; cv=none; b=t1bn+MVKwLIssQP30WyxTCotUsMjXBMAldK0z4+PvqhSM1tYOZviyoJC8ExlpAYOkuduARB8rfPlZTcOEhT2DGCQB0+02ULxpVEGtriclTRT9cniRSPuP1abq978Iq4D4xzZTKBVM1u4wmlNekpvQmCM5K+SvcuWWB+1khiQE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700326; c=relaxed/simple;
	bh=IAIfOx059NZ6OKbdjowZC+ZcF824yt+ovxu/DQa0BdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1txjvZuHW5czsoZkHCTqAnSleusz4Gbmc3jk5lphoHeBgJqwqjKzL3RlxraoiiBXsztgAC6q2SjiiHnR0duNluxeioIaGUPS5ie1ZM0iP0pTcUi8ZMzZAM3lZqipC+PijL/HhMW3QNWZm3RGqMpqZKXdKZi+rdWnjYHm/OFj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek+gOgOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek+gOgOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0290C3277B;
	Tue, 18 Jun 2024 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718700326;
	bh=IAIfOx059NZ6OKbdjowZC+ZcF824yt+ovxu/DQa0BdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ek+gOgOmgPxK6EduXAMFLoSWRx0oo0GKHqeBN4NuDvecQ2u0vNU0S8JIs5Qh22Plp
	 RWQRL/bTt2ANE6vr2fq/cbCrfC/Q7uTABpvFSLD0hd7twrUFC0fmpovXIdjk2kFLdl
	 3ExBgY2+rPCFgJ4adxteb/sztnIMBpG0EQxX3hMLICIPKDWwgpGdjutaVdXUdTPuEW
	 w6OrHkxT4hb7B7IQQ/5f5oeFFUzG2pKaaGJPNoHKRW68uw5vCYOBriGrkhjm9b2buT
	 R8xY8RrdMVeTEYVAKPSKMM6HszcdkZ7MM3+s8SibIlgRKOjmCzsPteaB3xxt/BCcif
	 fKUW2ny7CtDAQ==
Date: Tue, 18 Jun 2024 10:45:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: convert to yaml
 format
Message-ID: <ZnFJINOphiD1BWyR@ryzen.lan>
References: <20240617180241.901377-1-Frank.Li@nxp.com>
 <ZnCKlj_Gp60_2otI@ryzen.lan>
 <09fad8cc-ff9e-48b4-b954-4f84c61f3ffc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09fad8cc-ff9e-48b4-b954-4f84c61f3ffc@kernel.org>

On Tue, Jun 18, 2024 at 09:42:03AM +0200, Krzysztof Kozlowski wrote:
> On 17/06/2024 21:12, Niklas Cassel wrote:
> > On Mon, Jun 17, 2024 at 02:02:40PM -0400, Frank Li wrote:
> >> Convert ahci-fsl-qoirq DT binding to yaml format.
> >>
> >> Additional changes:
> >> - Add reg-names list, ahci and sata-ecc
> >> - Add fsl,ls1028a-ahci and fsl,lx2060a-ahci
> >>
> >> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >> ---
> >>  .../bindings/ata/ahci-fsl-qoriq.txt           | 21 -------
> >>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 58 +++++++++++++++++++
> >>  2 files changed, 58 insertions(+), 21 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> >>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > 
> > Should this file perhaps be called:
> > fsl,qoriq-ahci.yaml ?
> > 
> > Would be nice with some input from DT maintainers on this.
> 
> This should be rather compatible.

Considering that you gave your Reviewed-by tag, I interpret this sentence
as that you are happy with the filename used (fsl,ahci.yaml) in this patch.


Kind regards,
Niklas
