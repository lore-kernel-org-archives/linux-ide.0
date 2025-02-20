Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E581F4613;
	Thu, 20 Feb 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053096; cv=none; b=uq7mBC1QxOblj2Phkqdw/P3ppSYU09h0JfyNwlsnu7ZbKT/91x++geqGzUJ74gz4/wECEvyfl8Y4RSC2n8vpHrkoLkAIBPPAvShvCalfQcAvaL5kogX/hjdx1VbT6sewvAYN32YNVt45CFVJ6K3VcH5naQjOc8Faurs9D2QfUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053096; c=relaxed/simple;
	bh=TdLsJgot43HS8ozE4DoJoCa1+9b5p94PlkixZOt2CSA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=soatDDDPS09c1vj8lqx1VuyVEMueLajxji07QR3zn47SELrnQaSRCmqIpRSMqKR+Olp52PanaX+kDWk0jXtK8wwudXHu5vWd5EtuR+yRaxhHQxafZ1PGc+bdJAjq5OEqKeSB2DHYXvJ+74X7kkOL6DINGsf4dIDCkWTMToMgon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxbHBwZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxbHBwZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3304DC4CED1;
	Thu, 20 Feb 2025 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740053096;
	bh=TdLsJgot43HS8ozE4DoJoCa1+9b5p94PlkixZOt2CSA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=AxbHBwZoTWTTse0tSTM308s0Kxco4NivOKtlpNgnMeqIKBFa7gEkqo5UQn1K+8Q3Y
	 uOYFAjsaTt0Z1uQNfP/9ghpEVZxph6DYQQHnxz4q9SJEATZhhMvIhHJwPArKgNmkOd
	 VwQbtmWrWAgM71X0m7S9SkPSaLJJmS9F0E5vq8Cfilq3a6+6tyAUGoLP94ftqKplS0
	 ABbsVMEUtSDGPpo7Q9jIcHfLX9jZaUT1IZJJTwNpsNVDJaizvIoiYamknDLLbTko0F
	 sPZd2DBTwWFZd9pDKAKQpVitZFdqqXSy06jxchddOOjFnWG3UPAKcTUO8CUgzmN10H
	 mmTblhnICUz0w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Salah Triki <salah.triki@gmail.com>
In-Reply-To: <20250220080757.87278-1-salah.triki@gmail.com>
References: <20250220080757.87278-1-salah.triki@gmail.com>
Subject: Re: [PATCH v2] ata: sata_via: Use str_up_down() helper in
 vt6420_prereset()
Message-Id: <174005309493.9438.165196746646567327.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 13:04:54 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 09:07:57 +0100, Salah Triki wrote:
> Remove hard-coded strings by using the str_up_down() helper function.
> 
> 

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ata: sata_via: Use str_up_down() helper in vt6420_prereset()
      https://git.kernel.org/libata/linux/c/0ce4a0d1

Kind regards,
Niklas

