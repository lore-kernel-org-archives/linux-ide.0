Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D02DA765
	for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2026 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011541; cv=none; b=fHT3JHs8RmekAg9Ys2+ROXd+YPLbB/U8pO3cqoFVIGOwhD2EJCzMIhTxWHSZGo4LxzJLTDXDK2wdhS3dUbPY38wTN/43W5XX4ReO+pe+HFKG4lOVSLP5ZIzMfuJ8XXacRUq2ukQZ9c2n4UOA6kF1LBXmVyE452yYht837YIwnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011541; c=relaxed/simple;
	bh=N9zrlSTKQS45AFKICqF0j/XBy6/Y0wUUsIg3ODDjpBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zq1OxmT5+XPK768D9ZYnG+BSEzDcKV20vNtqboAqPy9zZK+R4+WkdSUAAZ16BSI8K+62Yyz7nVCdwcDwGZMNRbYIVtARZy1X12URTOlhmU78VpYgL1pkJR69tpw4lbAFwHwUy8vS7cOZcWKfYyNqHSgs0o2Ida3+HdSrvESr+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNtzmO+s; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNtzmO+s"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e12c67a6fso32740971fa.1
        for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2026 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776011538; x=1776616338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bcpisGuz2lQhjFsaoHWs5e0zfTCqxg+SMoBVOvRKSw=;
        b=nNtzmO+sg74EDsBMxCiY4TW5o7PwzRa9giC0oVY8OTrEpNT/hr+3Nupw3WCQ1T74Gd
         k4kjjfihGQ4BGeEPZ5AG2VSRVvTQrpk7+HdyoEJ1m5iwzPp2H8DS9rMZgIqdI1JAQ1sd
         GlMukWuqpVwAz6cFfp6HsFz9CtS0LY8gjmDSVW7MTOHWwGDP5TRj0e4mzsMgqjpWuXfB
         s1dUCFKMEIBIkGekrxFbePm8fhn8AMJ34pJDnUY7Qv4fwflDWG5PrLubyNm3awnKt6jd
         noMiLp5ij3xx1c7Ued85usI9QfoOkmVSV5u8wxfrhwJII29wzJK9BMgHGPPP8s5kddM2
         CkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776011538; x=1776616338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bcpisGuz2lQhjFsaoHWs5e0zfTCqxg+SMoBVOvRKSw=;
        b=hravwI7rgX8jFvF6RI5IMaBla2jMfQbC7v2QUdvamSMjcc63oPL/mvPqfJrCUJEmXg
         S1MtC5GOc4j2TtzpKNWWdiHXj6bsTVZIcLDVwC6uYuzk17Q/eyc9M2HD5fonmpsiOzUt
         +BJhGSy/NgVGPMzCDsorWWohr3Csnzjxh7VSGRU4xk+vXlLQFMHeO+By6kauiJiqZZ9k
         HPp4PVLTlifZzgsgLUQ1AHECJC7qrZbp4/XJMPyul7zl0DMkFWntVwYdMyB/l4Ht1nVJ
         dwd39YdWL4YI/CrcdqVbcdtQKwzXmMR0ydkmlGVSri6FW/yl3zMbmLDMR25VBtaUnqux
         I2Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+0uFesrX0wx+0qGnpeNXNruxzPK11rvWqTotmIzrduu6rVa1P7cQDjkmvAqreio0QG1FJGd9gXrAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp4NaeiGotnzIAAQkH0N9aQXXMjGWZ9wKRbWqojAv9cZYKv24O
	A1SCImFqvwTb6FD0LOPEaQGWTJVD6LI8pD6uSECCci1Z0w6C24ZRpknm
X-Gm-Gg: AeBDiescUApu1YR8WZ7RH0Sm9ut0443/IQ9DEwLH775ABfa+6LyJsc+rb8LbOF71XKL
	X8NmXZWFXTDUza94GNPOgR+ujJhfTe3YykZ2B32qLUSLdoBARZTlZfAEr80q16/4/mxTxfMHimO
	j9D3JlgOlEn6Pjv0yN5eVa0i0Fjql76FMPqcmsyKPEf9/uANpVBbhBd1jJ/48vKR326o/2TN/Re
	eYrstymM3kR8Utjv7xYrdGk3n5JCnObVqiEvtB+gH+Z4Ff1NDocRxoIpwm0818/8LPfkcEdKJlq
	ugtcm6H1OhTjwN0DhYGgGyllAs18pqTtgJl0eQ9t83LoUNfBEvmheh4MPr23sidvcgAHPoOq4Mw
	Gtny+PQR+ounCj+bIhwVxCPOktiKMt5NtWDGkji1B7ZjHCflyE33+9OeFz9/oKsvcVyw7FB61re
	Qn0dha9PJ+ZkT3nj2U8QGevt8vQPx7dLc1KwgVJru0ey7c1oE1N6EQg7x13KaAy4ROXqpJOJqnD
	XcAlmU=
X-Received: by 2002:a2e:8a87:0:b0:38e:2de3:f8ad with SMTP id 38308e7fff4ca-38e4bdcac07mr32216401fa.4.1776011537827;
        Sun, 12 Apr 2026 09:32:17 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:2f6:3ecd:1aeb:dc21:a8b0:f47f? ([2a00:1fa0:2f6:3ecd:1aeb:dc21:a8b0:f47f])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495ae96fsm17725851fa.39.2026.04.12.09.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 09:32:17 -0700 (PDT)
Message-ID: <7cf53a95-76a2-4be9-a57b-0887a28bbe3a@gmail.com>
Date: Sun, 12 Apr 2026 19:32:15 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v=2] ata: libata-scsi: fix requeue of deferred ATA
 PASS-THROUGH commands
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>, Xingui Yang <yangxingui@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260412153637.475606-1-ipylypiv@google.com>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260412153637.475606-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/26 6:36 PM, Igor Pylypiv wrote:

> Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
> during resets or NCQ failures. This deferral logic completed commands
> with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.
> 
> However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
> ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
> to zero. This causes the mid-layer to fail the command immediately
> instead of retrying, even though the command was never actually issued
> to the hardware.
> 
> Switch to DID_REQUEUE to ensure these commands are inserted back into
> the request queue regardless of retry limits.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
> 
> Changes from v1:
> - Dropped the usage of set_host_byte() because it is logically a separate
>   change from what this commit is fixing. set_host_byte() does not clear
>   the status byte and the ML byte.
> 
>  drivers/ata/libata-scsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3b65df914ebb..cd607911d724 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[...]
> @@ -1701,7 +1701,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>  	ap->deferred_qc = NULL;
>  	cancel_work(&ap->deferred_qc_work);
>  	ata_qc_free(qc);
> -	scmd->result = (DID_SOFT_ERROR << 16);
> +	scmd->result = (DID_REQUEUE << 16);

   You could drop the useless parens, while at it...

>  	scsi_done(scmd);
>  }
>  

MBR, Sergey

