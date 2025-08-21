Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A194350D7E
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806902; cv=none; b=U0CpREMQ2C2XQojiEOWLeHpAJvGDG8DbGeliOyNO3IUMTf+vD1XqUM149REZAFquIUUg4MGgnHsPPAEBOfu2+nahCQjj7y6EOViJa4LqLQAzpLQxv2CJy4I+qZKuTvUuBrDfXLzVzoeZegqTameelkOCqFrj8Ri25LClhiMOQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806902; c=relaxed/simple;
	bh=kURokXQjB5Kuo7a6U8usTL1aQ1tfaOTG2Bf9aj2NBoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRAJuYVXC7gjyijJoJjfekSkxK8nyHt9irx6ftJFR5sa3ZBlyqC/CXRKpGLyMuVnIWb9zLS7/gi5WEdwmlgEQBH26R8mxzxgRxrpeV7iRCf2g1Mva9bIlLsLo7xO1ciUFePsxzpjiQU4qnNWVaZBNiHs3bk/u6POFnwP7/95+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERqQL/HO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERqQL/HO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKFS9/TuG2v9AIcAoooIJr3bGKW6zmP0XL+5izT5Y+4=;
	b=ERqQL/HOdxsgpQA36LKutxhZZYLV+WC42D78O65waKROVIMMzWoUto2i+JVlpbge4sTpbH
	v/t22TlA8ZzIxcjw1TU6FWzanAs7vgzondrQOVHgl/vsloDIDbLlCfTx4vxDSCMP/wC6SW
	WGV5K/NTntRSD6JfK7lBhdyT69uGiTk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-UU3OBu7zPfCE0HToosTdzA-1; Thu, 21 Aug 2025 16:08:13 -0400
X-MC-Unique: UU3OBu7zPfCE0HToosTdzA-1
X-Mimecast-MFC-AGG-ID: UU3OBu7zPfCE0HToosTdzA_1755806892
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so7744155e9.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806892; x=1756411692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKFS9/TuG2v9AIcAoooIJr3bGKW6zmP0XL+5izT5Y+4=;
        b=bOEqlU7Aj9d9aPw1aKho8NIv/SxrwHsficBRxIljATW7k/e30bKpxsjKSCAwRzmpQ4
         K65uR/m2awr1TxCxqKAE5V6AnU3bJhbCHL/TbfPaKbsXTpoDE+aXWPT37WrT2/sV0QsI
         65IoMlGnz+x90aahy8nUcDjFprqF10e49Tl14o3REgtLXLXAt55QqMm1Y7QYKSMciKBC
         jB+/0MbcsLOEQbGA4tj4aM8u59Bbot/OgVU1afUKwuNwQk9HkPqxohivOQqiJJudbvVK
         AEIvqJ0y/t86bcn/XS3ZiVFS/WYRVdbzIfKh70nIVSCEUirFIXZ/rpRfwF92vvOcjWMY
         qKRg==
X-Forwarded-Encrypted: i=1; AJvYcCXT0vxCUia3LnRaYaatNBkreMJ6Lw5WN6yA5AkpqQMtoOr2vcT+LgkXxc3srPqLMsbDK8NLB7gvK6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3AFOkPP8GWrYPKfd41GzHF8hRQdHEoku1snuJdCaRD1vUQcM
	IUDLeWkogVV6noqQI/BsutpvTJoFiGe9hmA6T7IvMRmKmGvZFYO8XCHaucYNjyKZvhny2paJ5s0
	Ri7C0HwoDwO+xFGvJ+nqVkSJKy3y1RJ2V4wFJ2ABvJLTuhoEACtyGgNRsDNGlng==
X-Gm-Gg: ASbGnctPenMSZ4tAFZI3iSV2yt0P9ZVcVp73TstdGHIpNUhUgaM5PeANz0drLSEATvm
	hFqA9IraRI5jRT6OVO1QAmqM7Gh7lP+dkxu72JKjP93E+7pQ8B/exNARoB53arXb6avdpxLLcOc
	mUw/zK/7e7lUmdqJHPV/kVQKk/ddm6OsKSPkCqLVc4JnBK3SbWjQhD7MqwBl+0pwAnSc7LTmcYU
	8/hN9yRwvh88nuCMPh6NXhAZg4Ag1+7nQBGcuIeQZc6l0F0RRLMv7pjZY+dOdMcIJq7YSgGp605
	8IyE+5LkGstm70ZyqP8rPmco3TGeFqX815CHmW0K/SvAPUl+S7fU61MgnoRGdEOT6JpTjiNra5t
	hrZS3VQpGHne/NxzprnGcJQ==
X-Received: by 2002:a05:600c:1f1a:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b517cbee2mr2552535e9.34.1755806891767;
        Thu, 21 Aug 2025 13:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/z26sBz7JGLAktk/cnLNnmvA2KmHoRy5M1TseKC0NpCNohvOWfWbiwnk6fyruz4Gv4BdEig==
X-Received: by 2002:a05:600c:1f1a:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b517cbee2mr2552235e9.34.1755806891155;
        Thu, 21 Aug 2025 13:08:11 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0748797acsm12277591f8f.10.2025.08.21.13.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:10 -0700 (PDT)
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
Subject: [PATCH RFC 23/35] scatterlist: disallow non-contigous page ranges in a single SG entry
Date: Thu, 21 Aug 2025 22:06:49 +0200
Message-ID: <20250821200701.1329277-24-david@redhat.com>
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

The expectation is that there is currently no user that would pass in
non-contigous page ranges: no allocator, not even VMA, will hand these
out.

The only problematic part would be if someone would provide a range
obtained directly from memblock, or manually merge problematic ranges.
If we find such cases, we should fix them to create separate
SG entries.

Let's check in sg_set_page() that this is really the case. No need to
check in sg_set_folio(), as pages in a folio are guaranteed to be
contiguous.

We can now drop the nth_page() usage in sg_page_iter_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/scatterlist.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6f8a4965f9b98..8196949dfc82c 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <asm/io.h>
 
 struct scatterlist {
@@ -158,6 +159,7 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 			       unsigned int len, unsigned int offset)
 {
+	VM_WARN_ON_ONCE(!page_range_contiguous(page, ALIGN(len + offset, PAGE_SIZE) / PAGE_SIZE));
 	sg_assign_page(sg, page);
 	sg->offset = offset;
 	sg->length = len;
@@ -600,7 +602,7 @@ void __sg_page_iter_start(struct sg_page_iter *piter,
  */
 static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
 {
-	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
+	return sg_page(piter->sg) + piter->sg_pgoffset;
 }
 
 /**
-- 
2.50.1

