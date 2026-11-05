Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848793;
	b=BE+GIFn3CLrLPBTSugElrmhvrM5OtI7Sc1hEstnU+pBZFIJYyvW3FyDTNUg4fAQEO74v
	 P+vEcOSvL6+sl5ZbER/RAzG++ZnM7VgKMdxQtbx31zFRqQctZyu7QPNcZv//SZGHd4TcF
	 q8HfrM+t/S2n0zkyg5CwZhv3OfzmAPyPYz6osOTgJu2rS1XZ30hexMDFUO9i8XDbqNe4y
	 Hny6jfMbU3Lue5b/R0UAITrloHP8sGUorITqlHMRaMz0Mfg1FsnVtakT2KaetUfSdNYJA
	 NAo+c0/8zrzYOwUBAMtVClcC6xp5DnrvGIm/GiEnfPj/g/VDsfaBoAZxNKfZM7SmK3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848793;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aaz9g69UgrhCg5Td/Z6tv0L2kZlk47pyEWUUKdmQhPA=;
	b=XkXJ+PC7HcHBGUPpf/FZ1xlFS5d1AvZQL4Jf0qXEIVjuk1a8BN6YJ5TM1w3AdTiNW/zD
	 yXkNRyQb/hRUOuY4m52kzgWWDp4RtXHkYJhRmQ2w0r+umXImU9bx+Er+n5Gnx4XXUepBw
	 x1oZY4EMMWM7UY1Qi8vOpqv2iQqrb4LK7+Q1D/YSMZqKvp4QA4zh1jW2sAO2yfiIf6YJZ
	 UYlFSn5UcFWDEAxlfI/yZcVewyfapgvM87xBv4G6q54aVjZIs59oQWyQntOLJRG1v+7fv
	 OJrI5/i/kCRXheaTobMuf+1dmOGHq69YDrylFb5flo5zNF9FBToE0Z2czVuR/Mrxbow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0MFeLMk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB71606A326;
	Thu,  5 Nov 2026 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0MFeLMk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EF81F000C1;
	Thu,  5 Nov 2026 03:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848793;
	bh=aaz9g69UgrhCg5Td/Z6tv0L2kZlk47pyEWUUKdmQhPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n0MFeLMkftrm5St58fnsEcn7g5wi5JZNql8r+RZ5hISj2ThyFGi2WDzadET7L75mJ
	 pDNLFH57CpBKjSXV1lV+GPg9RdItCZFXgQ+ziEa++t1g/uYUpKpYDtUF5+mm0PsLSg
	 45zqJkkoAgcuGUwAkR4nLwqx3OPoOG47mSpC8IZAYU78O9Uz3V2DoxkWX8PlFop+Tp
	 vrx79lmliW8UBG3Yf8uqBMgkJH0uK/GybTm4P/ExpuugAfhuyodl+GbIAM/dDJTts7
	 tyNlHhMD1G3UP9Aqe2ezZxD58fWoLsXCjVJKMnm/6rhfh0j9EkKFPjPQHNeSrqKqiy
	 8Sx5mTQtEWCIA==
Message-ID: <fcc101f7-f244-4561-85a1-bd704d4644a0@kernel.org>
Date: Thu, 5 Nov 2026 12:19:51 +0900
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
Subject: Re: [PATCH 3/3] ata: libata-scsi: generate SAT sense data for ATA
 PASS-THROUGH(32)
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <202611042211545962bhKeo8yjWPGFgya4g6LG@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <202611042211545962bhKeo8yjWPGFgya4g6LG@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 23:11, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ata_scsi_qc_complete() detects ATA pass-through commands by the ATA_12
> and ATA_16 opcodes only.  ATA PASS-THROUGH (32) uses the variable
> length CDB opcode 7Fh with service action ATA_32, so for those commands
> the function takes the ordinary completion path: the CK_COND bit is
> never honored and the ATA Status Return sense descriptor is never
> built.  A successful command with CK_COND set is reported as GOOD
> instead of CHECK CONDITION, and a failed command gets the generic ATA
> sense data without the ATA register values.
> 
> The byte that carries T_LENGTH and CK_COND is byte 2 for 12- and
> 16-byte CDBs, but byte 11 for a 32-byte CDB, whose byte 2 is part of the
> variable length CDB header.  Detect ATA PASS-THROUGH (32) through its
> service action and read CK_COND from the correct byte.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
