Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692442A7BF
	for <linux-ide@vger.kernel.org>; Mon,  6 Jul 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371667; cv=none; b=CS0i5m4qNattCr3pdxCTUXu7q07bItcVL9QjmYyZfej4MSpjr96R25U+SNnF+Ow3Njs0ei8vOXy5Uup0JkDOaHjtmwxgjzKeJMad0NaYLBbueg9RnJ951+t4+og3rRAxDhy7KCxqKuPDW9R6iihiTjF3qiPx5hQSOxcQrCFSa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371667; c=relaxed/simple;
	bh=AEwBLW+CxU5gYjnaLHduQW3LInPxWi6Y9fFLIncW+a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EGwm6SgPqTLQpG60hXTDFEjC5R9UzuFSp8jpcgukhmBzIsx7w7Knq7uJ9HM3SZ8AJEiQ3xtXGRcAtJvP/VRUEzJA9pjYYsEMyTSPNGfnns8IIlQOFSs9mZaR+cWg6yERg4l0B2SD0akDCC+t0hGsLoEbNr3b3ZL3a7w5jWk9ldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjDBXqJV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjDBXqJV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8482df30da4so55798b3a.2
        for <linux-ide@vger.kernel.org>; Mon, 06 Jul 2026 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371664; x=1783976464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7H57X51UnvOhM8rXnBkLfIeDHveB+lp34HYqBwPjq8=;
        b=NjDBXqJV8ZCSi4pr7jVqqRiNJJW0wIVTt/GtOt7OPGNSUeCtvRZj8AE8X6WML5NztX
         vvpETRwfAEcdoyIMvJIp0Uu2quy47x8JNyiBYgHz44SrLqCZxbzKBw5I968faQL51son
         oMPuSLjduL8nU1N/6oiF75EsDh7byNgdYbFQHo7FFFOJ7G0G/FU8Eg3ReJ1NyfdwezQy
         UrtrlTNHyP5mxUPApiwp3F9XQYV+V9AF7ip3bSBIdJhBA7L9jt3q/yio8nH+10oaHPSi
         XPjhdXZ6PzmIv82uwIog6KPq3bun1NJRsuCik+OFD/37aPLpw87U73GiZYHz6R7jBJuo
         58Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371664; x=1783976464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7H57X51UnvOhM8rXnBkLfIeDHveB+lp34HYqBwPjq8=;
        b=CUx2RY9NaD61iBR8eKke07beovQNxTZNx/vxZe+RusDuebEcAVziea3xPlTjVDvruP
         GUT/4v0VqCWa0MNCjaDHwAQvZ1BpdAsSEpnsCeEcQpG9KRbW7QW9FJNpwXpXrba5wOxR
         QP12Z0lSB7fIS7nbXyeqm0+7rxGxZ12stRqK4ySOExqSY95DAi/XSOBWcdqPL/hVr3eY
         i0A7pc/iTImknPtpQeo0mDLt+OcuoTbwFZK812HQlb+u7nd2ylp2ch6yI5LZMZ+zp3Pd
         D6tEPhysKvhwdm1Dq6/nsLwXMG2NTmpqNPBriQ/m5yWiffxt3QKWREs+1d5Kw2n4Wtg+
         5Hgw==
X-Gm-Message-State: AOJu0YzpLhch1BJD2Y8KVETOEZeyaT/XUP1uHu4cMsgku/pyDi/BKHdb
	hZRIDCR8xm3kHJ8eMc+wQIT1aZktYRoMD8qnGs3AUICVEihPABF1MW0QtxiKR/piAmJXdbItXDx
	pLcatpECx6WLppg==
X-Received: from pffk20.prod.google.com ([2002:aa7:88d4:0:b0:847:9cc9:a404])
 (user=tadamsjr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8085:b0:846:8b21:6304 with SMTP id d2e1a72fcca58-84826bb949bmr2265949b3a.14.1783371662217;
 Mon, 06 Jul 2026 14:01:02 -0700 (PDT)
Date: Mon,  6 Jul 2026 14:00:53 -0700
In-Reply-To: <20260706210054.1336654-1-tadamsjr@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <akaHPScetfl1VbF8@ryzen> <20260706210054.1336654-1-tadamsjr@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706210054.1336654-2-tadamsjr@google.com>
Subject: [PATCH v2 1/2] ata: libata-core: Skip HPA resize for locked drives
From: TJ Adams <tadamsjr@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Salomon Dushimirimana <salomondush@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

Skip HPA resize in ata_hpa_resize() if the drive is security locked.
If the drive is locked, the command to read the native max address
fails with -EACCES, which currently causes the sticky quirk
ATA_QUIRK_BROKEN_HPA to be set on the device.

Setting this sticky quirk causes subsequent revalidations (after the
drive is unlocked) to bypass HPA checks, preventing the unlocked drive
from exposing its full native capacity without a reboot or device removal.

Signed-off-by: Terrence Adams <tadamsjr@google.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bdc88cf74709..3c06a15952f8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1338,7 +1338,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 	/* do we need to do it? */
 	if ((dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC) ||
 	    !ata_id_has_lba(dev->id) || !ata_id_hpa_enabled(dev->id) ||
-	    (dev->quirks & ATA_QUIRK_BROKEN_HPA))
+	    (dev->quirks & ATA_QUIRK_BROKEN_HPA) || ata_id_is_locked(dev->id))
 		return 0;
 
 	/* read native max address */
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

