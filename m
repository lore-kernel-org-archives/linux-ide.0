Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4D37428D
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806909; cv=none; b=BqY08wqJhFWVzUZvK7teL3BJUS2YMKqgcyc4wyH0ih3b3qJdQMXA8Gfdk4G3A4WbJlbDBlWiEnmO6dU+q8Te3nGMzdkTse58TpfWHbf8lRbzX7VWNyNSBtPTPN/zYyc6W8ZW5fJckMg+0wNHmSW/XLz6qG8WeVs9AVeD+18Io8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806909; c=relaxed/simple;
	bh=bq2gWh1hWRAlT57D1zXSNbOueAtiEim7ETzHNFHN/Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5Xw3LJdGQVt2Z0JgPdRTyKD+bKi7487d3v/RxHdzzWqWi0wS8UDEt6/cZi8S/Y9RMY4V5/i1EvC6rN3/LWipEq5SGgqH5sMu0akau9bRMZ5hWelFoRZ2QgbT/jy0EwIfa5h5XC8TnibKkhwiZys5jE/54BS020yV1pnyHq8kzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdA0r21N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdA0r21N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR/3u5W37RASrGsn/s3pQVQ78UUgH4ByCavV3b4UG3M=;
	b=fdA0r21N38x+v2UQLIZ9WgOzWypzyF/gGbyMtQrNNeIBCBkAH7jv3EsB2igOSoB1bm5R0u
	zwSo3epyzhY1kDhsD1gVzR3BS/SSw7j4pFu5qqw1G9nF2GyfOSX3B4rDzNGsDz+YRLxAib
	yGhcCmMtiIyZzytyFFCB9WOUCQp/uaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-gBid70cWNkCubVWvkAoAwQ-1; Thu, 21 Aug 2025 16:08:25 -0400
X-MC-Unique: gBid70cWNkCubVWvkAoAwQ-1
X-Mimecast-MFC-AGG-ID: gBid70cWNkCubVWvkAoAwQ_1755806904
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9bfe2c601so767121f8f.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806904; x=1756411704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR/3u5W37RASrGsn/s3pQVQ78UUgH4ByCavV3b4UG3M=;
        b=P0mxC/hOL5N7ZyeXHrBAw0Gv09xKOGbAqHayRR7xDf1sVay1cYOGTzQPVyy0I2XnAw
         XVRyYhuIhJz/cvXg9HxEme9oZdWziCHqllGmhilP7+A4wlpiKq4juVcElgQ7OthPsCGd
         jP5eJe1lji/opYPYl32LH2xzqudiFOm4dVCrj2iCKz3wjy+7Iymjfc6e/N3RHb2/ZUAy
         8DPzhOaSgPkHHVmTxec3EGwjkfXsZ+HqPz5SQFjWb5UztUJb60jdiqyOF7RMDs1kX9AP
         ajrqqC52mhMbfewC3Wt5feKFtePVXjPeOicw2AS5QwkFTMb/rKmOitRc0vWN30uGo6IC
         jvYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmhC5P+kMsBKPSA165T5QMkBvVefs2E0EHLMiP1oLoK/FuGE6JGI5ox4vwboqrQP9K/JQxXdrMfhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2oCBxufORNnc4buw4fMmLO/xkbpwUUbL3w7alAbT9PiybPUx
	07Nw5j0JWI0XwHb9csc51eEQ4OF3vRcC07Cxx/9W9GyN7rVlvgrZJUB2wUVWSJwS1wPe36Ys9Z1
	0OGAy8VIV3SAchgA5xSIaxROUTKy9J/qa8in2S26Y4lBl50um+2YSTZJeVHfZIQ==
X-Gm-Gg: ASbGnctwPe/Dx44LbS0DnOOSf/QJcv3N8zzNDgbVazC/ofqmxCBZGBzDYXlZym0YVmD
	0V7dZpt1i79HuKmTz2V/5iMvHdclpbOt3Gdb17dI87ND5r2K8u+//ePmkB3i0nSF1/Rah9zyiLB
	lKucwxu/5EB0UO7THRfTW/M6YdD0T/TQt/87F7Tn1faUB/MZrS+xKUeTbsPGNZgXs+bvS12444G
	eR3kwsU70YvYC4hQabb6sYSnAX3TXw++mxrV514doT5WCeJe0jND5TRARmbxcKkc1ou2oNxCEuy
	3tFAinYKzPgOft4Krtd/r5p9+GKuaQZ4NIeT6RisTkGqh4bLwkYUMXhA2+W+fpNaVgDpzL9PBi6
	gg7wSm2g6hSxflg5WARxq1Q==
X-Received: by 2002:a05:6000:310e:b0:3c3:5406:12b0 with SMTP id ffacd0b85a97d-3c5d53b40abmr247293f8f.30.1755806903646;
        Thu, 21 Aug 2025 13:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+53ePp4gOBoZK5+aLlST4uu6G3xHtHBUa0vmdrbtPfJ4bf44S3Zn2IpCr0m84pAneAOD81g==
X-Received: by 2002:a05:6000:310e:b0:3c3:5406:12b0 with SMTP id ffacd0b85a97d-3c5d53b40abmr247245f8f.30.1755806903113;
        Thu, 21 Aug 2025 13:08:23 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c1708sm13032145f8f.38.2025.08.21.13.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: [PATCH RFC 27/35] memstick: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:53 +0200
Message-ID: <20250821200701.1329277-28-david@redhat.com>
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

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/memstick/host/jmb38x_ms.c | 3 +--
 drivers/memstick/host/tifm_ms.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index cddddb3a5a27f..c5e71d39ffd51 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -317,8 +317,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index db7f3a088fb09..0d64184ca10a9 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -201,8 +201,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
-- 
2.50.1

