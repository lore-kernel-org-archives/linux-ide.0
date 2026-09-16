Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1E4D0A1F
	for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553921; cv=none; b=l7bBfjH921tbO/ZMkv5cJOUGbxlh2H6klmwUCPCbWBJ3UvQ2jSZ//I6y0mpgxm7EF1W92JB0hMHiq9+aOy+/eJ8Kq9wwL0Yu9VA2wDYYDN5Wyyomt9QLukJnpA5q9nWN+jb4xlxOaw8hixYZDyha2aKtOF+pb9VnnPU1t4jzoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553921; c=relaxed/simple;
	bh=x0DSXn7qY+4BII3rveEx9PXjSuNm7TnpAV5NIJEV/C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKS0l1ZbJYoC+A/8xhBblG9HWDuW7vV3w5mkr+A+wudaXs6PXsj6WMoBPv9LY7kf4cZPJe5qHw2vRIiRHdp1UEp4A1U5xspTTzY1AJUCC/v1M2jLkc8lmbouu9AihgA0oOhReHzLZ8JJ8wheZhd//dFajDkBHmmS7yfXI1+NV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa6B5XxI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qye/sZZx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa6B5XxI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qye/sZZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789553898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zrLTJEDYilqM1eD4LDYO6osE+L+7ljfUy7pM3j1XDJA=;
	b=fa6B5XxIiWtjNxXDbaOeNMrFKTnK5blxjvFGwEvXYW7ikcQuAjRIhNYYA3VtCMlx9++xdc
	Su+XJ4JXvrMp4ZvEBPYY1UiGaR2cihmgIbGRo3VukQpb0dpNpmIl/Gu3U/JX5Xym237Smy
	UtTXIxK1nN35gVB4AHFboSQK9mKj3Fw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-xFRh0D27PTagMpSQ7KLkNQ-1; Wed, 16 Sep 2026 06:18:17 -0400
X-MC-Unique: xFRh0D27PTagMpSQ7KLkNQ-1
X-Mimecast-MFC-AGG-ID: xFRh0D27PTagMpSQ7KLkNQ_1789553896
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f52ac21eso2962278f8f.3
        for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789553896; x=1790158696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrLTJEDYilqM1eD4LDYO6osE+L+7ljfUy7pM3j1XDJA=;
        b=Qye/sZZxYOAMKJKUGoeskLv04ASUpLGGO9GE/oNH6mkMuJ7HEM318NppWeyRWJH3j2
         HZbt5g1lGwkl0QBCPGVix3Dh+bCUlCoUooFaLykwUq8A8SUQ6+sCm4v7z6SA3jxu5H8L
         kGDWiIYEVhxkVodtYu2TW9o6+FzKm+Glo4lt94vel+T/zPbZY4E//TK1buNrOx1Wd792
         K7dz52PoVJlsfu0399RAyEdDaBYftx94+SCbQoDkwr9heIOiYKBEbuZnZWG2OP9Gs6XO
         uk6JgRh4Isgf39WdfmPtFQ3fycdwMaRn8eon4CQhO9E/H3SfUw1WRH97+cFaY5hVaKtD
         1rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789553896; x=1790158696;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zrLTJEDYilqM1eD4LDYO6osE+L+7ljfUy7pM3j1XDJA=;
        b=gFhUhAjAQ2OcI085ZrToDvf6CdVmPH5xZkRqExlZjOfa3dBjdCjrVFqlqFyWt+jhqO
         4cGSJReA7rz47lfHutJuCxInUw2kU8zmuI6+O9R+gEI7wy3yOdyLQ6q1StYq57AsTuOh
         NWMQvS0Ltp+LkeBzPrtX9vN2+HQxXfR1zYtEsu+lyXXq/Lz/Vfpw64q90TYNkzQBsUOV
         2aV8YhOXT6gM95r4CKQjQyxmjSyUmqYsyw4A3miph5O1gCSRPdDucFu95cjlPHmi8qRS
         sGt6Xg56hiurJvapNDDNqt5rvSGASjsrFN896dCrZ95M1nBOebyAKj5fs+jGzc9xBmF2
         HTVQ==
X-Gm-Message-State: AFuF++lUM8OIt0Sz0yMqzbY7nq1Dozrn2CXvJd0bJlncEdiC4QZTdd87
	K0uE+gWMBK5FYm/t3hRtrO5xRbb1b4tHWL10xGATM5f7gaza5cozJfu/Ue9MWsPSPtw7aGDSMCE
	YPOeEW6U9Kx9B+mz0CFa2cleBiLEg/FSbKAYjDWffJlu1XJBzmSNWU5+dfK/RYA==
