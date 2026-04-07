Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549312472AF
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547602; cv=none; b=R3SalyqpRy3n5HYym6ISjXBE6FFfdbJDSE8CJ8FhEWykgw2d/3wa7c0rUlFsa8CVVJKu1tLPO9g73WpYNBRdzZ3Qj0y8Kg+Bn5vP/w5SUD1NtK07kjOFu0T19Xcx1pdDEbzPiAqc+mFrIEru4mQ9QY92ErF4Hd6giQj7DxBKFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547602; c=relaxed/simple;
	bh=RTU9fF8UhSjFZMR132FvHE42KU8w/GozSzTfqgwTnSU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cKQE7C5OJ+l56xKDd+AJKitjqRYWV79TArtlBoVDljiwEI0aaFqTkGb9W0ZzdvmqRO6126Ah8Ncq90o0rX1fDh5pxkmLjIgWikIMaWZvRr8r2WiXbHBIiNATY0xmduaHWvvF1sndTrSrv/EJj2nvsTuExYlc4EDXXnMWNGCDw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu2p53v5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu2p53v5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725B3C2BCB1;
	Tue,  7 Apr 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775547602;
	bh=RTU9fF8UhSjFZMR132FvHE42KU8w/GozSzTfqgwTnSU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gu2p53v5qSl3oc+sBd8sl8d3M0QN+BUVIuS8mK7FGXJuv24kMo/iyiRPTZLuVuh6j
	 7Yij9VXV6hcDKm91tgaNAhdSjXwtoAHmNshnWCq97tIPWg8RErEzLp9E/l5A125ev/
	 /v0KRSvJcoGbBgF69at8CcLvF4Dvea/1yxH1+kBa+u/ajrV3T1qWTZpdGFd2Po4vGK
	 abl56CrgTaXvRoX1LDF31VbqC7ORijFE6KbZjgwjw0gddT5a8WL/Y0iphF7XZiVR2W
	 6x7QjIGiOx0seXqibDiPixb0Kv1hTVzESYLwKektNC5f9/i2BDsrTjxVSWzcboYeUx
	 vekFCeDTfCMzA==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Arthur Husband <artmoty@gmail.com>
Cc: dlemoal@kernel.org
In-Reply-To: <20260406222335.379935-1-artmoty@gmail.com>
References: <20260406222335.379935-1-artmoty@gmail.com>
Subject: Re: [PATCH v4] ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585
Message-Id: <177554760118.1191831.7536592442646477281.b4-ty@kernel.org>
Date: Tue, 07 Apr 2026 09:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 06 Apr 2026 15:23:35 -0700, Arthur Husband wrote:
> The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
> support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
> implementation is defective. Under sustained I/O, DMA transfers targeting
> addresses above 4GB silently corrupt data -- writes land at incorrect
> memory addresses with no errors logged.
> 
> The failure pattern is similar to the ASMedia ASM1061
> (commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia
> ASM1061 controllers")), which also falsely advertised full 64-bit DMA
> support. However, the JMB585 requires a stricter 32-bit DMA mask rather
> than 43-bit, as corruption occurs with any address above 4GB.
> 
> [...]

Applied to libata/linux.git (for-7.0-fixes), thanks!

[1/1] ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585
      https://git.kernel.org/libata/linux/c/105c4256

Kind regards,
Niklas

