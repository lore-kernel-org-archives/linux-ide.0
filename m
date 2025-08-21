Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15E353347
	for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806841; cv=none; b=PpyEpV9vUvBDffAjyZ1x2aS3k9mGpUE+sJ0bxk9jdQtAKdJY+aokVb+zenUFCqBQ1edJv4PO/NF+XVAgohvxckfEuY7tSWa6EXWgoclU2SS0+2aPErMGERNh1adgFyovAaqCHHUA799GaVv16aGJHnGvLPULWv6/3TfMx74TFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806841; c=relaxed/simple;
	bh=rCgYuDQcQ3nJcWNFmOxD+pxeBEJSNoep86nFob2zhE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5cO5Dr1r6PJH62CdGFLUdkplCCNvKtRMrBaubJH6CJWfHbZslGRLfi+VUpbfDTQkb5b/BOAQc4U0wKO4fBda49YcBqbC93zc6KR5vW7lJ4jgylLyt+GLxZzICMSArrRU3+hDNgJbIQqobpKkaPANki9t5Z+G9lPN9KnFMI+mZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvhgezoK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvhgezoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
	b=FvhgezoKXHMUZ2BWrsd04lTIP8unxj540pU946NcJnJJuOAbNKVsaPENFIHuD6kkJBPSKP
	p0LfaqPL9e5jofDyReCvBx3Ju+COG6jcSU+9UKHLRmnaECy4UXAUOU1zvMDtILyXgF/jdB
	8mDdg99mU8xQvc0YJu02PswwzrZb9Vk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-C1AVS5E4PLKEYPNZeodqKw-1; Thu, 21 Aug 2025 16:07:17 -0400
X-MC-Unique: C1AVS5E4PLKEYPNZeodqKw-1
X-Mimecast-MFC-AGG-ID: C1AVS5E4PLKEYPNZeodqKw_1755806836
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc566cb4so995966f8f.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2025 13:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806836; x=1756411636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfh98TqNQqR9uCNr2hB5bEgIJ/15ql7Yv0zNbj5EC/8=;
        b=eW68TkO6SAm6pNvuqvYdYgFkJdqLUzqqrwj3+SD8Mt1BRflIegPaZcn79QH6pdxbM8
         OQxgPpyZOk9eENpeL6otFJVjIi+HHu/mTM9Meom1HgFnZExGogQGK2JaqeXEaLPddrHn
         iojfUS9S72KCpymdCGD3M94p1acr55evXySTt8i085U8zxwb71x3j+MjGRPtWXKJI7p9
         0ClSNgEG32NhHIB79amoQm5HOfn3d1I2P/WdM0ONFEyK5mThXYdRvHYe9hxgz+gj6G2L
         cJPD/YXquLaIMQVqzZvbi4R4INYTKb0vwFhnU54bqiHJqBj6IJPdGH7ZN+bH+WaEHzZo
         6kkg==
X-Forwarded-Encrypted: i=1; AJvYcCWtgQyf4I7tcNnb3K4b407U3iv7eOlUW1yKcV8u6TcTJeuqXq74gBQS+Iyu7nPlaH0ImmsyWJFWuIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7z20wpF3LL6y2/YXYNCslm7YVGcTg78EK8CoiuWqh9OVZgZg
	5scj14ECrt6LEaCiAj96CRP88+nUXyPWM+FtSBTtN1DG9V4Oso9ckS6xRAiLzIRqSarX1d7AHz7
	Nmq82l4EZsfDclJUjCfdX9tUWuPoirYDrL7+vTB5x1LShzSSP2Hkb7omlVu3UDA==
X-Gm-Gg: ASbGnctb9TMdRv3ISAqOJWcJ+ccGxzUqx5kaCOKvIqhxrNMYIKUgDfXbEG+cfvuXBlz
	ZwpkqyFLtiJSgEsKlZ5rPYjbppeazs+GREtx3r89Bq8Jvh4Jue33hr2+mc81U0up2hlkb96Eqp3
	zEKcAhqn6c3r6dG+YI/tmaRA6OYXt/xXE1lsPZLbU7w+r+RUqOCUmXUxRZOoz+fit2m+a87Mo0P
	+heChwYF3cPib46xjkutAXrQefegE4SbU+RQOgrsLOxWQtkvO5KmegfV31uKfQS5VkihKyhssiT
	pV3Lob9OfDyjtgZigq0m7VVgFowM7t3w/M/irn1HM5hHWmHgAnTrEm4gaVj2wgCpXuJXUG2hxPq
	A5zgiHWHlz++e+VARCR4JaQ==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr162976f8f.48.1755806836133;
        Thu, 21 Aug 2025 13:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpC+bUbLbCjHqucY3RiMYJPd72Xl9UYU3JmJwOiC1ZPXsKWXLLEiwWSHifO8HwGgrBWSbiEw==
X-Received: by 2002:a05:6000:1445:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3c5dcc0da36mr162946f8f.48.1755806835650;
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10958175e9.1.2025.08.21.13.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:15 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
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
Subject: [PATCH RFC 03/35] s390/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:29 +0200
Message-ID: <20250821200701.1329277-4-david@redhat.com>
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

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c26a33cf..145ca23c2fff6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -710,7 +710,6 @@ menu "Memory setup"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-- 
2.50.1

