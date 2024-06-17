Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2493161305;
	Mon, 17 Jun 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651548; cv=none; b=pt1m5g1yA+B9TjbvCZwxOec34kNZG+N/9OSPawqm8TmiG7XUOJluRAgrvLX4rJVtQ+LX/wLfYummBwVbA4Iwan8efAywzAqsHnnn3VHbWaMVn8fBRFpvcrj/I82kJWsG8zFmjE2hZEti7r/AiLB+V6wbrpOWIv8cOu+d+CV23fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651548; c=relaxed/simple;
	bh=B4h2jdmZyvsKqtEmvhMKL/aeE5+NO5DlmV/aTD08Fqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJMFCI6+uukKIWFawoecU7MkY/0NZtexupP5i7ObMEHsN24nfY94tCl1sqy5z82q6oaCluxRco3DFhEAJY65INtE5376BJpztMgcwMvypyqWWwnF2AN+vSCmsCJomoxF293a4wn2jcCMioohM5g6l/kunj4YnJH2Ukc8hy0KIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS9gLkow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS9gLkow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17523C2BD10;
	Mon, 17 Jun 2024 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718651548;
	bh=B4h2jdmZyvsKqtEmvhMKL/aeE5+NO5DlmV/aTD08Fqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AS9gLkowOxiwL7qtscRm9qls//wNW9zMo6r6f/CyG+BZCrwcs/rPk0dRUD1GD3gcu
	 CPwAIXIs1y6nhqYp9vhjbmdaslKTh1FV2/TRx/+PSWjjhHPG4OBQ/vbVFEB6w0crOx
	 le5J8cUZbpSAZHfNd6pvFkDx5ZZypOyWKSOihN9Gi+nmDS14tdFFlUFyx+jivEWZ5W
	 DxU70qWc6J6KNNuF6g32hkDl3tGhciVVZPMl83EnzxldeO76L8+ZRDX/EmojKha5R7
	 8kNNfDxAlMqZS1DmN5uptkPMrVeEJz6CDJUPUOG2F1jn9sJ3yfyqxeYyeswRuzf4MY
	 yrFL+jfcbGMJg==
Date: Mon, 17 Jun 2024 21:12:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: convert to yaml
 format
Message-ID: <ZnCKlj_Gp60_2otI@ryzen.lan>
References: <20240617180241.901377-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617180241.901377-1-Frank.Li@nxp.com>

On Mon, Jun 17, 2024 at 02:02:40PM -0400, Frank Li wrote:
> Convert ahci-fsl-qoirq DT binding to yaml format.
> 
> Additional changes:
> - Add reg-names list, ahci and sata-ecc
> - Add fsl,ls1028a-ahci and fsl,lx2060a-ahci
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/ata/ahci-fsl-qoriq.txt           | 21 -------
>  .../devicetree/bindings/ata/fsl,ahci.yaml     | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,ahci.yaml

Should this file perhaps be called:
fsl,qoriq-ahci.yaml ?

Would be nice with some input from DT maintainers on this.


Kind regards,
Niklas
