Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714F238C2F;
	Tue, 22 Apr 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312990; cv=none; b=DWFyHOsJwJfFG0YBjbvNTi7bGfUXp9iE3ZP0v/qRBvbhn27k5+D3gYXntcKMPLtmXin4JI518mGlZijHZRDiukJTVZx4t+/pGbvFUnKUEwH0M3TtfTtNjo+TAdGAnKVRusU0Xvwybj6LsWKH9RASKwmEErJO6+01lWd64tWTHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312990; c=relaxed/simple;
	bh=x+gE1ToyJ+pffpnV6uRr8KZqS1tmZ2kraEJE5yLBLZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ju1rt8t84e1Gwy3RlUxmiHs3tO+aqQGcB9YgUc9uGA/F2AiNi2iYByTfc18D5yE5LG2tdN/J0gMpNF3Wfo8xu1z9GQM6SKW1zAyrTFFKsoK6XSWmRfRWhkr0bFjslMpCnZM1pm35Dv6D6fDsEez6Mjv8rPrNetqU1yPF+QHXFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUU5Vd6Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUU5Vd6Z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913b539aabso2920740f8f.2;
        Tue, 22 Apr 2025 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745312987; x=1745917787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dc1qxbEVnXrc7R5Apb0twXPOjPmh9B6aFcXdtk6C4M=;
        b=QUU5Vd6ZRq2NCsijk/eldFnDnlqhsa988litxMNb6HLbmZdCIHJcDXv03fYQjSsaAV
         yMKwO98ysj5RkDkuptWtyvsFJdlWbj5TM2HWUupBlNA032M2na2n7ZbCDWm78BMmCT8B
         UpYgPQSOxX6p+vaRTk4kn5IbAdwlAF5fArMN5/wZT7tLtVhcBflpSj9VhmS8IFCTxAHI
         S/FCQNpo8Kv4RJKw1RPVgdj3gWacCmQJO9qfG7iAkXBuVSoDZZrYUmKCV5f8V9ebgoq5
         bMPgVBRjxzXml4QLXX6/e8IKfbCEz4opAqw2k4PYsskkFMiXPUpWP1m3BcBaPfuCIHe4
         +hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745312987; x=1745917787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Dc1qxbEVnXrc7R5Apb0twXPOjPmh9B6aFcXdtk6C4M=;
        b=G4doZ/lXsSLDkUd/JjH8N7JMt03nCBg9pSdt4fHZcvRduuo2wJLg4+jbWOF5wUq/Ul
         fLPIrmItCMCKe847ZAavNMzSdfq9f09H7S+U2YN9HLaU22XjgvXxsehvuec1aIyLrWgp
         U5XU/xH5sL7q0NPIAVjjAZBhAFNlTupS2+4+JoC1WPwZgZYwcIoNY2biRQdNmLxjeXba
         rnUYegsu5UAkhWVICTWC6ch8gegvCwEdLi1k8cR3PY7hhsejklsG4Y4hrpZZBW5ehcpM
         kHWcPKZva4VZvdUgm8eH2G33QJIBHI5nH3+b4EzcRgq0kQf5zLY5Uvg15Oas9IY7FLYf
         66xg==
X-Forwarded-Encrypted: i=1; AJvYcCXe0TCzoN238Kxc2/7fmSw23X75g8V5WGZZPBrESwroiAv4cGGEWphHKgUJaGcjDChz5YMBlz9KasA=@vger.kernel.org, AJvYcCXsYo8Kq6WBpDJRkR3pX/RVr8JkDnLUTleoVPO9SwYtm8QnFdaxR3ROO0NGrlLkU8jlcTen8OcaN9eZgKWr@vger.kernel.org
X-Gm-Message-State: AOJu0YyFb0Ru2eyimipY3a0BfREs4B9IShJYKBN7lqjyliefblzbNFr/
	6cZCOuozgGbMs22OQa239FHNNZx6PRmnIVK3fHdvqUWDpYKR/BUO
