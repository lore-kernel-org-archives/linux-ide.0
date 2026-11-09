Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216267;
	b=UxQ0xpFWS/mSGKGgz9j+AAbsWEukMTpwj9ggNyHQS/Thkr0Jh71vv9THnq0wXoI4rnxJ
	 EsgY+4dVUp8fXxqNTUPkj759ZyeXCcHeUj0YAsBOD+eqyDtYMgKRRNM/vUupGp5Pm2f38
	 uB5iA58nvCSw0SV3JExxL9TEbZhgok7K3Gly+VicHefnhOuBI9xXE3Zj30/ZYBWqV7rz0
	 oYrJK9Qnom5JwLO5EJqSDSorLzdbcngeNxEWuTEokrFf+vJuaIuSMLDa+URr5pUTjYgxG
	 jVs8h9Vr9YikXl94L6Fei03RRbWRjlfKP95ph/UXE9zmkD7UECrnorOz+Q01HqVeffA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pFI37l3u8zC3Prxu9gp+hh5bUJYQTYSaiZYyT2P9tY4=;
	b=BdEdfQMODVl6bCYfByfR28o55q6gBvRAoURCs27RoqDj/z82sOYL8KVm39pU5JT/cnGJ
	 mE3U0NF4ODaqDfw9nwgsjWRRD+9ZUoY0WiWe2GQVgsn0qIBx/HQwHyTxYQprjQ4jfpkHr
	 +xdUCkmAvc8GygleG0no0k39+pqg8HTppyNyDDRQaffwKOgcDOt/EhbKQcomzd/SnQz7/
	 MEPAw6lUs+ioT1Oytsd0OHg4RBXtoCWd0kq7/3Han6H3I76MIdco+cr+JH3oDgOVi72Lq
	 aqCYEpmWcb868C8lXlOlFsJ1tp/agZ/EqDhS8UjjLAeRaGuiPmwaLPLuNsnESvWMdvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POwcUWJh;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD96082BC7
	for <linux-ide@vger.kernel.org>; Mon,  9 Nov 2026 09:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5AD96082BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POwcUWJh
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3704d30b84fso835247eec.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2026 01:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794216266; x=1794821066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pFI37l3u8zC3Prxu9gp+hh5bUJYQTYSaiZYyT2P9tY4=;
        b=POwcUWJhRVGKOBm2//Q1aL9FvlAg6++8vRHkx0fa2yyCmHy6ZxAwrj0WBAbCm4ATvs
         Vvhnl8SFPff03A1WgWrhUVReAP4tNVxYDP4MXUnxJp/m7HUHgA8QTPiBN9Fjt71a70Ft
         GAeemBEg9qCGyv8Zkfp66bw4czK5SBDcuTKQfnjOfzY42PRIqZmlBIzMBDzEJ7Ohdmty
         vTbPHSDo89ppM/4YI2qPV7csX4Sw+JIv7A8/DZId3wtAKHfIR6Dg5OUNh+julFhPkB62
         M6IHbgB8VBlTjt+x/b/BGWEyStdYR2bIfGuIFvOqIrnSXGKusgqxt0rF/ob3zV+dLCCB
         s59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216266; x=1794821066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFI37l3u8zC3Prxu9gp+hh5bUJYQTYSaiZYyT2P9tY4=;
        b=nVtt1OziI0nb1mW4P+ZYeNkIqfdjtVuWZj08//ZkB5DX+NwMshJ/bMHcW1mxdGH7yE
         IjqgQ1EYpMwTkyLc3VVCe04tsVIg+excVfITcC+HlVOPK+J2RZf6fYGGIAcCOMuhYGMj
         UQTuiDBRDG1z7t4cNDhMXxAcQJYyI80CEVMpsDxJofrYfQDrA+qNjMTi2XCzRp76ljx/
         GbVoIEeyeMrnvuAwlDdPj6EKSpQoAkT43zxo+VXwuzuXsV89T+BoMcRVdRoGHMHpMbYY
         Thxgawd65Dg1nGV6AJGe9ZC1V+f136gF2yKhVi+XYrbSiCFcnTofQLs0HNnKiK1Ch0/j
         9m2g==
X-Forwarded-Encrypted: i=1; AL+hErF+W42/+Vu1MioM7PEj+ENYQQjpbDXcFSiMYc2AqRvh8ekvcQwoa0OnRVB5plc2RERAqnfyupGB3ik=@vger.kernel.org
X-Gm-Message-State: APuU4Z+alxfCvu0lb/fNTBLUXsQJ/wrZQOVkRDNbRQlWG6+GCcKoQfhL
	WHqA6rZD4FGB3kGifugN5+4vRO+Rz7ICDBWvEWApawet69LCrO/1TlDg
