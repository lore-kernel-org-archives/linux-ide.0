Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAF362128;
	Fri,  3 Apr 2026 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200629; cv=none; b=ls6+9dTaHcwO9YHw4glXRPb3xwbDFRkC6PY4XwCe61AxTou48kiQts1k2NYWQLBCF5AznCh7xgrB4cHKkY1KaLtJ04uZMRjDV+6dcavpZLZIiiankdU6MJsMfwZg7+S5rVxcgBqelB1DHl5m7wGvCFe7KUHz06GHYI39Lq2P7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200629; c=relaxed/simple;
	bh=NoeXl6LlCu8woVXNXocSxpKJEyZV91Iefexafp4rCS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ECCth8NP4KGu6aJdZzJu4uFdcqxWEPXZXX/4Gg3f8FBFBIMFJ+N+ZrFA6qE+oyqMUZTUaqu0QZhe44AnYDSsBF67al4QGomTqCqhRLsDLX2JxdDqrq+TSfwEI/E6r0nyNWE520xWB3jB+feddfeZWJ+Dh301QM0GpDhcVMRgLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2juro3+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2juro3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC4FC4CEF7;
	Fri,  3 Apr 2026 07:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775200628;
	bh=NoeXl6LlCu8woVXNXocSxpKJEyZV91Iefexafp4rCS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k2juro3+zx3iSHUD7EJBJ5RV/Lhy1l22MXxZUDB9RWsB+TrEzFDXLLrYc5QSPHsES
	 ddDzkxwnE46Vt5uvmyu3MpAAdqAVltfzcVMkBONFATOOFJJpvPwAVL7DtviUn75wLq
	 kiB2WDArM+5VOHEIih7/lKA0Vq9KmRkqS+MBZQ9wFeEyOWIGUjnLsE6KzLdguW7A+0
	 WugUP204Aw3fsaZ5d9B29SrscugWQp/46zPYLMWLttNR2vyc2xavlgGSxq+qoXcGP5
	 EN6Od+WQnYKWP2AVJBHfPM+Nup9IB6A7hcy37jYvWHCdSxREepW7iecAglBe5zsIfy
	 otSA7DhkXD/oA==
From: Niklas Cassel <cassel@kernel.org>
To: Viresh Kumar <vireshk@kernel.org>, 
 Haoyu Lu <hechushiguitu666@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260403020710.254-1-hechushiguitu666@gmail.com>
References: <20260403020710.254-1-hechushiguitu666@gmail.com>
Subject: Re: [PATCH v3] ata: pata_arasan_cf: fix missing newline in
 dev_err() messages
Message-Id: <177520062756.2865797.14378088426789278071.b4-ty@kernel.org>
Date: Fri, 03 Apr 2026 09:17:07 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 03 Apr 2026 10:07:09 +0800, Haoyu Lu wrote:
> Add missing trailing newlines to dev_err() messages in pata_arasan_cf.c.
> 
> This keeps the error output as properly terminated log lines.
> 
> 

Applied to libata/linux.git (for-7.1), thanks!

[1/1] ata: pata_arasan_cf: fix missing newline in dev_err() messages
      https://git.kernel.org/libata/linux/c/797f6298

Kind regards,
Niklas