X-Gm-Gg: ASbGncuutRhZ/jnvNfgQ39LZxGW4EiKr8KSzXQxYRetVNorFO4CB1rBA+VKMCnV/P8+
	1qVidZyQxO5PT5lu1hd7K0H0PfibgMTiynrHlq1338ScFVEJ91NJmlCl+E6da9sO4wW1Wg/OlFc
	fydImLcqpA7PyhWztLRsaN5YNIwpiJE+xH64d/hHAQUkywqpSnh5m307oAC8AVWpT6ObuSgYNI4
	Le9YGu322WCeXZKK3NTgUc5IYTW7Fh7uAaqDIPXUl+PZ3wNa2V6PLpQop+4K+gdcclDbGXNtt+c
	voMiBG4diEBnd5/Y2/eETQiROopSvWUhjoHyOxAi9w==
X-Google-Smtp-Source: AGHT+IFnOoL0lS75tx1HejsRgPbEtsgbfdEWlM4gw9yf4q7LY6zIIBdLYgQaLeil6VU9FQMW9s5Ofg==
X-Received: by 2002:a5d:64cb:0:b0:39e:cbca:7161 with SMTP id ffacd0b85a97d-39efba39929mr11203769f8f.10.1745312986671;
        Tue, 22 Apr 2025 02:09:46 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa4a4856sm14281360f8f.81.2025.04.22.02.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:09:46 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ata: sata_sx4: Fix spelling mistake "parttern" -> "pattern"
Date: Tue, 22 Apr 2025 10:09:40 +0100
Message-ID: <20250422090940.25612-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in arrays test_parttern1 and test_parttern2.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/sata_sx4.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index c3042eca6332..f7f5131af937 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1301,32 +1301,32 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	}
 
 	if (dimm_test) {
-		u8 test_parttern1[40] =
+		u8 test_pattern1[40] =
 			{0x55,0xAA,'P','r','o','m','i','s','e',' ',
 			'N','o','t',' ','Y','e','t',' ',
 			'D','e','f','i','n','e','d',' ',
 			'1','.','1','0',
 			'9','8','0','3','1','6','1','2',0,0};
-		u8 test_parttern2[40] = {0};
+		u8 test_pattern2[40] = {0};
 
-		pdc20621_put_to_dimm(host, test_parttern2, 0x10040, 40);
-		pdc20621_put_to_dimm(host, test_parttern2, 0x40, 40);
+		pdc20621_put_to_dimm(host, test_pattern2, 0x10040, 40);
+		pdc20621_put_to_dimm(host, test_pattern2, 0x40, 40);
 
-		pdc20621_put_to_dimm(host, test_parttern1, 0x10040, 40);
-		pdc20621_get_from_dimm(host, test_parttern2, 0x40, 40);
-		dev_info(host->dev, "DIMM test pattern 1: %x, %x, %s\n", test_parttern2[0],
-		       test_parttern2[1], &(test_parttern2[2]));
-		pdc20621_get_from_dimm(host, test_parttern2, 0x10040,
+		pdc20621_put_to_dimm(host, test_pattern1, 0x10040, 40);
+		pdc20621_get_from_dimm(host, test_pattern2, 0x40, 40);
+		dev_info(host->dev, "DIMM test pattern 1: %x, %x, %s\n", test_pattern2[0],
+		       test_pattern2[1], &(test_pattern2[2]));
+		pdc20621_get_from_dimm(host, test_pattern2, 0x10040,
 				       40);
 		dev_info(host->dev, "DIMM test pattern 2: %x, %x, %s\n",
-			 test_parttern2[0],
-			 test_parttern2[1], &(test_parttern2[2]));
+			 test_pattern2[0],
+			 test_pattern2[1], &(test_pattern2[2]));
 
-		pdc20621_put_to_dimm(host, test_parttern1, 0x40, 40);
-		pdc20621_get_from_dimm(host, test_parttern2, 0x40, 40);
+		pdc20621_put_to_dimm(host, test_pattern1, 0x40, 40);
+		pdc20621_get_from_dimm(host, test_pattern2, 0x40, 40);
 		dev_info(host->dev, "DIMM test pattern 3: %x, %x, %s\n",
-			 test_parttern2[0],
-			 test_parttern2[1], &(test_parttern2[2]));
+			 test_pattern2[0],
+			 test_pattern2[1], &(test_pattern2[2]));
 	}
 
 	/* ECC initiliazation. */
-- 
2.49.0

