Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615937;
	b=dByah53xJCdT3K4ieejSVVGM+CWRUuCMoz8jnGoN1LEDckabJVzThYe4tstEZFk5p7uW
	 2HVrBItjWYlqjDa1lELoVDSYxPd1jfL1rkWEnzrrCjiTbX5m9uSRAhLinhYzJ4/V6J6Cr
	 VwABy6LDHtrMEmhYfKc8pIvErih2iRHmfcBsxaarAWlgTJ6Al80YuzxoUR2TG2gAlx0O0
	 8I40VUvk8i4GHKrshxigcvZysvbPoXGWkYX+hygk/6YgBzGM/OYksEsu2OrYUv18qkJnP
	 73qW5LG3mxq5OKyyr7lxdji5mWjQsDSYl1xJ6i11lkgfXiN+bptsu0MQhldxr2ytNKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615937;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=GgMZBNV6Sj+FVKmxkL7XsFhidDiwdHXShH/Sd1EzcH8=;
	b=xhdfKGLhwA+WSiFgif8bL+guEBUwF1OebIsxa9SsKCNvcpsj57xI4b4jvgHXmB5e3441
	 2y/giXRzHTTJEYJLn0BnpZrhG7G1JybkmW335/WJq8GTLG+kByRXoosSWC2B5+47B55Pm
	 Kv5BKANJLxlnbwy7Iz3tTkQxuuKlz/GeEilZSNvHCEpF/edPHTTObr7B2QMp8iiZ36ie7
	 UsupZ2Inm8UDfYVuTclC7lVXaJt11Kx67fA+LRmiqBXtn2oLWcXGaBAbuu1wK+K+02pfo
	 L1EMD7wAa2wv7mGSYLMrAVkhnDQ6u6zQfSsYIWHqVInj1rp9ebtHjas3944kKCFrjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WooOBcM0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84955606A324
	for <linux-ide@vger.kernel.org>; Mon,  2 Nov 2026 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WooOBcM0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774BC1F000C1;
	Mon,  2 Nov 2026 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793615937;
	bh=GgMZBNV6Sj+FVKmxkL7XsFhidDiwdHXShH/Sd1EzcH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WooOBcM0OhTA2Y7+lLrYVn7Rs84kQq5voDKevCvKtuCVNQyQYKjr2f1hUg/hVEX4H
	 5I9A/RgtJhf5Uktgl+28BmtqL/mid9jFnxeLC8jVrMMzYPh2HkCmic/vzv9aRNlT4j
	 TF2pu/BVQ7TPm88R7A4MdJfDpcRW86Je46YZqzXjXp/LORe6BK8x65DTjtTZxmx3o8
	 J/ykAsAAbcaz9AKn7klJXx+XR2zD8PhzzkQWNV/LP48WRzsYcXwm7CTOYl9xLKDS41
	 4ZbdSCaM4IYQhkcEGsGGBR/Nx446lkbojOKYHgL10NkMqRt/RSP4qM3YeZYGVMr+LU
	 daTj2c+0rBZig==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20261030090047.407906-2-cassel@kernel.org>
References: <20261030090047.407906-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-eh: Retry non-NCQ commands when their
 sense data asks for it
Message-Id: <179361593620.1216108.18017031062568985341.b4-ty@kernel.org>
Date: Mon, 02 Nov 2026 11:38:56 +0100
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

On Fri, 30 Oct 2026 10:00:48 +0100, Niklas Cassel wrote:
> When a failed command has valid sense data, ata_eh_analyze_tf() asks
> scsi_check_sense() whether the command should be retried, and sets
> ATA_QCFLAG_RETRY if it should. ata_eh_link_autopsy() then clears
> AC_ERR_DEV and AC_ERR_OTHER from qc->err_mask, relying on that decision.
> 
> For an NCQ command, qc->err_mask still has AC_ERR_NCQ, so
> ata_eh_finish() honors ATA_QCFLAG_RETRY. For a non-NCQ command, whose
> sense data comes from REQUEST SENSE DATA EXT, qc->err_mask is now zero,
> and ata_eh_finish() completes the command with scmd->retries set to
> scmd->allowed, without looking at ATA_QCFLAG_RETRY. Such a command is
> thus never retried, even when its sense data asks for a retry, e.g. a
> transient error reported as ABORTED COMMAND.
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-eh: Retry non-NCQ commands when their sense data asks for it
      https://git.kernel.org/libata/linux/c/597be410

Kind regards,
Niklas

