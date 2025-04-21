Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278E4C7F
	for <linux-ide@vger.kernel.org>; Mon, 21 Apr 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745194068; cv=none; b=HgP4LF8uhNB2qP5fL8p1KO8CF+GsJtk6MPLBvl9CvrSb7HQW+iXpV0R8CqVqTfqpk2H2UbgXAF6gQIKJ7b5PWWu0FxKTmzNINzE2g3Jd7++D8enjjpMOJff1f8R5BrrCxMLpXmWSZJ20jDzrbOnb5VrBFISy6dXfvI7HjBljhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745194068; c=relaxed/simple;
	bh=KQvSPGIZIKFCxRUeo8uoYopk9r2AvnPRF5iOe6zXzc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls2wAlJ3Gr2EiZIbZGUhZU7bmLv3KrdnPAw9MRZA/6ul41VpOQLlk/AEAbyi0I+bKKRqIfnaIjGOqVTz6ig5YqzbE9rTr+2Y15rBg9o6HZK3LzHoyfGSFQiJ3GWgUzz5hRKsCnokGRlzMiguduae6gpvxSnq3aBvm0fJVNCXByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pctlIHU6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pctlIHU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC009C4CEE2;
	Mon, 21 Apr 2025 00:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745194067;
	bh=KQvSPGIZIKFCxRUeo8uoYopk9r2AvnPRF5iOe6zXzc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pctlIHU6Shu7KKSj0SfUYHdP5D5t9G/HYuyv7+H/WwpYc/XFLYdsu8Y0okRBj9HVA
	 hWBrl4LJfaarGTacFzP2qaGTe4UGagX1vCYAZe6ZTUw3yi0wq0VnzSZ0jp4MqhfPgV
	 ZHFJiHONSG8SuZ7/064MG1qrhDbuOLNy101OJZx5KZUbZpj3sKCzNv5kXJ41MgQfZp
	 4xDweQflVR2JGVbzTLZn2wja92CCiOulyajQVdGxom3knxSwu9JGFI09ZY1TCBUwV6
	 +QBZ8CAtuafIOGpI9m0slA2b03En0oNnb3mVlgFrGlC7RVUMncnmq07cD2dO2uttpq
	 /Psqh1OjV40kg==
Message-ID: <9ae95e40-8459-437a-8925-84a9a8bd09e5@kernel.org>
Date: Mon, 21 Apr 2025 09:06:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Successful NCQ commands sense_valid cleanups/fixes
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Hannes Reinecke <hare@suse.de>
References: <20250416093127.63666-5-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250416093127.63666-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 6:31 PM, Niklas Cassel wrote:
> Hello all,
> 
> Here comes some minor cleanups/fixes related to the sense_valid field in
> the Successful NCQ commands log.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Changes since v2:
> -Picked up tags.
> -Changed "1ULL << tag" to "1 << tag" in patch 2/3 (Damien).
> -Improved subject in patch 3/3.
> 
> 
> Niklas Cassel (3):
>   ata: libata-sata: Save all fields from sense data descriptor
>   ata: libata-sata: Simplify sense_valid fetching
>   ata: libata-sata: Use BIT() macro to convert tag to bit field

Applied 2/3 and 3/3 to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
