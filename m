Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77062266581
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136687; cv=none; b=qB3qqGNgYvx2fHkcI71F1FDSSiS6CDHTlEMsNO7B17Z7GSIxzbpfhy7HkjLLaN7lepB3uItqa2NXTRXobLltd424vdp/os+IdbWNDJJfe8HCiAPCvLEZUtzki2syLSh8MOGVFJyCcr92w9hKTTg52HiA5y+1loKaAHha2de+pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136687; c=relaxed/simple;
	bh=1yfvBaugUTwb2WH1uNPfRl0X4hkseks+JlvvtUV6E8g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e1EF+ose8jGBrGEsUo4j6ZszQhS8n0u3SgaTY2OAV4yXvfK2T/y0S+bffp2gXGIkM2KGw+RtAtlJee7KdbK5sYXWAwXpWVZ7T3Ex7WDj1bUZn1psz5llkmvuFvmHmMsYm0VPGmizJmYe1YWrX6o9jqd6GBtRkvfRL3GsrZGwjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptUuOvWd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptUuOvWd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so9198325e9.1
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775136685; x=1775741485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yg9MdfAaSLI0rVc17JGq+XYmdD32tt6ays2WdHnciXM=;
        b=ptUuOvWdg9b3eIG1+/8275aJOeR2GoYn7jUWxcsPkaOw0Y+MbFYU4GWE8KGrH3L6g2
         4YUfn97R/NbUISkZSyoNp/Nu2wC1JrRGBgCBtmk+r3p6C3Kg5hPeOGL10VAvfbEMWfjJ
         veTFbWz30Bs/num1W6T+VquZTOLTN8maTU0WeRGjKjTmF/+TVeopnPKrGsD4V8h7Yv08
         +qPC3o3QjPxdypsxiFwuFASqiZ+dOcfW9A4yZa6sfpJ7elCnXT9jsx0xzU0hARw2bLMA
         f604Em6ejzR/Jzu/l6aXL3fT2qJAIK9B4XpczqK/MNhcX05pjXcCRmBr56G+KM2uCr7l
         vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136685; x=1775741485;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg9MdfAaSLI0rVc17JGq+XYmdD32tt6ays2WdHnciXM=;
        b=j9XfdCh/O+anXExkOqmBz5XO7azl6/ZGU9PEu8t+WXg4BUsKBk9amNtjikxBk1089v
         JqGPutRfO/U+vxLhIcsoFjgMdrtW7SEqUDAwgsQvHzt9zmNWjBnhBA/5ZKAJQ0wewlQM
         WgjVmshu0iINWgk7ci6YtReuDdJL6//Gxe5vD6r9en+B8w/yiYz5bmBo+gJv/qTrUDjr
         i20iCCbmTdWDHOVZDKO7lVZqtNSBvvUDZ7sa5affiPOuRAcOB1tD3tHGG7TRAK/yRUdK
         /g/DO/641HFLRGE3fiMbexSjcw1nvofeb9fv+p3N2Zy/0O7vLSBzw+T0ZSkAlZfYWDlJ
         IFrg==
X-Gm-Message-State: AOJu0YzxqPchCuVI9S7s2RGvvRny64aB0kSt1ZaZq1Ro0d7/sIsCiPjp
	29otm/t5Zh4bFM4ReDJJZyXhNvMSdviCdaSsWAUDiFpMd546MuYpewbR
X-Gm-Gg: ATEYQzzh5V2opDQKFsuBH7+sar4Ei0ywZG0aoaO13qn5ZMyjZnVUboe8BZ2I3NDJqHZ
	ShddaWuZu6oX1XAaVSmg8+7S1kniLL3+ec8QYaF8BRgDtXqBRYyGDMEMY4apZFhL+wkzYAtKT3B
	vzT4j1+17pDkiNo1fQuHcO6L3YoR+boWsCUlp0ajE+TVpw9BDnuKCOHnY1dAzedGtsEeQS9a3lL
	yTxAtudsRaqV1NybFTz32Gbgeu7f0E2LCLjEOm8yStuTptQel3EhhkeI5XrkrFFBJWLtjtiUMFB
	6e3mNMci9j+9A1GDujESg2Znn3jrk6YndVv9mtkusmkQ7E1rAtdJQU/Nyl+XQ7+QqAVkAfYVMWx
	ImL5NCCwTLIYlB6u3Wu6y9FWynQ0i7aBAX/TTKH+gA2nmAbO12wJhOABV/UyEu++grVFDKsIolI
	Wk48oMTGN7GwfYSCWs9EGxeK3QUHJSpkeDK3cOgfDL11Eoyp2ja+tU8fClISPa/hgfMJBVFC7Z4
	vrGucjfsJtChFTbI0QwvaaXV3ojO7VL6XcX9gcfdq8nZF4AEiMW7wxBb+/nE7fwFyeI7QsmBoOU
X-Received: by 2002:a05:600c:8214:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4888e01e356mr44327095e9.1.1775136684686;
        Thu, 02 Apr 2026 06:31:24 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm251607115e9.3.2026.04.02.06.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:31:24 -0700 (PDT)
Message-ID: <91a152e2-a29a-4ea4-9bab-5f9e61510a3e@gmail.com>
Date: Thu, 2 Apr 2026 15:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/5] ata: libata-transport: split struct ata_internal
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Language: en-US
In-Reply-To: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There's no need for an umbrella struct, so remove it. It's also a
prerequisite for making the embedded struct scsi_transport_template
public.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


