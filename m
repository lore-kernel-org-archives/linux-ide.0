Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741801;
	b=c7hYH4pr4hZ37aR8SNYi53flLW8krTo7ZL2Xr/SeQ4nTA+VeqeY2RP00dlxiWOCqoHsH
	 Zw7ohPlET48OKn+BDnPKBRaVGvVu9UIC+y10vK0LHiqgHTKWSxyh/eTuVz2c4+2KtZ60j
	 UGtSPB5gWoi6UfPg8OpWrfraUmcg7p88pXU/tWSm7pLxFnB4FjRQvCq2yYUq9U33o/TgF
	 Vz3Q3dRNeU06zxdBgig/Rb+orirqKoOcQr7ymOGrQFJA3XY3RQiKBQE1Den/zuAajYnht
	 /FmiwpE2TXvO0NjHYmmsDowDeB0taWxZB3h3NyVPircvhbjr/MN45USH0/I/pp8R6Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741801;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XefquohLVsnYnykA/hXZvzcPbulywIgpgIsGpyApaF0=;
	b=frdshOC3OngQg5FjCHYV7eLRvRdLex7Amxd7UAhL0FiObplFHP2pXPt98E+Mq+FVPUDQ
	 X83XRQaDOsnY2hxRa194JCl6K+krsTjgtWtk8d1moGZscHbWIbFmc2dSH/ocYACmMBSca
	 V/mB0ahsxlPRe7JmRNuMtHVm6E79ZMS3lHv3F9peILdoVu08OBlYPt2WObGppqTV2dDpS
	 pV6slchF3L3s7RzZ8rpLIHCsZAS4md39xZujMsp0NqP1Hkf72T7Fq9VorOQxOCZyot6Sk
	 PlmHzXvEUL3mzKHFQd9sy3hRZpGMtWAUOs+rzdqd2KP7mA5Xrw2+RqY56/1VpLW74WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GX1rwI4k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C185606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GX1rwI4k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D18C1F0093A;
	Tue,  3 Nov 2026 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741800;
	bh=XefquohLVsnYnykA/hXZvzcPbulywIgpgIsGpyApaF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GX1rwI4kR/gav9zlQBC7lAapk23oFe1AxJfNV4wdLVG2hdiFeBX4XxVJBllrzrA3l
	 buE/3SuRdJ9j9SFEz9gGOzb8dEv0NDMGfjs2jffaPJFoypkqD43KxYR+/NFhlgVZBM
	 NPdY+gWgDq8iVrDQAfzyH0E3krtrEKlo35b5e46syvdssTtNPgMHMLXQA5SbyJBp3Z
	 q0q1Qwrz46Vn60d9Lx8MKOm8dd4Jhfo23HGIFUILUS3R6nvkkhUv6nyS48+bYCIg4O
	 GwHqEUVqN0vdtfQBSEBVOwcwQQZhJSC/zl5/04g+cN5LGKb2MWP6Zwxqcsro+faoKh
	 jOiyyNtQaxP6A==
Message-ID: <5b424f29-29ba-4363-b071-db37dfaf94c0@kernel.org>
Date: Wed, 4 Nov 2026 06:36:38 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] ata: libata-scsi: document the MODE SENSE mode page
 functions
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Hannes Reinecke <hare@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-18-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103205448.931471-18-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 05:54, Niklas Cassel wrote:
> The ata_msense_*() functions generate the mode pages returned by MODE
> SENSE, and are also used by the MODE SELECT mode page handlers to check
> the mode page data. They do not document where their buf argument points
> and what they return, and some of them do not have a kernel-doc comment
> at all.
> 
> Add kernel-doc comments for all of them, stating that the mode page is
> written to buf starting with its mode page header, which matches how
> the MODE SELECT mode page handlers get the mode page, and that they
> return the length of the mode page, including the mode page header.
> 
> No functional change.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
