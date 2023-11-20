Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF977483;
	Mon, 20 Nov 2023 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY4DNXZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332B4C433C8;
	Mon, 20 Nov 2023 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700440277;
	bh=OmHLXiOrAgMaNG1uUjFv3wgZ/90zPZx0ShH/mn5WtTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nY4DNXZD0Y9rZhdWVKcsw/rCi5fTazaY29Yos4iEFIDruVJ/E0c4LTR/d33l298JD
	 y8lNmW7ynG1PRuozONgIPkJUm7DSyCn1cv+VMkxtv3tdpfC9DrUG1OnvH3DmoV1ig+
	 AYpRsLiAx+UZ0qcF7g2OP9wYwlwxqgTPFYyGA3jVK/eLSFRQCKi4/cXKVmQ/kmPwOw
	 p2XfdTSGreXOuV62VNs7nUu6G9C1mnSNQxT88ZCeZSrB579nrfbuChEXY33nSExbwW
	 XO/+xUBDZjo/OfiYWMo5NPClKLtzJoe7LsSxB4YpCAbmGiiR816Ekpu7yJ4VD75U63
	 0f1k6d7GOhrfA==
Message-ID: <bdb6a94f-f068-4627-b11b-dae4c152e7c3@kernel.org>
Date: Mon, 20 Nov 2023 09:31:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_pxa: convert not to use
 dma_request_slave_channel()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-ide@vger.kernel.org
References: <497fe3c81b83ea74c4850bc44ea09acf15886b7e.1700296910.git.christophe.jaillet@wanadoo.fr>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <497fe3c81b83ea74c4850bc44ea09acf15886b7e.1700296910.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/23 17:42, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> While at it, also propagate the error code that is now available.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to for-6.8. Thanks !

-- 
Damien Le Moal
Western Digital Research

