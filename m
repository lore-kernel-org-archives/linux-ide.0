Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778B37CC82
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806912; cv=none; b=SNOFjw7eQW3K4RuGlINnk1LH1SeoSm+raYmKMsU+i8LIg3CT3wOdwclvJcQBWutXH93H7mY1miZp9GLVCiWtf60MH0B2Imd9FA4UClynaAGINlM83uta9X0OPfvl7TIjz6RCUcwBRFN2NS9JS4miBirZKaEexHi2PkAoG+h5u2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806912; c=relaxed/simple;
	bh=SsQg42O77qinr7crb+JX5LkctmenW7x9L4AwEMidQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMF0l7Ns681JFc3pjPVKrA+Fg2olupyUl0vrx/j5p8KJwmiztkp7d2VyiCfFeigQdtn3upNwgV1yRQR9lsVc97CZtvczMtxEsTbdz15Gc+X0jNZ+cDxoj4QL89sZh7xdAQpiZbdtST4Txp39m7PNVChvXfjm+Ky3z3tMGlzJNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMbgk+c6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMbgk+c6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKmA6ti8X8/YIeKKq4I8EEiHVsObQn302mzSXytdc/A=;
	b=RMbgk+c6NY3X2Y04IGUecPO9z9/wNEqUjGc/0E/NtV6bL3DGA8CbNpQXybroACN//0s+ez
	pgr4W2/Diw23H+GfTP8dCGtsWJp7D+T7wI+e0q2EZ+4NwbOG2A3zKv5n6iUD0J9azzJPn3
	ytQKKziup6h6r7RQQNEM87DctiecC4o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-FuM291YlM3aZCqhYLKu2KA-1; Thu, 21 Aug 2025 16:08:27 -0400
X-MC-Unique: FuM291YlM3aZCqhYLKu2KA-1
X-Mimecast-MFC-AGG-ID: FuM291YlM3aZCqhYLKu2KA_1755806907
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9dc5c2820so445616f8f.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806907; x=1756411707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKmA6ti8X8/YIeKKq4I8EEiHVsObQn302mzSXytdc/A=;
        b=WQrsri/Jd2/s7EBIhdUTQLKmBEH6jkNSXNwENn5Vb4LLPVNMsBZ1S9MMERv6uZms1Z
         NjL2kkt3gCihd6201wnQALRbxmMtUQt180OikAYpsU2exwHnjWM2x5/k+mO0ka4Y4nvQ
         0inmTXYJAx6lCBND3Zq9daXIzaocCM9XvbrblPJkqTXdWxNYF652vrzIhGRzohZb4gOR
         /Kcs/ea+IVlCJDtcGsCDlzXDeWLkl94hYOi5Ju/31u6c5a5rH5O1wiv/lo2SFMD0VmHq
         5UQuunFqskyOqy4n85GhWuYdX78HrNNYowrntYW+y2uGFxEk7EGBeHxtopbhVjqBPb1x
         5XoA==
X-Forwarded-Encrypted: i=1; AJvYcCWom/7Vf/E4bUq1HQdNG6gJi28C/WJdMZvwuza5mxqSCvUUtn5X4PQzVidUW5X1WW9/Ox8kOGkHPiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0wBfUVR12B9gt1Wu1CT5HGEEWHswNknYt777UyX3nMopUSzt
	kBj1ldZ/rsCkcJ3oRQjUeOGfcntLDX9ANCUOYzIPIF4jjQfxzOBGIEo6FMU+geRA44RzpJmWqze
	zvg1zGwy8mTbb7zehjyAj9liiOvMA439xrgksR9bullgDL+dHHcBZk5It1oBHPw==
X-Gm-Gg: ASbGnctk4Zj3tMa9zVWN7s261Z3pr8sjOCnhDrNpR0OXUeJmOR1V1vj3+TC6pXv7AmI
	jrzj8rYShWKaDp8dk6J60/5Ch7VHb1cRm1qgwHFCk4xf2nfuiUdbOu3+1I4V33u+f7GI0/7siNx
	Uak+wn3uKcnCKccvOsF8kr95pZN12JDmCPzQKyUYClpbZBOsNfogQxxvO1e/U3YDmoxPI2/KeBb
	hYboAD3auqeNJ96I6Eq0eCGSSwugJD5mlcFw7dU+/U0+otNr/hRKp7ic9QQk2+tLruZd+0WyeBA
	4OGMx/l2fL6zx4yIuXTtmyzWOjpbxOQDubUVEEs0n9KIahhYWxrJo1ymLezZii780rirwENjYPj
	b1ev769bg6cFFQr7q7I4uGA==
X-Received: by 2002:a05:6000:288a:b0:3c3:f134:28ba with SMTP id ffacd0b85a97d-3c5db2dcc73mr210103f8f.28.1755806906735;
        Thu, 21 Aug 2025 13:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFquQDwTQ7641wc0kBtooMvxSzqNfE3+XbhkCNDvunKpGE2abRVQ6uRBkb0Dc/grDWRh0uIiA==
X-Received: by 2002:a05:6000:288a:b0:3c3:f134:28ba with SMTP id ffacd0b85a97d-3c5db2dcc73mr210077f8f.28.1755806906301;
        Thu, 21 Aug 2025 13:08:26 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789d12sm12702699f8f.54.2025.08.21.13.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:25 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
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
Subject: [PATCH RFC 28/35] mmc: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:54 +0200
Message-ID: <20250821200701.1329277-29-david@redhat.com>
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

Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/mmc/host/tifm_sd.c    | 4 ++--
 drivers/mmc/host/usdhi6rol0.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index ac636efd911d3..f1ede2b39b505 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -191,7 +191,7 @@ static void tifm_sd_transfer_data(struct tifm_sd *host)
 		}
 		off = sg[host->sg_pos].offset + host->block_pos;
 
-		pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
+		pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
 		p_off = offset_in_page(off);
 		p_cnt = PAGE_SIZE - p_off;
 		p_cnt = min(p_cnt, cnt);
@@ -240,7 +240,7 @@ static void tifm_sd_bounce_block(struct tifm_sd *host, struct mmc_data *r_data)
 		}
 		off = sg[host->sg_pos].offset + host->block_pos;
 
-		pg = nth_page(sg_page(&sg[host->sg_pos]), off >> PAGE_SHIFT);
+		pg = sg_page(&sg[host->sg_pos]) + off / PAGE_SIZE;
 		p_off = offset_in_page(off);
 		p_cnt = PAGE_SIZE - p_off;
 		p_cnt = min(p_cnt, cnt);
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 85b49c07918b3..3bccf800339ba 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -323,7 +323,7 @@ static void usdhi6_blk_bounce(struct usdhi6_host *host,
 
 	host->head_pg.page	= host->pg.page;
 	host->head_pg.mapped	= host->pg.mapped;
-	host->pg.page		= nth_page(host->pg.page, 1);
+	host->pg.page		= host->pg.page + 1;
 	host->pg.mapped		= kmap(host->pg.page);
 
 	host->blk_page = host->bounce_buf;
@@ -503,7 +503,7 @@ static void usdhi6_sg_advance(struct usdhi6_host *host)
 	/* We cannot get here after crossing a page border */
 
 	/* Next page in the same SG */
-	host->pg.page = nth_page(sg_page(host->sg), host->page_idx);
+	host->pg.page = sg_page(host->sg) + host->page_idx;
 	host->pg.mapped = kmap(host->pg.page);
 	host->blk_page = host->pg.mapped;
 
-- 
2.50.1

