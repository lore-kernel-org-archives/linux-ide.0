Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615018;
	b=VlaKoLSqrKflJh7k9uX/4l5+Bvz1qalDyutc97i1FB0sp7CZGWBIMVkaRHNU/ajzI79x
	 EVWlGm3azMmzCHTffzGPt5vsW2jhs34Zc/LPP3xaJAZAARGHBy++PVvFrFG0YB3yVVsR8
	 D9XV7vAFDaPwHbeay+J7xmJue/DxTeF5pqTg/48zWLTaeVzbJvH6FAUiOgQNH5u02uiSJ
	 RrbdeohZ+DG6+5z0DyYYu5wa/R/FxLCYAU736dKWRNUeB3lBRo9UFeO3MPSJH15ipznEQ
	 nc/KsjC1ttpoQmg6K67RyE02DsHpsn/B+1/516jmSYvW3qbzdkTF4gpzcrWyMjtOZbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615018;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=J/S/PMjySOVg3mp3rDG7gRScpBRoHnWrd++xQO2/Poc=;
	b=XrmPm8AMMJj6GJBu2VSbtLe2+GRxAUfDnxV5cCwdif9zGPqqal+VTWeX47v1KYBHj8+5
	 ST3R6GtKrWo9hFM6JJphczvdw+uaTyEEhCt9Al48FkaxwdwM5vJhRmfrccjsk386HarBs
	 gKtIvpXFh8dBqxi46rglqV2bRnEnqVFfP+xcgoKPfSIRkQ++fhaHZ/a8SgbIldE6+tsqL
	 AvgSvdTv035ai9hRhkrYPiBHukmDA0oqhuiyEP6MsW1YgVglKCu3fhYhV84QnI/3Qoe3K
	 ZyjV7dMvc5EGv2SuSn+Yq3CB00f8AQXGkaHSHxdN+iBkyRxpPPqNlbBmPogpYe01nmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhi9Vp0T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B9606A324;
	Mon,  2 Nov 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhi9Vp0T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57AF1F000C1;
	Mon,  2 Nov 2026 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793615018;
	bh=J/S/PMjySOVg3mp3rDG7gRScpBRoHnWrd++xQO2/Poc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hhi9Vp0Toqsw1cn/iY+H8NpQHL+IwAhdRbmavcNwgNixrOt2kTl35wYiOw7ZFv/+H
	 M6UzJ22zsUldxvtQjR+CArBekeBPuqJ8lRnoTsb7NxAEFODYsphXbdu2xjYqVxe/0g
	 CO/Gk1PgU/DKNgUF9FUf9wHtGXIW0xyn/Fz7nTQK1cvct0rAJD2ntyAJNw7ltrzkER
	 YNAOZolhnniremtbpG1YF56DFKA6cJk6bVf7j+wTmUFlEhewNXgegJq0FO8DZ+KLbQ
	 1qw7UeQWdwvjIiqmgCMU3idEONey3bnBgNyA8FT99efeDDSuuvWGGegA+9Z1GMlDzz
	 ur6WPsmezojNA==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, dlemoal@kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, yang.tao172@zte.com.cn, 
 zhang.yue5@zte.com.cn
In-Reply-To: <20261020160101007xAtLUWDrReLsKCbDsa5eu@zte.com.cn>
References: <20261020160101007xAtLUWDrReLsKCbDsa5eu@zte.com.cn>
Subject: Re: [PATCH] ata: libata-eh: drop redundant ata_tag_valid() check
 in ata_eh_maybe_retry_flush()
Message-Id: <179361501652.1158579.1072798638583086666.b4-ty@kernel.org>
Date: Mon, 02 Nov 2026 11:23:36 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 20 Oct 2026 16:01:01 +0800, shao.mingyin@zte.com.cn wrote:
> ata_eh_maybe_retry_flush() validates link->active_tag with ata_tag_valid()
> before calling __ata_qc_from_tag(), which itself evaluates ata_tag_valid()
> on the same tag and returns NULL when the tag is invalid.
> 
> Since the NULL return value of __ata_qc_from_tag() is the single source of
> truth for tag validity, drop the redundant explicit ata_tag_valid() check
> and simply return early when qc is NULL.  This mirrors the style already
> used in ata_eh_get_non_ncq_success_sense().
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: libata-eh: drop redundant ata_tag_valid() check in ata_eh_maybe_retry_flush()
      https://git.kernel.org/libata/linux/c/267accfa

Kind regards,
Niklas

