Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848590;
	b=KpW4zjuk78X2/Se1wTYXI1GEHRcM0eFANyr1qdbTBdi+Dw3AE4CHcIDuCbeuN9I+ZY1V
	 FoiJJR7++TfRYDrBg5Ffe6B6cuH2wUBKg3wNm/jWa8TulRx1s2/f8FmLCZcswoYDH2Lxg
	 hr7VMfrBWFE+0goMRi5Bx/nmR/TfSP6f7Gtmt9QNHAX3t4BRE+RfFfQ07QOPgptRuErpj
	 ZCk6B+hRGnQ1e6zY6d2Oh7FN5zCSSil6nwBfvjo6XQP7f2rxxr/viIfuHLqShNx1GHKce
	 RLDzY/b8HQgbIygRiwkGq+eDeLhPWq76UpV6P5/CJo4pGfizbczSQj3Hh77l7+ImkeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848590;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=UyHtLL1HLltieDeV4rWCRiPVTte4r/yeIEGF8Rty6pI=;
	b=MjgqOh2UFXo+npaaGgKgzb3ujbTBHw1m3Ady3KzpBsEfDpUrJvzmMloXg7LnhL+m7mrs
	 EOgxKeo3XWrB1mD7FgX2w/L9s8+UMrc08YQtBu1Dof6uuprQOKhzyh5+ypy/ovW1BFhjn
	 ErUKnpmGPotbGVJKfdmn3Dqj30gF5kwI0Q28+/gDD/qpFDA4YUKJXSQj5xfCr+u0FaJ98
	 weM1U84c/sEK+4eOTnIpQlji1NcleSPAGaNTtycIdQ1Tm/Q2n5wUnqha33zENYnJNqj3g
	 BtII67VAYI1MUwv/C1Ey8hhxSKH4mE7u62VxRcKtfzZPrq+pkbwaym5CmOmTZc5BjjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FZVzI2o/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7A606A329;
	Thu,  5 Nov 2026 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZVzI2o/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB971F000C1;
	Thu,  5 Nov 2026 03:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848589;
	bh=UyHtLL1HLltieDeV4rWCRiPVTte4r/yeIEGF8Rty6pI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FZVzI2o/1Va5PAWd/b2x94WPq1ogJQILLVxvz36+KYSj4J9jIRkF2SD52Q6vIr+2/
	 G0zaJAx7HHWIfFV2bV23xFfOULPUwO4QTdcbnmPQIMgGiZznHvWas1JVu0HcOdrJri
	 ijdf6k3jAoZquwUaZS0JOjABGGzG5ObemJnx5IMGrC+wQSVS3YM7eGHQNANMV88VD1
	 mRx8Tp+ZkffzGzDgRhiOcfPmz2F30VVdF1nL36J+IuGh6/IGslezZg+akbth5VDQA2
	 0oWcrRKPURxpMaOF+G9ee2cGhpZx8Ls0b03+I2FmD6LH3u2Q5IWE6b1RC2KU/KCKBH
	 5LD5Yc3DHWMOw==
Message-ID: <5cbd975c-0f2c-4c52-8c88-2bd64874ab86@kernel.org>
Date: Thu, 5 Nov 2026 12:16:27 +0900
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
Subject: Re: [PATCH 1/3] ata: libata-scsi: fix the multi_count check for
 32-byte passthru
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20261104220939917jqg8_alGN5sACGWq5M9D-@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261104220939917jqg8_alGN5sACGWq5M9D-@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 23:09, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ata_scsi_pass_thru() translates 12, 16 and 32-byte ATA pass-through CDBs.
> For a 32-byte CDB (VARIABLE_LENGTH_CMD with the ATA_32 service action) the
> ATA command descriptor starts at byte offset 9, so the function adds
> cdb_offset when reading the protocol (cdb[1 + cdb_offset]) and T_LENGTH
> (cdb[2 + cdb_offset]) fields.
> 
> The PIO multi-sector sanity check and the multi_count computation,
> however, still read cdb[1] without adding cdb_offset:
> 
> 	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf))
> 	...
> 	unsigned int multi_count = 1 << (cdb[1] >> 5);
> 
> For a 32-byte CDB, cdb[1] is the variable length CDB control byte and
> its bits 7:5 do not carry MULTIPLE_COUNT.  As a result, the sanity check
> that rejects a multi-sector count on a non-multi taskfile is silently
> skipped, and multi_count is always computed as 1 << 0 = 1, so the
> comparison against dev->multi_count either emits a spurious
> "invalid multi_count 1 ignored" warning for devices configured with a
> different multi-sector size or misses a real mismatch.
> 
> Read the count field from cdb[1 + cdb_offset], matching the rest of the
> function, and report the field pointer relative to the same byte so that
> a rejected multi-sector count points at the MULTIPLE_COUNT field instead
> of byte 1.  For 12 and 16-byte CDBs cdb_offset is zero, so their
> behavior is unchanged.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
