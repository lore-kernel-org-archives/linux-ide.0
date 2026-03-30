Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB8191F98
	for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884023; cv=none; b=LFjsLT5w4ZY7Tc9lye0hWKgqfDK9nQ/dLC8uSOOoW1opEc4/VuuPlz4K++bedTHIiklBaEpWiS+11r8rWMkkXOCpSvQRCEgut20PSyyCLCwUkl40IPZQnkFEM26YtbhvnYbogIsb3dZ1fkqpKqDFmiHGRL+br7nzTH6SVMhcpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884023; c=relaxed/simple;
	bh=PchLg47BoBpJohMsD4ROZvOHbC0GAawfXljfvYGjtgg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IQa6N69hA6Ebk+xcjwP2QxRZocVGV4f2JptLANP00IU+Wd2ghwc07osUjHe4Os9ywYWe0a65NOOVwFZ8PHzp/mOSpJroIHJpOcjW+tINGYa+JhN8iJ0yeTFWi3BlUaVnR8uZIsFOpOrNW5GPMxNNO1Zii6metSWd9QeTrQ72ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyISMm5E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyISMm5E"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso46522425e9.2
        for <linux-ide@vger.kernel.org>; Mon, 30 Mar 2026 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774884020; x=1775488820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5NWc9Kh/cHqjmnT5hD86zA/WmWLW78ICGYIOiecTiQ4=;
        b=hyISMm5EXvC4VA1vudXXsmmijinYb9zHntsPSUX/paBNTG+Hx3lJLQvKo3trAoFomX
         gLZOx0y3wUZHoLrRw7duu2TUHh0i7FAmCgl2fUO3p74E6B7orvZ+2MEG2uABGlZEaTsa
         lsDrNQYVMCYvUcWuofcVLk4Hpi/p4oTmd6BB2r5W0lykhdsOa02nNGf9/v1mReX0R6Ox
         O4QbRGrcAw7ytOG11zYOjh//NSJtYNwSdydF0mgRQE+F+0XBngHETPuwolDVkan4SJoq
         2MaOFWIQ7Ks5Zxrx/Al+p8OmiA2w3GuLX0DE0L1jy4ngLPPUD1Zy808+Cp2LMAeLp1SC
         2wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884020; x=1775488820;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NWc9Kh/cHqjmnT5hD86zA/WmWLW78ICGYIOiecTiQ4=;
        b=tHbbrBl1Rbxe/Nt/8QW6vplxr2Wmr7iPPtDo6EYMB1w9oU26aCnSWfDNAky+911dCA
         +B9gbjZPumqd/YnAclPhkrWuZ/19YJozQyd3MeF7aMdJx8QqD9P5KiFUNfryUAxUpnp6
         dFdbiuIhjqXi+CaSpm8pzbxa1iHWCVjgToCRJzBjpOI8T9OJmXtC9XHh/B2edeL6wNhm
         S7BIMgyH9/rn//aU00llr9/hEY3pjiyRJRg2m5RJvmqIaelOuXobW6tCc9VwwRLtPhI5
         J3POEsPjE3CigkCw2ggw3vkyRfnuW8NgT8OQUFlFr/PkGeTtGTivBRPxQdc1VLdPM2P7
         UlSw==
X-Gm-Message-State: AOJu0YxOYXkhXLO9bNmASQtP3YVYiy2KDD+bHcVRUGIu1xC/fEjo6y3j
	dUcf86OaDzidL+bJIDZRKNVpdy06UUvDbBIDsRAAWYVdArSwkmfNj98Wwx3OHQ==
X-Gm-Gg: ATEYQzxOYFDZogEd4CgWKJPtiVzYjJPULQz1v6alyC8Wmw15T9pmqytQOx1A+kAaeUN
	LVKqGNAdsrnCug7OVN8F0Lp8WLXIhPmirZoloXYWR2rAx28PTO9NqbXq7OynxDU4+C119Zf0zoH
	6Hh3lmu6WkjfLaC2yW2EclXRZx26EGnpqX3lgsv2aKZx2Nh1DdgvQ8HTjIr0AEylydQhpwcCCDm
	QuZEk5UO0+gvSlM51jOnFJHuzpIB5jhqw3gx/voYRKoB47fGK5jugMVIeo9XRHVtPQ71aclq71O
	K9xvZVsYeKvwAIwayDW5n+5MxqgLEHrq4o/2gYeE/vZ+4KQOD8kGEVPoujbuuSdYNIQEOvv38MJ
	v1QfVfK1fPckJvpCa0OLBOSe6eMldK+DPMULKKKby74tTm1UmPCntGm6/n6h06c5PwucL7ASURV
	7YwD29ekwSdnSp/+O9synCVLcwY/eDSxTEZ9U41g7sSIuicoX6b+8TOA7DY8v5GH28zv/N+qHTu
	S9ED6L9QNKUDkf/kZjZrYfM/X4VD6jkVFOOc2unJitV2dpdMRxcFANbzydnqGfzXQ==
