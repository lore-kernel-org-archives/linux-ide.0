Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44F313550
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806866; cv=none; b=fT4rVOr6Np7fg/pu1W4GwWUPAMeXFEVcQ425KsuM0FPmrnOZY5+fzTF+pVXa+ojeTlbtU4rKbTx1pg79Fv6AzUtwWoed3yHSeumOIgLny95LT408Z25BO1+FWv1CrQBIFJ41gzzMIBH3n+pJ3udsr0S37c2coAnLa9F9Yzi1Xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806866; c=relaxed/simple;
	bh=XmsSbVhT3dGsaRmtyroJ024d7WMqPWbEWQJfIPHhOJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKQdY4vfuf0wuAoOIzHyJaNoFuKJw+C3Rwj3eacVL0XDT1ywE6cbiwrfFWc4n28qQ7cuVjWiiM0RHPh5ZId5UDfFS7Whyz1+5qunCfrcbiJyY68lLbmWX+HSxsJrvtCK6vKz95QZ1u4nuq7NjmV3T9R2TupZwDYiobpBdPx6u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CH8r6nmP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CH8r6nmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
	b=CH8r6nmP3KCdXZMFkoQvPAZ1pJZRBcIAUYhHBGbN4jDLDZcaoAULhvaDkuTvcoWYCPQKxc
	Xz+1EDYt4987pD0fioEn7fmuSQW6gtcCiM6aZBUExDmETNIBvNF7qlU3/6+eDOdvpQFO6u
	k+VZJ2bivRWRY8bIqct/CM0tFvC6TSY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Pjn8Nn_JMFaNm73FHpQlQg-1; Thu, 21 Aug 2025 16:07:39 -0400
X-MC-Unique: Pjn8Nn_JMFaNm73FHpQlQg-1
X-Mimecast-MFC-AGG-ID: Pjn8Nn_JMFaNm73FHpQlQg_1755806858
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so8301505e9.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806858; x=1756411658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
        b=fputJuJyxLfiqjzxhDoMlth3nao/YaDMaGtRV4sMCgSC6F2jcA0yNJYI1fRIxPcoXJ
         uojfGWkfrJIioh741E0aXuxw8y5dL9sSGqp5viBC5dqLEjQgs/FrVWFANpeGWuf3jE0y
         gJgc04dINjYQ9lDvSAv6iSLAmcTZ8UYzU/JU3ZRGOtOQ/+xGnrYbanGaT4rw5d/3B1cc
         aSEHZPAYKX7YO/2kHuRTORnik4ZsgewqlXPUPkjVjN5qA8VwMThv8B385a6+iWugRFL1
         rfMasRs7nUqC8IdDjFhPcNiCm0ueczdFqyMmf7jHAYrWBuEw4wwqxR4wxfJngH90Fwuz
         7tLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJfjxle3MpYh7188JOqCBJj6WJj7DBbpSVMTQWxxFpm2P340jy8JdM6c8FUngrby7rEkAqwLO+imM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cf90MFQgUKcUY6TuBbOhxE+lQ5XE1SNUy4bGYi0mDrHNOrxa
	9HbTbqjGoWEY75EWK5C0RNjzRhoPPGyKvxC1ZBqsdbETVdB8JmK47StiMViobtkMVx9g/78d1+O
	bdHI6CcfglhzXYcz3/nQQ1FnKmmD7yjSxnEmRPOtVNSUBllU49Zc/+lch3aMNJw==
X-Gm-Gg: ASbGnctgvfcuOAGyIRBx6FAbtJFP5EkQsItFHqosExc1ZskmMCWDoWDI7nNIkHGsAEz
	4RTW9zj16pB7BPomqcvcWmzhtZZRbXB/PSL//zkd8AzuHF4J67Uq4EKv1aO69UWan8wU8VV7qwp
	NgXpOPDeHw5S61N4EQ2V4lG05dOdtHWZC1m4rVnsrOoSjclQgY3ciDaFYoe8XISazlqSf/j2z61
	78bWrUHpvNOpozmIRO0BIBcMxYTcEAw0q7TklBYALJmIoT0mTWM5g381d+wDwDJKMJ9XL+kh7zj
	2E+Ahe/B2bdAv4uT7RY6gmcWKn0oPZ4gjN9dmjOKlgoG7xTI3Tqbzlfvr6R1Gz/9OiuM1Asl5n6
	r3VK+VspvSI6TIahNR6uBiw==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646555e9.18.1755806857890;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSU80KqPPviGOLp6CI40u/NjPujjG4FLCG6NoakJIlvY80lRDOTTm20w50mEKFuk0YjVSLQ==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646245e9.18.1755806857378;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e87858asm18672185e9.3.2025.08.21.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
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
Subject: [PATCH RFC 11/35] mm: sanity-check maximum folio size in folio_set_order()
Date: Thu, 21 Aug 2025 22:06:37 +0200
Message-ID: <20250821200701.1329277-12-david@redhat.com>
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

Let's sanity-check in folio_set_order() whether we would be trying to
create a folio with an order that would make it exceed MAX_FOLIO_ORDER.

This will enable the check whenever a folio/compound page is initialized
through prepare_compound_head() / prepare_compound_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..946ce97036d67 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -755,6 +755,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
 	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
+	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
-- 
2.50.1

