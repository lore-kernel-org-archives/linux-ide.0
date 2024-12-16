Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4233FD4;
	Mon, 16 Dec 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356333; cv=none; b=bQDRxnlXO508puGYYEwIqSdA5x2RtqIxMZF2Ps93jVs73frMEclzurPCNYAVMaLtpH3ARZA8/bjTvZrEu2wjkMf82E792Y/awo/RM1k72HkDF/Z8B475iKCJyxFC1UJRPr6thD5jKIyuB47MBNGRJII20gmVlBXNQuLN5PcuOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356333; c=relaxed/simple;
	bh=+ytGs5iNlpVolKV9HLJ4iLnwUuCFjtQvY6n+F0WZyh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5Uvrp+nr0tc51+KAMzUHJm0ti8wCmp5BxDDi49VO/pDIElypIAd/OX6JmHYAVmVOHXQi30Y5NrJVM7wZ5FovAH1cu8Qomh57fcDBOl2w2thH6CvsFWTjBD8Qz+5zh/DMhMTgLeOEszNBNKiiaDgiGBfAvAku8NrZLVdl4aeon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MURnKrVk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MURnKrVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F41EC4CED0;
	Mon, 16 Dec 2024 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734356332;
	bh=+ytGs5iNlpVolKV9HLJ4iLnwUuCFjtQvY6n+F0WZyh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MURnKrVkgBxMjnHNzFW/0BLFt25beanVPLx9/sEsfZZQIFSMbJb0shloc8DWENC/e
	 mIS9Q/40O/M5oErsuYqzQTqQvtb2xCzG+l69e/5E6uJJcdRk9Y+i5pJ3DF18RRey47
	 ZnuLzyt2TQktf5d5rDn+O7m/uW/r8teohcqOGKaNzukXeJScREary2GzFxbeUbPrq+
	 0L+WdPS7c81VnMDYeHD94DgGcvIQE/cnvCUXe7ltzKJ9Itz0cScyJb+Z28fn+UIQ5u
	 6Wg4gZOF9QZe+rfftinQlkvv6bGSbHSAIdxI0L89Zc+qEysWeYaPcXsMZH8gtwhQav
	 avdd/JePdZRbw==
Message-ID: <80fe376e-a057-4973-ac67-abe92c694bd2@kernel.org>
Date: Mon, 16 Dec 2024 05:38:51 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_gemini: Remove remaining reset glue
To: linux@treblig.org, linus.walleij@linaro.org, cassel@kernel.org
Cc: p.zabel@pengutronix.de, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211235250.136985-1-linux@treblig.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241211235250.136985-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/11 15:52, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Now that gemini_sata_reset_bridge() is gone, we can remove
> the sata0/1_reset members and the code that creates them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to fo-6.14. Thanks !

-- 
Damien Le Moal
Western Digital Research
