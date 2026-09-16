Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938E262FC1
	for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564444; cv=none; b=XXMdmec2n9qIiuSWyGD4rQbEX1HNlaqZeGwFHreAt5c2tf1SHbMWOHrJzBHSxM3VDgAWyAdnrxiKxpSoTVJ9AclUdOO8Fz7XUEYXlQ0Vw5ve404KSIq4tl6njvDS7DgY8cyFMlO80j6e0DfJ4PI4qV1YsGxqCtblrmVIuIbBKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564444; c=relaxed/simple;
	bh=xe7I+LtKEMUw4nQiau3c1f6ro0yPrs3rC4yAyimwVQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6SjMVqNZwNvBe5GqS3fBKsuOCBD7ndM23VJW4Ipm266QP0qtmi5T02L3C5JrUeqvTF+R+tsyugMdlRyz3CWwh6RqNXOUwAS+k2Kg046DnV2WcZq9xfxugyJl3KVFYYn1IReNsbf5h7cTkPfk7n2J9EW3xeHNcwG2r5ihhWVvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+v/fQXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+v/fQXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD3D1F000FF;
	Wed, 16 Sep 2026 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564442;
	bh=h01FKm+ej/T4e7UyUaZhVIdEIShN24FkOHL67a+qlig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L+v/fQXRABlafKQ0CY5/vJlyWgYW8yxF8OkOoNKw+s8HJfHlYP2XuRGvST8zxlH41
	 iwC5gwzCP1mguEOT0ilKaEyv3zORqq8deEOBmZaXmgqnKAZlGt3pDjd4/RyDDSItzs
	 yAZ7Idvr7MI0AhJ7SLMtXxp3OMeIVnUy7OA/knJ6hEGHozix8Q9MjXL6vDHozwGxUx
	 WMeBy8rQ75PYNEroMmD+db8oHn61ymZ7qS+5X1NBfgBnXG+Brf57tI6LbbCFwfrkX4
	 m5YioMOk6lXaSGSUh2KDYgyrWmYhv34kjBwqPnwM4MMYu4zVE3UQYZsju/y6aQgd0g
	 kIncEV4y8KgDg==
Message-ID: <bff5a53e-b6d1-4e56-9639-8d57db44ae6c@kernel.org>
Date: Wed, 16 Sep 2026 20:13:58 +0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc
To: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>, linux-ide@vger.kernel.org
References: <20260916130031.29990-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260916130031.29990-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/16 20:00, Niklas Cassel wrote:
> make htmldocs fails with:
> 
>   Documentation/driver-api/libata:604: ./drivers/ata/libata-scsi.c:2301:
>   ERROR: Unexpected indentation. [docutils]
> 
> The Return: section of ata_dsm_trim_pages() ends its first sentence with
> a colon and continues with an indented bullet list. reStructuredText
> requires a blank line before an indented block, so docutils chokes on
> the list.
> 
> Simply adding the missing blank line does not work either: Return: is a
> kernel-doc "special section", which is terminated by the first blank
> line, so the bullet list would end up in the Description section,
> detached from the sentence introducing it.
> 
> Spell the two bounds out as prose instead, so that the Return: section
> stays self-contained. Documentation-only change.
> 
> Fixes: e64e6b5dc867 ("ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Closes: https://lore.kernel.org/linux-ide/b0a0b8e8-cc4f-4c7b-8bc5-fee0712d405a@redhat.com/

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
