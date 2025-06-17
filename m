Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5E290D9E
	for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151691; cv=none; b=VPJzBRSWxncH8kfpaWxE9udrxKfWcsKTYRQ7Ufi3Wkep+oEi70WZ2GyhUOARKPcOAWiflWxZKSubv2b+hoF/HCZNEQ0xfltF9VSeMJuMYllHxHjit1kg2a2v5cclFru1S1pzNKp6/Mn5thL2A4TSzrRVCJh/U+uPTUUsNNobgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151691; c=relaxed/simple;
	bh=lLO2fCjHD5SkdB8etvYes/BgS2gzKuqxZDTspQKbm+E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h2h2q3XfYbKuw74yznOHeyfABDCaC/lTrTFpqGUH1ol0fXgYKIguSGI54PxrxOYeR42wpfkg5zNCgfkP4eXDcsSZGvpl7QCzmNBhZuIIHEENw+AdLJUH6mqsqVeSdLc2eatUfiv8VT21iy5imkL9JRnqVJ1Ke1k0D1AMCBS2p4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBpDIspa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBpDIspa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98366C4CEE3;
	Tue, 17 Jun 2025 09:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750151691;
	bh=lLO2fCjHD5SkdB8etvYes/BgS2gzKuqxZDTspQKbm+E=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=XBpDIspa4ty/hANEkavJeBFqUBxa776v/qycMCoQLX/4xt9XMqhsmELSisHYUX7DR
	 bI5RNg/2i9WFnJFadSM1Khw9+pszeUDLXEd62tJ7WFTBVPys8NlJxdI1mTb+rsRAwU
	 iX2h3dlEpuDsuFK+FVDshl5Sxb2T+6NGK208+YbPlkIH9rGhXjRvfV63qPO2AHFYi8
	 SnK4sO0UKKVgfrLvuvPeowW+QIkoN9G6ZFG+Oq1gjSkh2h/hsl0dNU7y6EL1b4PjAG
	 UUhjpFVpNNXw8w7cXY+Xi1GrymbrjM6lOslcTfKDOpknP1WFM7+xF4EtHVh0NS76GQ
	 GoLccJNeCldHQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
 Mikko Korhonen <mjkorhon@gmail.com>
In-Reply-To: <20250617062055.784827-1-mjkorhon@gmail.com>
References: <20250617062055.784827-1-mjkorhon@gmail.com>
Subject: Re: [PATCH] ata: ahci: Disallow LPM for Asus B550-F motherboard
Message-Id: <175015169032.98629.18402692900345592702.b4-ty@kernel.org>
Date: Tue, 17 Jun 2025 11:14:50 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 17 Jun 2025 09:18:41 +0300, Mikko Korhonen wrote:
> Asus ROG STRIX B550-F GAMING (WI-FI) motherboard has problems on some
> SATA ports with at least one hard drive model (WDC WD20EFAX-68FB5N0)
> when LPM is enabled. Disabling LPM solves the issue.
> 
> 

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/1] ata: ahci: Disallow LPM for Asus B550-F motherboard
      https://git.kernel.org/libata/linux/c/a7b3b77f

Kind regards,
Niklas

