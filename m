Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0A343D8A
	for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884111; cv=none; b=H27CTdc2lFFV9olYrYrdKHk5ZvHjSphn/2fChjSJ83q7GN0mSt2jeA7PvNqs8y+ohAx7upMIA8/6VAMaYlCexsnrtVvssc43uVSeBdzk+Ns+zAm3bWBY2BUEH+LbeLqkOEeGv8un9Ttzq+wUW2JLD9VcurEwVPlJsUBt07rg4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884111; c=relaxed/simple;
	bh=bl7KrmGRw0ScOMwx+l5gIcR3qkFAOsFnbP+m5FKjiu4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SWHNwhKqmRjt4bL1nm+IkztyEwWG+mdna/0QaqRk7nrqZjuYGgZhxvhK/Fike28nENtcqIovdyez2ya8vfXkn6sNod/xWAHWJAJ3OpoDT0OyavUxN5eX+YLDHOItAp/Tot6nmMcuY02ck46t9SPsAU10FLfTXgZD8oup0IgAwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx/mDxcr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx/mDxcr"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486b96760easo50864825e9.2
        for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774884108; x=1775488908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8LtIoOi+S1ToaKtxTGQu8GSFJNrJDL2MG1FP76mWCFQ=;
        b=Jx/mDxcrfYm55vrzEsvEtd8y0GxGalN2YAeZ5E+A4yoTSQcpseLsrIykni+SkeQKmX
         bIzGG0b2lAztWLpXauDRq593LxV8GCVe9BNjo+IHcpzLXobwCori7Ot8C7zKU54XM/RD
         dAiMMOSoszc071qUEgiKv7K5iTo+tQWJMRNQH6xafAKocTL6PAKZg8X7L03Kd3HXNexz
         AS48b+/DrjEdpSzbbvTYnckMOrCeCihaMTw0M4l/zICKlbvJWIiDlwIaLK/li6aRMqet
         RpFQU/3mWl96evzL4/N1iDt6IDik2TTeOOHnB3rKAMJv8GJLHpCHZQ5aKqfYm9i5pXdi
         Vv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884108; x=1775488908;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LtIoOi+S1ToaKtxTGQu8GSFJNrJDL2MG1FP76mWCFQ=;
        b=WKXUPbM524OSm56GQaihjxhks8hIEu1XHGwLeU+9y+RE7HYFYVDOHebN4e/J4g59uf
         q31UQKUk+lpZIjD2ZsBZkASW8UMVRL7skXIk3y9I8NGP9Bw8Kxn/1C071eZ2kK6UUZyV
         BAwnV9GMEku1yXvVUUXcVuMAQLqd6dCpX/+6yGXeP0v/v9tv+AjcRRFKEzIQ/s4T/fvs
         i9o4zayz2ojJjGlDaogBw5zYpjUrWkbrbM0c0KrwsnEuOYeVGdoMFHJI06i3AFWadXAj
         v18Tb7BTxR+ufQJTy0+kOzCHPNMq0qjoLFybdfeLtN6n9cPGlNU8HX2CupmpuDy3aRTn
         Y5Vw==
X-Gm-Message-State: AOJu0Yy1Rk+zZyIWkovKDaA5YVbl9dsD21SI2/ltPkh1CT7e0slsLMQ9
	WJoGqxKf60aGgnuD3edn5XFd9wzmZ76luOpVWMEW/G4oT9TyLmBtPlccmoxveg==
