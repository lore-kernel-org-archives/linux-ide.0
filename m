Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2142252E
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540946; cv=none; b=lfFOPlxlt+7q94yoeqtXFndbeMxwOI0DFRxNl63lbTPzn6DuIbykCUMxUum+2TB6ytIb429Xx5PYylZnOzGDYuhdeYdkpX5NIB9VzozwbhK8vrO/zLocAboCfmzVMRthYhWS4y+6ENOZTpbAusgKzdlQuJzPXKEAOAX8HpAovBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540946; c=relaxed/simple;
	bh=ZUMUGZ68CjnRy0ZsDRlJUAAY0KbE7wlJ7040W54hgds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVlnoj4hzVHoT6qZ1x9EErAHE38otshoCtco3uqegnON8ijMYIzk1qu5q8ekBCGKRd3HNJn2iv3o8NJwRVMT6l1jr0VvsVbGlDv29Suwv0wOh0sXMozCN7EYoZTfJDz/t9KxqqmhaCQsfBEs6Zt/VC9SoiUm/7F8cY71qK3AcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnf8hgT4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnf8hgT4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d9b60c652aso15159865ad.1
        for <linux-ide@vger.kernel.org>; Fri, 04 Sep 2026 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540944; x=1789145744; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4GsW1ItMcI94B2xBysezzYdBJbvGd3XDZq8/TrBi8R8=;
        b=hnf8hgT4ANbUimZjfdb9nEeQScV5K4MC0tWaN38K8V8LKTe7GaxK7p6IF8hPnph4ue
         OfnI1gXhE+hKtMjSWjFeuWWIqNgA8Yw2j1gia5gRJv2rZMHYaNawMP4/7SSZgx1HWFs7
         phQWJa09oVpGnQmGDqNQHJIrEJm+yickeiF7eW0P96D7kw77/Ar6I4e5t+u5zn5efUJ9
         e363z9Gxa/0hNclhSk5/Xx9+q3z5LW58Rfx8Z1O0Y075sgNcBG8fwOrY4P+R5ZeCzftC
         t3J4WhsPOXMXlAeBgwEc6mM4As/3e6bJ5Ugkk3/78wVX43Zui3Gy6e92XRH9Yyx1zMLa
         8rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540944; x=1789145744;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GsW1ItMcI94B2xBysezzYdBJbvGd3XDZq8/TrBi8R8=;
        b=cVL+7F3kx6x6AHCvEqPHrkJJCEZdmVTCSdLe/qP/rvM81CL/Z2C3i1agRxTsg8u8QY
         HLypr5LPih9treWH2bdr5XtYDTZUkFkSOtNVjtH24lEtjQhTSCkx+SOKR8P7WQaSK9Ot
         l44FDdZrQ5PrJnIzuDau39j3aKPlUqvesM3NkeSdwz5mHxUN27hVyjRkOYGaE2jJp6S0
         4PIJdnio6Ubcv6K2pIBmAPz6DQZ4XlAevFkC8a5fuPPcuVBJ0Jl6nqInWKPPXJAffFFL
         Sd8o+dEdy1iyFv++jmu7YjXe0iYwoouo7EFmz39uDJDusnpKiSyWc2GnGehz7nqBfV+k
         SUtg==
X-Forwarded-Encrypted: i=1; AKwUvBxjJ97PT3u9Q7GV7Z8K66V8uNWDrEMccFQfW1dsWLA3Mi5srKXzuA305ugYHUaT7qF761FcnXj8WsM=@vger.kernel.org
X-Gm-Message-State: AFuF++lkxvssmw01+N9NhvIjRM/BqN7FYOtwQt8hnfLBEkiD4mxCFd8B
	redmCZx/DeQc12TaceYIqX3t+ddG8xX+ENqpQdCBYIpvHY1Hn7uXAUMc
