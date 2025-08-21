Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E737FBF6
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806929; cv=none; b=cZ3V1cN3AZ81onv3JcsPFTmz35/up8LMk12s8eTqavuKepRcQZfanq6n2NfDMmQbfzMWMkId5eb+vhs3I87Xj0NavOy8T7SHDMLdrB27gwyE8Yapf5+0LLLi/Uv77Y0G39bCy5LO4E/3Uq6w/wDMaHqwR74zmx1HTQmRHtZQX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806929; c=relaxed/simple;
	bh=izYuZWtM9expuJ4aw1W3JEFW5k9djBINp3Pti4HydYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNAGz+dyRl/Dth80sbTSD58wezNH2x5H1kCcOTwq/HZ5Y+Ow9MUDybTINaAuDbieXD1Y9KTdsLoGgG5WJdPBoxy+IFRldg10UO7gV5hWknloJIGI9Tt9CQbK1S9Qwpaouz+IiAym/IPioEbFC/IiveggEqKke5jIuMiAiLsHXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfRnDWql; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfRnDWql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
	b=gfRnDWqleQo/tZ4QAtrPQMKR/aUg3yes98cmHPGjoTSRneXIVL//IQrG0SWTbax/+5Iz/9
	ozw1hgbIbhMaJIcm3hzSqiWVfzGZ7WLufLzSMczJFDkBKFPEMw5zlWpb1ZFHB2I2YPlnlr
	vg9CY6UzsMjU9WGLhao23urW1yfcuAI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-o9m5l2IHO1SCifL7LIXlqQ-1; Thu, 21 Aug 2025 16:08:44 -0400
X-MC-Unique: o9m5l2IHO1SCifL7LIXlqQ-1
X-Mimecast-MFC-AGG-ID: o9m5l2IHO1SCifL7LIXlqQ_1755806923
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9edf80ddcso517663f8f.3
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806923; x=1756411723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
        b=k2AAe8Di+GyXFnd+z8K7BqDcLcaauvgkMKyGk78BTXqw4bfO33czNEwQKJVOEtHKJK
         4tovvrKWqNL0nzmEwTAGa1FJKWANAfdAcYNnWl6MwSM9MalXSLFUgaJrckv36Tk6sVro
         qJTC1y8Lkwn4TYffIe6t+XfJuyVc5+C+p/Nabu6i8M5UJp2ezRvWnAUQuQ/Bwa7WNz5R
         1/P2sN0dzUIuwg46F/p5OPvGGcizIl3r5XpuMpv1W4mcY1Lg/UMQUUDlnUJ44YnyDWga
         oIJooTHLJcYdr2vrwb7ow8n9yuvtn0tFsSpfFSPLXp8V7CT6t5CAehXrUAAwg/jstsDl
         UGNw==
X-Forwarded-Encrypted: i=1; AJvYcCUobPv4nw3Gzeb8ixz7zJGr50wMTXBKuXHac/BgPxQHZNDOUHzD/1WsdZ2CvUWtlLRq9EE4bSEtkyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSG13ezyqQ/W8GXfKxq4TwO6v5OaoHvvpgSIuQr4x3Lcf5Kyj
	h7O2l4Ez1ocuZHaLNQCN1YtgZw1FRVId15DrzFXUhW4DKi5/zr/+oQLkiyXKkDyQBy3/w0aX/9m
	KAfweqUxEBqi9gHuzlh4cNxk3DmYr9gE0TnVdeYodv2GVjkZxOor/wfIn9H/jqw==
X-Gm-Gg: ASbGnct0LB5HLg8kiUs0mABHyQ63W5qEL9PGhEF6iHcoCbNpHm5fc6weiBPsp4cG9nQ
	WtSjMW4R5hdJDepGDX/ibDsE54AvvuG7K4Pt4by1cNRMMj/zSX9kbDW6AezrncqAN27dZNl6gpt
	4pwNu/hW/XqG/kKxI/tU4wUYKYXuHg7rc6XXhX+0og38bCdfP6nLUjTm1+/yAuKpwj/9GUo5zxd
	nOgkiMUZLYQkZaMbOuprC8OoR8VMSYhOp2L5mq/BYNzrx+AR6o0+cpssOYOToXa6FbuxDVyldma
	6GyM8TwBcy/u/Wz23cZtgO2ZLmrxwuCYwArNxJYL50XeHucZzCyDJzQmLjNjes6STnMvMYs1aNm
	pk163GjvELlrpBLPRT85XUQ==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204682f8f.33.1755806922954;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnHzRKC08dohUKQD/XdldMc6IWYVddiLtTh8Yidep5vx+5++gzVG23SiimMwYZ+HldR36Zkg==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204645f8f.33.1755806922505;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a587sm10028205e9.18.2025.08.21.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
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
Subject: [PATCH RFC 34/35] block: update comment of "struct bio_vec" regarding nth_page()
Date: Thu, 21 Aug 2025 22:07:00 +0200
Message-ID: <20250821200701.1329277-35-david@redhat.com>
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

Ever since commit 858c708d9efb ("block: move the bi_size update out of
__bio_try_merge_page"), page_is_mergeable() no longer exists, and the
logic in bvec_try_merge_page() is now a simple page pointer
comparison.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bvec.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 0a80e1f9aa201..3fc0efa0825b1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,11 +22,8 @@ struct page;
  * @bv_len:    Number of bytes in the address range.
  * @bv_offset: Start of the address range relative to the start of @bv_page.
  *
- * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
- *
- *   nth_page(@bv_page, n) == @bv_page + n
- *
- * This holds because page_is_mergeable() checks the above property.
+ * All pages within a bio_vec starting from @bv_page are contiguous and
+ * can simply be iterated (see bvec_advance()).
  */
 struct bio_vec {
 	struct page	*bv_page;
-- 
2.50.1