X-Gm-Gg: ATEYQzz4lMtuhOPwOon7515K29fwKS4CGSXrxVxzbbKuZsPpbbOMO1uhrYDbqgwqK7e
	hXLAhBPrmZOz5M8uJXqegNQHBHwO9bIMllc1ZFK8F3tgTf3Adr4bIhiNIXvhjtBc+BD1X/RcV+y
	EskjOHf96bb8f9TJYc87RAh7GSstgM55inmn8fPS3f0epw7abWWFoHgYdLVvE/WKYtaL0NZKD9j
	JA2snDJt/QfqOn4CNvv8dL8fj2c5WVvoxSnOzNwHGPHmC3IcVpeIbTQVX2Pqi/IzBN6YcBv4Hjx
	/ElfJ3MufmAoTgGAzr6WO4guZjqqENg/GHLTmVcQPVsIPhyYSLd0PfulfJlR5aQ6np6LXyBtobh
	Wj+k70xeVTZNOyYt89l8VHc7WkYzQqv9jQppZR9ciUtl1wBjbFM+ICH3G+AgUtL+r9bKNp3bkd3
	aUEYZ37CnB6FpdT9PedXcB+OcF85nHqhj9rmIbRy0S590HuAFNK9XsXC+6iW+soU7LzYiWfNACh
	+eRYNu1C1BMhzSihnnOE/jBD9x7rcYT6ESqr6DNmyLyyEXZ7uJkt0mZ0mFZltrhcg==
X-Received: by 2002:a05:600c:c109:b0:485:40ed:2d1 with SMTP id 5b1f17b1804b1-48727ec777emr166468105e9.17.1774884108327;
        Mon, 30 Mar 2026 08:21:48 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674? (p200300ea8f1aba00c5ab4ea43ed7a674.dip0.t-ipconnect.de. [2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c957b9sm423526885e9.8.2026.03.30.08.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 08:21:47 -0700 (PDT)
Message-ID: <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
Date: Mon, 30 Mar 2026 17:21:46 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/5] ata: libata-transport: remove static variable
 ata_scsi_transport_template
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Language: en-US
In-Reply-To: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Simplify the code by making struct ata_scsi_transportt public, instead
of using separate variable ata_scsi_transport_template.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-scsi.c      | 2 +-
 drivers/ata/libata-transport.c | 9 ++-------
 drivers/ata/libata-transport.h | 2 +-
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 06f3a243f..b15830bed 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4624,7 +4624,7 @@ int ata_scsi_add_hosts(struct ata_host *host, const struct scsi_host_template *s
 		*(struct ata_port **)&shost->hostdata[0] = ap;
 		ap->scsi_host = shost;
 
-		shost->transportt = ata_scsi_transport_template;
+		shost->transportt = &ata_scsi_transportt;
 		shost->unique_id = ap->print_id;
 		shost->max_id = 16;
 		shost->max_lun = 1;
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 538743e88..adf38e4bb 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -37,9 +37,6 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-struct scsi_transport_template;
-struct scsi_transport_template *ata_scsi_transport_template;
-
 static int ata_tlink_match(struct attribute_container *cont,
 			   struct device *dev);
 static int ata_tdev_match(struct attribute_container *cont,
@@ -224,7 +221,7 @@ static int ata_tport_match(struct attribute_container *cont,
 {
 	if (!ata_is_port(dev))
 		return 0;
-	return &ata_scsi_transport_template->host_attrs.ac == cont;
+	return &ata_scsi_transportt.host_attrs.ac == cont;
 }
 
 /**
@@ -722,7 +719,7 @@ int ata_tlink_add(struct ata_link *link)
 	return error;
 }
 
-static struct scsi_transport_template ata_scsi_transportt = {
+struct scsi_transport_template ata_scsi_transportt = {
 	.eh_strategy_handler	= ata_scsi_error,
 	.user_scan		= ata_scsi_user_scan,
 
@@ -783,8 +780,6 @@ __init int libata_transport_init(void)
 	transport_container_register(&ata_link_attr_cont);
 	transport_container_register(&ata_dev_attr_cont);
 
-	ata_scsi_transport_template = &ata_scsi_transportt;
-
 	return 0;
 
  out_unregister_port:
diff --git a/drivers/ata/libata-transport.h b/drivers/ata/libata-transport.h
index fe5ca66fc..629ac843a 100644
--- a/drivers/ata/libata-transport.h
+++ b/drivers/ata/libata-transport.h
@@ -3,7 +3,7 @@
 #define _LIBATA_TRANSPORT_H
 
 
-extern struct scsi_transport_template *ata_scsi_transport_template;
+extern struct scsi_transport_template ata_scsi_transportt;
 
 int ata_tlink_add(struct ata_link *link);
 void ata_tlink_delete(struct ata_link *link);
-- 
2.53.0


