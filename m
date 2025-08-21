Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADD34F473
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806838; cv=none; b=m1jWO0TmN2HP7p7FZU96nlpqgCuXIfoaNxHGne62MV4GvCnFUI4+HNuoa8RDyxWJBTcWLgMG67WMheRXc18stAmLXUqqCYZOlEaaIds936pQYkCRIcyY7PmESQQyrq4u/J+pYjkHOrJj7q1S82wpv3owRx+T9FHTWgStso+xVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806838; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFANAA+rvWDvJ9ve9O8VjWz0GFHVAmf4EEGqy44WJl6pPkHZCri5wXeLltywBaEUHij088kQnLYHtlo8XcGyWTKqB04Jy59e+nbcjV5+ZTHSfeAPJCUVTQzgJQdZMDlSHDhDzcsuCKbvjgNVZx+009Wh2T/M9/L/ZMFXsWtolNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUBaY8aG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUBaY8aG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=ZUBaY8aGc6h8AaVVkeyTLZ3J+O1D+D/c8cVUbV19LJv6ZIKVbXabLCyTrOad47hDCgnktr
	RRuDrA7m34WEiR6fwoRZHoEFArIqXrONt6ywnM+0+d5IkIZjr5pYP70a/XseYFqWNgLQc+
	SAAkVUJHYT7W/shHWSZuLf7wwSq0iVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ivdW5fTZPiCVaknaJEqvXQ-1; Thu, 21 Aug 2025 16:07:14 -0400
X-MC-Unique: ivdW5fTZPiCVaknaJEqvXQ-1
X-Mimecast-MFC-AGG-ID: ivdW5fTZPiCVaknaJEqvXQ_1755806834
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso6963385e9.3
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806833; x=1756411633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=etYNkzGyInh+RR0dZcrLAhZLX4xisthHBVgHWuc0HEwQljk/VofuAs6Vt4j5qdciYp
         SzdmovkoEU/13FRklbTwQAmXWC9CWyb/V1GrC+q78aecQBJKfgy83NjglvC7Nw9GwYgg
         k7MFNHDTaGGN2bHtbkidVbT5TpB9c2jDVERNHli3B089CeD8r6avcCa+kHpQTaNMaUPp
         P10VOgABmNRJd3MYbioZc6X3MzPCRLp7cR4hKSFqrv99G7cwLt+qQpr+3h4I8xtwjqrv
         DqjNEE1TxkZE01MzYOuc25zdzbQQUqn+xWPscYE70uh5H15EV9IdfL9hxm+VsSfodl4G
         FP0w==
X-Forwarded-Encrypted: i=1; AJvYcCVSayE1IGqAz8o6lvuH8V6hxwIERfKDRYSPisPn3DfioauzeUIKEh/AEngtkIXih5oyKNu5oo9gAyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FZLIQCLJRMjHKdjpA6lGfj51NiW03QTr0rtpLFojVrD5Fl7p
	o9oBQhnG7CprAjC51vlhi4bT/4ZlVC3FRd7tjc5lrdcu7AsftA/FDFRJpJ9zXB/6/9EVJfaJg+l
	ZgNBVJD8Ss6R92P/efHXYlUvH2p65ndO8PcPQ+gNNE3A1PjSjLa9GYdha5uF8UA==
X-Gm-Gg: ASbGncsKMypCxlgIf302aEDZLPx76frDSGlNAC9nwj392c+ta+iZ7mPNFfNVrIZysII
	v3cXjxfN/ELI4E//gMjerblu1tpw6XWeqvruSoN28wEHdEZnmKjud5QvZzdAhh+Z33AUI32HcWB
	y3EbJpostDiY3XuC97QXMcXMyR7yuj6IFYG6Cw0Uls0SkfIlG2l9ElAgvVDlM1qUdYYnfPwCHoK
	qs4ZqBh2aLa01hr04DV9qERMUGAB3kyXvug62Pb1SaRoGYVuojx8ENqZyGaSCJ4GCm1mM5njbsR
	oGjxobtJSpnY++xP1Ie796h/2xR91vyNU9q9Jh2pMVImoq2GWwEXdwL3Dvr2Jbj8yK7InuEBmNH
	mZALOUg4q1EdpKWw5FCak8Q==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598305e9.14.1755806833352;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
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

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1

