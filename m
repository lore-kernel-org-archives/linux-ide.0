Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB036CDEA
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806848; cv=none; b=ElG6jQ065pwszDxD3Huu7WimdsFFjn/9sYXRw6xHmRRMdac76hgsiKDYAbq7G99CBFNlGjbHLlmGWnU8gg+gQmm41Ds4WPqX+DdyH1bCc+jCEwWkG9jA6XYsCyykd9MK7O/Mq/HiQvO/ti9YK9frj6cuvA+xa04XRU2vnvlbXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806848; c=relaxed/simple;
	bh=vLP4m8ubY62ddowshnJEYGhNc+fB41I1n0umGIUlXAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCPrUxWXNCBkbqCtkn3PL8AQLf8pjF2foF3Z72GCYpXryeJwn93FFG6r4/55ApsVaGVVNd606EsPsqAq1LpgE318uhySsDBJ6ew5bjdyGdwohN6oQEYs+iwMoVcYwvZAh0GJq8MNpQ3c6ia8BGBMYuHjqE2BTHw9vF8qxO5OE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2b9wZzk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2b9wZzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
	b=T2b9wZzkC/xtgKn0ukr1t3QPXzSS8koSErP70VVlBJTnOOS6+oUpk4YqREoCKecgtdFRIx
	kGW2IIM/tgsuWykBgbG17G0j4gTen4UC+bNsSqM6/3hdTCdVEEjGP6KqUCVvLPRcpMl4xM
	kkKGre4Sb/rfgzVn3cYIqgkm329u0Nk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-13w8TYVoPa-pe5sVtCHdlA-1; Thu, 21 Aug 2025 16:07:23 -0400
X-MC-Unique: 13w8TYVoPa-pe5sVtCHdlA-1
X-Mimecast-MFC-AGG-ID: 13w8TYVoPa-pe5sVtCHdlA_1755806842
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0045a0so8434035e9.0
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806842; x=1756411642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
        b=pBTLetVhFyC/0TmilR47WDpMRsgmmj4dXYWB3yYHGrWMn+DgqqiVClma5IYB1UAU+S
         E6iKqEjim9EgVYf5MiYphwv2tyJG1Tjnokh+KRBPEz+rfHKvVu09WGP3+ftraZ0rsgkB
         /MVOONVkXLysI18Jdmu4bodcZHan80LBYdU1kQmnYlt49ghI2p8vEEF1PGfOqA4LW1S9
         fd1yCfyQ4bthne7/zaiy6gOqJC4nvbdNR0SiAUs4LsfDWi9yTMmkSAxzocRocz3zESMm
         KoDw94GqWI3/yMXqNxz8r4sjOrYtS+thZOjvtCuNnqHWbeurd57orvErJTzyBEfuNikN
         SECg==
X-Forwarded-Encrypted: i=1; AJvYcCWiHCsRSbMiAfmDU8YGk7+iyUSxok0FujraguYXv8p0ZRUUzUoXfcOJ/cRLiPQ2hG+Dd3PU8s0VehY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRO4+iY/aiyTrpxwN/bgLlkHz+DUGdIY96JuF3Fmum/hTdQVA
	fPHsKSOrEaicNNJQLVUMPWNLm4FuKVtQfj5j4PRBAdqxC2WlBaofH4VAE3PQsj1s6uAt4r/oZ3+
	A6Ts88bsxkQfwIXgsPunlR04fcz78Nd3VS0wlAi3gPzfcPtrCO8qcAEqkrvMroA==
X-Gm-Gg: ASbGncuKt37zAyr9IkjtwJASR+Ua/WkHiQKdD7hmfFPdfS9pgtV6riigLCKGM/NwkmR
	dvrWGi/r54gzCj3uFee16v70EzOkLVih92MEzLQP+T/WLJZi4napKRGUCB3iLV2njQqr8BkLnLG
	ao6md7SxP5GzkGaqYM2WfWZhCXo1y8ltzrxWoZjeA71eO5wL7AmxC3AN/O+MASRN2XAYODM7bmd
	NZYCfWbbKQ3nEYYmT7mdRIHWc4p6AbTjCjMm/amNggh8Nn+I0ZoIEyNJ4inBE+p9yrZ7bm4+7sE
	47Orwzs/BM3qZD/BRxsHw/ZsDSRk9rpHVaYddIfnvNwpFvarSwG/ShL2OCy60xy/N5AkWSp8br+
	7iqozOhr7/ekL7tZ1Ch5VrA==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412845e9.14.1755806841743;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBnzBdejX2oNj8vG9iZBZKJew+pPrkGWxHzVnhFEnb5RkXIsj+cBFTtJrIXnzr/4lYhSU+w==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412295e9.14.1755806841198;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10960275e9.1.2025.08.21.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
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
Subject: [PATCH RFC 05/35] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Thu, 21 Aug 2025 22:06:31 +0200
Message-ID: <20250821200701.1329277-6-david@redhat.com>
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

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f4..1149289f4b30f 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.50.1

