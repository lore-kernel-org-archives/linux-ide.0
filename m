Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041634A30C
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806867; cv=none; b=H0tS/RDemScp8bF+nUAxEBk5sl7UNNmyX8vpyopLohJSG+96kxtDkKjwT3gwEpSaHpulNFyXGQVDygba9Llqyz85s481/K2SlZTTqA5prmZsaS9cZLfO4YxLQilkQicA52zllsx4YiQjpU/0Y5y/xzVrQuidvJZi36ngoFCWmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806867; c=relaxed/simple;
	bh=EbcdXL10oBVSBHmjJHKvKh3MpEtOuUSNb7Ges4yPKyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpbKoNyjAywUa5Myv03CS+cndkkF5yB44UicEhcGCMZez3iS2ywCOTDeX2P1WdbqD5qS/qOYgirikK6vC9JaHoIfSi3mMxFDkLi6fWimXx8N7zYNCmBqVcf2mNH34C50rmEgRBe3QcDOAMXprGXUklTuNfP9ThsZosSOCqw3YOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1/E+adV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1/E+adV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+ehuLujhp6/6Ui8/ETipqTmnVB5w2txW2o3jJCUzuY=;
	b=Q1/E+adVuYX8JC6nYgeVB8Co1OcJGSTX8sUUSbsngZ+Kelsz7Cg/w2rq3awMe1NECnRqqO
	p8HnNG+spMUhqyjsvz2fqBoqH4Oy3OdDQBZoNqsWLlY0TC+W/dDyEZfGRqNLx/oCxrcgyx
	w8AooxSq2F2gaUn1JzljIx7zFagxlaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-vOsSTYaTNUCYXjEvxkvzWQ-1; Thu, 21 Aug 2025 16:07:41 -0400
X-MC-Unique: vOsSTYaTNUCYXjEvxkvzWQ-1
X-Mimecast-MFC-AGG-ID: vOsSTYaTNUCYXjEvxkvzWQ_1755806861
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b00149cso6294575e9.0
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806860; x=1756411660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+ehuLujhp6/6Ui8/ETipqTmnVB5w2txW2o3jJCUzuY=;
        b=l5QpFJgCvFlZr1rMU2svqYkmOcYrGaon0ogai1v5tOFpydet+PRlc1wVuKbUqNXcDO
         mBLijDMM9KpErCNdHkpvgr1qJx4bCX+JcShPZ5WDESFKsWlO1dZrPkxZW7IBDKceHAEz
         KFlDBAv75u1O5tFcsiIsmOW+Pg1dOCY1D/tUmbapIPRtPS6IgtYK280J4dl/llJXm08Z
         SGTfNGxUfyzCQ2thFaRy2ZH0EjVCr8MNJ8iZR8m9sj6zz9eDP+S+NhRQS6cmdvSLeZnC
         1iQI8H8B5S0G9e5FqBrayX5MhQ8A8rjhjcyHnqvzquoQE5I1c2nCPWKvtr5PUugrRIWf
         lZDg==
X-Forwarded-Encrypted: i=1; AJvYcCXytWSSXV4bfvBRCaL4g8xtEBSBVDRAIqkC15bJcdjQWeIWWQlJ5KCSUKQXebq8cPcsxsEtiT4VbAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWHQjoHliua9I662YxWGlynQpLRo1rFLcEvrIYhSjTncZpjcI
	EwxYoRzFRRJPS2qldyhe0cGHvMMT9DmhqMe4AamW1Sa3w5G8v/jXoG5Hq6qNXv+gETn1tc//nou
	Ac6zfHcSiNaW4ePCRci+AepHlI48gEcpH6KbeD56fSAO54VLk6G0jORil6XWfxw==
X-Gm-Gg: ASbGncsX4Sgakt5pfpzUFsphKycLB4kXhjCr2gy26iEbO286gg4jCklWxNJhjY6dhgv
	k82jFpxZDAdi8BtMLdp/1Ci36i59vdz8BljRwgkFRHANa5FGatcOVrk6iI51yMFwayTR6gT8ByC
	GYoaFQgVHDgvZldE2I1k7q8oqreU8U2VtufQ1xvbg+g8TqkKGCPSC4IvxzC8qTJzuvm47uARJBY
	dwJ2XrxEI403/JJApUxevFksIMBtdkjcpNXMESz61ew5JgftdJoujWTd/aW5gHyA2/4Z3OJyLyY
	3Iy7KX9tbezvjiuw329lAkCVhqJxGk3T/FmOwyqpHQtLpYPJKdHPDB1pYq63C5BLRhwhf3Wzcp9
	i2hh/3KsfAg1cP0Is7097Ng==
X-Received: by 2002:a05:600c:19cd:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-45b517c2fc0mr3573125e9.17.1755806860566;
        Thu, 21 Aug 2025 13:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrtwXyk8M0MMGhBsDq6sn2/zjKB5pcui5JGSP2GUX5VAX4EhNVsrp5ZVJRMStvpa9W7AdEeg==
X-Received: by 2002:a05:600c:19cd:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-45b517c2fc0mr3572545e9.17.1755806860106;
        Thu, 21 Aug 2025 13:07:40 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a52bsm8600375e9.21.2025.08.21.13.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:39 -0700 (PDT)
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
Subject: [PATCH RFC 12/35] mm: limit folio/compound page sizes in problematic kernel configs
Date: Thu, 21 Aug 2025 22:06:38 +0200
Message-ID: <20250821200701.1329277-13-david@redhat.com>
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

Let's limit the maximum folio size in problematic kernel config where
the memmap is allocated per memory section (SPARSEMEM without
SPARSEMEM_VMEMMAP) to a single memory section.

Currently, only a single architectures supports ARCH_HAS_GIGANTIC_PAGE
but not SPARSEMEM_VMEMMAP: sh.

Fortunately, the biggest hugetlb size sh supports is 64 MiB
(HUGETLB_PAGE_SIZE_64MB) and the section size is at least 64 MiB
(SECTION_SIZE_BITS == 26), so their use case is not degraded.

As folios and memory sections are naturally aligned to their order-2 size
in memory, consequently a single folio can no longer span multiple memory
sections on these problematic kernel configs.

nth_page() is no longer required when operating within a single compound
page / folio.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77737cbf2216a..48a985e17ef4e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2053,11 +2053,25 @@ static inline long folio_nr_pages(const struct folio *folio)
 	return folio_large_nr_pages(folio);
 }
 
-/* Only hugetlbfs can allocate folios larger than MAX_ORDER */
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-#define MAX_FOLIO_ORDER		PUD_ORDER
-#else
+#if !defined(CONFIG_ARCH_HAS_GIGANTIC_PAGE)
+/*
+ * We don't expect any folios that exceed buddy sizes (and consequently
+ * memory sections).
+ */
 #define MAX_FOLIO_ORDER		MAX_PAGE_ORDER
+#elif defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+/*
+ * Only pages within a single memory section are guaranteed to be
+ * contiguous. By limiting folios to a single memory section, all folio
+ * pages are guaranteed to be contiguous.
+ */
+#define MAX_FOLIO_ORDER		PFN_SECTION_SHIFT
+#else
+/*
+ * There is no real limit on the folio size. We limit them to the maximum we
+ * currently expect.
+ */
+#define MAX_FOLIO_ORDER		PUD_ORDER
 #endif
 
 #define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
-- 
2.50.1

