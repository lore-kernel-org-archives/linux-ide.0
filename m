Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C903D9DBC;
	Tue,  2 Jun 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398949; cv=none; b=T9RG1ZVpFacKXc6YUXwOOtC2ked/oKhTDOCePxcv+sRESGihYG+mq4wzB0UXwIS5r/fSx0EKdChJb8BH6JbQkxCVcl+fRMCB5lDY9JQogMk0W6HIj58O/abBLxXeVVuPGrFC03Bo5zS6Z4UWrVT5VM0bjGsl3WU+2yBUPQlwiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398949; c=relaxed/simple;
	bh=phH/rqgRB4N501C8P+a0NYx/S6DfpkmBAFYa/r4iDh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIPW+Ngc2tEtZbA31/2SFXoalr58kHxTNut1K7Z4iJMnlBq9YEBAbDrly+x2x9jFJE3LaI7y685jPmRsqTOqX5mm5F9zFxj5jmK8E1djlvAPoq3ATCtWy57yjW+YMnUXOh8Gk0ychRLDZohFUKjMvxtUSMOjJdYkIBupXxWoIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onFBrRPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onFBrRPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25BC1F00899;
	Tue,  2 Jun 2026 11:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398946;
	bh=c0zbiYwJ63kv53EGDpM+ikOYLQBbc2jQuYZYphDDFpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=onFBrRPeoDqp1t7kKXira0cYaHJT1ioa6qfHegs/2upfpLq8/KdE2RcmJhk9R9wrj
	 Mi89zFlvLjaNwqbGu+ItBO9mFxEVotFrzb8S99ITaVS7kAg97qkmOtkIqeLS7TOSqW
	 0w4mMopzOitdqkz9cwkYjlHuQnueMjTI7DIElktazg8vgxmfuqDGV7iq1HYJX0PEyc
	 R7R85VTwaRPNXnD6Zf7Z+A4sArUGaR7B588mxzXzDg61LHB+xYasIgb6EWOWyrjB9B
	 H8wNvgXzRnWbeifU6G4Xj+J9u7MVdVuKO7RIX++e0it981bGjPGothcEIL5T9wDnAS
	 RkJ83Bj1PoiIA==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org,
	Rosen Penev <rosenp@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ata: pata_ep93xx: COMPILE_TEST and ARM fixups
Date: Tue,  2 Jun 2026 13:15:34 +0200
Message-ID: <178039382780.1476613.14351407667143963560.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530003627.42473-1-rosenp@gmail.com>
References: <20260530003627.42473-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=cassel@kernel.org; h=from:subject:message-id; bh=phH/rqgRB4N501C8P+a0NYx/S6DfpkmBAFYa/r4iDh8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLkdof7JlWKs2v63ZCdavbUsGp/cJbB66CXzdWWprJJc Ss9z0Z1lLIwiHExyIopsvj+cNlf3O0+5bjiHRuYOaxMIEMYuDgFYCKraxj+uyRtzHc8ZuQ3zYo9 o3JB+JaAGK//pgVSLbzvtArWd65OY2Q4tOBhhtxH8Xl8BxYuj5u8bV7Sdda51uIy1+5HzEjxLMj hBAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 17:36:24 -0700, Rosen Penev wrote:
> This small series cleans up pata_ep93xx to allow COMPILE_TEST on
> non-ARM platforms. Patch 1 avoids including ARM-specific asm headers,
> patch 2 switches to unsigned long for the data variable, and patch 3
> enables COMPILE_TEST.
> 
> Rosen Penev (3):
>   ata: pata_ep93xx: avoid asm on non ARM
>   ata: pata_ep93xx: use unsigned long for data
>   ata: pata_ep93xx: add COMPILE_TEST support
> 
> [...]

Hello Rosen,

I applied this series:

Applied to libata/linux.git (for-7.2), thanks!

[1/3] ata: pata_ep93xx: avoid asm on non ARM
      https://git.kernel.org/libata/linux/c/cde1e86e
[2/3] ata: pata_ep93xx: use unsigned long for data
      https://git.kernel.org/libata/linux/c/8bbb394e
[3/3] ata: pata_ep93xx: add COMPILE_TEST support
      https://git.kernel.org/libata/linux/c/590da526



I can see that you have also sent out a bunch of stand-alone patches for
this driver. I'm not sure why you have an interest in this driver
specifically, but considering that a bunch of your fixes were sent out
with only a few minutes apart, I doubt that you can have tested them on
real hardware.

For these ancient drivers, we are mostly interested in real world problems
that you can reproduce on real hardware.

We don't really care that much for theoretical problems reported by AI.
If these problems were serious enough, most likely someone would have
encountered and fixed the problem by now.

One option would be to do like netdev and just remove some of these
ancient PATA drivers.


Kind regards,
Niklas
