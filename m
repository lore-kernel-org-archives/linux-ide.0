Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E91993B7
	for <linux-ide@vger.kernel.org>; Mon,  9 Jun 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481075; cv=none; b=XSWTuJrIUUfez7VwcjcOOmHmtUUOqsaOt4xf72pg/1h5KUL62ciGjKcj5z4bZzktOUgiuf1aBrqCgvWKCau1CjAkR3AmI2A3OBVpnUfOMjP697ls5TYfb9Xc7mxXu//GZe3QYjUznYfjCsPlY2bdIMS3WA43/TfjnbCeX1Rkw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481075; c=relaxed/simple;
	bh=Gf2OhPCkytJN74aD1azSfh8t2Vbvs/6Vz9zaCW8YTjc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GP89fRrgn2ZT3pkQb3dnFjP8FBl+wUulLCkAMRbllrNWZ87KgKclSgITTP9hqJDt3NhSsfob6Q81UqXovHFB0ZjfxnIi0L8472zKBUR8nH61O5dyg1MIaMMjyxMq173GRij/GExSQA2autkUJF4BhE3oYttrl0K187e98XAgvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dc/QhicT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc/QhicT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749481073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gs2l/XSTwWWEVNnK45Rd+y5ozHte50M5IDoHUKNbzpg=;
	b=dc/QhicTy94ZSKMuHg9pQMjPR72FKFEsTjs8ur95cbjjA4nIrbV+On5tnUOYwlLFnPk8UE
	aCycxz1pH04iFMg5CVPkoPlEB8PqEqBi1Ex/EJWUgQgnlomLn8+URLUMn4R3H0fkcbQ+K4
	LzG+H/0aNw7wuNLTy/xgrKmPJDM7NV4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-ZcsKuBoGOnicT6IcZrWHmg-1; Mon, 09 Jun 2025 10:57:51 -0400
X-MC-Unique: ZcsKuBoGOnicT6IcZrWHmg-1
X-Mimecast-MFC-AGG-ID: ZcsKuBoGOnicT6IcZrWHmg_1749481070
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb61452b27so352289066b.2
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2025 07:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749481070; x=1750085870;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs2l/XSTwWWEVNnK45Rd+y5ozHte50M5IDoHUKNbzpg=;
        b=aThqr8aAqK5CXtEVlEjbHfbEqKmWvS5V3ZUN+TBH/9jeVeeEo7dek4UlOEhgkOBNxn
         mecqqCJaV0xwhj0rushuCvHyf5j6pbLgdNgKU2CTbnGJuq+neC8HJeAxcUzK+4R/dmcd
         cDAuuO1uRunb0tV5t4oZAveqmhm8Eamh+yPzJQizSjlrN9BLNU69ndxOTT4u8eBbeAjL
         ktmfyM6nrmstOKTDmSmVJ1TzZ7QYv3ShbxuDs7tIr4TQYsHKDmkJ9RGYrKo3xQoIebHt
         zW0d2imCfYIW5pYunrO2XjIs7etPZIlao0zwc67JtJTMS3YxST6w+Q7Q9XpZ/VnVQCLK
         fH4g==
X-Forwarded-Encrypted: i=1; AJvYcCW3erSHj7EOm8dK5oyORxdzSp3JoAjb+Zi6dc18jqE/YP6nY4i+0Fiw8+Sa+Jr5pUUdEbjgItiUm50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyois7O95eQW8gfBzRu5Oy/KIFcF+u1PfKWlLI9HNhNtRKbaOXl
	qyLQG6OpicERpcxtklfHrvNNtzLsgC7CE3+oLrmVVrw2/cs8m6TNI7FESN64szmvZwJaIp5y7Rj
	ZWU0pkzfMYnyFSXL1EZ8SJYtZfzYkV8qJbPWfKGR53RNAufNJB75gSeHMB8hO9g==
