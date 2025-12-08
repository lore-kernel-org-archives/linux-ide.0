Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380F1F7569
	for <linux-ide@vger.kernel.org>; Mon,  8 Dec 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165956; cv=none; b=T3JMrvEAhr9ANJyWUQB0NnmhKZchl/Mao72huub6UeN1iBwotu6MX0R3sEww4b/uFUdNjN1IErwAJtmaUIdVpZK4mfqYQdpJdxm9B/+g496N3aa+hkiokbEQTrUKI1VVLm57lGZan78NzLFQGGdb5cwSdHsEfYaT8y4pntFF5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165956; c=relaxed/simple;
	bh=P0QMmQ1SKG9Pr4GLNgwpp+tEyA6lfAUPOLppY9M8GfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flJ3DtQyyfsMTHBlrmP+PXmVpu6IBlF3O4XqZ/JBY3PadwtxI7N2DDwEB0w+mUzB1bVwb5NmdgRyzg8ixwPdEhYf6jEpZ4TQunhlMwanZVJsS29FdbZoLhoaYZWW+2jkFZY3W1KCURumBligJ7yYt+cm1xnx31v8t7wUznjyoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8hq9AZ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8hq9AZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19235C4CEF1;
	Mon,  8 Dec 2025 03:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765165955;
	bh=P0QMmQ1SKG9Pr4GLNgwpp+tEyA6lfAUPOLppY9M8GfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j8hq9AZ2C6yZhNwGoEJfImiMmNKGoaVkJKSWgiZA/s/fvOgiX8ZKoKaDQQ670MKOL
	 18cSQ0ZVQWN/iNY/QpKBMtsKygFFY5+XHagjQBnhlt+A1lNiuqQObR7dQsypfS832G
	 iv7AH+70lqZTwYHL57ejt/tgR84B7GaX1F70Oy+UAc3FY/F6o8HhOfAOmMiC0ZdTjF
	 ZDypQfLJgfzPpYSRF5RtE5Knz5t7QV50COpRHQ1dhwXWxwBE89d43qSup+F1v6hAOY
	 003EvlsPqpgwk76o29nVwpfj5Ix8QCYn6m8fLM/EsqAKoKK1qffZfRfzbMKR6uOrhg
	 J8t8M8drxHGww==
Message-ID: <9ca385d3-d293-49e8-ada5-afc5f1f4b78d@kernel.org>
Date: Mon, 8 Dec 2025 12:48:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] ata: libata: Improve max sectors quirk handling
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen"
 <martin.petersen@oracle.com>
References: <20251202122129.421783-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251202122129.421783-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 9:21 PM, Niklas Cassel wrote:
> Hello there,
> 
> a recent change:
> commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> 
> bumped the default max_sectors_kb from 1280 to 4096.
> 
> It seems like a lot for SATA controllers are buggy and don't really like
> this, see:
> https://bugzilla.kernel.org/show_bug.cgi?id=220693
> 
> Therefore, improve the max sectors quirk handling, to only have one max
> sectors quirk, which also takes an additional value.
> 
> This reduces the number of ATA_QUIRK_MAX_SEC_XXX quirks from 3 to 1,
> while also making it easier to quirk additional devices with different
> max sector limits.
> 
> 
> The series is based on libata for-next branch, and the intention is to
> queue this series up for v7.0.
> 
> 
> Changes since v3:
> -Pick up tags from Damien.
> -Fix minor review comments from Damien.

Applied to for-6.20.


-- 
Damien Le Moal
Western Digital Research
