Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2372D7DCE
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136514; cv=none; b=C0QnGeoYQ9G/gpsoMofZ0ycknSmW7Yuym/7BWztzFdnSKa6AAHfKfyERohIUplnasZQwsdsPosqDhN+j2UcF31SOwVXy/I4miPo3M2W1haDrmvQlB9FYRdZ/9LGdIzn4tO3PhClHEb2St7KXOJK2trCJSQLKWsAt1QxzIOQwYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136514; c=relaxed/simple;
	bh=FDRWKcxIXzwEXEXV8BMdD6e3CAi3CbUeTGY8Jn8D0/0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jLVsXA5wbNB6Xbuxrzcy5d6ejMEom8KhW/RsS/SQCLnJlv/zCncdQrIUOLYq9TNtQMyxLBkdMTDI+rrV4++TmCTTji9+iZWgqYkMEBhWbzcRNJVYiHXAEfk2HPdYgpgc6ppVRg9jG9XdyE8i5Q6/Wp5NzrCRdlX7/T3P6EyiWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPIzaZvz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPIzaZvz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4888cfa003fso7137935e9.0
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775136511; x=1775741311; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdu24AWc7/+vw61EiMrWtOhFBzA8SeqNCNWGzjWFP94=;
        b=fPIzaZvzC/RhAeo5QodnVd1SHfuMYckTHOA1TkNnMXhSmer1ILfqjo13nipQLOIqhO
         wYLiNQ+Bz0NLJghfF0kYw6wIEN2r03sDKIvV+T7YmWqCi6tRg6J8hAzP24m0w70ztpPZ
         Q2FVyo/SuQy5ptCZzLWusjADHXzY6XF9UigiJneuiX8Ec/B2YfG7citmizUDbSvbGlHx
         1d0ZrQXfn9xvA/17wwaFZ25Fxd421wHa0sGaUVdYIDJS+Jxk3I/TryFdpimBrClHV8F5
         03V11FzYuEprtImzRJLiJkZQvrntQijGqreeTcU56GyAqy1U9kzamew7L3BXyr8ufd95
         swBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136511; x=1775741311;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jdu24AWc7/+vw61EiMrWtOhFBzA8SeqNCNWGzjWFP94=;
        b=KaNDqTz0D/MzGpS6ACwKHwJlWHWrAbW4SWhQaW7nw+QzZNC8MSa5AzCPopENrQZmJj
         BQUyJBzpXvkmLtjcYXmnynhHP/pWwPWX2Yh10EJ5KlHhKsV1smPadnC7iYNnVy7x5Br3
         GH1NQl5XH8EwXNrLsy7OYzIZ13Cz9doZtuWxjsBAG+5pjdbk2DoA4bwoobyW6SZ+SbkY
         J61SUY6HFSk3c4GpKI9dWleuFVAa+KWwd8aFJBgR8CDcfz+sKQYMiVE2Jt1eSJgMCRyA
         Ifw7AeUJcqSFdMVJFGkaKqt0zMFaiXpx8hnVgcCYlQsrNSm5IiHL7+KfmXAmuaKbq7Mf
         ICPQ==
X-Gm-Message-State: AOJu0Yzv3vz31V8wlEqj66szZGQv3ARH0qXUADIvaEM/HqvLY6Spsni2
	4FcGapX7bs3SfAsNf0cyD0TaLDZymrA2sfhU5cum+QjuCJEzM8zSDws3
X-Gm-Gg: ATEYQzw+IsChiqoNDav/Jpc7dFNaxhUxcrRKF3FdZWRYeW6RV0ou6tV+RUVUMn/B/JZ
	ttXUNFpk6277RXsc1T6uDEn+GZnIaoNfY8VRMkt99fN00jPcnmAhzEPt9eNkRZMqcqJS0EePRVO
	ArRlGPvrrLeDCKXKCDfdPF9/0GDYZRbV/N+EfqEIZFQQuaz/EDCK1eUqcjy4izyRGjR1qSWsokD
	0H7EwnrZNq4AZxK1yqGkZxfacQDJO8qQPmJe0fuuSTs2moS1NRhw9+Pre2E/ww1rtehPg4+8cR9
	5BMlpHQ8K5KL/EsTjmbm3F6jYdF8gAPb0bFL1gxyqUOAQShCF1PF2pdk41RAkgCgVgK64t0lo2F
	JlOZooyy1DwvvUBw9q+uvlYaVFpbs5a96H49iiQ1JwHQxTKd+EcjA+PRuHXFRN21FL5TzozgonN
	B1zFc2dYojt38IpMh38K5bOYMEPf92j9aaN0gAakkRpLKRpnpSLpI41vjq0KlLF064lTQTUarbV
	tUteIA6WBKPWFY3zGIucZUeltktqHEkaBQKAxsvmd6SwkCD3PwnKzn9wukKISfaCg==
X-Received: by 2002:a05:600c:8584:b0:488:904b:6fd0 with SMTP id 5b1f17b1804b1-488904b7623mr28411725e9.10.1775136511109;
        Thu, 02 Apr 2026 06:28:31 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm176997095e9.12.2026.04.02.06.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:28:30 -0700 (PDT)
Message-ID: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Date: Thu, 2 Apr 2026 15:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/5] ata: libata-transport: series with further
 refactorings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series aims at further improving and simplifying the code.

v2:
- improve commit messages for patches 1 and 2

Heiner Kallweit (5):
  ata: libata-transport: instantiate struct ata_internal statically
  ata: libata-transport: inline ata_attach|release_transport
  ata: libata-transport: use static struct ata_transport_internal to
    simplify match functions
  ata: libata-transport: split struct ata_internal
  ata: libata-transport: remove static variable
    ata_scsi_transport_template

 drivers/ata/libata-core.c      |  11 +---
 drivers/ata/libata-scsi.c      |   2 +-
 drivers/ata/libata-transport.c | 117 +++++++++++++--------------------
 drivers/ata/libata-transport.h |   5 +-
 4 files changed, 49 insertions(+), 86 deletions(-)

-- 
2.53.0

