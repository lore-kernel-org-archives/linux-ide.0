Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E328FA85
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297107; cv=none; b=PXH6mAuu6xDYGagxX8drsLQQz9ZkFjw9louRMthm56uk03nSHsyLWK2U1zYYMhrk3idAjmNlgeVyNz/0kZGsI1xXloQsHGgKIu8dcC6kKW8RWQ3Z2iZp3gHhUovaMy9GHTL5qu7SU3+40gugHVeIu8a9sntdrKBgCemVQsVf4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297107; c=relaxed/simple;
	bh=FmB78dLdqC3pwWpf5D2r8zLK/PTvg6AkWweIwjK6mes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnx+deK8wge6roCXwGfnoxlyH7CMPagppDGEElacnKWcTviUThXaZ6VaJCIcFz8RTZBBnQJpPfnGNyyWgpXv16omd0M+jlWdqNlcxkopb/LCY6onyFLnHIrrc7Nzgd/GiNV1r/eAEs42uCTxPkBJVtDn7mxuXphMUjs/5L49UC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/9n4OFX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/9n4OFX"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b60de463so2590430e87.3
        for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297104; x=1751901904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isl92AilX2k69PaZbNzPtQN1Btmyukuo21zpXPHla48=;
        b=D/9n4OFXd/JVZhm+4tE/6squPpYjh+1vHcnCWJVazK0bFNdnuVFlvOaRsUbLYtCqPt
         2/bRSvuK4QeXW7INSwFRSUiM/dw/g4NWdTY8bs4MjMWOaYQRTRevJLsvI+fqRZZvToKv
         UhEk6yDHsItPeZJEe6E1W6g8T8iSi6GPZB+TmCd/zAcV51+oiN401JqYoLPkBzct/g8s
         ZMetjUYM8HtKFB05n8sqmtSbK1P/4waPJYiKf/u1o6Rf669oLlMZQ+XKWGSSlTYXEv9q
         jKzmnnJ2Dra95RnbYxozsrOH2+TWxKuWksl9Z0Ora9sO71htydLON87M+tGWUJ5RBiW/
         MefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297104; x=1751901904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isl92AilX2k69PaZbNzPtQN1Btmyukuo21zpXPHla48=;
        b=k8DK+1B/YO1ixpm1v0CPyXroKoED5n8jBqZWhE6GxZRgu7oc6IN95ilZ//01ln0Kp0
         jb1TacBd/AP6gmQw/hfJNEjc/ztIu/MxpjPCpcOI1TnzFWCRdV0eV6A4pAupGPQzVKh+
         E72aRK/CUl+2LURy3O7EdEq4iFlsBoOeslCaZN/QD1/HkKmBK+wjU07+5IT8bpl77vkL
         cGQQW3snzb2YTubVTb+UMToxerPVroUdEm2I8I8xUgAgA+0AFYvQyGors1rqdehDj9+U
         EYhLhTie37IbR74wt4irbnrH0iw7SL1NH858EHNdv6fYhwCaMb5v+ZVByWMTCtpeDCHu
         X49w==
X-Gm-Message-State: AOJu0YwRij8vfeqe1ge5n+tujQ5L73LrZISC+9c5Zsm1HygndePh6l6P
	V3lUMXtKMSb46PsLASV+c/E5+D7XKJs9cTcluhqLXdC7XyP6dNqE/D8gf0MbYQ==
X-Gm-Gg: ASbGncvh6IYmsx1VVUsds4KHDtm9Z9z5Hhunr1YtH8t9ZGttjPvAPXS3ZAzSMmtx2RA
	VBxvWxOH7MV5UJU9yA8lledY4BCrYuM6pq9JynKj3Huy5CAM5Sl8tA3tEkbXImwqzsrzIw7mS3Z
	ek5qcOfX2U2sNNh0tfWarmdkdKATyJ9ilaEww96r8MiAxvhy8270Tj8pAsXGTj9vF9eSf1GOmWp
	8FVLlS2d4CdHERMzl1HujGpK8gOWstqnYYcdkELirVbDa05l8FsTgEuxvdPF/0JGHy3+4F6G9XS
	r6Ycic/KvDLoZJun6FwCZ7bdqrZClA5s4NB6dj1EXmmdUzXR6wzZYxOr7jamaj/P7dLdcgTrVwp
	0LiFUIafR7bSvxJbuQ8Dbp/rvkmFqUV5yo5iGD4oXANEQ37G29vc=
X-Google-Smtp-Source: AGHT+IE5fuwxQYL7OlKgAViv3H6A8oFlVNdAz2ppG+kw4X8fC9gWiVkvL0cvRbmKibNx7Gsa+pUKAQ==
X-Received: by 2002:a05:6512:3083:b0:549:8675:c388 with SMTP id 2adb3069b0e04-5550ba1d504mr4990767e87.52.1751297103455;
        Mon, 30 Jun 2025 08:25:03 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:2df:1610:9bf0:cf53:5ce2:a5a1? ([2a00:1fa0:2df:1610:9bf0:cf53:5ce2:a5a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2a85c2sm1454027e87.136.2025.06.30.08.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 08:25:02 -0700 (PDT)
Message-ID: <e8a5d802-e2f7-473e-b133-e385dd166c95@gmail.com>
Date: Mon, 30 Jun 2025 18:25:01 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] ata: libata_eh: Add debug messages to
 ata_eh_link_set_lpm()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-11-dlemoal@kernel.org> <aGKpK4nidqbMbY9y@ryzen>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <aGKpK4nidqbMbY9y@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 6:11 PM, Niklas Cassel wrote:

>> To facilitate field debugging of link power management related issues,
>> add a debug message to ata_eh_link_set_lpm() to easily track LPM policy
>> changes done from EH context, that is, during device scan and
>> revalidation, error handling, and when a policy change is issued through
>> a host sysfs link_power_management_policy attribute.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/ata/libata-eh.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 7f5d13f9ca73..7134a4ff6535 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -2140,6 +2140,9 @@ static int ata_eh_link_set_lpm(struct ata_link *link,
>>  	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
>>  		return 0;
>>  
>> +	ata_link_dbg(link, "Set LPM policy: %d -> %d\n",
>> +		     old_policy, policy);
> 
> Nit: This is smaller than 80 columns, so it can be one line.

   The new checkpatch limit is 100 columns anyway... :-)

> Reviewed-by: Niklas Cassel <cassel@kernel.org>

MBR, Sergey

