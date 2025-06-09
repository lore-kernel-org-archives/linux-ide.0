Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48141993B7
	for <linux-ide@vger.kernel.org>; Mon,  9 Jun 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480631; cv=none; b=bpA7pQhApCaYk4hnsK3wO4AMs2KVYq2N3OctQbMfiYIQ+6S4pVrPRwKndWJevl2RagPN4EKtUs4VrP2aylfSq2Bm9k6Ms8S+GIb+N2aKWgQxZpOndsKmNKWv5msRjJ8zVUQ9RqgaeGVyRpM07sD1b3NIrvr0fIUozBkjDha5ngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480631; c=relaxed/simple;
	bh=iOQ9ahJTuWJwUN09cjNubdxTOTCvzB3MxyfWuc0MWUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2sBoOdPzevU4pMzTv1txtN/k/umGfPSdsz3Ph5CAzvJf/FhIPX+7IgpR2LnniL3yNGFfoIIuafKo6+C3zztR2BRUmayoP6Tc+nmW6VZp4JpSTdTMqtU/c39J0WfUJ8N/TNa2M1m3extgspOMiV/grC0chIOVidHGJ5M3ZD4HNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzSrGn8E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzSrGn8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749480628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWJiNQ+6s8EO87edXBEwO3ecY5AolAzX8w+E8zf48r4=;
	b=fzSrGn8E4r2AiyGnd7Xk12pbzNZ8tp95bZvhuaZPF6p7R+Xr/O7yBWNlbUv8QWmT/TG7Fv
	P/o363wtH/VxYunAhYWMaLr415ESwYyjKq96fGUWs518K+RvYRCFERdJeSXY8mYnOZSqou
	NlwZ7Ot2MgoLjJbTCiPkjoe7s145baw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-6p-lJxTwO1qHjTMDW7ErBg-1; Mon, 09 Jun 2025 10:50:27 -0400
X-MC-Unique: 6p-lJxTwO1qHjTMDW7ErBg-1
X-Mimecast-MFC-AGG-ID: 6p-lJxTwO1qHjTMDW7ErBg_1749480626
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3e0c1336dso307764766b.3
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2025 07:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749480626; x=1750085426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWJiNQ+6s8EO87edXBEwO3ecY5AolAzX8w+E8zf48r4=;
        b=o1J55TP8LZdfhPctgkH/bmFewzHWx4uwaLv34BRa/t7hOvmhl1CfLwLlv9DUgOsksK
         ysO7E/4cwMdF059pR8w+iQQOPx/KNlEvpTtFRt+KZxZgWx+/xsiGEkB7M9CrZOsGPMiB
         j+DXlb20bNtafWZRkgs6GsgBlvJegkfupyIx3Hx6Zq7+p2pRvebGGeLDgvrmBDctUSnS
         jxZx1JqunC8D5CJEvqJr5jlxqL3XIjYYhM2U7FEx9R0C7j+CbRB6ugFyttTB09zw6ug2
         4BWapOL/4HOLWd1XWRrkZxbtDXKhKcwkoIZ+8s/7pQ4t03XT0aBzPyrggUneaXjMmhKH
         Krdg==
X-Forwarded-Encrypted: i=1; AJvYcCVBNggH9OcA3++qwZbX/vVrw4OpB9K0NGdaeKQZhLvyDWCA7uk8gtGgcIeY6qZg2n3051dweuTXBgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKCC+rT3yKqYr1vr4u6nl31RnYJ02WrVanDoGcKuWR+My3pwb
	O10qcT+W79RI/Ik9Geszv/e3+6ictWrTL7hGGYM0KGLMUMJxcQtkIUz7e0C5p7dHLd9WCLHCWDY
	vFnsKEVMb7PlfJpq5HOfsrlnUz2+IfGw3W7UKwcGVHIjRSPTWBKjkuYNrmuLyXw==
