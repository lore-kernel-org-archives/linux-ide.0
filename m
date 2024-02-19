Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629379D1
	for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335012; cv=none; b=tYel3+/wF6oqPZen1wqLK0/NDh0xg5IWtwJm+e51Q6jFEnmwoVRoneNSGjqty/ExLj2wbC4j5Qv0j3D66R7OuzuuJTDMywBKcJiznN/pM+fnzIc1DPf/e2tYfAPJz/V1OTabdg07sVr1IVutdTzbSXiwJtarT7QjBthAPLMYY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335012; c=relaxed/simple;
	bh=/UPbtbTAdJYaVlMzWBWUJBWWC0z3Vpj1G2yU44smyUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB6qQDhcmgGykGS7mlUPoJmXvIiXkjofZMWr2swJzdkDooYevPnjcfwUV1Ravuhf3TVOuX0TnPRu9ntFtRLGroYPX7XtBRdKq950Uu2iA3YSf79flS78NLaNcJU3KvcWFUtfeEeMW0IbIAMgWM85itxoCDVWDkSM7Mh0JdLgwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jarW3oit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jarW3oit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A28DC433F1;
	Mon, 19 Feb 2024 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708335012;
	bh=/UPbtbTAdJYaVlMzWBWUJBWWC0z3Vpj1G2yU44smyUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jarW3oitEzzD1itICsr7oAdkLlsTNcEKlM8LxCe+RtndmEdnbDSr44GESyWldQQpw
	 10ZyVFGQRw5fhiH6VbkSoGD/8/+orBV0/urYF9n56pKFbYriKL2SNLMhjbq4hr8xPf
	 YEp/eA5OoC5Fm40v7xfgqGVGxUPLx1OWKQ7uaWks9Bz0wDKNu5cDGgCo9GQ3q1lm70
	 j1Q3pDDtqdYThwB8Mg2mWFTP/uVtcz+LOwKiv2XxBIFyi+siCTXNnBbmo/6IKrIilG
	 hM56SQia++Tjii25BFuWQS0g65FAtdV7k1rc0KBajcYziZ8UJIecZbAz+XjVQJoVL8
	 BnUEZjoAgdnyQ==
Date: Mon, 19 Feb 2024 10:30:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Andrey Jr. Melnikov" <temnota.am@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ahci: asm1064: correct count of reported ports
Message-ID: <ZdMfn5bp19qd3vft@x1-carbon>
References: <20240214165758.986896-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214165758.986896-1-cassel@kernel.org>

On Wed, Feb 14, 2024 at 05:57:57PM +0100, Niklas Cassel wrote:
> From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
> 
> The ASM1064 SATA host controller always reports wrongly,
> that it has 24 ports. But in reality, it only has four ports.
> 
> before:
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> 
> after:
> ahci 0000:04:00.0: ASM1064 has only four ports
> ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> 
> Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

While I agree with Andrey that we should change the quirks that use
saved_port_map to instead use force_port_map (so that we don't have
two different ways to apply port_map quirks), that clean up can be
done on top of this fix.

---

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.8-fixes
