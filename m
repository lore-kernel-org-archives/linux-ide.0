Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496335957;
	Thu, 15 Oct 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061730; cv=none; b=ACltMrW+0GA0tjGrN/LXjWwNJIMf0HjDw3FrqCYZRGKNCrfhV+8JLD9b+JFQGfLyshKi4kbiQeBjl5/wJcAQlmJdMsayWPsosaQ7RZGCVfh5PGfglMPO3oS//u49+KaB4Xx1iTidWGaIQNnU0IPkVqNsTqgK8s1Nod38dJqVcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061730; c=relaxed/simple;
	bh=9CYKk9PdlU6y5y3b+cUV7pY1Ge9kvJMZ6rLomfzDGww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hmcmuhH30AuFmLivbCj6tPuw6bgxsbZJrX12J5D0NZbGSSnTJlKkXIFVMzfsUBPa0UZLj8JIR/fEYwauuYVKDtu2UtisnOAPNzd9g0RSixtYqoWjoGsloITgL4SJExRCg3nchewve0WzuhR82gh6BJMpaZGno1qp74mZU7DV4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWttyTPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWttyTPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627EB1F000C4;
	Thu, 15 Oct 2026 10:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061729;
	bh=1qn5JoPujOBe4HO50wf2fm70E5p1rFDAaNVm9TnbglU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JWttyTPYX+BGInKF7DGN+25lL3r3uCXBTbtKH/2WgMQ3H9Y47HqlytIvr9bbNOmAC
	 cdYiMciGovKg8fvkEyjU+iSpvyZkVn9ENWJGcXxPe9a8sBqfsW6gBOcDtWKqHTpbTd
	 C4RbV8DEg3L3FtzEaywTRafI3IHfRa53RC5hFnrUbt/kKz4ru/Zlibz9fZAFcQEraK
	 5UKgRwFrtVVUbM2mDIcfyucPtd1eyA92pLl9dtyDKZAC/fEyRJHUHaXpdtTcSzz0aJ
	 NIif7i6GTP27Fflwgm8VS8SBaobEunZNtu78RDbtM6E+ck/SaeterpxcAW1WU2pZBB
	 03KxsQQA6NuGA==
From: Niklas Cassel <cassel@kernel.org>
To: zhoumin <teczm@foxmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <tencent_26064A115A53E4C6D00433C89E1894E2D808@qq.com>
References: <atCHxGZDY4heAXwE@ryzen>
 <tencent_26064A115A53E4C6D00433C89E1894E2D808@qq.com>
Subject: Re: [PATCH v2] ata: ahci: preserve preset port masks
Message-Id: <179206172813.693388.9429491809907793991.b4-ty@kernel.org>
Date: Thu, 15 Oct 2026 12:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 15 Oct 2026 17:41:02 +0800, zhoumin wrote:
> ahci_get_port_mask() returns zero for absent or unmatched parameters,
> overwriting the mask set by the Marvell PATA quirk.
> 
> Update the mask in place only when parsing a global value or a matching
> device entry. Leave the mask unchanged on parsing errors.
> 
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: ahci: preserve preset port masks
      https://git.kernel.org/libata/linux/c/014c29a8

Kind regards,
Niklas