X-Gm-Gg: ASbGncvn0Nb1T1LmSoroueu0AjJs7ffimPmUBspVdA2PN6INqCC548M8r+nsLEJc0Bi
	vLIRLYJfVnT91aRGQFBaYOgfoLOeYBx7tJhYGzNcAqD0EK1Fph++azenoC+vZOdpLwjXdoQhoSa
	01juPWjs2GO42YfQe9QD40G8+Jrgnup6rsMx4aax1OVGL3zNavNXbMrOI6+Y8XZm5KFWmlHxB+y
	qUliPhqt0V8F9sYEUb1iUV+kPF4Q264nGv8ZLL1kzEP1DDfVOrag4nV0+BXK6js9SjkzkFLMcS+
	+fBf2Fenk6vIMoTonlO4NSmHtiRL5uCN2zqAr0rFYuC/oBmznhEhlSBFQ2Oe7khwA5tLw08dAzD
	TyoCziKQvlqkloEqAMZKkSSVyKxo6Iybm6tIXWQty/N7z3rhbHPOLbJ9ahKBf2Q==
X-Received: by 2002:a17:907:3e12:b0:ad2:425c:27ce with SMTP id a640c23a62f3a-ade1aa5d448mr1226073466b.2.1749480626244;
        Mon, 09 Jun 2025 07:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8jZN838yoO4NG/hyAZJWcTKL9QJxGCBZh/EKGaC2KsEIDpnFlwUF/RBOd3Ey6J0XwheVqyQ==
X-Received: by 2002:a17:907:3e12:b0:ad2:425c:27ce with SMTP id a640c23a62f3a-ade1aa5d448mr1226071166b.2.1749480625837;
        Mon, 09 Jun 2025 07:50:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c724sm565574966b.175.2025.06.09.07.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 07:50:25 -0700 (PDT)
Message-ID: <f62172fc-9ce8-439c-8e5b-0044be38357a@redhat.com>
Date: Mon, 9 Jun 2025 16:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: ahci: Disallow LPM for ASUSPRO-D840SA
 motherboard
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 stable+noautosel@kernel.org, Andy Yang <andyybtc79@gmail.com>
References: <20250609134539.943587-3-cassel@kernel.org>
 <20250609134539.943587-4-cassel@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250609134539.943587-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 9-Jun-25 3:45 PM, Niklas Cassel wrote:
> A user has bisected a regression which causes graphical corruptions on his
> screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type").
> 
> Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
> board type") makes the graphical corruptions on his screen to go away.
> (Note: there are no visible messages in dmesg that indicates a problem
> with AHCI.)
> 
> The user also reports that the problem occurs regardless if there is an
> HDD or an SSD connected via AHCI, so the problem is not device related.
> 
> The devices also work fine on other motherboards, so it seems specific to
> the ASUSPRO-D840SA motherboard.
> 
> While enabling low power modes for AHCI is not supposed to affect
> completely unrelated hardware, like a graphics card, it does however
> allow the system to enter deeper PC-states, which could expose ACPI issues
> that were previously not visible (because the system never entered these
> lower power states before).
> 
> There are previous examples where enabling LPM exposed serious BIOS/ACPI
> bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
> laptops with a too old BIOS").
> 
> Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
> motherboard, disable LPM for this board, in order to avoid entering lower
> PC-states, which triggers graphical corruptions.
> 
> Cc: stable+noautosel@kernel.org # Depends on ahci_broken_lpm() refactor
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index a6ce172fa928..be464d0f46a4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1460,6 +1460,17 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  			 */
>  			.driver_data = "20180309",
>  		},
> +		{
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
> +			},
> +			/*
> +			 * 320, released 20230208, has broken LPM, no working
> +			 * BIOS has been released at time of writing.
> +			 */
> +			.driver_data = "20230208",
> +		},

Same remark about using "released" in the comment. Otherwise
both patches look good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

for the series.

Regards,

Hans




>  		{ }	/* terminate list */
>  	};
>  	const struct dmi_system_id *dmi = dmi_first_match(sysids);