X-Gm-Gg: AYBFou1qF45Yc0Q9MX7tTiB5djZlKom/ZtDywog88s8jIeZiuBRNgSCS5EuQ/IwN+0x
	4luCwThSJQMSiey+g60GddbXkTtINQFdGqezekrvi9jwHA2EeWmDpjuhUlwrLu402izWh3FOsUs
	Pohr6Ccy2KsXMaQUPspxH+iyrJtsN9rqtYMYjAkk81ZKYDtXL1fMz2+WURxM+ouzW2SLfZ8lD7A
	VZ1Ena44gQpwFsEpeigSWJaYwHroHTDXlo6iD2NHY/R63X7TkzYYC18i/7hvaewCI+jfIPJBDun
	CPyE6HOsmhUCCNPvIg0pcLotxvMCkGjGvyd/2GmxoB/w0kcNCPFJbCqAkTQewxoatSSPD1nuf+X
	59EHyimIrJW+I4OWnLEbdJPd2eipIRzEJ1WSuINUcw2uXKhq7ncyHBAokDMvvRq9x2RVqlG0cJ3
	vt+MdIGwaFjqKGvSgF9ZBZIPH8PSNq3x3K3vvTYGTQGXlqYEsXE2JwHuk4IzlYVbmADVvlUzgIn
	B7dB7R7Z96VT82UqLIkvsXqCMG3GF0TUkQHqD4Px+3nFLsuJq2JXFAQf5ZzjDkumdi4lMP7jp1y
	cXj8RFyX
X-Received: by 2002:a17:903:324c:b0:2c9:deec:f564 with SMTP id d9443c01a7336-2db127cd4ffmr116304655ad.13.1788540943879;
        Fri, 04 Sep 2026 09:55:43 -0700 (PDT)
Received: from [127.0.1.1] (ppp-124-121-114-221.revip2.asianet.co.th. [124.121.114.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14aeaf74sm12251675ad.81.2026.09.04.09.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:55:43 -0700 (PDT)
From: Mikael Etienne <mikael1022bzh@gmail.com>
To: cassel@kernel.org, mario.limonciello@amd.com
Cc: roland.waltersson@netinsight.net, artmoty@gmail.com,
 linux-ide@vger.kernel.org, david.laight.linux@gmail.com, alvinwylim@gmail.com,
 kernel@wantstofly.org
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Fri, 04 Sep 2026 23:55:38 +0700
Message-ID: <178854093896.541085.18395405788748617410@gmail.com>
In-Reply-To: <apq-h4SKix_zn3ni@ryzen>
References: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apnpZ4d-utWZM_Ux@ryzen> <78dae3f6-3b3d-43c8-b2a2-595fd6e6a00b@amd.com> <IA0PR17MB66878CE05C135A2BA1F1DD079EB52@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apqn-bdMi4y4l1gE@ryzen> <07efa8b1-c5ef-4a61-8b0c-45f68d02d9f5@amd.com>
 <apq-h4SKix_zn3ni@ryzen>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Niklas,

You asked whether there might be different versions of the AMD IOMMU. Here is my
full identification, so this can be compared rather than guessed:

  CPU        : AMD Ryzen 7 8700G w/ Radeon 780M (Phoenix), family 25, model 117,
               stepping 2
  Controller : AMD 600 Series Chipset SATA Controller [1022:43f6]
  Table      : ACPI IVRS v02 (AMD / AmdTable)
  IVHD       : AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
  Kernel     : 7.1.x, Fedora 44

The EFR field is probably the most direct discriminant. If Arthur, Alvin and
Lennert posted the same line, the "different IOMMU versions" hypothesis could be
tested immediately, with no extra hardware:

  journalctl -k -b | grep -E "IVHD EFR|IVRS"

That would be particularly worth it for Alvin, since iommu=pt is insufficient
for him while it is completely clean for me -- that is the only divergence
between our reports.

I cannot be your tester for point 1, unfortunately: I have neither a JMB582/585
nor an Intel or ARM IOMMU. The reproducer you quoted is current; one
clarification, fio verifies its own CRC32C, so the result does not depend on the
underlying filesystem.

On your point 2: I am working with Mario on the AMD IOMMU side. I have committed
to testing on my 600-series and reporting the outcome in the regression thread,
positive or negative. I cannot give a date -- the machine is under maintenance
work -- but I will report either way.

Kind regards,
Mikael Etienne
