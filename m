Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741087;
	b=ntdMzXw/BYUXMSu6AKHLH9vV2UGKF6NTWX1lSBGjI8VzHR/cM8RLEhsnYbh+m7cJpqjZ
	 1lXeDitofyx9ljyEjJOJfP/+vx30NkuAdksk0cB5bKaoX9DSvi3mqgYtz1b+3173UMTvK
	 RuWfqlH1BX4RPh66QAoh1RqFhAORZrlQI6CIWomcSGEe5b55eYZZpsrTtydmXe0ysvzEH
	 LIyZYLzt/G/0aCr5Nxr6SQdSESqZGoOpMeoLHLpdy4v4nx3tMTR2UyCVxFITzx9TvP7eO
	 /gIxUUQPs9EU4DYuuhqH14f3fToS9Vq5KVJRy7bpJRuqjs0bNZbtireLQ/8CrB8hPMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741087;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=49htRd0D3rQ+WWBybn7NnT4lf0wMxN6Ic+Lcl8IDZJM=;
	b=V3pICjXsAlgwe+dnw0iHe3DFZFcetQIwV6erRvm+YPM4gAIBGGoHqh+x5GENEZhKDTS1
	 poji//2HK0dR4+iHg4lHsaQP/blZaHl8iUXQHfPeliqxyi0tV2cGYRkTIaUnb9cndQqUd
	 3pEsvCVo2r0EsD3rKPmYeliY9PkLaWVMH19nBFWMZftGVYvIrWd6WibrMv8Zpnyu3SshK
	 HJWtW/tOb+0ylRtXX6R1V/YlLsd3lZVVdDfS6msqTnpKPDUXQoJQoJWdAFqfoAlxDgRzG
	 rQFgbcv6VUTRbhUMJh8ZA0SB5RsZ4Z19wEEULfmMlSBILZpsJsU/Uh2nsLXAVla3B5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzofG0Vf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B0606A339
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzofG0Vf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6301F00A16;
	Tue,  3 Nov 2026 21:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741086;
	bh=49htRd0D3rQ+WWBybn7NnT4lf0wMxN6Ic+Lcl8IDZJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dzofG0VfiTPuBZlyr/3gHdoXn0kcM2xEKth+jW0TDqt7YDQAuBEN9NsRLlY0uv+nG
	 ENO080M3LwIhGRpDkJRNbgDfc0fxI0sssa8EPEXaO/Lx/WfjO/YrEwGX9bZM2u+SCp
	 PKtOh5DLdTk9S/Tf4iw0cXAWlXqBddJmzrZ7sq6MSHnqh3fZ6DGhbIFOIbMqwhSpAV
	 CydwPY2nZrH1RCY0XhYyolAAP/N3x9VlVgKjWKC9noALgopaQ2BciRHXtL9PlYpt7M
	 TdB6SnmMD+B1zIstzeCWoZkKampBwPQKnVquimIDP6gRaSysu63coLHULdO6thTdJL
	 AjHOyzeIbyVFQ==
Message-ID: <ad77ed01-772e-4adf-a0ea-f7a7f3e394d5@kernel.org>
Date: Wed, 4 Nov 2026 06:24:44 +0900
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
Subject: Re: [PATCH 5/8] ata: libata-scsi: fix MODE SELECT field pointer for
 block descriptor length
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Hannes Reinecke <hare@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-15-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103205448.931471-15-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 05:54, Niklas Cassel wrote:
> ata_scsi_mode_select_xlat() only accepts MODE SELECT parameter lists
> without block descriptors or with a single 8 byte block descriptor. For
> any other BLOCK DESCRIPTOR LENGTH, it terminates the command with
> INVALID FIELD IN PARAMETER LIST, and the FIELD POINTER should point at
> the BLOCK DESCRIPTOR LENGTH field, i.e. at byte 3 of the mode parameter
> header(6) or at byte 6 of the mode parameter header(10), as SPC requires
> the FIELD POINTER of a multiple-byte field to point at its first byte.
> 
> However, the mode parameter header length and the BLOCK DESCRIPTOR
> LENGTH are added to the offset of the field, so the FIELD POINTER points
> 3 or 6 bytes after the end of the block descriptors instead. For
> example, a MODE SELECT(10) with a BLOCK DESCRIPTOR LENGTH of 16 reports
> byte 30 instead of byte 6.
> 
> Do not add the mode parameter header length and the BLOCK DESCRIPTOR
> LENGTH to the offset of the BLOCK DESCRIPTOR LENGTH field.
> 
> Fixes: 7780081c1f04 ("libata-scsi: Set information sense field for invalid parameter")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
