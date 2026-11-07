Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054369;
	b=FA0K83ZC/ayaVpL5+qkTfcRs6lh6SBIniwMYPC0ew2LZnNRFKut/q3M4aUuOWygVZZq9
	 geDxfAuU61rKvUxYPY1B+YdKoxudpe7ysuD+2H0Y8xoE0QtSM3jFIRikR1y/TMPu5k29t
	 ZvHBQ9hy+XLsHEyKdxcw4hsdOLGXV605wcvp4bcZWs+pewOQoNjZmFrZ2x9AwPb5+p0ZB
	 rFm/fPiAdHOJ5UHLqUwSBLz58zW7Vi0hOCqtqk7sp3CXRrat1/4BmI+gGHO8tJ2Fv0PDM
	 LoTiPLDEeJ9aJCeSI5JEMUu5ZR5BAKwBr+8ctaOzzSnMK5IuKsoIQYDDr4aeR61F4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=BJRSGcvQMFPpFwAghe7ImMxKahRAtB4NPS9oeeeM5qE=;
	b=v31ssrXdbDenzpMtDVk/SKbzV+AUjlKuMj97jfWiL2ZD7ESRbpsNwauV2AlmicBhmpIV
	 LB5D6pBwWt4XthmSgjpJmqLvrOJUpfgxmGE4AdRIF1pk2xIK5hWhM9+pUwenOIEI+deFv
	 zuTunKEoa9RD/RJM2tvYnkd1amJNtKiUftRSr9tW6WeYqcXm893hAJHw4/+D+bKhkR70i
	 vZfh7Bykq6qaHInLKbxTd4Bwhqt/tGcWKZYPSSlXvKp98GaUJrUuiYdfRgNq0qXFzyD5X
	 3shLV09qokHozRhDO411ghTCGuSW/T3tJsWa+9uh8oAmmYRerA+JdQFNHPLTX/0NgPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN5kuaPx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00034606A326
	for <linux-ide@vger.kernel.org>; Sat,  7 Nov 2026 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN5kuaPx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2B81F0089F;
	Sat,  7 Nov 2026 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054368;
	bh=BJRSGcvQMFPpFwAghe7ImMxKahRAtB4NPS9oeeeM5qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TN5kuaPxxS0StgzzUGs1mTN3Ta93FVxYP9HLxJ3TSS2zcYvK1sME6GFNuWH1wNHwt
	 2mzloQvDUZsFSH6UkotCtMZs1mTrqdLUJyJoAHklLOIVMP7ymnyjidhjhCNG7z7ZEt
	 Ok117+zlOrJIROBMVh7hrA+vtwetFVoYOfwFRH+YBcpgjgrYUeNZ9EMKWW6401g0nF
	 hjytGO4QDrF2t2JwkKbfwEW0bvWlu5CuzSswUQl0jwbrviCjbVwpHUJ1aUg4iGHdAQ
	 93H+9RcDOY36q9HDtOBqYY1zELfpMxa2f0MTboon8Y84Nhylicr2hWCpGR5cq1b0Zt
	 Iva2UJ7E85CrQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: (subset) [PATCH 0/8] ata: libata-scsi: MODE SELECT fixes and cleanups
Date: Sat,  7 Nov 2026 13:25:34 +0100
Message-ID: <179405421066.921267.17063227827127270512.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103205448.931471-10-cassel@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=cassel@kernel.org; h=from:subject:message-id; bh=2AN97UBWEYJrR4vUaBmWocXWeHrdkCdrd0OCFHlVa6k=; b=kA0DAAoWyWQxo5nGTXIByyZiAGrvGL+jpTu8Lyx34ZnKU8Be3fzveOelGBQl1TJK5FzuwHdsY 4h1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmrvGL8ACgkQyWQxo5nGTXIwIQD6A9z3 d7rlRyr+Q9D1WS84iJf/fWoECNBDWnmFN+50Mv4A/RNkcmsWW0P/wVIFDt8z2tMUBYkGLXCgQOW 5/46br94L
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 03 Nov 2026 21:54:49 +0100, Niklas Cassel wrote:
> This series fixes several problems in the MODE SELECT translation of
> libata, most of them related to the FIELD POINTER reported in the sense
> data when a MODE SELECT parameter list is rejected, and makes the MODE
> SELECT mode page handlers significantly easier to follow.
> 
> 
> Most of these bugs were caused by the code being more complicated than
> it needs to be.
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/8] ata: libata-scsi: fix MODE SELECT handling of data after the mode page
      https://git.kernel.org/libata/linux/c/6fde0444
[2/8] ata: libata-scsi: do not accept subpage code FFh in MODE SELECT
      https://git.kernel.org/libata/linux/c/b29c40dc
[3/8] ata: libata-scsi: reject MODE SELECT mode pages with a wrong SPF bit
      https://git.kernel.org/libata/linux/c/073cee4a
[4/8] ata: libata-scsi: fix MODE SELECT field pointer for unsupported subpages
      https://git.kernel.org/libata/linux/c/c25252c0
[5/8] ata: libata-scsi: fix MODE SELECT field pointer for block descriptor length
      https://git.kernel.org/libata/linux/c/d1fa37c6
[6/8] ata: libata-scsi: pass the whole mode page to the MODE SELECT handlers
      https://git.kernel.org/libata/linux/c/83339ee5
[7/8] ata: libata-scsi: set the field pointer when rejecting CDL
      https://git.kernel.org/libata/linux/c/54f42006

Kind regards,
Niklas