X-Gm-Gg: ASbGncs4zDNUHIYyCUPvXpNHXKDTBdOU3I+e8ZoGwgdUyZfWO1G3ZHtoc4XWV3FcdY7
	+itBVe/17aXIlOiUl5h2eUpXuztuSSL+Vy5KU2vd6H7fO7TvlC5Z+mzLsRfZyYaN7/+9s50Ajdp
	QnjdUzuwwWXchUS5QdrhTAO8Scc7EmPRwSEi/WeqgGf61pkpc6ZRkYnLtzflHZ/mMS8VNxaOtO0
	JjhgnI4af9IZE1HgNjgmBH9ChIML+KobKGSb3xmgtO2eErX2O2DNRdODgo2kMfqUXg1sLN4GKQh
	SPI4ZFFs4eN2dEStKQ13IJT271qXna2ZO/u7lLeLnV2efquEXOCzdQrwD+PJKOl+so1FViyZ0hL
	DXKYzV2xh7W7GUFsdAB3oPTtxJML6h9+CcsGmcQRPSm/WPl2N9T72FMqXwhCLmVrUpu8xXhRA
X-Received: by 2002:a17:906:f5a5:b0:ad2:4c38:5a22 with SMTP id a640c23a62f3a-ade1aa0f3bamr1174925666b.51.1749481070297;
        Mon, 09 Jun 2025 07:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBkzDndQWT1+aiXYHLYSb17gSIr0BTWhMtJLJcdrUWYlxzL3y30ofLcBLxnMj+TC6zk7byAQ==
X-Received: by 2002:a17:906:f5a5:b0:ad2:4c38:5a22 with SMTP id a640c23a62f3a-ade1aa0f3bamr1174923566b.51.1749481069830;
        Mon, 09 Jun 2025 07:57:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db576basm568215066b.65.2025.06.09.07.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 07:57:49 -0700 (PDT)
Message-ID: <0dd6308d-304f-4677-be0b-4d3b04e6d8f7@redhat.com>
Date: Mon, 9 Jun 2025 16:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: ahci: Refactor ahci_broken_lpm()
From: Hans de Goede <hdegoede@redhat.com>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250609134539.943587-3-cassel@kernel.org>
 <6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Jun-25 4:49 PM, Hans de Goede wrote:
