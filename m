Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794056886;
	b=fEMml+I5GZEVY8y4fVVyXKoe5cozo/LdInM5kxII66GXW4iKeHeD8CLzzxo0fn5CSZvP
	 92lXVxW/JyAkIKcrM/eK8mJLM1T5nuKgx0iMjDg+GnyK51RS16CP8GSIFntMCQg7bLB0q
	 aVBAF6hHtgLOM5ORWFv9nX4mHI37xJe8wJcfSKT5YZQDI0z03MAkB/4m12IQ5ueycGZak
	 SeJl+Rdwi3aWe3KeTgPCc552SkrsU+e6uxUGkITUGSXME8/FnYBvDA+0DYX1NSrP7bINm
	 +L8/oKWum/1HrUTkYSHJxZwIR2K+wt8RRy4gnGbc/pf9EDNbwYQgETZ3/N8BN37sTBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056886;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=V4b13mTAwk9r8eg/3JZ+gVEHGm1XSkxtcOvYy09AwVU=;
	b=zE4eCr8HHjVWCpQwDdsQRZjNjLWOBOCYNErd5o3SDn5kjGhxEgqYKTu46Bb54kgPTBfb
	 MT5XBy3BZk1lUTdTXB017X35Apxuc54ISuM6L5HoJmqYl3Qp5O9q5jkkQNftMYSzS3Ela
	 ++/1r2v/SF832vN1KcoucQ41vZYCrDlFV9UVVfIT6YOzNB7RreGEiWLXpOWb+UbCvStHM
	 BU5Q6d/x3juk6YINQxm972xXp2iNzFwwzfpOROCO8XDjfStYfxGcQPBXqZF70uRzLZawn
	 6UwYznPoZRoSfv8q+2mSnCV1azkzFfBBDXlMg6HfwZkrXq6n8LFXdHQpvwkGquniI+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vo4VN2V3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D25606A326;
	Sat,  7 Nov 2026 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vo4VN2V3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2F71F0089F;
	Sat,  7 Nov 2026 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794056885;
	bh=V4b13mTAwk9r8eg/3JZ+gVEHGm1XSkxtcOvYy09AwVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Vo4VN2V3Qt291nkFp95O7T03DmaSoAZ0XiJsJ7hdmPdktHBFFAe20Uq+ZGE/kTlJ5
	 p+CZrB2fgsc2MYF103I0fVadgnmlKSKm+wDjiW1j/On+Q6f+Yn+O9fHm1aATuSLUzL
	 HhfG7t7uLHikOSR3Z3NZo6rZJbBXv6SsqDoU0Qy2nCuGUSbRIGHm/QN8NPxJaBix9r
	 WnwLaV5Jz2E+0Uxt2vxDjclZQmV3n5eE+08vpAvt5b4I86UfdZxd6c2S54DqhzHfG1
	 1t3983xGKGVcidF+jGb/M/dsHrpqALuq+AW6wKR5My3ZgGRoNz24gA/GYhtxx9yNlL
	 zd2cyWKP0Vlmg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261104150614.3231589-1-Frank.Li@oss.nxp.com>
References: <20261104150614.3231589-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH v2 1/1] ata: sata_dwc_460ex: replace chan->device->dev
 with dmaengine_get_provider_device()
Message-Id: <179405688421.943559.6118296661484264171.b4-ty@kernel.org>
Date: Sat, 07 Nov 2026 14:08:04 +0100
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

On Wed, 04 Nov 2026 10:06:13 -0500, Frank.Li@oss.nxp.com wrote:
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change intended. Prepare make to struct dma_device private
> to the DMA engine.
> 
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: sata_dwc_460ex: replace chan->device->dev with dmaengine_get_provider_device()
      https://git.kernel.org/libata/linux/c/8dbe4880

Kind regards,
Niklas

