Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34D35E4F3
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806880; cv=none; b=JZczE6QhBdA0RIljpXUthVZPcXDEIeilhahfVKs8EURuQzp6YqJEr5xFRhT0uzXEEOCENHjpLhu3jJACkRjInTFncX9G3f2u+5WLX65VG53/bfTjJKc/upsvEy4+X8zwYW+o+qCmcMev0MQNF9yhC1LRPcLTFQ+oEjI3rt3Rp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806880; c=relaxed/simple;
	bh=jeuBd6AEd//7dLky0U/9/K8CcfgAIF74DmeLEQ7xh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzf4qT4eLFy47oo8P/gk5pmD6Vqpx5tS0TqMDqlTztN57XKoS/5MN+98UPGfGyxEcG++8o5WdR4ei8LuKN4BcopEhsP0RUu2+nHvfjV7K+1j9Yn6ENxdvv4uIhv9tdFkTAlTrGHZ2ITpsrhn1GcGZCn6zMSQ1+l1vO32AKaVpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc7k8vzI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc7k8vzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
	b=Cc7k8vzI8vWyxlhOTg3zj5LNGjaDshsiz6wO+Ms72EVhWwZd1ayoq4w78xvhwzeswURLhd
	sTkMrm8c281eBuTMugA4EQ0gLZR/hym/wLnJuwYj0b/EGcngrTVom43mob3elWoOAbQwg8
	yXIaPVKhDlpqvvHwwbMbC25+SHd0wvM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-Ym6LWLAVOuq88s1qv19T2w-1; Thu, 21 Aug 2025 16:07:55 -0400
X-MC-Unique: Ym6LWLAVOuq88s1qv19T2w-1
X-Mimecast-MFC-AGG-ID: Ym6LWLAVOuq88s1qv19T2w_1755806874
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso7258525e9.2
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806874; x=1756411674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
        b=ri4v8DeshQCPA7bweYZhViKB85xNRr0Kb+VXy4YavyaKH1/sBsLH+FXfqQhTV/PZt9
         vP5wrYhtMjAN+9r/KcJsAE5LXsQdyhVSPyF92UZb1fBs0wCKO8lyTaIgi95ByAR38eWZ
         wUeMB6Iy7KsvZUViyl8tr2jzA9l4aRliLDIndUjc2Zt9Ojk1UQrWYe8Ck+HvZXVb5N9l
         R2Z/w4MjKsEytnwjmdbjMNbXRUB6kt8XHA48yJURD4uML5UctxmbmvsKyMWyW3xLaCat
         QzyMjRwdo8H/QLB692WW6sIjO5H6huCMdgKycpajqRIoMKg39Wnc/SmS+hrTO5+Ru3CG
         C43Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxopCU5CJtYSVXvZ6QlF2FoNCrCwFep4lOIy2FZf1M5QlFqjVAWzoQNNHOSe5dNOhAmscP+GH/IKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFNccqCQ5LMowpAgFnG/v16RNjft95aYpfOvuyj3ZOLycjrlT
	zZY/WJSWMQGI19ISYguNvVWqcw8GidauX9hEgygn8e7CrcubBg31ddIFsh5v/upk8z9CBj+z+vL
	/s90qAlsQRHBJv3O07Eayc1kco//Wna5/3ysBAZEKajrti8/uzu/upcjy8IzmDQ==
X-Gm-Gg: ASbGnctqcz4nCATLZ2epw6UC7/zOQZ5kEFcfUAa5yC2+r4s/G1d40Gr889Qj4EvM9Pd
	Ao9BB+SilAyts0EPOp5dpjgZk9qyNU5sNgNjbhd63aedoG8u2G+y/2PTUvthgNEcbf9vrNKbv67
	g1ZHToQCsvTFI6tCBHxw2P/Ji32TBvsP40otgyr3T2oLtCc0ApAz+x3PCs2ayZhAqdfZQVMTr2D
	+Eg3qb8fbF/Uph667cD0GOTorAahHACy+OMCJI+eV6czhrlwWOYJw4/xS0mPmCITECp+2oFdbAH
	FTmJcLMdXsol6+DdeJbfdDs7fPh3IfLD0XmouX0/OpaJN50qs/nzzU+ip9fIcZZjaiLA6Dup9fi
	7YwnNhou0Q4F8yr0F8LoyFA==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2554275e9.24.1755806874315;
        Thu, 21 Aug 2025 13:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8ikhW4DoWVw60oDeAXqMRvn4UERlcVawLCjGel2pacwRc1R1ONhYVQm5EzuW0YIJQT4FDg==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2553905e9.24.1755806873856;
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487a009sm12690403f8f.11.2025.08.21.13.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
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
Subject: [PATCH RFC 17/35] mm/gup: drop nth_page() usage within folio when recording subpages
Date: Thu, 21 Aug 2025 22:06:43 +0200
Message-ID: <20250821200701.1329277-18-david@redhat.com>
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

nth_page() is no longer required when iterating over pages within a
single folio, so let's just drop it when recording subpages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b2a78f0291273..f017ff6d7d61a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -491,9 +491,9 @@ static int record_subpages(struct page *page, unsigned long sz,
 	struct page *start_page;
 	int nr;
 
-	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
+	start_page = page + ((addr & (sz - 1)) >> PAGE_SHIFT);
 	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
-		pages[nr] = nth_page(start_page, nr);
+		pages[nr] = start_page + nr;
 
 	return nr;
 }
@@ -1512,7 +1512,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			}
 
 			for (j = 0; j < page_increm; j++) {
-				subpage = nth_page(page, j);
+				subpage = page + j;
 				pages[i + j] = subpage;
 				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
 				flush_dcache_page(subpage);
-- 
2.50.1

