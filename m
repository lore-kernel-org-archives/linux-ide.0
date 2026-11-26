Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729478;
	b=SnPNnWVdnfQvdI+x9xKZNFsBzl8n9tjb3j2+GpGE6InNnZu2H/MytCk9SwfzMM6a3Mnc
	 q3qZdr6v0PLQuDHG35aioe/ioOrOeZ3UsN1skdx6a+MCQ/GqhHU+Q3x2iP1qv7DAg07EN
	 ZR32HyuY3fy7BBo0KZqjAsUshkIH8GDqPac6K6w9zPZbEF+ilOOvYlJN9FpixMSS3i1rY
	 ShR6+Pl8tV1ivvLqmq7I5bumGn8F85gog3/Mbk5+hn1ROHGv/kkEz1qylP/1LC9bIvquR
	 7HP4fjs6fcAcQ8l8olB/PK5H4+s2z7ZN7gyljBniEUPQPHB3NdpnZ2dO5GM5lxYgaIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qsM5RJY4ssSc6XEZK9/kRUVmdgCpjgjWKidI/l+cEZA=;
	b=5S2+tLBiZDcdW2QU8PcFgrnejGKkKTApR49JDuAMzz71G1F5UefaYRhWbFTtDIt1XgnN
	 6GpfCakf+m9kER1chyCO3LOc8LEpXvb+MGfiCZWKHJOAXvNs2YNjS4sgsnh/eAN5BSsg3
	 uDeqdmXRtKUSBdHVNxZDksD0nRIg1nyzCoGxjByQluIctckVNPQobihFwNllqIS9zdX6l
	 4mCYxQGZS1KrJz8XoiG47aU+tDnCkyZ/EssKgz+wUGXPovCTXQ6I6Ozuet9FXy+8xNOZD
	 t/4sD77Zc1JCKHHtD15SSKpgRkdSKeVM5EVpExmE2tez7POZ3agARMxOmmuLlIg9I0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+89tWrj;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E03606A330
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 21:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10E03606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+89tWrj
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so4205184a91.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729477; x=1796334277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qsM5RJY4ssSc6XEZK9/kRUVmdgCpjgjWKidI/l+cEZA=;
        b=L+89tWrjVUOYzEBM2CqDkJbR5+pFAJamBwDNctm7dEk42pNZiH8VAzRW4iyCSIGUuU
         lQWdTCzMAWO3o4eqQkY4Itu9kHrX9un0aj6zfVpaDNbCsfBvil+62Jsl+CUn4ZrVwn5f
         Sa9NW8Y5s6ym8AOtAgPCztni1jJ6VhZN8D+SX7+U+QusGeBpiez0C/3aOMgylc6kMOwt
         Sg1jZ1K4tmWh1DMNJX+cDsTkz01dkDirZNlquuHaPvv6Z3i30Go4ATqjxekm8p2O2LaO
         +75dRYD+rHcXWLj1jlbwwao8FwAeQP02m2AvsiX0Cwz6upAIiFpfVYAD/a3dsuBdUf6A
         4VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729477; x=1796334277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qsM5RJY4ssSc6XEZK9/kRUVmdgCpjgjWKidI/l+cEZA=;
        b=UmLdYsNND2biuja9/irFPIFlEY01xnwwZda/fA4/dBYVXKagFjSIn9Y41ehhQWZJdq
         ZcW953/0YZDxYJY9t2WRTAZ/rbyFl+5Pq/ofVnzQWYO4cR0oPYMDnacIqINiHFQuOK3G
         4ZYBF7EDKRykXZdU1dXiJlAF2ncDyYkhAPYbpYvpa+Zl7vp9sbA4VTrIFfZfzBkBYTd1
         WCpGVA7NpjQAu6l+etyJd0UNF1Z+9xlW9qgV9W6sc6GSPpUCIobpBmcoxRWdZQyFFYxk
         SJBU0qRK/tN17IhYVyY0+PowUriOqmYvY2edelBMVD/LB9B3zz+a9roeH22jcNQpdJbK
         F0wA==
X-Forwarded-Encrypted: i=1; AL+hErFwMgj0GNe/wlePsa4RFrK0xY2epmZe7N23wPrj6Ear9hqqhhKICNLGHeAiYiT9d6g0FbzGLnXCgKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dy2W7ZoC0doShTzfQ/ZTqVMjK7O8X/r9D1EeyPkl62NlajjlQ
	+WAYBCsQ1QTg604A0RD5G6TE00DOC5RKl9VDXHRX6jrW8ITrSMATcseO
X-Gm-Gg: AZFdTZfwT7rHWoVA2gzdOzn71SXCYOJeDxUZRNa7BK8zFspjA/s4Db/36b78Bd7FzBd
	Vmoggq5B5vw5QJqk9It70A56kE971u20oskqGwaDbjA1EKuUM1UjviO9f4X2WqsrPUkhZp+uoE6
	ALTpp0jpoMZIZYSiofcYCmTk8O0Hb7G3yGIkU2OOGvujP3lIJvaLn6xsfX0RR1kvqN92Hn49Qeo
	5vQk3CVA7m5AUAmT9EBxygro2rDhDcZJXXu8+pPZPXu81t2Z1LqPy1c2cVAh5En6tEtUD1A4KZW
	ZEQe4htX6qr/EMUBOZ/WGc1yf/iQr4/skNpaIhQbFmifGKpAYQ3bLhgUA+LKIKVYAtHTdON5R6c
	iPv6BKD5TUmhAYhYhMc+Voq2TF9BBELrqfz3jslO0qgdR0FA558G2+Hvzrm5GZ80WliEANMWwfV
	yamYkNO6VpYgPHxICt4cb8oOIq9h4H0ESnpierG93wYB7279Vg0hI8fhmnNNAJ8gHb53lp4R2JH
	AxXDPHe/7k9i+o5O9aJg6gEu7HSbnn8eDDGicrN3Noo4+87B8HKktLNQg4ImvHQSTrViFCTPC3t
	YrTLqB4geVTQ5cY9NL8KoKMpEWw+CUKWPwOfNy8MK2hUbNl2xA==
X-Received: by 2002:a17:90b:2e47:b0:3b4:eb3:a34e with SMTP id 98e67ed59e1d1-3b41c8fe15emr19804307a91.21.1795729477360;
        Thu, 26 Nov 2026 13:44:37 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm36176538a91.3.2026.11.26.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:44:37 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2 1/4] ata: pata_arasan_cf: add missing newline to warning
Date: Thu, 26 Nov 2026 15:44:30 -0600
Message-ID: <20261126214433.38317-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.38317-1-artem122novak@gmail.com>
References: <20261126214433.38317-1-artem122novak@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminate the clock-rate failure warning with a newline so that
subsequent kernel messages are properly separated.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/ata/pata_arasan_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 12f1324461d1..0b3e4e63b66d 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -318,7 +318,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 
 	ret = clk_set_rate(acdev->clk, 166000000);
 	if (ret) {
-		dev_warn(acdev->host->dev, "clock set rate failed");
+		dev_warn(acdev->host->dev, "clock set rate failed\n");
 		clk_disable_unprepare(acdev->clk);
 		return ret;
 	}
-- 
2.56.1

