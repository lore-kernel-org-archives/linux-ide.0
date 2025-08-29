Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701D311C30
	for <linux-ide@vger.kernel.org>; Fri, 29 Aug 2025 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468932; cv=none; b=WX+igXoH4Z+aXMib5klrC9fk5/FPUeZ3lmx6vT9lgh7B5coQZf+O7o6fGpgfoEvLZn0FfmJXkNNvfTvK9HJKSMRRfZ27CFdnRz3ADveOEhDx8EbV8VlXyvVBaYH43HJPSD3UIIsS/z54y8WmIlJTYWT6rmmuyqQiiR+h+KAb5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468932; c=relaxed/simple;
	bh=FoNT4pW2vO30gJjTIVwqBgPZl8+yPQqfN/jW6rNv+Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jR4fMFh2IbemShz/5UnLqrUT56Kjo2zGAxeTdqWsfnreaXAFzuZydaEA4GknDtPAs94098iGebKqvLGTvLYv04VZDBXCmUEK8Bn4Oru6Mks3C3QPKHbx3f7EvrvXBR3Q1FhCwWdSzLIMAxhpbobYXMTfnwp3zYYW0kWWr3pDxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OX148GJv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OX148GJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756468930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZYQANwx9dP2TniNNzJzejSk0KLOlcIb4cHUahyjX99U=;
	b=OX148GJvbJAZ98zeKqIKI7vLm2n1C0pNRkSjV4VFLocJGil/YP4434Ny0xJxRY0epjYcbI
	MwEOmqVXYDeBhcVi1ZlnRhhwGhZRoUbuGXn/qtlM1NcUN3JwHhzaiu4BCGPSjjQvb7c5Oj
	IzglX9ww1P1anISyWu8WYN/KC5q92lc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-EL3OeSAIN9KSV211kiNA6A-1; Fri, 29 Aug 2025 08:02:08 -0400
X-MC-Unique: EL3OeSAIN9KSV211kiNA6A-1
X-Mimecast-MFC-AGG-ID: EL3OeSAIN9KSV211kiNA6A_1756468927
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c6ae25997cso1224666f8f.0
        for <linux-ide@vger.kernel.org>; Fri, 29 Aug 2025 05:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468927; x=1757073727;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYQANwx9dP2TniNNzJzejSk0KLOlcIb4cHUahyjX99U=;
        b=CTOKgXghLhvTupN6L/kvdXwns2Vg1HfT6KM9ZiWNom6hOwtmK7GQHkLy3d3yCk0uAc
         QuTYO4kwzd7IVbEQWIi7LdpDMBPzYrlr5JttdzmhCntomCUGnGhzrhKde7Md/sLASKSx
         n79dsJenm1Wcmx0yCYbTr2vQuTbz1IKA7DSeNVT/FWVz3zDu+YF9rRiLqNWZAgwV8rtS
         x2MQXYI/Az96R4FCwOwCt5s+7dPtMx5m45zPHreNIQITR0WRFTSyFAhOw0y5UgwzgINN
         fvCZ2ntKtFM63bNUtbhpCMPyJwjQl8hBx4kkrEl/nxV1QqFOqjAmjKmfDGnWj7YL/uqd
         kpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVHWTqm/iWbphm6180RdKWJL/8X/6qf9RfrY/QL76Qv2vOQNYz0XFZ9Msi5BbdnnlAclm66tZBTmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oY05R5MpdW+hxKREoW3Qp8/1BFoOViw8p65u2L3+c0rp0ytK
	0y4dRZtmW36CUXIRPdYWezT4Rbh9nrbjcLdaMCzUn4i9ezaG4G1Bj28OkA2+O8fnl5J+HAFv4g1
	m1RcpL3sVyXyQyUPYZNw3fqfCnq/QmIsUpOOxwBTjUrZTq3tFAtcUFrIgx0INtQ==
X-Gm-Gg: ASbGnctO8gcsUf4R9mzp6JWV9fxQjlP5uKiFPNHcbHtlhTIyQn9edgDSg37diQi3On9
	B0dkCCFrxXFJgLQ3On6Nvpc0iVvTRrj4sch+74ygdEOpDRru40E94lQSxpbhK/ESKV/Gqabcu/J
	QOtd+ylN1E7+OQW0aWgDz/ZgDoC01hUkSnHJR5+3ghOB05hKGnwPFfz3c2yoR8jQ0smq7Pprrcl
	rh2hVV6a8vLqXQjH6ZiijQeHkqRPYP7qMjJMYmIlIa+y68/rg7XnTanrqcrAXw8PuxN7wf9Lzoq
	hZfaqpqzspNWf1i/vm2tcSIz+fRHTX78vYtxZE6GmElR9hu9J2OYf+so/SApN1b/ddJdQSWCsmt
	8CJeZzQTaxwD9H+jnpWzMSwsX1TSGYwyr6jbCmdw8VQMI/O8sF5uQvj6UHaqAU3U=
X-Received: by 2002:a5d:64ce:0:b0:3b7:7377:84c5 with SMTP id ffacd0b85a97d-3c5d7cb4888mr17563607f8f.0.1756468927064;
        Fri, 29 Aug 2025 05:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3QeYJZNPVWNTyOlFRY+fpxC5ixu9vVBtJrj04o0E7yCOrYXtrsrSGdQYXBgGHm6MDxKQL7A==
X-Received: by 2002:a5d:64ce:0:b0:3b7:7377:84c5 with SMTP id ffacd0b85a97d-3c5d7cb4888mr17563581f8f.0.1756468926590;
        Fri, 29 Aug 2025 05:02:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb96ecsm3144067f8f.45.2025.08.29.05.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:02:06 -0700 (PDT)
Message-ID: <d2bc788e-abea-4453-86fa-daa68e280d52@redhat.com>
Date: Fri, 29 Aug 2025 14:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/36] fs: hugetlbfs: remove nth_page() usage within
 folio in adjust_range_hwpoison()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-16-david@redhat.com>
 <1d74a0e2-51ff-462f-8f3c-75639fd21221@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1d74a0e2-51ff-462f-8f3c-75639fd21221@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 17:45, Lorenzo Stoakes wrote:
> On Thu, Aug 28, 2025 at 12:01:19AM +0200, David Hildenbrand wrote:
>> The nth_page() is not really required anymore, so let's remove it.
>> While at it, cleanup and simplify the code a bit.
> 
> Hm Not sure which bit is the cleanup? Was there meant to be more here or?

Thanks, leftover from the pre-split of this patch!

-- 
Cheers

David / dhildenb

