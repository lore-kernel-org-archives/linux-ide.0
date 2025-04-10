Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53E189913
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744321483; cv=none; b=M9J4afHgwNjdd+7y8SFw35k0DhBK/Z7CQtkdsf66JTzEUCpFEAOGqYSb5vGHziecB71GK+2jqvwYy19XvlHm4ZQNWC0v0JgORnpK4o4hDznEs/i7SxxJVCJ0WYUL0qkYb6X17TViGcAbKNLXDuoVtxqx1v1JrhN5LUDJ2YPuRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744321483; c=relaxed/simple;
	bh=KklelM4fdLjlU3BKm7DQG5Urfqu2IiWQ1IMx8OKCk/k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=neoWrJcmqGdYiZoMdvAT3ifTmDWn8+Bv+bD3yRMJWVF8u1Z5P1Af0UvBGaeMgaNe5suzdcr6gJjjBqzTOdr4N68fTO+Lu5VzZr384C9IoiKtKJ711pddVzduWOC6h5E1IjAv1+zoOaCkbRzLkWLuqBQZyLaLTMKXFagu8AVKavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ano4706K; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ano4706K"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso259064566b.0
        for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744321479; x=1744926279; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGc98gxYxUKlLAT9GDeQKNinJ5BrItYsfd69E7F/iGw=;
        b=Ano4706KKt33eH5K1j+0iu6znzuRkMY9gM2ghz0+KGQSmeK0NuH8jaBUi3n8+yAnvf
         KFNzshU1fcv1txeeLLozmCHmi3ud5mvnfycQcjtwrMtpODyeYlwjTB3LGR6O3SMbnwfp
         4guaOJZmTxurPZ1tKb+Tm+82SQL6U8E2ToT2GBQ5Nd3T2NIyfzN+lp1FpjwstfcJQdRc
         uMZEbHYXkYP+cT4PsqbtDNDNco5SrRpGldv03tbWHCj3lbWIlZTRoIM/tUBlOXAvnxWT
         t9v2JwrhljcvdLGvW09fk11rX72CrIhk+ngNlsMqOI+N3Ms6ILu5zY03pdYVAyvWMJeX
         cwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744321479; x=1744926279;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGc98gxYxUKlLAT9GDeQKNinJ5BrItYsfd69E7F/iGw=;
        b=nSjuQStpaoNUYrAaWDdX+qv0HC7dZLOMUoYiI7u6bvnxnsyIKpDXoJBDIlAES9bWVE
         aNAsyUo6VtuRysYDiSfGTjkk/74UOMU0X+ACM9rOST8jaUfktzOiwPd1SBEynQFJoS9c
         7FyBtBCNaf0Mbi2YnWm/ZgzO2YJjYl3LJ5U2wtqi9t6gjYU/O6zSsGttszZfgqvczfr7
         Qn9DciVVz5gNmmEOJgObcjJBScAcsHuchRjrghVLIsIRi/Emu8m/Hr5rTX75sXsCo4Hy
         c72KgzoyRevODg2/F1xpQZxK+Z3unK/aE5siCYo8BIubTK/HElxxzLPg3tV0LDbP6Eo0
         oXGA==
X-Gm-Message-State: AOJu0YxJnm6o7UwB/0nTLPYFGzQV0Yszk8TKMSlcrRiME1MV16ahPEio
	tzTmH5BmTedF6n9HXeC6Gw80k8skppwDUhfPPDxbp6p4DxF6kWwmHX+gbg==
X-Gm-Gg: ASbGncsvVKUkreU8frDc/HZcaPdr5FNzLcn4TsPYf8BMrASVOc3nc3GEUhZPtlJarAS
	pHBc1zoew8GkJqisrdicoPvdgHFIK0fAOgEnUoT/cOfpSCNWfwZdVXHHbSsuFTTXDVzOYBM1LSZ
	26b0Ccc+z4+3LxI/9kmHnskk3nqLJv9un7DdrG6z+heqXUG9RoQYLZyx6gO7i2GaBgmVzoabIxe
	3ZWNcd+IB/0pMWfwkjh+4AI3SJvotqETTDA4pZ4a3q3n8AMqf1ZGYhmMfcv1WXUVTmzT8SjGJyP
	9xL9jyqL5DW2Rlrm51kj1kQhlfgSBPfcUBredzBpEmDijific9ImAcEEkqfAusysCxH2qgqe0mx
	fjjp/TCCn30xE3t9uyrzhvZ17YQAmKKvCQwO5EL94EiSgO35vFBR1AiaRKwgK9of46gEzpn+ICB
	8RSDo6u5U6BLRrW8PcGZdN2cHJd0HLbg==
X-Google-Smtp-Source: AGHT+IEk0CgYVZPs37F23lVIPGgU9lIfpMYyT2q8/wGL4KHIhoX5EEG1NmwWY7bJAqCjS480kFLwYg==
X-Received: by 2002:a17:907:9624:b0:ac3:773:62a7 with SMTP id a640c23a62f3a-acad34d94camr20859066b.31.1744321478853;
        Thu, 10 Apr 2025 14:44:38 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ae9e:d00:d036:f606:fd6b:eb81? (dynamic-2a02-3100-ae9e-0d00-d036-f606-fd6b-eb81.310.pool.telefonica.de. [2a02:3100:ae9e:d00:d036:f606:fd6b:eb81])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef5c445sm68816a12.31.2025.04.10.14.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 14:44:38 -0700 (PDT)
Message-ID: <f9e7276d-d9f9-47cd-8b9b-5dc85567489a@gmail.com>
Date: Thu, 10 Apr 2025 23:45:26 +0200
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
Subject: [PATCH] ata: libata-core: Simplify ata_print_version_once
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use dev_dbg_once() instead of open-coding the once functionality.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-core.c |  6 +++---
 include/linux/libata.h    | 13 +------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 773799cfd..e58a22e83 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6682,11 +6682,11 @@ const struct ata_port_info ata_dummy_port_info = {
 };
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 
-void ata_print_version(const struct device *dev, const char *version)
+void ata_print_version_once(const struct device *dev, const char *version)
 {
-	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
+	dev_dbg_once(dev, "version %s\n", version);
 }
-EXPORT_SYMBOL(ata_print_version);
+EXPORT_SYMBOL(ata_print_version_once);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_tf_load);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ata_exec_command);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e5695998a..02c9f621e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -41,16 +41,7 @@
  */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 
-
-#define ata_print_version_once(dev, version)			\
-({								\
-	static bool __print_once;				\
-								\
-	if (!__print_once) {					\
-		__print_once = true;				\
-		ata_print_version(dev, version);		\
-	}							\
-})
+void ata_print_version_once(const struct device *dev, const char *version);
 
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
@@ -1593,8 +1584,6 @@ do {								\
 #define ata_dev_dbg(dev, fmt, ...)				\
 	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
 
-void ata_print_version(const struct device *dev, const char *version);
-
 /*
  * ata_eh_info helpers
  */
-- 
2.49.0

