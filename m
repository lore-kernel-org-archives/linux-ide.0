Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EF2BF3F3
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136569; cv=none; b=L4hIHC0rb+/Ejhch1qdmZhPpTAqJodYr5K27MLdSBFskX2xKo9pLuEptwInDEAbPk6nqA8jDrss53JXg9DIgh7p5a3D/J5TPoW0550V8yyLejDceWQrz+t9zK6Xpd8nhTz8e+0nXvhMFl8OsUpLMBRlo6s/opfC+sXIVuQ+na/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136569; c=relaxed/simple;
	bh=Pkt3T9OIZGp9qirfgJYTgEnRWa4IrP07FmHp04xMgpM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uy5yoUwXo9KUoVklUdt4TTaMHyYi+cDMW/m/gRsSa2hoamPa5VpsjKvYzWyNkOu5ZwZiWaD+piRz0WOn03vTVPjCJgFByPSeWaRgxPehy+RvXavVN0MY4H/SUP7VT1ddJuYrGVrTyNTCAGGt50yZFLCumLMCKc/4tZomilSM8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDOSkgEW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDOSkgEW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4888375f735so7398515e9.3
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775136565; x=1775741365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w7lyX97kUYtzBJUQjAG70TMLjz/e+eDEZJ6A2bZetvc=;
        b=PDOSkgEWaS92SMn1bx3gELpnYo6QpUqwD+THSDfh5R8eshMfCprw30fTwoJKKLd0tQ
         5+PWK7dMtO3VRmtwVzXedRT9fJHzqFbpO2kfd7RJRjfjL2TL6NWG01tA+ioxXhLtKdc3
         aHZToZsEsS+j03VtRdSckMigKGhzsUDVE0uVf7fDSax9skgajOa+NxoimvUIfjVNnJBs
         iON0XhIhloEFxPYtWErKXJNm+Bnh2o7wBPzw1DyMj8Q7ygq+bUYDb34tCc0wHka0M3b7
         QLyzQ2NmtzWv08mHvaTgS2EWJNo8ZltJBWpxXdqtLAEG3RyK5pZD6phrsZ0C/S2fSHhm
         QT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136565; x=1775741365;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7lyX97kUYtzBJUQjAG70TMLjz/e+eDEZJ6A2bZetvc=;
        b=gTOoejPyuFGf6lDCr3K/8/s4ilbAAe0fCahXJgaNhEewM/gOFz1k5RiGrL+k9Rp7bw
         EmcISTcFGOKxa3vrYWu3f74QYFqt9iQ1ef2seyRuvEiPdiRLuBSkaLeJv6MLIGYzz8NE
         c5Zk0lOMpaK29muXC2w44GEssYv1eg2Gw9LcB+vqP+bBAzCMbdEBaw1rbWnUdu9FIlnq
         pJXUlFkh/HwmI+sKohzx65ZVDuqIrMLPUwQuAbleRUIMbZF/MjF+UbAXBuwYg3U0IAzO
         A237Qlhs4bXDhjEBJnDLJAWzn6j0FNdzYrMo0RTyvZfmzP6YlvJRaTbSKD6J/Neaa53X
         b18A==
X-Gm-Message-State: AOJu0YwiYajEwfmxUlYQlIJzCx34Egt5ltqmT8qNbqEzlarI6ICqI37Y
	051WBfXrJr2KZa/HTf4yeISO0ObclPQT17Vcg1DWI6+Q6Z1hFpohpZ8HaFVkxg==
X-Gm-Gg: ATEYQzytVfck94OQNM71L5ysTl4BTk7HLK5mRwl+Cs9OiV/Rte/Gh+0h53bb2SGgCDt
	fk0R27BL/Yrcc0GYTRlY45oG15aL8I7lWJovRc4Ci7aCRBz+zs7OmVydzjrG2Gi0n7u5SFLxW01
	ycU/MKaS5hEuS83kOQ4PlBaoGWPC5Ztd1s51IW39l4nkthz38xJB7ADlNwuk45R+INcP76Uhx/S
	Zaxi7OjRLmpxe+a+OZ0GC5fGN3pD5Vyl3Pfzzlc64VA2d/On+kaObuVozLJGG9atRixLXgi4WGY
	174raOV3eLMMGs+yTTntiZPnDnWRizEvJbOucH9Yk0TgTfGhS2IFbsd+iKouruGsMtNDwZ1MNKt
	t+kWo9FEeHFbFWbTmv7gmsypuIMh5QF0LSvu6yXbDCQ3hz1j2DjMOiSP0cGWL07is6byDR6S8MR
	GmkIvLN/lju9comv/T5rTeZ87IAhrVagdBajlPuos12NcjxYVZ1PEaXJ0HDOeVjUKyEqJBaRafB
	ACrWqc63b5X8uvnHvE4YAdTYTSx/OpRjvXXifnZOJ5A8CoyiAyqkIT/KkVrKGNNkw==
X-Received: by 2002:a05:600c:4f53:b0:486:fb5c:3b20 with SMTP id 5b1f17b1804b1-4888358be65mr130438095e9.13.1775136563103;
        Thu, 02 Apr 2026 06:29:23 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a567bfasm153322115e9.0.2026.04.02.06.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:29:22 -0700 (PDT)
Message-ID: <2f14be46-11b2-45d0-bd94-0ee2d4f0ac87@gmail.com>
Date: Thu, 2 Apr 2026 15:29:21 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/5] ata: libata-transport: instantiate struct ata_internal
 statically
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Language: en-US
In-Reply-To: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Struct ata_internal is only instantiated once, in module init code.
So we can also instantiate it statically, which allows simplifying
the code.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


