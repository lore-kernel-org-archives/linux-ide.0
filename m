Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848197;
	b=fcZ9RkHlGDQfnQDjZcYkST9728C+C2E9v84RN6RZt+nTznNxvmH5uUZ4KM11Antz0dWD
	 ay19/JZN1xFDeg1HEP1AjsqAOZQ/Y/4OsXXjiDkXojZVKT5KM0DOWv4rsU7Ar8IPOw0oL
	 9kG2xc206psbNDDH2k9V3SKCMuEVzJdZkaGKd0bm7E2+6hYEI8q32lLfebcLDFChpGT4f
	 PMqioWSQ98hRJ8WXr4SS/Pwzpg4/0rJ9ZTtg8BhY1pIKR+rf9oal3QKZOI7Q1te1sTgPT
	 kv624saP5MJ2OJn00uYH6zeY2B72AxbAUJe3cO/7Ql43VNr9nwHqA1GIeIaf6jBKv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848197;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cqN94OyTbAoo5Pulz02+wsUsnmx9+whDItOScpWRfF0=;
	b=FAL4QE7YJhOOxrEa/mVEv3tZMdX38+MihvjNapQtS1XGoeKFtwbsS0ZQz5zwCgNLSQA5
	 dBulr79ML0rbtTrthveSo6LQcQyA8uP1ydaHUaRdTQsXoJj/JIT6sUITTX9LmwfZgHEGy
	 CmkBKsQLdslt0T4G4dCvSXSFphVSiEdfVpiHDWjkOjl3jtbLI+MPdN+VCmoNV8oGpXJVc
	 NdEalPMebdIgbHdptaksk3fNnc33eZBfxeFdZ8ojehdBwnSzTDzx3S+cbIFh+u6KXBD8b
	 vf4F66O1MfdUogpp+R6qjvdmsJ3lyw1PqLbhUivhQQimaQL0qNHUwmgURSI1AI/6fTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2LZ8nvl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F51606A337;
	Thu,  5 Nov 2026 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2LZ8nvl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0721F0093A;
	Thu,  5 Nov 2026 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848196;
	bh=cqN94OyTbAoo5Pulz02+wsUsnmx9+whDItOScpWRfF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B2LZ8nvl81kRTYwu+/TbeFMKgo4P2b8Wifmh+Eky4G5ANypCGQh+AAlFSeigc61Fi
	 EsgI0Vzo8OOsh4FudpybOomLh8JBGH411duzlxKUpgf6fiCI1zrdp50j0bwioyGYlV
	 beHy+oWd5qcxbvtb0rUfmBRFzz6vAvUU/NWcX3YQKoQhHYOCc2YUVT6wabFY3EJgE3
	 A8vsaPQhg2WkrNX7twVi1XIgunEKMXxJoePZ7/d+ACdlXBwFLDdT0A2lrdaEJZeW17
	 AVR4yt2XZEv1jlPIcWc9RYrkVX4R356q6Fb4ZYn/ToNqBQiD0e2bjA4Hngd4rTlVay
	 HOvcDHCnEl8yg==
Message-ID: <75557056-6fe8-4097-977b-a0f94ac7b252@kernel.org>
Date: Thu, 5 Nov 2026 12:09:54 +0900
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata-scsi: reject data-in commands with a
 data-out buffer
To: Zhao Gongyi <zhaogongyi@bytedance.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261104130638.37882-1-zhaogongyi@bytedance.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261104130638.37882-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 22:06, Zhao Gongyi wrote:
> SG_IO can submit a data-in SCSI command with DMA_TO_DEVICE. The
> scatterlist can then contain pages pinned without write access.
> ata_scsi_rbuf_fill() writes simulated replies to that scatterlist;
> in the reported case, the copy tried to write the shared zero page
> and faulted in the kernel.
> 
> The same mismatch can affect SG_IO commands translated by libata.
> ZBC IN and GET PHYSICAL ELEMENT STATUS completion handlers can modify
> the receive buffer even if the drive aborts the command. For ATAPI,
> the successful INQUIRY completion also rewrites the buffer in
> atapi_fixup_inquiry().
> 
> Reject these mismatched commands before the buffer is written or the
> command is issued. Report ABORTED COMMAND / DATA IN BUFFER ERROR because
> the CDB itself can be valid; the supplied transfer direction is wrong.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/r/20261027090809.94126-1-zhaogongyi@bytedance.com
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

Looks OK. If needed, we can tweak the sense code later.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
