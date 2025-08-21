Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190526B77A
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808200; cv=none; b=Ayg3QOndzJ82MSL2tDWvdR8BkxB9aZkEe9pKGiVy5PeYnl5P2zribT2G5tnvuR531CWTHTkek80r1z8rQCd5ysK1vmEUe5OY5aTOzMyIMNuARqjKw7VTv8cSE/cpYmjv0IoYAyERc7s0EBiDhMuu2pqZchboawJJdXg5uErADTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808200; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9Cqd2P9MCov4lrlHTg5Akx1KBNUMfMn/AHRJAGqVD4flyCJuD48RfV4k+ozA8HYeDCo3oUh7gjhlJv8IuOyOuu7ecWkQWqVTfBWB27frE1FwSdbju9vK3SoSBS/ddbaVOEkwQI6VVz6s/DSO2DzvVanwWJqcYORrc/uRfBcARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G3NotcDg; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G3NotcDg"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70d7c7e96bdso7690516d6.2
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808197; x=1756412997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=G3NotcDgj/00OiKhjtpWegKmyPOF4X0vM2EsB4oOJqdknCPe6rQ0iA0pgGY/4tQtu8
         mQobIN+bTyTE5Ot3UUiar4mQVRhBrAC8HNDpj4D1fpl019k7VUwOqMer9FkLAjXGt+kF
         jbSBPQaQJbNCK8G0AV6KLC063UUVqXzTbaaLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808197; x=1756412997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=omoswY08R0+V3prV4Nm3yaUCMSgmfMEkue+PwyzmqxLMtY9mLRkcdk2biNX5/3gAJ4
         ANdkMLibnOvvb25B+SszHHIc8S3pcXyapH0rCywS53hGrjJYJNPpc3L/uFXK6EeNa5nE
         jO+64HhaCfCEQp4ahUQSo0hXB5X1scTWDGMlbBJRj81vuXIp2AA4z+/Odb9hgU9T5Eh+
         HBvcg2vaw4BwN/gSxdLhCBzeQGXvB7QxAywhFsqZZG1k7eJs2gOXr436J7ThpISpMrPw
         HI13rrMdF+dehmW4V0Y9krhtjlE+lUzeEp3ziziMcYrIjIfk3pw25y7swq5ILTNYCWFL
         Gi2A==
X-Forwarded-Encrypted: i=1; AJvYcCXvA2wUpY2z1SvcrQcKSHw/FM4ytKWG3Dl9IioxD9WJuKauZZaIvxiM+GU8pfaQbiqelOobwEzIbkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+WQX193r0kcj+Q484mAyWjABfQQiULbvT1JmTnZt4xVRq8fw
	wY5YuoOsmQCebC5Az8WOBfzvkQ6bQ9EUE6ZHgsFAMNuU8xZikeu1Hk+wnak225xDgVkRuIwst+D
	g+78xB4EyAQ==
X-Gm-Gg: ASbGncs4oY2nt5gfBmM3VMcY5h8WwoP8/1Y/RUTFkufs0DQK6ML/rUvLJZdjUlpbKZ+
	Sj7ogZN1STzo4CkvhMJkteMXDkGUUdngd8IF6X1Im4/J1A36b7EpQI3aMKHISWDj2R3gi3pwzZZ
	XQ7qJmF4xT7omEh3W/bzka6/yN60BdULswl4C01z1l0pN7lsYYwy/O+m6bzDkbtoP91ZD+6EH2Y
	8CUM2JETB8wzEkqwzSmzj18m4OXMk14WRLuh0phmmazC3MLqPr99bOmbjQBYJyFlj+rZnjFBQVK
	gA0JEwnruBDa5ayLK4WhYEXy9u2ikSlsmX8zAoFV/kSbmQE7oj8NGTkd4yS+26OT5kHiDLzew2w
	pE2lnF/6WZnAkKe8qobHFl6WmtUks/VUb5ffMJPdhmueIvLzrsK7SnYmagUuL3pAX9ripDc206c
	eoeRShMH5uBl8=
X-Google-Smtp-Source: AGHT+IHw0vlU/t39b+dcguWffq/eiWhFlC8MKS82C1cQQIkKvNBJL9Db9PNW6O0wO4UTtUJlGrVLTQ==
X-Received: by 2002:a05:6214:2aab:b0:707:63b8:3d46 with SMTP id 6a1803df08f44-70d9727cf86mr11653756d6.30.1755808197102;
        Thu, 21 Aug 2025 13:29:57 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9370592sm110967586d6.56.2025.08.21.13.29.56
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:29:56 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b289cdc86aso14348211cf.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:29:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4tkkR9ybWCazw+DaZdlcYuc3d61yc8u3W6d7qHh26ykVn025fElKrngoH5VzJPOUR9zwloHxPdpU=@vger.kernel.org
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus
