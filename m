Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF39391E7B
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561355; cv=none; b=ok9wOqqkkPBPLoy/ZSxIn2vkm/FvEdtr4ypvQD00t3q/JVWaovL3g86qO23iBbIhfBHoKMRbnvTFz51aplnMifOEfYL6L8T1ndb9Jih1fbahGgHczm79a2v25gNCMNOOl2GQewvQAcI2XuFclejlCVw15d1CvN4CXvoxHWOPtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561355; c=relaxed/simple;
	bh=/YUQ0q8ixJWZlGVPOR6c9v26vcoyy3YDs2//GxzHr+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmi1Wj/mM271z+glsN3/wOFuLRi7HXcpXKTsA9Hq7rXZFSNOM9F1RRIJL7sJ54pBJZpv44etIc+Q1Co5YzdbDN1Tf1ppFBfQbxw8M9Fytu4zADzHLKnvKadU+VSOtsRJcGvQUGi585sJ9QiH7kBzHr/99xKZcp1dG66Rst2jsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHl/pSZA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHl/pSZA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so17579405ad.1
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 18:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783561352; x=1784166152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6LItKpf7a+W7OnNcYTRQLI0rt0/GNIYg0vpBhecbpgE=;
        b=oHl/pSZAaiqCv7rTewRWYxXezQVaKjsOg3ZS3qpJMPDQ8T35NHQMlLMh3NKk7TDPQc
         4oSebA/fqUqKHW1W5IYZXrBOx4pfIjtKUW5cLm13M1UsgsOFQdA2kYWqC68qaamzcVXv
         1c7peNkfqzaj1iHrNav+F0C3SnpFJAdiJEln5ss4bx4LChnRR0Yx33t0Nb2f7aUNQCWM
         oNJKMiuWBbtAaSH83PJWdNiMMaFy6MFfLGuq760AzygVWbo3t96Gh7WMc5CeFUC1A0AH
         pkO+NYeeg8h3RmyWbTHpp+JouRmU2JM4EVNqCscvxtlPdDKlmeHbHtb0cIw3zsg/GF5+
         W43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783561352; x=1784166152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LItKpf7a+W7OnNcYTRQLI0rt0/GNIYg0vpBhecbpgE=;
        b=X7Fjh9Q8OZW3AP/JSDKDI/VrIeW2ACouy7QQn74ZTCQqs+EBqHPh79VJlPa+AguGOO
         GYZVqa8Vis3UCHkmVkPuhnhYBAlN5kByTuLgv3QY+NCCFqX4wYLYWzEpWMQBztaNKFSo
         +zAn3jZCLktRRAmtc64+FSeS14DGqpelmYfqZ5S6GsdgRMxAgtPGN92gqF4YdYdJfCBN
         nOh8tFu1fi+qxgpq7pHZL1sJKgBOYWz40DfIETo4cKfFaLNFuQ9KYpZ5hw60Y0pKIRQf
         L8JHjhUUtYvLkb0o8abjUrv8qK+A99/leoMB/+Ykv+xu9NKYAzsZxmzrAKCp0f8xdCH+
         WIPQ==
X-Gm-Message-State: AOJu0YwQbu5T0NptoedGbwOScu8UPCzZiMaCU/58I/sX3RTgxDAOHwY1
	oyQ7nTSYd2WRsVXD3iRKAWfv03zLk+P93BLusyzV9lQDVB0gxfEIecFfJ5a+IQ==
X-Gm-Gg: AfdE7cldsd/YzY2rmE00cbfaOcSjXm9XZMphrfAIGbChvJ6mZbeXSgm5HS3/cgP4e8g
	9MVrm70VmOZ3+e2NDSWDTtJprG04zUtvlGxaxMwNho4lrHtP9aen0Ee67vyQYNJ5ZJcSW2JT9PY
	PwEh8z0Ly696+BEIUfqjFp8p1GsY/HlbZuBPDWXBARgdb5qGGy4JcJTCjTlJ77ML3Kx0GmXNVzX
	Eupf8nbi3AaZ/FMjXm2qHA+rI5MRGNwze27aItlZ+mCWVvouKHvF1Ku/ItzAycLo7oIf9VM5aXt
	L9V0/ITshcacuHOxCDLhQNPNjDRw3qcQz0QdCFU7KzRnObVoV3ZQ9ufYQoI6OVWMEYc5wUENa5X
	WGZZbOvO6YtFkHVLCR1Cl/fBU20dykhLgntFncwDMItHJimvFMjtwOc85CrxNGI0vySY6OJZmjt
	em/vRembv4eHP5ckWgMGQBz8QGYZipvAQ6lUWoOySnINL3fiQ1jwkjZOmPvuNMGoO91HPct/u4t
	VSfMHQqWBKKhK40nn1wclf4HhLRF9eKJH3r//6SmZa6lrOf1S/v5+yGq649K1eyYQ==
X-Received: by 2002:a17:903:2b03:b0:2cc:f4d4:299f with SMTP id d9443c01a7336-2ccf4d46d5amr32275565ad.27.1783561352337;
        Wed, 08 Jul 2026 18:42:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1ea74sm35271205ad.41.2026.07.08.18.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:42:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: libahci_platform: use of_platform_device_create() return value
Date: Wed,  8 Jul 2026 18:42:30 -0700
Message-ID: <20260709014230.1905756-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_platform_device_create() already returns the struct platform_device
pointer, so there is no need for a separate of_find_device_by_node()
call. Use the return value directly.

Avoids having to free the reference from of_find_device_by_node().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/libahci_platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341..2aa3df58fc9a 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -617,10 +617,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			mask_port_map |= BIT(port);
 
 #ifdef CONFIG_OF_ADDRESS
-			of_platform_device_create(child, NULL, NULL);
-
-			port_dev = of_find_device_by_node(child);
-
+			port_dev = of_platform_device_create(child, NULL, NULL);
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
-- 
2.55.0

