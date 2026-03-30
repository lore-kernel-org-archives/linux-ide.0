Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34355337BAB
	for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883939; cv=none; b=RRy1eOmRj7ExxjVenzAh6v3l72loU3aHBunP0rjQe1+AgXmAJrduEbp7CJ28pHrwLGm9h3VmUptxoCGj/nhabLaSkXPUVNG14J8FBfpSPNUvXT1Qns672b8MnCNKDlJuVHmbYNK4phUq8s9WD0NLVmw5nM3+f/wMJFnKers0FvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883939; c=relaxed/simple;
	bh=ACzjuPfsw+HNnPSCOmXpg9PWUaMTN1jYQVwvQ6K+178=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cB4paGe9bhqElC31L6EA7UzNLMPgkNDOPstFZQJiW08aowLSFqvadQsulEXIw6n8uOBA09VABl/32MTCfapNOhvJbvR5bdUOtCFmmiJZZjhiTwL33uAiw3DaxJM6Mo6k7gHrfSZVFebj4n6UspBJ2YR0VgeQ0iBTJuTzNc3CqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSjgKlCF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSjgKlCF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso55597185e9.0
        for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774883936; x=1775488736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U1kl37LttMxd0hyup0n/XTTPM4jxgkh4I3snaIcj5jQ=;
        b=OSjgKlCFtjKVq9FiidFxYxnGGwBi4mYUHyPEmOM0a9QTfXa91EGwK/Y05fcRyHaW+E
         AVi1pCMlRig3YSF/n+TeEEFyYUBPTqWt0QXw7Ojx9llhbsD3+wAuavt0kW/MShYSO/Zu
         0f3Ro1obvfHUw8jTAHUPOjRT/9Z4VKF8AqhOfaiUUi3AMc5pTKHpjBg8nQCvBIIQI5rg
         DBXa2h8NmGaINtLu24WUvbeCyaLBiuQerIfzeDO/S9aQ9wDayneJ940feB8H576Z2C1W
         Y/1PNquY1AN32DE96K8fL+IdEfSVI5EHKMP/ddrfhqveDISeg6pCtHk+dOSqur1yWANM
         +wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883936; x=1775488736;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1kl37LttMxd0hyup0n/XTTPM4jxgkh4I3snaIcj5jQ=;
        b=WdXvllizsKAKXt2B8+ofMrj+fQ/RA+P9DQ0Jk4oWuUGslYiz0MdUR000lMNPJWBmNT
         yxM8TC25Ks75RojRukuJEE4A/l/uakdT+dXzMc8497DSeVFj7USoj5uaxytghcrErOis
         L8tnGfLEWAaaMcs78ol/4ZNUoVClgBXCkScFGS1XLEfjZz/v4eBY/mIEGkFniPguwTMD
         2pU6HwrrV9AVs7RL82h9njppSFSVKRYt8sUFBobuN0P0j6U85ryWiOIgHOuOZuwf/ADu
         07ojviqALzG+8W6U3iFGnLJXvKeI/pzv5gagZtVXkTUOvNq5pvLl5YWqvmf5btvJQgIQ
         Z9Xw==
X-Gm-Message-State: AOJu0YyM4oLB8bPR2dN5BBng53Oe59wq8rjvMfojDLqyg8/8cwxTg++E
	cTlykfUF8hUHu6ZYBrKgA4qE2TgS+iQ4ue42P9/7YobS+KSQtfEloiotKLmd3Q==
X-Gm-Gg: ATEYQzyK5Ak98Ssj6tTfpLP0SKXmB4z1/C0yug+kt3ZShuwpppyKwzY7DAGkRhvq9jk
	0ZY8YIh++sOdfFCMO09pfN4/5jg1iAoDuVUrX/t485OmDUiIpgC4gjumxOjDnHTY/XQrOeebgG/
	8QwtZi7213VfoLXZ7jpamVhTzY2dH7dpgiGKxFfyKS7OKOWKU6SkAuM43Q6igfrh/RCQdIkR3gF
	gzR9VMPXMQFVDnMc8D6TNKi2aqk4G4AZyNUiZSGke9T9WddLWA6GGgg0DI/OPzzaihvS7HWr2bn
	Ns+xztYG9+d+ZQXspb0kB4x03pu8/FbXgk6TNdrhRxlemSts8IYobYUE/xEV/frEWBQMlovseJ2
	PbX+iT8/qt6Pz/DQRxBofviK7Xt/+f3Llt9L7HXBYUBgbDbxL2UQ7E9fwBcbtSCk0cgyogfm/xv
	rHFvQyrJSh6amIADLwAMfZmxcspZtUQUPz6lgg+/SsXEHrO4mU5LKXd9fx0e51XLjoBzWzyLOzO
	5fTxxVLT5rQhzC8uN+YpnBSUSR1BXHqOIdsK5s8rvaBN2DufuvJPEs2Zb4J2a7J5w==
