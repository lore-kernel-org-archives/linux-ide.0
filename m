Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074182E229E;
	Thu,  4 Sep 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977304; cv=none; b=iKtE2CmwzdyWp+7kkZA4Gye8Ij0Fjr0uoS3lCXNZjpKThHSSRtV5OeioqE3l+bH36fLPkVs7CIswc2dwbKSi7rCQOKt6miVUYdQqrxwtgFtqsRaYzoK6iOWekRgWpeL+Cd8VRFZXLLxQZZkIeBliMeyUgqQjzdI08O3cWSU39LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977304; c=relaxed/simple;
	bh=oeux7o7S78ErMfdiBwTr9Z47gi/tPN3gufRN3obUJ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j24uzbT61z6TOf1B9vnzZ6aPY6hSU0zWY7/7a1r97SmvBhVQIke+KY7EjLb67psbybQOyIdB+3lOXPyi5h28eW/eBZkrRrV+FSFt2PozNpLXNt9vy7tAopzZSUJ13b49E7+6LX6pMzmYT01j4joHVunYiS31eWI+TxndY7CuA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EciXTXhZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EciXTXhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADADDC4CEF4;
	Thu,  4 Sep 2025 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977303;
	bh=oeux7o7S78ErMfdiBwTr9Z47gi/tPN3gufRN3obUJ5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EciXTXhZUtF8mge6/PbpxoVuK4dPyf++Vnq6PQszojXqCbddVQf/fkFE/KrXH/lL1
	 En2/TPQY95uqPDF/+Pv0HdIbIMsMxnIJm4Eyadr9QJlC9Far6RVRRI2ve8s56TQ1yo
	 0NUJbO2wJKueXjq8hXRhWqCy5Cesx4HpnGs1pXdZbAkKygsqrCRBnsLKtGzIcUpvtP
	 LAQCjL8Nq8w+Ui7JXxiHHtH5Tbpcqlm/4WGkBlarSV5eWXqut2bxF1gWs4jw3sfe6/
	 9Pvt/a8BaEtPkvnSo1bFjVUHWRzq9EVkLv8vKY/Nm0vJZb8X7QNFbGqDzEr3KbEgYC
	 +bktODvqp/7Xg==
Date: Thu, 4 Sep 2025 11:14:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yulin Lu <luyulin@eswincomputing.com>, dlemoal@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org,
	linux-phy@lists.infradead.org, ningyu@eswincomputing.com,
	zhengyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, fenglin@eswincomputing.com,
	lianghujun@eswincomputing.com
Subject: Re: [PATCH v3 1/3] dt-bindings: ata: eswin: Document for EIC7700 SoC
 ahci
Message-ID: <aLlYkZWBaI5Yz6fo@ryzen>
References: <20250904063427.1954-1-luyulin@eswincomputing.com>
 <20250904063718.421-1-luyulin@eswincomputing.com>
 <8489c13b-6810-480c-9894-bb5c80cfbde0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8489c13b-6810-480c-9894-bb5c80cfbde0@kernel.org>

Hello Krzysztof, Rob,

On Thu, Sep 04, 2025 at 09:10:34AM +0200, Krzysztof Kozlowski wrote:
> > +
> > +  ports-implemented:
> > +    const: 1
> 
> I do not see how you addressed request about firmware. Nothing changed
> here, no explanation in the commit msg.

In Yulin's defence, he did comment that when having the Ports Implemented
register initialized by firmware, the Ports Implemented register apparently
gets cleared to zero when rmmoding the driver (probably because it disables
the clocks and regulators to the controller), thus this suggestion breaks
the use case of being able to reload the driver (rmmod + insmod).

He mentioned this, and asked for advice here:
https://lore.kernel.org/linux-ide/2cc9f2ff.6a2.198e04fd36e.Coremail.luyulin@eswincomputing.com/

After no reply he asked the same question again:
https://lore.kernel.org/linux-ide/692e11ca.843.198f0337528.Coremail.luyulin@eswincomputing.com/

I assume that Rob simply missed those messages.

Anyway, I provided my 50 cents here:
https://lore.kernel.org/linux-ide/aLBUC116MdJqDGIJ@flawful.org/

(I would like to add that I think it is the disabling of clocks and
regulators that causes the register to be cleared, since we do call
ahci_platform_assert_rsts() during the first probe, so if it was the reset
that cleared the register, the first probe should also not have worked.)


Not sure if it relevant to mention this reply to Rob's review comment in the
commit message, but perhaps it should have been mentioned in the change log.


Kind regards,
Niklas
