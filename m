Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1733350D7E
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806899; cv=none; b=T5TSfy3jIS3JQmJjbDBk2qgNYeYgH68RA3+24wBVUxu4sSl/l/vXHY6N/eS4SuiabstnS74N6GJ875JVBVM4pgXoYS6fvLFAsa6QFLXjRZoQbFrgBGHDCB4VwTn0AZ9+pUhYDfxRiwxboaRwZHw2DncqwNu8cTiHJIB+BSzImTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806899; c=relaxed/simple;
	bh=o0B/aIsMAhafmNCelOfWp+ALdEBw0Dyti3dxNNba1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzKAnJDaaNaWPNl8iLrybN7bI2QSdxN1DPW12341UWWuj7/kHhm3lQYT5Cn+er3VqDO3jyRYKAR46OdxCw5mnQ3W6/Xl5SwccshX1BWb+aVIHDdS0cwXJFHxK7E9m83kKG3iOwL/V1lAFe3mq8n+rpRi6Fv1/Rn13AhF9zSxfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX9ONMgY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX9ONMgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
	b=aX9ONMgY8Vm9SFNoIXmwHxRPfk3NmbO6UISkA8vvEeo3SF/fDCQYUXNYDiwfvmFWOJ4lon
	HFolaJl5h1GSXNjWj9ptyUPBDd1BvVxQZAz5qhoYO/51ReECmFywElPz2/HhSnOjSlC21F
	bRBlMVJGNLiPkBF9TXx1pxNZ7YGpT4o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-FKiDEDpZOqSsynLwEe3ppg-1; Thu, 21 Aug 2025 16:08:16 -0400
X-MC-Unique: FKiDEDpZOqSsynLwEe3ppg-1
X-Mimecast-MFC-AGG-ID: FKiDEDpZOqSsynLwEe3ppg_1755806895
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e4117542so631251f8f.2
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806894; x=1756411694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
        b=qN33XwGmkcNmPtAShaZqXCnZGul+tNJicmpMKXvsRr4PC6q0SVtnzU0j/cYYVmvur+
         wbH1UfRDggm3VWYfz7iTlekeMkxESx4VNS91gaoJvtekcEUK8FGXfCC5qbHiZDUNWncO
         FbwiZv5EBc+gHrDpSUm43wedGqii+htv+wqMPG7aM1dqxgTtuwwIxWhIgh8L7ovkpM6g
         S/0qCBZIj3R3hZzDTXDzj8220vW/ZL7QvUojDpXGTkrXvovVQvQBUsuNpgu2e3i01DLB
         Oofnb0iuxGRBsvhe/8AHYYd2N6ruP/N1b3mNYzUUlCSrADfbLxoRB88+8SV6Qh0bHplp
         2nZg==
X-Forwarded-Encrypted: i=1; AJvYcCWsVjVeeMbBcpY0qe3L3nqTDrVnw1RZOKm8OX3qg01gsn9hRa3OTLbPMcFPt8LWdXcmRoaccqQkCRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSdr2HoH0FVrqVnluyKVYvDKX925LGRco7Z5KepT8npJlBkM8
	jbUsGtqyq2I4zegYTyYQvupHwcnaIDwDCxb0oF6lGkEpeI2EaJxcLoxndyATh41f2dQQF9GOoyL
	s7b2lSC/0U08p8EuWcKZYU2epk+SKSV1dAvwZv2VgeIRv4FbzjHWlZvpAGQRqrA==
X-Gm-Gg: ASbGnctu8dQtrbs1eqXKHb6qd1GwHXJAo6TmicyGP2EKkmGuTBitZZIS1ZkmN+pk7cE
	irmVIeitDwd4NcE88K8QqtA8/ciNMyE6R5GcZA1guvNf5u5f5eLde7mJZAqiKAblD3nKO8XcQHp
	WFaq6T9qxPbD2a2QFu7CRxjKpoUZaG1Dj7kd6nA3YMd5Di0ensoqVr+A9WGb2PubuOyuZDY1XgV
	+yqEiqWRiqOPn1iRpWV4BxQ3jS5TkEdkEezefRNN2i3D7+6Bg1mnDRjupeQG9zm9A4KNP+UuTj4
	ll+WGlZxLZ30APCMh0iU0b4aGGAc3G28s0UmN969HbeaHCOcWWDC2izl9lSRHFOYfBm1FTu3shC
	lu81DdXRoAh+pG20krhf11w==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215852f8f.44.1755806894498;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYrE9N2OTZOZSEOVxEUY9xhX4UsF8UOhI+5wOqBRpd/3VSIxUjVMLdiea20BiXkc+w3FSZ8A==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215789f8f.44.1755806894010;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074e38d65sm12982954f8f.27.2025.08.21.13.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
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
Subject: [PATCH RFC 24/35] ata: libata-eh: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:50 +0200
Message-ID: <20250821200701.1329277-25-david@redhat.com>
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

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/ata/libata-sff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7fc407255eb46..9f5d0f9f6d686 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -614,7 +614,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	offset = qc->cursg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SHIFT;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
@@ -631,7 +631,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
+		ata_pio_xfer(qc, page + 1, 0, count - split_len);
 	} else {
 		ata_pio_xfer(qc, page, offset, count);
 	}
@@ -751,7 +751,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 	offset = sg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SIZE;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
-- 
2.50.1