X-Received: by 2002:a05:600c:a44:b0:487:59c:2bad with SMTP id 5b1f17b1804b1-48727efcbffmr203924655e9.24.1774883936462;
        Mon, 30 Mar 2026 08:18:56 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674? (p200300ea8f1aba00c5ab4ea43ed7a674.dip0.t-ipconnect.de. [2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c845b8sm264280295e9.4.2026.03.30.08.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 08:18:56 -0700 (PDT)
Message-ID: <f9d372b0-cd10-46b2-821f-80c4c29c8992@gmail.com>
Date: Mon, 30 Mar 2026 17:18:55 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/5] ata: libata-transport: inline
 ata_attach|release_transport
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Language: en-US
In-Reply-To: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Both functions can be merged into libata_transport_init() and
libata_transport_exit() respectively, thus simplifying the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-core.c      |  2 --
 drivers/ata/libata-transport.c | 34 +++++++++++-----------------------
 drivers/ata/libata-transport.h |  3 ---
 3 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ae56567af..e76d15411 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6778,7 +6778,6 @@ static int __init ata_init(void)
 	}
 
 	libata_transport_init();
-	ata_scsi_transport_template = ata_attach_transport();
 
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 
@@ -6787,7 +6786,6 @@ static int __init ata_init(void)
 
 static void __exit ata_exit(void)
 {
-	ata_release_transport();
 	libata_transport_exit();
 	ata_sff_exit();
 	ata_free_force_param();
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 0c7ce278e..9d594562c 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -766,29 +766,6 @@ static struct ata_internal ata_transport_internal = {
  * Setup / Teardown code
  */
 
-/**
- * ata_attach_transport  --  instantiate ATA transport template
- */
-struct scsi_transport_template *ata_attach_transport(void)
-{
-	transport_container_register(&ata_transport_internal.t.host_attrs);
-	transport_container_register(&ata_transport_internal.link_attr_cont);
-	transport_container_register(&ata_transport_internal.dev_attr_cont);
-
-	return &ata_transport_internal.t;
-}
-
-/**
- * ata_release_transport  --  release ATA transport template instance
- * @t:		transport template instance
- */
-void ata_release_transport(void)
-{
-	transport_container_unregister(&ata_transport_internal.t.host_attrs);
-	transport_container_unregister(&ata_transport_internal.link_attr_cont);
-	transport_container_unregister(&ata_transport_internal.dev_attr_cont);
-}
-
 __init int libata_transport_init(void)
 {
 	int error;
@@ -802,6 +779,13 @@ __init int libata_transport_init(void)
 	error = transport_class_register(&ata_dev_class);
 	if (error)
 		goto out_unregister_port;
+
+	transport_container_register(&ata_transport_internal.t.host_attrs);
+	transport_container_register(&ata_transport_internal.link_attr_cont);
+	transport_container_register(&ata_transport_internal.dev_attr_cont);
+
+	ata_scsi_transport_template = &ata_transport_internal.t;
+
 	return 0;
 
  out_unregister_port:
@@ -815,6 +799,10 @@ __init int libata_transport_init(void)
 
 void __exit libata_transport_exit(void)
 {
+	transport_container_unregister(&ata_transport_internal.t.host_attrs);
+	transport_container_unregister(&ata_transport_internal.link_attr_cont);
+	transport_container_unregister(&ata_transport_internal.dev_attr_cont);
+
 	transport_class_unregister(&ata_link_class);
 	transport_class_unregister(&ata_port_class);
 	transport_class_unregister(&ata_dev_class);
diff --git a/drivers/ata/libata-transport.h b/drivers/ata/libata-transport.h
index a464b8fcd..fe5ca66fc 100644
--- a/drivers/ata/libata-transport.h
+++ b/drivers/ata/libata-transport.h
@@ -8,9 +8,6 @@ extern struct scsi_transport_template *ata_scsi_transport_template;
 int ata_tlink_add(struct ata_link *link);
 void ata_tlink_delete(struct ata_link *link);
 
-struct scsi_transport_template *ata_attach_transport(void);
-void ata_release_transport(void);
-
 __init int libata_transport_init(void);
 void __exit libata_transport_exit(void);
 #endif
-- 
2.53.0