X-Gm-Gg: AYBFou0vWt5/+h6Yxq6oatsYn3S2Sl170mwa9zAhJElnkXxfauBzrG5GojhxGZlO34d
	qo38M+1NEKMogkVH9BA13yi+U4HR2Xoi/NUNi3jM56UuMDi1rmYsgo5TLj4hvaf0+g8gYLcM85n
	Ey1hdqv5j9DzTwuCf1LqzeqOhh9DIXbLMHADsdgVyQKm9669ZmE1oXSK7kqs8harHyQsEpaO6jy
	HWs4RUfoj3yT05wGtkQOwZ4p3iWp2pTM2oc3vaWdXhLFB06JWR1rxpI+dQx9J2FLsbOtxoMHsFJ
	KvhAI56po/hXvmd01fFyWmoVay29sHxswZzFlsHpE4Ms1BwN+iv1nvyPAbhJaxVKDeEp+r0wmV8
	RkIdc9qLshp0t3pFRZ+ERllw0SRKbIb3+XnNhNjMjnSzj8JNamxJHTtKu1Alq0Bo0d3SNVU+SFH
	h0Q1N0WqUdzJr14lfmxMO9irUS5t4bS2/ANn1jN3Q4WvG2RDHcOuLDgYE83jH3AdVIXupMvWly6
	wboXLP6z0pwtn8EH+kOGXbd/rRnIYaDdzlHkWr4cqc3tSuOUTQ62RLYa+5CRlE5JJmwXL1hueH4
	7vWMmUO8p/kxajVTUheo/xKLijuWBBFVAneEjbEWOVUrf0//
X-Received: by 2002:a05:7301:1885:b0:36e:d060:8bad with SMTP id 5a478bee46e88-3725b06f63dmr6559413eec.5.1794216265687;
        Mon, 09 Nov 2026 01:24:25 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265c0701csm11989483eec.13.2026.11.09.01.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:24:25 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2] ata: libahci: delete the SW activity blink timer on port stop
Date: Mon,  9 Nov 2026 18:24:15 +0900
Message-ID: <20261109092415.1436149-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

The software activity LED support arms a per-EM-port timer (emp->timer,
ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
callback re-arms itself while the LED is blinking. emp->timer lives in
struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
with devm_kzalloc() and freed when the port is torn down.

ahci_port_stop() never deletes this timer, so when the SW activity LED is
in use and the port is stopped (driver unbind / module unload) while the
blink timer is pending, ahci_sw_activity_blink() runs after
ahci_port_priv has been freed and dereferences the freed ahci_em_priv
(use-after-free).

Shut the timer down in ahci_port_stop() before the port private data is
released; timer_shutdown_sync() also stops the self re-arm. The timers are
only set up (ahci_init_sw_activity()) when ATA_FLAG_SW_ACTIVITY is set, so
gate on that flag and skip slots whose timer was never initialised --
timer_shutdown_sync() on an uninitialised timer trips the debug-object and
lockdep checks. Sweep all EM_MAX_SLOTS em_priv slots rather than the
current links, so a detached Port Multiplier's fan-out timer is not missed.

Not tested on real hardware (needs an AHCI controller with SGPIO
enclosure management and the software activity LED enabled).

Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
Changes in v2 (thanks to the Sashiko AI review):
 - gate the shutdown loop on ATA_FLAG_SW_ACTIVITY and skip slots whose
   timer was never set up (emp->timer.function == NULL): calling
   timer_shutdown_sync() on an uninitialised timer trips the debug-object
   and lockdep checks
 - sweep all EM_MAX_SLOTS em_priv slots instead of the current links, so a
   detached Port Multiplier's fan-out timer is not missed
 - correct the Fixes: tag to 18f7ba4c2f4b (which introduced emp->timer and
   ahci_sw_activity_blink) instead of the later code-move commit
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 001a6f5e4172..3f6844acb413 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2605,9 +2605,32 @@ static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *host_mmio = hpriv->mmio;
 	int rc;
 
+	/*
+	 * The SW activity LED blink timer (emp->timer) is armed from the I/O
+	 * path and re-arms itself, and the ahci_em_priv it lives in is part of
+	 * the devm-allocated ahci_port_priv; shut it down before that is freed
+	 * or it can fire against freed memory.  Only slots whose timer was set
+	 * up by ahci_init_sw_activity() may be touched -- timer_shutdown_sync()
+	 * on a never-initialised timer trips the debug-object/lockdep checks --
+	 * and all EM_MAX_SLOTS slots are swept, not just the current links, so a
+	 * detached Port Multiplier's fan-out timer is not missed.
+	 * timer_shutdown_sync() also stops the self re-arm.
+	 */
+	if (ap->flags & ATA_FLAG_SW_ACTIVITY) {
+		int i;
+
+		for (i = 0; i < EM_MAX_SLOTS; i++) {
+			struct ahci_em_priv *emp = &pp->em_priv[i];
+
+			if (emp->timer.function)
+				timer_shutdown_sync(&emp->timer);
+		}
+	}
+
 	/* de-initialize port */
 	rc = ahci_deinit_port(ap, &emsg);
 	if (rc)
-- 
2.43.0

