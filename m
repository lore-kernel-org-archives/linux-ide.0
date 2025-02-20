Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41F1C5D7F;
	Thu, 20 Feb 2025 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740024819; cv=none; b=U+KAE7HibOFP6TIKERIMo37pbxSluXYTuCGeitubskjJYlfQUUTLK1Yyx8dyktJuD6kFblsUPcFs8fy1pv+1ab0X1NTpTBjXxVZOwkwaH3L27jofUCf/D3NNGKDhoJx7QaeZiw/xPb5xuhWUEASZ4c5UxpPpcdtpIFKiy0Ip/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740024819; c=relaxed/simple;
	bh=n+4jod0/bbzbgvUJNdSXf+rBuyzwITWZ7bGkvLjVSX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gRhiHgCuxpdiQo/BQ7/A2wBBTZdN95AUBpOYf5BgOR0tyeTBY83gl75Kd+G5G+9FxEZQvMcPmWPgX4fauwNToAubpDNxE100G4SvoMri1AFjV/iRbO/dsWFNQW7cnMWz+2pZyzeDpPN9QdKyGgXC4KeW/AkgsLGI/spptifxQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSNLfeeE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSNLfeeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D0FC4CED1;
	Thu, 20 Feb 2025 04:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740024819;
	bh=n+4jod0/bbzbgvUJNdSXf+rBuyzwITWZ7bGkvLjVSX8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HSNLfeeE1S1lBIcQZDPbxLsziZffSU5qQ0JO6PgF7eDbut6A3qrjNvuBOxRYKQ0wg
	 K8hy/SARoSyWZm+dJewtfgoNBkWrQBwGlAhZPW1qLjUVCSdJpNa7H8S9B79q34xUpC
	 4lAnW5RkR9lYVUNXAg5VZBMFyYKkxR/kpfZNXEd44pv1ECtiPwjYVayhPPbeElsz/0
	 40VMiYvJZoHT6I6ciQrGROpP2qxxi1kiINZnQHPs/96AktAC2yilEpvSiHA0LYpeR+
	 DLkGCTNL+Vnb13EPLJm9XKY4/sU/J5Y9ptjy8Xt27fPSEZpjJygHQtUKnKX/1fLz3U
	 AKTamneKYfpyA==
Message-ID: <d20228bb-c1f4-4ebf-9010-e861e0ddceea@kernel.org>
Date: Thu, 20 Feb 2025 13:13:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Use str_up_down() helper in vt6420_prereset()
To: Salah Triki <salah.triki@gmail.com>, cassel@kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219203554.42727-1-salah.triki@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250219203554.42727-1-salah.triki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 5:35 AM, Salah Triki wrote:
> Remove hard-coded strings by using the str_up_down() helper function.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

This looks OK but the patch title should be:

ata: sata_via: Use str_up_down() helper in vt6420_prereset()

With that fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
