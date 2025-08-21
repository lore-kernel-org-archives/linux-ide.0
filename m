Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3335CEAF
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806877; cv=none; b=SuS1/nPIf+E3zNhEF4sfPAWbSIEFZKL+lwdaJZjijRy3FipbBTEwVjPfyivlB80F+zuLtW1UMG6toAcwHMXglH28LP7wgLaZd9oOn8YeJXCxyHyDu+uOkJzcaOc4e49YvuV77C6ICWgAmNfbdgNfJtyLjDYfqKjjYXn2fKA9MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806877; c=relaxed/simple;
	bh=DqyVXDGsUgZb9r/3HwvxxZbRj3b/8OImyDb3ud4Q1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leLLoWb8mEw1GWrH0+ewmTzcp9Zepifch2F2YZNmutg2LkwNDtacyG5C+3mBAbrHqt6dG9bDUgBj9dU2TiGlT4Ppc0Gn0ULaDhbe58K/DjkPfTGJdfwj3Ai2+0frbjIQAupUHK39+c/m6VMd/EoWjRbQnwts4EfnZtOVXl4bdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ibk57JeW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ibk57JeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
	b=Ibk57JeWoGlmYmhEGO0mKqFFj7juZc9klc56ivvxd6emwSHYUf5E5WtJTxvTnWUV9Qd2QY
	m1LVc02TAYYhUQm5CU9NLYfhKREWI0RmzBTrK6+boeFsd5I+YhLqF+rAo9Ya/u5ysDeMvj
	Z4Ya7F8irll0NLQT7VgESlWogDxzBDI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-bbGZaoCNNIafeig9hEi2sg-1; Thu, 21 Aug 2025 16:07:52 -0400
X-MC-Unique: bbGZaoCNNIafeig9hEi2sg-1
X-Mimecast-MFC-AGG-ID: bbGZaoCNNIafeig9hEi2sg_1755806872
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso10738585e9.3
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806871; x=1756411671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
        b=oowxAXMSbKWzUSjtqDVKE3AiBNhf2IrJPApeeJJCaFHUJib7AW2+wuMs0D9JaI1+CC
         1WMRH17gNUdo1OG946HRaNZMoRn76vhV00eqyB+AL6Gh6NpANvhY32d2CIXTbiE6uHRP
         xvF24/5f/VesV75Mfakg0iphEk1NqnjMaygZr0tq8RmpfDQHQuVxSRD3rACcK3Z7EbCW
         HhPNcJPzXxlYXX2kQE/bd9mZxoXlWkp87Q+6z9htblzyQTQXbsu9qmuWHxZuXECecvGw
         iCsiQYeki/pa7t5vFFUJXMfv1bzO7pj9Mno2MlQv4llJRlL6yBQGD2kxH7KneIteUwmT
         9VAw==
X-Forwarded-Encrypted: i=1; AJvYcCV+IKlte8poW4vWnMoHHZil5VN9VJzOXB+JgZiKyuA3pSucueOeY9vHYdzui1+XcyqUhNVntKUM/NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtjmA3gB3VteA4quOcHL362I5yTVELzH0DMnhqP3+ZqrKzuL+
	XNr3JaCmQ8sxQ2ZgaW8faodl8pcsPxtK+PjDlneGGIx39CVmvS6Gi6+fwzHyNd50Qu11XY0ymO5
	hoqcchH1hnSbmXmZ3KsJekBg8Zg7oRTY5mE76DSPOKBu0GzV0PtMbJfJtmUj7qA==
X-Gm-Gg: ASbGncvFeJku/VJWOLw5nigDLp2P+KtKoiPm2VrQb0xIf70FyDqyZ0HxXcw1dP1ncCN
	efEHwa7Li8oJnGfG/p9k6l9UC54Fm2VqyklTA8o9bSE322mJ3sQXWTGvQEC2kt9/GWUKS3h63yA
	d82On6DMXSW69zFATGEq1Hs8HdmvjBT+GB6uur///v/wBvmp+gJVUcmMLxLPkmfauhA+SkakUwt
	MgV3nnzahOhVLFKYq3tmbLt48AkbKst47Gx5d/5NYEiHP2AJKh1QvRBtdLnbEjuyH9ofFUuevGe
	S4oRGNT+cSufPQeOHUiqSvMrMtu3VnNDjmRSkn79XfQ12mlMjqYQjMIEB2hoBrPytCgZ6WbYoM/
	QZY5E2HfYH6mpi1ztBEPdbA==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2278785e9.10.1755806871565;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQe1GSIQC6LfutgynQLrqB1o4Jo0GTrBjlhxRWjM7nqTD8l8oEo1HOcPxtIuVQVn3tsHm8QA==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2278575e9.10.1755806871147;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e1d77e0sm22159155e9.0.2025.08.21.13.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:50 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 16/35] mm/pagewalk: drop nth_page() usage within folio in folio_walk_start()
Date: Thu, 21 Aug 2025 22:06:42 +0200
Message-ID: <20250821200701.1329277-17-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer required to use nth_page() within a folio, so let's just
drop the nth_page() in folio_walk_start().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c6753d370ff4e..9e4225e5fcf5c 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -1004,7 +1004,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 found:
 	if (expose_page)
 		/* Note: Offset from the mapped page, not the folio start. */
-		fw->page = nth_page(page, (addr & (entry_size - 1)) >> PAGE_SHIFT);
+		fw->page = page + ((addr & (entry_size - 1)) >> PAGE_SHIFT);
 	else
 		fw->page = NULL;
 	fw->ptl = ptl;
-- 
2.50.1

