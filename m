Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DD15533F;
	Wed, 14 May 2025 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260832; cv=none; b=niv/bbztJwddbQU7KvThvtlt1GK1VsLMbqgp2/hWpEJv2rvagW2LpxzqgiL7UwooOy2AqG/FrCLqjvkmWPMjK9snLQDs/fVo3ag4/eETNSt+Cid0VJY+7DbqqU7TAOuXkYLm6Q4WB/RXJ12S6U6CJvBHZNg87a37wIyRmQVzjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260832; c=relaxed/simple;
	bh=ASwgkb4PbSCNZaG/pv0+lDCFw7kkeNaKYPen/9kVQi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/qRuEhrlaOMOPm2aXTp4ZdVn0t5EljouuCPUu6KwpjaMcAvmPvVxYVnjbVaZONitC8jlLZP4J1/N9Qc9St0rcqPqILR5zZt36EPBkZyYOOLAvDD3s9LITg4qpXlGDKebIa/Aly1ertdimewvW2oOcH65gLZKyFcGvoy87EFrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNe1TCKA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNe1TCKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57AFC4CEE3;
	Wed, 14 May 2025 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747260832;
	bh=ASwgkb4PbSCNZaG/pv0+lDCFw7kkeNaKYPen/9kVQi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNe1TCKAccJBicAu1TalvFldNtstkJOHZ7AHBX1BEIajW41pGAHDpZOKaIpmy1zZ6
	 AHNIRqjkqFDCN/m3vahQPc/hUJZskElWxMjOP6XDEUVd6+K5gwpYq8AU46Yq5P3vZR
	 hTo2MeJf1hLgtq21LFXQEpBiGBZVmS81xY8eFdUJ/SYzyXTK8hKbUlaI94pDUg2P6W
	 l5mJZoWS32K0myXGFnkDZ2PuYDqEjQHlrbzlk/pzEIVQ40wsItrGe6pJLmrOtbF9cc
	 ACIqBCO/0L8wOBvpyL01afeT6oVwhk/4mm0CF9MIbchwjh/O12AWVVnaAeX6FGIFYF
	 71zfJsdorXu6g==
Date: Wed, 14 May 2025 17:13:49 -0500
From: Rob Herring <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: Convert ti,dm816-ahci to DT schema
Message-ID: <20250514221349.GA3133893-robh@kernel.org>
References: <20250512215706.4177925-1-robh@kernel.org>
 <aca3dabe-d050-49c3-88c9-6e76ca63e0ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca3dabe-d050-49c3-88c9-6e76ca63e0ec@kernel.org>

On Wed, May 14, 2025 at 04:24:00PM +0900, Damien Le Moal wrote:
> On 5/13/25 06:57, Rob Herring (Arm) wrote:
> > Convert the TI DM816 AHCI SATA Controller to DT schema format. It's a
> > straight-forward conversion.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Applied to for-6.16. Thanks !
> 
> Note: I will wait a little more for the other patches to see if reviews come in.

Some of this stuff is ancient, so you might not. xgene is pretty much 
abandoned, but there's still a handful of machines around with people 
using occasionally.

Rob
