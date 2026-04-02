Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1631F98B
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136737; cv=none; b=PVd2h+w6VPQt9ZTcbdVn66WLJBgOcFTY6jcnfVJIf338eaE3vCBcw65vymSRvKVlrBkT1lLZlB8KoNMW5WCGkINGTYrY8vyCWuQoTEYmbEeGaNJDT6lP2fZtDI6U26sHsJeRyDDZM1VNmh4UD3OO2yR/XsYpoN6pTagu2wnTZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136737; c=relaxed/simple;
	bh=rD0iHIvZVh5bnT5Ghfn2LMMag9AYPFQf1yu2E6LMoD8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BRRWm5GXQlyUi+d/RXIw1aPJMYQNoBHwYU2cvfdMnFHIELbJvfJ6otVBP3KDfXTaJ29Tn8+ZMP+Xpep7cWdSpcYhsZDaaREts2lbQgQabjgJqHwpXiSkC6eeFyBokBD4c84PwIkJuCK+AUxy9H457S0R3js/Pqiaq0QAN5NzTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL4otU+B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL4otU+B"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so8797035e9.3
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775136735; x=1775741535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7BnqSNQqqXt1XTO7uhbxBJAVp0tAa89VSH6tk08p79Q=;
        b=dL4otU+BxzC6RL+DBMncAYeRWWschDnDL2Yd/dVP+Li3UjIfsosNAPyIJiVdPrKlba
         WDO++38QatNpo8srCSgIehrQ6BLn5P6add6kZ9TZ4fIz85ZLjm3/qwWkd2A+eYTRWOD/
         8AbIgzF8TwEgx0cGP/xcG8T8hh6JkaYACcvEDBKrobV5pTt9JdGn6fww2vR+bnDddOih
         FQpRfb+cIX3Uv2ZgkUvMYwfLSf1vnDsaOctIulY7Iu9XcMLlhOX3RixzRL2m87RDUFwk
         TcFL71rJkSGqFypSRJtfIZSmside0PN9lB7IIfiFP4jfxkCN4T100Zedv+1mSMfI8ryF
         qk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136735; x=1775741535;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BnqSNQqqXt1XTO7uhbxBJAVp0tAa89VSH6tk08p79Q=;
        b=gqW2uRFSp9m68pwDrhx6jECYRYDNg/EPVviePdENC8FiRdwIio2dSAQY4ZcYGbM3nX
         oG3biwW06wLVoo360MW8RTyeENZ9Mvye5sXNCxdnxJ+s2CHQXQbtaD7VzSm2hj/kJGOA
         rVm7h0dIDyCrpIa9gYDkMx53hvAdRPjwk/DistMZhL0ZrsZda6bnn0JgYbbxf5LlLR+v
         grMrxSmDeNRWeDtwhhrMxfFEEtUTyEJ57Jw2Xq0xtCjMLpmv01tHocnYGGnES0EVKY0B
         QqyHEv0H3GR1qWxi8qXQLGcGQ8VZdrrrO9v0mDzVI/DcW1n3AGLoglProqeXZeMVLTc5
         9ltQ==
X-Gm-Message-State: AOJu0Yw5DyEucTi06/t3G26rUyIApVEkfMkxsbm9msiHmka9sjiypG9p
	x83rMNfLhtroomQy6kiP//RB7xauh+N/WI+WxIoWZPTiW3UmOQKGdKRl3rRhnQ==
X-Gm-Gg: ATEYQzxLS7Jz1QvqFi20VNzQoy2uPLMbJI7+wble+Rzm3+nWRdyOlDazcj0MEUBFO/X
	6v9BFQ2xVhU/YRkIlHMcY7Ge1UWcucZCkprBLqN/rSpttRhuTfU4u/N7PRgFNQcpknFWYMh874S
	C5RMR9GR7av7+0lp5VFCIxzeoxDfk3PBe7pBl8fX+FSjIDIn73tFHGs4NsXxbXgksoW1sI0KU6d
	p8Dif5RC+5SxwruCHoe0HLJfUxXAkF3EyN6Psq/ShBYFcpjgr/bqiMsnCTvvYLp4CZL5kpV2eNf
	L4Oc97R18KKq/UyoYapavi+gHqcYBhobEotIA6yZNLzoBEn8yTnUmhquqNYJE2lLn3Is1yyMwK5
	lqpmvxWprZIghYt95DnGeOZZODb7fBO5xPMMOjB6Xo9HlG/N0+wwFbxpxLV0F0z/MPKCri6ZhR8
	xsiVTCUdOInZxAPZDOyTBHlgHOXpLT+ZrFAazXJDDoPItIpFBuVgNwtwOfa+D+MxttcpJp8UYXN
	SKlXrytMfSdSRUzud4FiWH8l/Cb1IzIvCHbdWveTZqfMuNLG2tIcqFyEhKbLUtSoA==
X-Received: by 2002:a05:600c:8488:b0:487:1fbf:e0a1 with SMTP id 5b1f17b1804b1-48883569e15mr126831235e9.4.1775136734895;
        Thu, 02 Apr 2026 06:32:14 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c637asm7682833f8f.14.2026.04.02.06.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 06:32:14 -0700 (PDT)
Message-ID: <d74731b0-525e-45c2-a166-d56c5766dc00@gmail.com>
Date: Thu, 2 Apr 2026 15:32:13 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/5] ata: libata-transport: remove static variable
 ata_scsi_transport_template
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Language: en-US
In-Reply-To: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Simplify the code by making struct ata_scsi_transportt public, instead
of using separate variable ata_scsi_transport_template.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


