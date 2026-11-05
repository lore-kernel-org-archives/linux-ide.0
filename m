Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848689;
	b=PBzdGY7TWQTOpS9HKHq5/aNTJ20tCfs8MbjdonZlNegLi+dCHAp062xb/hBDboomWXck
	 uKhOZfw+Q9b9OQk313Dzd2uZu6brks9CZSRq/U5Jj6iaasy9MSlUxre1brCPE0hZV5IED
	 1KPXI9BMuEpTyeG94ZBqvGCpWUMkS9VMZsZyDXLg7MRtxxroNh4Y5eWcmDGBOI4qCapN4
	 284AHus61XTy+O/Azl/tficb+lnthSTvwu+Wg4qF11pAoO8XtWV0jYcq4Ahoy2YfgELYA
	 9o/rhPszJWRRlc79VqeHE+ks7uXESAMvLHgBO2C4aP2QZwdkBcAnIIUAEjtGkXf3J1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848689;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dqt22jZQdl3uFkX9KbcuN7mROihP6n3vK69td7OPSoY=;
	b=cfbbHFi4tUC2gLfPY9qARvuflswHcbKgNfNlzzuiB+xRHdBF7IJt+rwRLnkOaWLcAwQv
	 ovwuuTdLBopDgQ0oP+Ohj99DSrmDiss7K92AkOykfeZ/gEGSzCUGBhTekJCKAiTJ2FwgY
	 75xtZzu174WdpXjVKsFY+RqPeMRMnfpXDHLEALRxaqlHMEeDb6YpzrvLvS21a5znILCpP
	 XNdyw4/HFa07Sct3dwwq4quyW4v6eeFXXxVM5vNwfMHm0wkQtvVhLryCkuPEDaN/G30GD
	 anF/EMkSt1m7SM+CBiqEPe63qOqbo2G+3vI8nKvv2Ob36Ne+XJ+vGqdB1RXD2fzxt7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kcgaA/OL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC89606A31B;
	Thu,  5 Nov 2026 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcgaA/OL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D3F1F000C1;
	Thu,  5 Nov 2026 03:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848688;
	bh=dqt22jZQdl3uFkX9KbcuN7mROihP6n3vK69td7OPSoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kcgaA/OLIKBPI/kAe7gL9uydPd1KXuB2k4qc6rmmZ7bdansH7ggrViDTvqpH3C1GT
	 Au3AVmdhzG8z3IPN5/gznzwOGrNIpbowdz6TTc3RfDFD2jj+Fg4zZCeIFLsI2pkW/Q
	 wAPQGsYaLLMmIP1m/lipqIIsYlx+BGzDJakXoX+tJoZToUIfg5f8QKSafKHeQn2ZhU
	 66aVJwlJ+5xsFOxAK3fMJKAE350naQ6eXMTfa6mAAmAW92lZ93Jz0KTsm2ABgcwiXV
	 oH6cxEELsctm+y+eo6ll/m3L6vNwMYakE0BpvYvuXRyfPXwpJv9Msxy/Pi50hWizND
	 h+rXweZq7cpbQ==
Message-ID: <2fab8b9a-999f-4163-9827-0c09eb3ce815@kernel.org>
Date: Thu, 5 Nov 2026 12:18:06 +0900
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
Subject: Re: [PATCH 2/3] ata: libata-scsi: reject unsupported ATA-32 service
 actions
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20261104221102824qAKUWNkiSgZ1yRnQM8hI9@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261104221102824qAKUWNkiSgZ1yRnQM8hI9@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 23:11, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ata_scsi_var_len_cdb_xlat() handles a variable length CDB only when its
> service action is ATA_32 (ATA PASS-THROUGH (32)).  For any other service
> action it returns 1, which tells ata_scsi_translate() that the command
> has been handled and that scmd->result and the sense buffer were set by
> the translation function.
> 
> No sense data is set in that path, so ata_scsi_translate() frees the qc
> and calls scsi_done() with scmd->result still zero.  The command thus
> completes with SAM_STAT_GOOD even though no ATA command was issued and
> no data was transferred.  Before ATA PASS-THROUGH (32) support was added,
> such CDBs were not claimed by ata_get_xlat_func() and were rejected by
> ata_scsi_simulate() with ILLEGAL REQUEST/INVALID COMMAND OPERATION CODE.
> 
> Fail unsupported service actions with ILLEGAL REQUEST/INVALID FIELD IN
> CDB and point the field pointer at the SERVICE ACTION field.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
