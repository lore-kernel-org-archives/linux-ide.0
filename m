Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3C339872
	for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883893; cv=none; b=WBv7bmWtsSx0IIPfHJgLWkZwyE9/lCtu//t7REB4MkFqoA/h1q5jBDwmTC8zG86luuWUbcjwZfAnRcZBV/l9Bv4bUzXOmApcuBAxMs85TtgBJRa2EvtDC+eXS/0JQHkgEvVq4FOCqVVIsF3Ago0Hu7/AVYPgrhSMKC9/USqO9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883893; c=relaxed/simple;
	bh=AZKSL4ISdPbhB9PotON6/4XM54KEbj/hq2EHSgKhyZs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hvuhmWfHPwQdd1btz8+rA5a6Mh6nFCTn3eJQxA61MPS8xYGGR54bpvCokPTgcBre0PkUcsPaouchYqo44brkBL/973kcYIJeH6rY8UHllrcqyLNStv8GjuNsi5Qv7QNrHNg/X6uywbdGjZWbh+qC8oMi9Ru7fHC+zceQpD953OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liQpAy4g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liQpAy4g"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso41863895e9.1
        for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774883890; x=1775488690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7L8Y2A7BbK6eroZTnDlarDqLBiqenVGMWKEaxr9od+M=;
        b=liQpAy4gQQnu64xv/nzod/MdxO2ANnIgU/v96p91RcxPC1hzkHEDVUZArsXd9OiN7x
         zs/BdQcuT3duit44OzGZb30RuoTcbz1ptCKjAdzLVnxp+sF2l/b3JuZs6Ia53Hm7BqA4
         aJwM8USgQ8l1ewEm5VSRgyqd/7VyP4kr0Q3fFaKD/up7Aq2DtIzKD+I7snWFNFjsL85n
         pB+gXZQV/rBW6n66c/WSEQejNiSlSz0FOAltihzQ/SssTCQmrAtaeeEQOyfF69embPPA
         D2fXeOfS7ZTcNG1y8fuOlpeP6gm8UNv+oiofyXNae+9pLM/MZ8HpFBObHS+P4oq4mNng
         LTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883890; x=1775488690;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7L8Y2A7BbK6eroZTnDlarDqLBiqenVGMWKEaxr9od+M=;
        b=j2y95/zqGdCX4hx2BtZvNUYxjrhLy4SgndwM6qsmLwWOFjvYLSDfefAgdJ+Tmjs69p
         SeaA+vHgUGqr/XVXFsQ0fT8/xSBzH4bGeZGg58m0qTemlde8HHMLSaWtmhth24HhzhxV
         j4HW4fRrsOFWDDUii4MOXK6896qtRbuvPWkvzdIY7vfBXa0vc+SkFVXqLxCD2+gEzo8x
         tdqNp1dH5YaU+/+wALlMDvVk0okJe0rCE5nDxAGkaCyPKgLPMa/tfDpp6sMD07k580eL
         rMZi755GA5pmsXVYnQLvsul2B5eWVqvBKXc8Imzp1pCGKd4LQJd/fU7ryZB9xsY9S8zQ
         TnvA==
X-Gm-Message-State: AOJu0YyOjuBNQQletDHYWkkoSzaDxvfMVn1wJd76DFVI7cmI5BtUuDtg
	NxiYWq6iwvehuIOBCVCcUDcsG6nL3J0CwXP9GJFK9UIJv8Z8rkqI855xSchGjw==
X-Gm-Gg: ATEYQzxD+y2YMXx8L5OC8ZYiBzuETKy5HX7TETSUEVZkX/+UeqsSjCtUhF4TBMgLa7i
	Zs8akeuy5Jlk2QNPG+GCUJpq1c+sBmprZ7taaSSLtbhS2eIVpb0A4RSmRhvgnjJbxzKaMxCIZB/
	oXhO327N/WZPXq5OD2FSi0SA1WeSr4OiS5quW11z0aogRnnPgaWTbq1+Avl9j/ToIgJYIcRXhzf
	IaDZIZwoLJqOSZ7v3Cd8TzqpJVabWCyxn+WiXdadFQBe1N1TnCkIj8yrDs4kFX8jkC0pFS1Po/Q
	p+PX3rESgt+VGedtHuladfv8IZRLT8Y6kI46XYSeajJbl3F6JZSVePPy7ftWFWE/57IIe2dcZsI
	VbzmwXeJiByR+j+ud3DULGFmkEeS8CTm2+04t17x/dyqHFq+Y11HuWKWJI1gVQE1GdXxyckAULD
	kRf1n1FbyHZn7wen1x3OP/pPSlcKjAV6OLiyLmIuIT+MjU+Ly/Z3T5rwlAp1TAlEXNAmrMDWAyE
	R2Xo6O4C/Bwyq+EHfI72Z9uhKQbUn3MkPl8k5MqDNbehB1Up1KwyyeW9ugpfAeB0A==