> Hi Niklas,
> 
> On 9-Jun-25 3:45 PM, Niklas Cassel wrote:
>> Currently, the match table in ahci_broken_lpm() contains DMI BIOS dates
>> of BIOSes that are known to be working.
>>
>> Having a list of known to be working versions is usually the wrong way to
>> do things (as this list could theoretically be infinite).
>>
>> Refactor this match table to contain DMI BIOS dates of BIOSes that are
>> known to not be working, such that this list can be extended with BIOS
>> versions (for other boards) that are known to not be working, where there
>> is no good BIOS version (because all released versions are broken).
>>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>  drivers/ata/ahci.c | 34 ++++++++++++++++++++++++----------
>>  1 file changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 163ac909bd06..a6ce172fa928 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1411,27 +1411,39 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
>>  static bool ahci_broken_lpm(struct pci_dev *pdev)
>>  {
>>  	static const struct dmi_system_id sysids[] = {
>> -		/* Various Lenovo 50 series have LPM issues with older BIOSen */
>> +		/* Table contains DMI BIOS dates of BIOSes with broken LPM. */
>>  		{
>>  			.matches = {
>>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X250"),
>>  			},
>> -			.driver_data = "20180406", /* 1.31 */
>> +			/*
>> +			 * 1.31, released 20180406, has working LPM, mark any
>> +			 * DMI BIOS date before that as broken.
>> +			 */
> 
> Note the DMI_BIOS_DATE field is the data the BIOS was build, I would avoid
> the word "released" here since release-notes doucments often contain different
> dates then the actual build date (e.g. see below).
> 
>> +			.driver_data = "20180405",
>>  		},
>>  		{
>>  			.matches = {
>>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L450"),
>>  			},
>> -			.driver_data = "20180420", /* 1.28 */
>> +			/*
>> +			 * 1.28, released 20180420, has working LPM, mark any
>> +			 * DMI BIOS date before that as broken.
>> +			 */
>> +			.driver_data = "20180419",
>>  		},
>>  		{
>>  			.matches = {
>>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T450s"),
>>  			},
>> -			.driver_data = "20180315", /* 1.33 */
>> +			/*
>> +			 * 1.33, released 20180315, has working LPM, mark any
>> +			 * DMI BIOS date before that as broken.
>> +			 */
>> +			.driver_data = "20180314",
>>  		},
>>  		{
>>  			.matches = {
>> @@ -1439,12 +1451,14 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
>>  			},
>>  			/*
>> -			 * Note date based on release notes, 2.35 has been
>> -			 * reported to be good, but I've been unable to get
>> -			 * a hold of the reporter to get the DMI BIOS date.
>> -			 * TODO: fix this.
>> +			 * Note: according to release notes, version 2.35 has
>> +			 * working LPM, but we do not have the DMI BIOS date for
>> +			 * this version, so the date, 20180310, is based on the
>> +			 * release notes. Mark any DMI BIOS date before that as
>> +			 * broken.
>> +			 * TODO: find with date with DMI BIOS date.
>>  			 */
>> -			.driver_data = "20180310", /* 2.35 */
>> +			.driver_data = "20180309",
> 
> This reminds me that I did eventually got the actual BIOS date from
> the reporter. After some digging I managed to find the email.
> 
> The first known working BIOS has a BIOS build date of 04/09/2018 so that
> would become "20180409" before your patch / "20180408" after your patch.
> 
> I guess you may want to add a prep patch before the rest of this
> series before this patch to make things a bit cleaner.

Quick followup on this, the original "20180310" was picked to be
one day older then the release-date (which is always after
the build-date) of the known broken 2.34 version.

Here are the release-dates from the release-notes:

https://download.lenovo.com/pccbbs/mobiles/gnuj39us.txt
 
  2.42  (GNUJ39US)  2.42  (GNET94WW)      1.15  (GMHT30WW)    01    2021/06/10
  2.41  (GNUJ38US)  2.41  (GNET93WW)      1.15  (GMHT30WW)    01    2020/05/11
  2.40  (GNUJ37US)  2.40  (GNET92WW)      1.15  (GMHT30WW)    01    2019/09/12
  2.39  (GNUJ36US)  2.39  (GNET91WW)      1.14  (GMHT29WW)    01    2019/06/05
  2.38  (GNUJ35US)  2.38  (GNET90WW)      1.14  (GMHT29WW)    01    2019/03/29
  2.37  (GNUJ34US)  2.37  (GNET89WW)      1.14  (GMHT29WW)    01    2018/11/30
  2.36  (GNUJ33US)  2.36  (GNET88WW)      1.14  (GMHT29WW)    01    2018/06/21
  2.35  (GNUJ32US)  2.35  (GNET87WW)      1.14  (GMHT29WW)    01    2018/04/16
  2.34  (GNUJ31US)  2.34  (GNET86WW)      1.14  (GMHT29WW)    01    2018/03/09
  2.33  (GNUJ30US)  2.33  (GNET85WW)      1.14  (GMHT29WW)    01    2017/12/20
  2.32  (GNUJ29US)  2.32  (GNET84WW)      1.14  (GMHT29WW)    01    2017/09/21
  2.31  (GNUJ28US)  2.31  (GNET83WW)      1.14  (GMHT29WW)    01    2017/05/11
  2.30  (GNUJ27US)  2.30  (GNET82WW)      1.14  (GMHT29WW)    01    2017/04/07

As you can see the known working 2.35 was released at 2018/04/16
so just a few days after its build date of 2018/04/09 .

Regards,
 
Hans



>>  		},
>>  		{ }	/* terminate list */
>>  	};
>> @@ -1458,7 +1472,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>>  	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
>>  	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
>>  
>> -	return strcmp(buf, dmi->driver_data) < 0;
>> +	return strcmp(buf, dmi->driver_data) <= 0;
>>  }
>>  
>>  static bool ahci_broken_online(struct pci_dev *pdev)
> 