X-Received: by 2002:a05:600c:3b24:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-48727d5a329mr234631805e9.5.1774884019744;
        Mon, 30 Mar 2026 08:20:19 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674? (p200300ea8f1aba00c5ab4ea43ed7a674.dip0.t-ipconnect.de. [2003:ea:8f1a:ba00:c5ab:4ea4:3ed7:a674])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247472csm17144993f8f.28.2026.03.30.08.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 08:20:19 -0700 (PDT)
Message-ID: <bf2ecd99-cab3-413a-97e4-1828aecd2c23@gmail.com>
Date: Mon, 30 Mar 2026 17:20:18 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/5] ata: libata-transport: split struct ata_internal
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Language: en-US
In-Reply-To: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There's no need for an umbrella struct, so remove it. It's also a
prerequisite for making the embedded struct scsi_transport_template
public.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/libata-transport.c | 53 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 68ae57a89..538743e88 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -40,13 +40,6 @@
 struct scsi_transport_template;
 struct scsi_transport_template *ata_scsi_transport_template;
 
-struct ata_internal {
-	struct scsi_transport_template t;
-
-	struct transport_container link_attr_cont;
-	struct transport_container dev_attr_cont;
-};
-
 static int ata_tlink_match(struct attribute_container *cont,
 			   struct device *dev);
 static int ata_tdev_match(struct attribute_container *cont,
@@ -729,21 +722,25 @@ int ata_tlink_add(struct ata_link *link)
 	return error;
 }
 
-static struct ata_internal ata_transport_internal = {
-	.t.eh_strategy_handler	= ata_scsi_error,
-	.t.user_scan		= ata_scsi_user_scan,
+static struct scsi_transport_template ata_scsi_transportt = {
+	.eh_strategy_handler	= ata_scsi_error,
+	.user_scan		= ata_scsi_user_scan,
 
-	.t.host_attrs.ac.class	= &ata_port_class.class,
-	.t.host_attrs.ac.grp	= &ata_port_attr_group,
-	.t.host_attrs.ac.match	= ata_tport_match,
+	.host_attrs.ac.class	= &ata_port_class.class,
+	.host_attrs.ac.grp	= &ata_port_attr_group,
+	.host_attrs.ac.match	= ata_tport_match,
+};
 
-	.link_attr_cont.ac.class = &ata_link_class.class,
-	.link_attr_cont.ac.grp   = &ata_link_attr_group,
-	.link_attr_cont.ac.match = ata_tlink_match,
+static struct transport_container ata_link_attr_cont = {
+	.ac.class	= &ata_link_class.class,
+	.ac.grp		= &ata_link_attr_group,
+	.ac.match	= ata_tlink_match,
+};
 
-	.dev_attr_cont.ac.class	= &ata_dev_class.class,
-	.dev_attr_cont.ac.grp	= &ata_device_attr_group,
-	.dev_attr_cont.ac.match	= ata_tdev_match,
+static struct transport_container ata_dev_attr_cont = {
+	.ac.class	= &ata_dev_class.class,
+	.ac.grp		= &ata_device_attr_group,
+	.ac.match	= ata_tdev_match,
 };
 
 static int ata_tlink_match(struct attribute_container *cont,
@@ -752,7 +749,7 @@ static int ata_tlink_match(struct attribute_container *cont,
 	if (!ata_is_link(dev))
 		return 0;
 
-	return &ata_transport_internal.link_attr_cont.ac == cont;
+	return &ata_link_attr_cont.ac == cont;
 }
 
 static int ata_tdev_match(struct attribute_container *cont,
@@ -761,7 +758,7 @@ static int ata_tdev_match(struct attribute_container *cont,
 	if (!ata_is_ata_dev(dev))
 		return 0;
 
-	return &ata_transport_internal.dev_attr_cont.ac == cont;
+	return &ata_dev_attr_cont.ac == cont;
 }
 
 /*
@@ -782,11 +779,11 @@ __init int libata_transport_init(void)
 	if (error)
 		goto out_unregister_port;
 
-	transport_container_register(&ata_transport_internal.t.host_attrs);
-	transport_container_register(&ata_transport_internal.link_attr_cont);
-	transport_container_register(&ata_transport_internal.dev_attr_cont);
+	transport_container_register(&ata_scsi_transportt.host_attrs);
+	transport_container_register(&ata_link_attr_cont);
+	transport_container_register(&ata_dev_attr_cont);
 
-	ata_scsi_transport_template = &ata_transport_internal.t;
+	ata_scsi_transport_template = &ata_scsi_transportt;
 
 	return 0;
 
@@ -801,9 +798,9 @@ __init int libata_transport_init(void)
 
 void __exit libata_transport_exit(void)
 {
-	transport_container_unregister(&ata_transport_internal.t.host_attrs);
-	transport_container_unregister(&ata_transport_internal.link_attr_cont);
-	transport_container_unregister(&ata_transport_internal.dev_attr_cont);
+	transport_container_unregister(&ata_scsi_transportt.host_attrs);
+	transport_container_unregister(&ata_link_attr_cont);
+	transport_container_unregister(&ata_dev_attr_cont);
 
 	transport_class_unregister(&ata_link_class);
 	transport_class_unregister(&ata_port_class);
-- 
2.53.0


