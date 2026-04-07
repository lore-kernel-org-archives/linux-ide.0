Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E53B38AF
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565865; cv=none; b=VUVSIC8Vd/yD/v2aD15fuL1JIaTmUM0Z9sACsC2EqeTnTUri3H6nOu5j2KcO4oIHZgqF5CrSyYzdHRn+Itx8Pm66w0FIg5huoEnSe7NAzW3CZWd5eIJBgcmmL42PIB62szPZ7a6pCXOtJnb7Dhp5Vkxn1aCXWb7GmsdZvc+ajlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565865; c=relaxed/simple;
	bh=1o9cPXHi8huFedFCD5d7nTMKnwE+omqeHYoD/Xjy3t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQItQ7F+au4eHePioan6TD9BShWKKH2K3pyw3ERZtcwho0ybCdWA0q7WykXPbdJlt4jWrng1Vc29AdVFh5ZmwGbP1KN8cI2mYq4ktIBPtiS9o1WnokUQ4KVVaaKDbL/sHyqY4ZdmFxZFHdrgm9v/peF+Zb/st5Z2eRJIkGzpVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku8mIh/y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku8mIh/y"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b150559bso15258465e9.1
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2026 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565862; x=1776170662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avpVJjB/82Fn3wFIB5WAn73rX6SyUg78TZKUXxBJoVw=;
        b=Ku8mIh/yJj/Tmh9u9Lp07uOrpf3T+AaYgy6KnqTnThSS2ohMtB+zbjLk5ya+Dt83pY
         YVVfl2squBzLA6P3r5nnPpxQI0BEGpX0UQep0t5bWvf/ixq1pYtOJhfNTcmqlKe/Tyg8
         FKEkkDl2WV76HCyXBjGcEYBRMgyt/XCQ3wOiECbgIAfcrdSP+YIrBn+dPY9Q75gWC8QV
         qWPtMrHbGz7Sw3WeT4Gw8WmfZFUAUHbuMNJEjG0fpcTQn3qwj6gtM1jMhGGEMr6GZ57w
         KEoDYQEVlsdN5NZkr6GMeIhuK1jG/kTDbBrtG7Vm9cP6AWawEDyIJ0xoUdlftzMSLeYU
         OG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565862; x=1776170662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avpVJjB/82Fn3wFIB5WAn73rX6SyUg78TZKUXxBJoVw=;
        b=fVts3j11IOyrzLWnyNEq0J58KvJI3CoIT69Vkw8hubH69FSQJmY8/FNheSbJRghs50
         zr7R5OA9x9tDInyhMRlvnwQnbH6MC/ANvfxxUickX8PxXZQylMHjF68cIpIf5N/B0jcz
         XubhEgCeYQYzy3Nn85kb16XaDkNjvQOf8Ty+AEUix48mPUBpg+WA91WTjskooG6S/UVh
         qacuKxm8S+mJvUnF6orHq3fgT+yG3U8cRpsOlcr9te7DqPHUCIYlqK4xUSplfi6D4W0K
         CJDWMqW7QXLCbx6x1IlNAOTvYi1GQnTP172ks5ZrF9yNrnmvrmCKYX0bY6zbrwGHtbP+
         Ot+w==
X-Gm-Message-State: AOJu0Ywu97LczumG4Oorl6un04yrynQsljlEJ3g8Sr7nMsvHodGWyNmZ
	Q52o1pB4S1JdD94o7Q5opbtkUVkOkU5r/ITpwakGlPZaKv2bOo5O0X/D
X-Gm-Gg: AeBDiet4R9ZAhV5+lZ3BjEOZlK7q0cETLX4OE4itIWGCOVl3QqHxvPeleL28ehEhLam
	aEJVVpAPwTnygOKvN3Dt893jtICWl9HiDZjLrLz+tWelZNcCWFpwbR5ykPkZuSfKlAvsCCJBGIs
	3+ETfuCswwSkrMu99jU9YiMX4qW/R8YbxblCmBxFAEORXMMAuA8IYwbazHeGK/Z4crIdkc/p3IX
	Gp0xwYFvIEhBV+QdZ7Se3/QaGzXRUPxVbQnDCsxtxLvyjyqUq7edXCBOWKAlBIOa7jwjufYdeBT
	WmzSzDGiJ6Boqs92de/vshOi+cYnGUadRZEe5o2lNVuxmx5SlewoPbT4We+0epDJxxmQ+Rmzim2
	bbXmCB3+eaA6GE2YmZ3AAbBtfdVcSt2IfOPTCL5q8DOzLQvP2bn29p6TRcF0eGxEJF8eZmPnI6R
	if76w2BQ4FlU4EcaXIfMCJqlG6NQJ7h7fQHUm01gRdEZmQw1/3MWwsuWTVc0vD3+Ks1490ye98x
	gf1RjcH0B/WTjNq079TGSZ5W6dahvVbSBrRfglL0FM9VqOJsFaVx3nRwfPH0gIa5g==
X-Received: by 2002:a05:600c:6305:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-4889978da75mr232604065e9.17.1775565862063;
        Tue, 07 Apr 2026 05:44:22 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:5e00:25f7:695f:5e7c:1831? (p200300ea8f465e0025f7695f5e7c1831.dip0.t-ipconnect.de. [2003:ea:8f46:5e00:25f7:695f:5e7c:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm621310825e9.4.2026.04.07.05.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 05:44:21 -0700 (PDT)
Message-ID: <d355f69a-5963-45e3-9908-1db79e29f37f@gmail.com>
Date: Tue, 7 Apr 2026 14:44:19 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: libata-transport: remove static variable
 ata_scsi_transport_template
To: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
 <05030d56-c59d-474f-8b77-c5d0c456647e@suse.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <05030d56-c59d-474f-8b77-c5d0c456647e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07.04.2026 12:39, Hannes Reinecke wrote:
> On 3/30/26 17:21, Heiner Kallweit wrote:
>> Simplify the code by making struct ata_scsi_transportt public, instead
>> of using separate variable ata_scsi_transport_template.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/ata/libata-scsi.c      | 2 +-
>>   drivers/ata/libata-transport.c | 9 ++-------
>>   drivers/ata/libata-transport.h | 2 +-
>>   3 files changed, 4 insertions(+), 9 deletions(-)
>>
> Huh. Not a big fan of this.
> 
> The idea of using a pointer is that it'll be initialized to 'NULL'
> if the module / file isn't present.
> Exposing a static pointer is tricky in that regard.
> 
Provider (libata-transport) and consumer (libata-scsi) of this static
struct are always built together:

libata-y	:= libata-core.o libata-scsi.o libata-eh.o \
	libata-transport.o libata-trace.o

> Not sure if that is the direction we want to go, but I'll leave it
> to the maintainers to decide.
> 
> Cheers,
> 
> Hannes

