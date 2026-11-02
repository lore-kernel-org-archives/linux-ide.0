Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634933;
	b=Zo2mGYDNEAKV6oR3TJRnNwodXhWX8W/UeEZnpZImnVZcKPY8gm4wc+yYMcdauXnpdNgK
	 sFqUHHgnymF9pyp2C126qYuxxejElzd+MkjNrjmTgj5aRIsQqPXHDViLhfnG5qEeQZRKk
	 sMm56+W7uRn3W7cdfC3r2WoEvHVysCrptTK1lErwchS/3NgZ8wLwmHCWRloNWUEb1x+dJ
	 qAMe789m4fsVMNLAIqeIKX/j88nGcG5ivV5Hgns8XiPdP9IR2s2xQ8n79T/HHhewz0dPT
	 WV2SArZGkwm/iOtb6w6WcthYihakH1fHnYe+zd198cR9XQLGUe1TZB1AaCHWW9tELEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634933;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=VFnMXppruVXwNFD7M6Ry9+LtIzQZrAxDCq55NmTKUf4=;
	b=kSFkkPOXWI+ja6o7E9+5iFdvj7s08Op/j6Fw1ijXBQZInasohHLE4ZxRX0lq/pukl6s4
	 wKka6e9W5RWgF/LP44+/0iHOzyaV2jm9onM5KmNA/RJf4fCbeGT9vnxYf+1UKYrVIYK3F
	 DMUjdyO3TpSM8QDvYSMoAdW6ihXTSMA7Nv3RFoDxPT4HLOWyCnWK3HvZb4bnLdZWlDPt5
	 00hGOy3eDVr/btnU183MhT6HuuEg8ae9Alh1TqjIA6v6AEWxijAIrsFVQXfA+UflqyRge
	 X4og02oJAz+s/pmKTCd2CXIxhUl6HpWDZMLn7x9r/KwCmeJD/7pZJRb+N9cHbtxyWrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CziZJPkA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC903606A33B;
	Mon,  2 Nov 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CziZJPkA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE68D1F00A17;
	Mon,  2 Nov 2026 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634932;
	bh=VFnMXppruVXwNFD7M6Ry9+LtIzQZrAxDCq55NmTKUf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CziZJPkAH2jWnpMbwYAUgCxbsgs8cZmMGo4IuNxzj7KCESZt0RHIwqAR0UBQB+0/S
	 Ey9GLXthp2gnEqX1w618TW27VK9O+60rSQTbWHsLgamphGyeP42k+gNwIz79mjJwR2
	 fTA1C3f46WSSLelm+Vcr7CT+Wi9yl3D7ub1yptWv43K8oM3fE9ZSPqLw1WXUWsRRF5
	 6qzecqeRnq09wzguRn9bSI7nrkBKWNS7KlefXTB/sp64pfO3pmLLUXtcfyYq5RbJsX
	 6T8lkmU7Xu56NI/sOvw+iJtQyc6HZi/FEhWh+PeQbWxGOgEzE2SzK9s/bSgvv9p32a
	 OxE6kE6W7P2cA==
From: Niklas Cassel <cassel@kernel.org>
To: ysato@users.sourceforge.jp, dalias@libc.org, 
 glaubitz@physik.fu-berlin.de, dlemoal@kernel.org, linux-sh@vger.kernel.org, 
 linux-ide@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Florian Fuchs <fuchsfl@gmail.com>, 
 Colton Pawielski <colton.pawielski@gmail.com>
In-Reply-To: <20261025034410.808796-1-daniel@0x0f.com>
References: <20261025034410.808796-1-daniel@0x0f.com>
Subject: Re: (subset) [PATCH v2 0/2] sh: Fix IDE on landisk (HDD models)
Message-Id: <179363493058.1263381.18150416948695371234.b4-ty@kernel.org>
Date: Mon, 02 Nov 2026 16:55:30 +0100
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

On Sun, 25 Oct 2026 12:44:08 +0900, Daniel Palmer wrote:
> I dug out my landisk to look at kexec for Geert. Since I'm lazy and
> LLMs are good at fixing bitrot I let my LLM work out how to get
> it to boot again.
> 
> There are some other issues (perf is apparently borken, there are
> some issues with the decompresor and big kernels..) but this
> seems to be the only thing stopping it booting with the defconfig.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/2] ata: pata_artop: read the ATP865 mode register through pci_iomap
      https://git.kernel.org/libata/linux/c/1a37d8d6

Kind regards,
Niklas