X-Gm-Gg: AYBFou0R6ZIs5C9SOrVUQ9ZvnTak1eGBLEJy5vfNcL0kjmvxinUKA6k8wagFjBA8IXA
	F/nPmM2M143haWL0dXC1xp3WJkD/sHK+aRYoMheSqNjvPitdIhLaZcq6Y9pOQ+k7qeUOh1Yox8/
	pKTMwZtToAIiVJDuE3293a5dbPrHYEDjfQf/KLhW7xD/7AfhPUtwd3eNop8/Gx37Qvwzc5Gk8/3
	WtJNNGm5+0KrLJfXZgb+lU4jPMEej0pYJ/Ljs8OAa7eiNfpvCZPrMxG9y2G0yTm424n7AHwszua
	2QX8SZU1Z9WSvaJwj5GhckIDTvCukjsbEVs4gzLW5u6x9WATXbgNy2vY7wcU8l/tIGnzpwx0DDL
	9BVAWPVfmJxGWbznI29Fl3jlnOcXL
X-Received: by 2002:a05:6000:40e1:b0:487:999:a7fa with SMTP id ffacd0b85a97d-4870cee41f7mr2360168f8f.6.1789553895843;
        Wed, 16 Sep 2026 03:18:15 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:487:999:a7fa with SMTP id ffacd0b85a97d-4870cee41f7mr2360132f8f.6.1789553895381;
        Wed, 16 Sep 2026 03:18:15 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-41-176-3.web.vodafone.de. [109.41.176.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bcc7d1esm6132066f8f.0.2026.09.16.03.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 03:18:14 -0700 (PDT)
Message-ID: <b0a0b8e8-cc4f-4c7b-8bc5-fee0712d405a@redhat.com>
Date: Wed, 16 Sep 2026 12:18:12 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: scale DSM TRIM payload by MAX
 PAGES PER DSM COMMAND
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>,
 Hannes Reinecke <hare@kernel.org>
References: <20260702105956.2058733-4-cassel@kernel.org>
 <20260702105956.2058733-6-cassel@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260702105956.2058733-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2026 12.59, Niklas Cassel wrote:
> DSM TRIM currently always emits a single 512-byte page of LBA Range Entries
> (ATA_MAX_TRIM_RNUM == 64 ranges), regardless of how many pages the device
> can accept in one DATA SET MANAGEMENT command.
> 
> The maximum is reported by MAX PAGES PER DSM COMMAND (IDENTIFY DEVICE word
> 105).  Honour it: size the TRIM descriptor as a whole number of 512-byte
> pages, bounded by that limit and by the logical sector size (the WRITE SAME
> data-out buffer is a single logical block).  Build and transfer only as
> many pages as the request needs, and set the DSM COUNT field, qc->nbytes
> and the maximum WRITE SAME length in the Block Limits VPD page accordingly.
> 
> Build the descriptor straight into the WRITE SAME data-out buffer using an
> atomic sg_miter mapping, instead of staging it in the shared ata_scsi_rbuf
> and copying it out.  This removes the global ata_scsi_rbuf_lock and a
> memcpy from the TRIM path.
> 
> While commit 9379e6b8e0f9 ("libata: Safely overwrite attached page in WRITE
> SAME xlat") replaced direct access to the data-out buffer with an
> intermediate step that writes the entries in the ata_scsi_rbuf buffer, this
> solution writes to the data-out buffer using sg_miter, which maps each
> segment with kmap_atomic (SG_MITER_ATOMIC), so it's highmem- and
> multi-segment-safe, and it's usable from the non-sleeping
> command-submission path (unlike the page_address() access that
> ata_scsi_rbuf originally replaced).
> 
> A 512-byte-sector device still uses a single page, so its behaviour is
> unchanged.
> 
> Add ata_id_dsm_max_pages() to read IDENTIFY DEVICE word 105.
> 
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 135 ++++++++++++++++++++++++++------------
>   include/linux/ata.h       |  13 ++++
>   2 files changed, 107 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 429b03a08071..5d56ad66af77 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2198,6 +2198,39 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
>   	return get_unaligned_be16(&rbuf[2]) + 4;
>   }
>   
> +/**
> + * ata_dsm_trim_pages - maximum DSM TRIM payload for a device, in 512-byte pages
> + * @dev: ATA device the DATA SET MANAGEMENT TRIM command will be sent to
> + *
> + * A DATA SET MANAGEMENT TRIM payload is a list of 512-byte pages, each holding
> + * up to ATA_MAX_TRIM_RNUM (64) LBA Range Entries; the format is page-based and
> + * unrelated to the logical sector size.
> + *
> + * The logical sector size still bounds it, though: the descriptor is written
> + * directly into the WRITE SAME data-out buffer, which sd sizes to a single
> + * logical block, so it can hold at most sector_size / 512 pages.
> + *
> + * Return: the maximum number of 512-byte pages a single translated WRITE SAME
> + * command may send to @dev (never less than one), that is the smaller of:
> + *   - MAX PAGES PER DSM COMMAND (IDENTIFY DEVICE word 105), when the device
> + *     reports a non-zero limit; and
> + *   - the logical sector size expressed in 512-byte pages (see above).
> + */

  Hi,

not sure whether anybody noticed it already (I did not spot a patch on 
lore), but this causes an ERROR during "make htmldoc":

Documentation/driver-api/libata:604: drivers/ata/libata-scsi.c:2301: ERROR: 
Unexpected indentation. [docutils]

  Thomas