X-Received: by 2002:a05:600c:4e15:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-48727d5a191mr221172245e9.2.1774883890064;
        Mon, 30 Mar 2026 08:18:10 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674? (p200300ea8f1aba00c5ab4ea43ed7a674.dip0.t-ipconnect.de. [2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270dd790sm176422465e9.5.2026.03.30.08.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 08:18:09 -0700 (PDT)
Message-ID: <ad6ef45a-1e47-4bc4-b9fd-6ba3ec8ca83e@gmail.com>
Date: Mon, 30 Mar 2026 17:18:08 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/5] ata: libata-transport: instantiate struct ata_internal
 statically
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Language: en-US
In-Reply-To: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Struct ata_internal is only instantiated once, in module init code.
So we can also instantiate it statically, what allows to simplify the
code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-core.c      | 11 ++-----
 drivers/ata/libata-transport.c | 57 +++++++++++++++-------------------
 drivers/ata/libata-transport.h |  2 +-
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 81479ddb8..ae56567af 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6779,22 +6779,15 @@ static int __init ata_init(void)
 
 	libata_transport_init();
 	ata_scsi_transport_template = ata_attach_transport();
-	if (!ata_scsi_transport_template) {
-		ata_sff_exit();
-		rc = -ENOMEM;
-		goto err_out;
-	}
 
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
-	return 0;
 
-err_out:
-	return rc;
+	return 0;
 }
 
 static void __exit ata_exit(void)
 {
-	ata_release_transport(ata_scsi_transport_template);
+	ata_release_transport();
 	libata_transport_exit();
 	ata_sff_exit();
 	ata_free_force_param();
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 7ad180265..0c7ce278e 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -745,6 +745,23 @@ int ata_tlink_add(struct ata_link *link)
 	return error;
 }
 
+static struct ata_internal ata_transport_internal = {
+	.t.eh_strategy_handler	= ata_scsi_error,
+	.t.user_scan		= ata_scsi_user_scan,
+
+	.t.host_attrs.ac.class	= &ata_port_class.class,
+	.t.host_attrs.ac.grp	= &ata_port_attr_group,
+	.t.host_attrs.ac.match	= ata_tport_match,
+
+	.link_attr_cont.ac.class = &ata_link_class.class,
+	.link_attr_cont.ac.grp   = &ata_link_attr_group,
+	.link_attr_cont.ac.match = ata_tlink_match,
+
+	.dev_attr_cont.ac.class	= &ata_dev_class.class,
+	.dev_attr_cont.ac.grp	= &ata_device_attr_group,
+	.dev_attr_cont.ac.match	= ata_tdev_match,
+};
+
 /*
  * Setup / Teardown code
  */
@@ -754,46 +771,22 @@ int ata_tlink_add(struct ata_link *link)
  */
 struct scsi_transport_template *ata_attach_transport(void)
 {
-	struct ata_internal *i;
-
-	i = kzalloc_obj(struct ata_internal);
-	if (!i)
-		return NULL;
+	transport_container_register(&ata_transport_internal.t.host_attrs);
+	transport_container_register(&ata_transport_internal.link_attr_cont);
+	transport_container_register(&ata_transport_internal.dev_attr_cont);
 
-	i->t.eh_strategy_handler	= ata_scsi_error;
-	i->t.user_scan			= ata_scsi_user_scan;
-
-	i->t.host_attrs.ac.class = &ata_port_class.class;
-	i->t.host_attrs.ac.grp   = &ata_port_attr_group;
-	i->t.host_attrs.ac.match = ata_tport_match;
-	transport_container_register(&i->t.host_attrs);
-
-	i->link_attr_cont.ac.class = &ata_link_class.class;
-	i->link_attr_cont.ac.grp   = &ata_link_attr_group;
-	i->link_attr_cont.ac.match = ata_tlink_match;
-	transport_container_register(&i->link_attr_cont);
-
-	i->dev_attr_cont.ac.class = &ata_dev_class.class;
-	i->dev_attr_cont.ac.grp   = &ata_device_attr_group;
-	i->dev_attr_cont.ac.match = ata_tdev_match;
-	transport_container_register(&i->dev_attr_cont);
-
-	return &i->t;
+	return &ata_transport_internal.t;
 }
 
 /**
  * ata_release_transport  --  release ATA transport template instance
  * @t:		transport template instance
  */
-void ata_release_transport(struct scsi_transport_template *t)
+void ata_release_transport(void)
 {
-	struct ata_internal *i = to_ata_internal(t);
-
-	transport_container_unregister(&i->t.host_attrs);
-	transport_container_unregister(&i->link_attr_cont);
-	transport_container_unregister(&i->dev_attr_cont);
-
-	kfree(i);
+	transport_container_unregister(&ata_transport_internal.t.host_attrs);
+	transport_container_unregister(&ata_transport_internal.link_attr_cont);
+	transport_container_unregister(&ata_transport_internal.dev_attr_cont);
 }
 
 __init int libata_transport_init(void)
diff --git a/drivers/ata/libata-transport.h b/drivers/ata/libata-transport.h
index 50cd2cbe8..a464b8fcd 100644
--- a/drivers/ata/libata-transport.h
+++ b/drivers/ata/libata-transport.h
@@ -9,7 +9,7 @@ int ata_tlink_add(struct ata_link *link);
 void ata_tlink_delete(struct ata_link *link);
 
 struct scsi_transport_template *ata_attach_transport(void);
-void ata_release_transport(struct scsi_transport_template *t);
+void ata_release_transport(void);
 
 __init int libata_transport_init(void);
 void __exit libata_transport_exit(void);
-- 
2.53.0


