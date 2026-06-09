Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246803B14B1
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023884; cv=none; b=mP8PHMf8SYx3pErlUDBA9PukdC4ednrngtwpEs+1V2zcSShkxpH3OBuHDT73moZhOspnFQfQWklLxVE6Xw3gsUTCOz4TZTZApphBuz13SXpFaQtAcl7CBN9Yj0BcKOHDmhC5UV2Oo7ptIz0pGoFNOwSzZHjRe0C1ZLyJUVdDk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023884; c=relaxed/simple;
	bh=7OD9K7+PNTgv5lAGwwVgIYfdG+FDenvDnOS94Nkdhc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNPLtXOmewIFidF87tPfK0EeVuGgxUBmmtBGURasKIolCMjDoBoleiWy+43NrutVUQ4Id6J17MU/ygGK/PdLwuKt09RTXk4QA2m3K/SDMMpwV+O4GVamXR65I1yAdoGWiLYxrErI7B8g9j426yDpoVXhivhOX0kYOJclyJHi5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=b9moRLsV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="b9moRLsV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso3981871f8f.3
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781023880; x=1781628680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4I0rjoZYTJVgl6imeeh01+FWB7oZu1PLy/VEN6Jb68w=;
        b=b9moRLsVFzNk9U4CKOI+pyeuu/bES8n6+ZUk/tvo2Xan/40iLj7KCSDz9WQEEF7Fbc
         hS6WF6i1sDpl6P5jbC1pB9WiZWvXjXFIzW4EHjn+Q+gc+xo69E4khr4uaAby6XIZSVsE
         Tzl9dph32U8rZ+ZCuMk+fi80UnTXGypOucyCeIKNohB5VNye9vg1LU5zdiPsB1lPlrsf
         IRfwTr22bM5uPs4thYo7vkHmzJjNKDU0sl+GEb2Pv8sRUbcqo4I3KxqwFTctV44KncSd
         u58DXFELPuWTPAFkujYbB+iKG3SBniTTQYedyQuRJ7PS5Yc0EX1rWbirbEdhzTXN24zO
         8XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023880; x=1781628680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I0rjoZYTJVgl6imeeh01+FWB7oZu1PLy/VEN6Jb68w=;
        b=Rt5GkzMCNVYvDns0mk9LOV6aWVFaQ2WoAaEScngiBHlJWcvjSw8W7YA35z/ptMhlah
         6BIuQwrXWIPdcdvKuGxSu76g5hhzQ7horvxibQijHcAbk64e/91p1s285qqB1f9bdzXG
         M8/l3h1ohj6ym4Ez4k5DctNEqiLUaoJWYcVAVpIaiAs9399UgP+xelul6PTlzZ21FLQI
         twe0I19tUAc7tr5ns9gi2+vFtUOpDz3+iIc5YLOssPT6R+i5KLfupgRmfk+8QISvsba+
         Cl/Ln8ZX9k49RO6SnV9qphk2L9M0L6m8vV5QjShCZHwIH0Ro1kjWRdQ4CX8l6aBeDvUk
         Y66g==
X-Gm-Message-State: AOJu0Yy4itLHs3psowJq4JnxaRD/1kEFN0xhn34zUTlb6xbKN7/TBVFR
	Rxvj0eVoqu/LwodTZmWGbRVY58c0rzXrAtns0KBii84vYa9Qpityw68u8XVzzLg9/RI=
X-Gm-Gg: Acq92OHqk2bzHhJ8hALX9bUTyo6RuQQKOz2RHLLBjKKs7NbS0kfGXzJADXocZ+eNX52
	cBgPPVXvYKEdrODErbAbI1Az8A3IrjdPfQSrbgp9UrKxgbZpZLaJ9xHuM/eMbd6WWZXYiZJfDXy
	dwdRSEUzEsV+kNcCngU9iuhETCw/D9HpYDer2hMalcp67a++ntiroGTpzgfddnjCO5KFZNfNGLb
	0mSWC1O2ZfHNvr6QX3945MhSq43bLQdJJOxyHkbJKGMcNUrdOppaPKb7SUTeYXYje61WWJY0CNg
	0Tld6/O03enFDPDo6b2dLKU2WeN/UGSh/Ttf4EoX3VgW6xLF+pxtTU7zpz1Q1xN5gysDZ7Z1bWL
	DLvAOSaQDbnnRprlJQpyGMhTYCJplHuARevgjUstGzUhnrpZeaOBCZMlYgDNTy5BzNHlbODar1w
	kk/6rmp/x94hcenaDtE9wjVpVH2XXvwiEdKb4ztsOl0gZX7lDQfEYRgz6gbcPqyuLAJv30fW0mc
	1OW8PyZ6ur+YuEqL+d5Gn4+Hg==
X-Received: by 2002:adf:ec0f:0:b0:45e:db3b:921d with SMTP id ffacd0b85a97d-460307563f0mr23190912f8f.31.1781023880539;
        Tue, 09 Jun 2026 09:51:20 -0700 (PDT)
Received: from localhost (p200300f65f47db045b0dbdd314d8a71f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:5b0d:bdd3:14d8:a71f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f344148sm61176450f8f.19.2026.06.09.09.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:51:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ata: pata_isapnp: Drop unused assignments from pnp_device_id array
Date: Tue,  9 Jun 2026 18:51:13 +0200
Message-ID:  <395c2f2ed11614410956337fd0e10b7adb47f8d1.1781023750.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=7OD9K7+PNTgv5lAGwwVgIYfdG+FDenvDnOS94Nkdhc8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiwNl6aCwAmm7CmLxHMqQ0/NfbSpXm1v1rwfakyTm+8Yz H2uW2jayWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBE3qiz/1PJaNsk+jX60FSt Vz4hMvVf2y2yPM9+WfHR9Z287r3qQ45v/2bX+Pq+qpzo3X7ff0LGvVMvYmwuPrHMDpiR/jStsOn CE5GA5XbOpx8IbPj+OUNH6P2sZpnMjJVW2Wc7W+4b98ZVOJZ+mswmf9pn8YGJEYe+aXdN5k9K0l zRsLw+6EVF85Hnm72v905pK5/pOOfx4z0rHbk6v1863Twt1C3AfHE0I5+NVOaPQ+8k0qMNFgsZe B6xc/Y2iQhgFuOPaSi+4PlT6rZDVZzmth1tTOXxOcyt6Vyf9Wpe64hbnGefPkW3ySz45/79e7SX 3NG3nDehn5s13W7nlh0pbqI6Vyb+SckIbn96+aNGqv1jAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Explicitly assigning .driver_data in drivers that don't use this member
is silly and a bit irritating. Drop it. Also simplify the list
terminator entry to be just empty to match what most other device_id
tables do.

There is no changed semantic, not even a change in the compiled result.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/ata/pata_isapnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 0f77e0424066..23139009c40e 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -119,8 +119,8 @@ static void isapnp_remove_one(struct pnp_dev *idev)
 
 static struct pnp_device_id isapnp_devices[] = {
   	/* Generic ESDI/IDE/ATA compatible hard disk controller */
-	{.id = "PNP0600", .driver_data = 0},
-	{.id = ""}
+	{ .id = "PNP0600" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pnp, isapnp_devices);

base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
-- 
2.47.3

