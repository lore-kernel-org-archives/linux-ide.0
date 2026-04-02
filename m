Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AE3D76
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136611; cv=none; b=pWz+yBouOZ4YVJWuDoaTlk3VfBPDyrXVlJjySek5fyrOArI8tf6z+3HZ6X9y5v1k2mxNEMCe7j/C2K+G51l0mHAZNBaLCWlLkvBscFWukEivcC0IH/HRcbrGx/V96iL4cIOmmI1fHeNiJ1BezaE1kL1MjcgKkn/fhqN9orJPmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136611; c=relaxed/simple;
	bh=JrVHFMZNKcwjMVa1s9VV7l2sSF/QrrfL0qUAbc4mjEg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rr+e9yCbalYvz31z5r61+phqBBk1ApOF8JmITIbTC2E5oApSYC5d+yddI+6OkxUjfI2ZC6loQdJyyA2B0LBkvqWWo9BuE+YDExxwdZh3LReUgue/r4gtnRLvFGYV4rKDOwQYwV9XdzxLesKSKFrig/9sqi4fqhibtFPT6j4ODEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3cU2hyR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3cU2hyR"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso847052f8f.2
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775136608; x=1775741408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eoEcSOHjCJZjYvQil6SGjHHueDbu7aSVgTFvm35qfho=;
        b=d3cU2hyRBuql3wbHO0GpWNiaWzKuQVeQVOPlZjMkB9iJ8FCvYGI3smAtAtV/EKoiC6
         7uuHtLSoI/WCKcpEKgKqO7cqZt5eeasEatHVAP8QT7RK5iwnjw761u0qAH6ya/06IESz
         vTjlerAfHV5o0X8mAM6t+POLpCZmHqjKzi+QvCgtkebxmCe9/oCTD10iMYsN6TnOl1fT
         Dd11Knyjo3/0rzoGYhrbDi7g/zQUF+onVO7mHvj6EnzgVyR2v/07E9rRBAn1sY/Zo+Ca
         Aynba5oQoO4huSkHvAbMOJQWzGnWHCR0Q1rzG3yTGM9L9J22KB9BHDOmyqLTrMEzWZrY
         BmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136608; x=1775741408;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoEcSOHjCJZjYvQil6SGjHHueDbu7aSVgTFvm35qfho=;
        b=HLnDAna0wIwW2pDX7odYph082zBgoLHnf79PyCnMqqIQ4LDVA7lTwb7Q2ruGo+dIYn
         Ued5yQ0k3OMRRLwYWfkgE0qUO/X2xGVpXWMZ6kfVLfN5uLrripCJzHi+LjuGpX1ouQsa
         yQzwdsdVS9zlsS16PsLXqPcIuf8w8B6C48BhWA3IVXYdN4Ca8dRWVXqI3waxhlSw4zMF
         92Y95cgn6381fGVLAMuuouAPm3gkpc/NxCLNwsf8oieczGoA3RGTWUO/7c9R2vuRhTF/
         QEXPeUPnyc5KLgUt3ZfTZE5cSAqMWCbCKhXLRdhWj4wuR97TQ6kTFg9NT6Q6YewhMh/8
         bIdA==
X-Gm-Message-State: AOJu0YysuuOZ3HKNLxNCcY/rMTkBGMcAzu87+A8AGpA+x+v/r7Qze1TM
	gZAdNdTVNScTuetshOVVmFh1u72aBtCZ/KHrhuWk7dNuMpBhs3qUvZTl
X-Gm-Gg: AeBDiesYPp4gtvXmZ8IzmAc8Bt7xPljAWotL8p5rtrdQI7SB09dBh7ijlmSBON9WK5m
	9qQsAh53mAS22EEM1m9wVJX2rmqeLwcJDOa+Z6CUEbNgA80ViuyQoUcVVUW4iK2nEWjTWCJTzq3
	tgqZMOK9QN1XHj4oVZa7TLwTvFjOp68Pf8lFmL1cGDcvxoJEYN7bEaXH39urbnJX3j6DTAiRNPU
	nmDyy2ZWMnYqbKJw8I6htK4h9G0QTOoFPMS58sXPTN83vkZL1CWgqvpFT3Lo3pdO3Cc3Vgwpb4S
	kw7yJ4n23WPrqZdUEBZ9iA05si0hbi3N9oMenoQgzPRduALXPQQofSi1M3yGb+UD+S+YFpHjvFW
	CVYa+ssEVMKv4A11rRjHiWMyUWBmwtPOLC47AB+9icaMmSmaaDBOCEGJnsMC07iJnrxppMzQxvH
	eCmtI+UcRMqpd0OZ3yIiHTHNAoMbsqhN+/0HB5Pg8blg0Oyfad1yNGRrzQiWgHXkQkcUCs4Fjin
	luiN+nhblS7qjciGYn4fv885Q+fpaETCvyvKgO4jmmqFi7NpNRzlAnNJ32ngnYnSg==
X-Received: by 2002:a05:6000:2586:b0:43d:121c:37d9 with SMTP id ffacd0b85a97d-43d15045eadmr14648932f8f.1.1775136607212;
        Thu, 02 Apr 2026 06:30:07 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm8150058f8f.27.2026.04.02.06.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:30:06 -0700 (PDT)
Message-ID: <6a1f8c7c-3be6-490d-ad4f-4ad1349e7f32@gmail.com>
Date: Thu, 2 Apr 2026 15:30:05 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/5] ata: libata-transport: inline
 ata_attach|release_transport
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Language: en-US
In-Reply-To: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Both functions are helpers which are used only once. So remove them and
merge their code into libata_transport_init() and libata_transport_exit()
respectively. 

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


