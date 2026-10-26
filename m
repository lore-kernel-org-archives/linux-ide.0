Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039380;
	b=TlWnZyAcG8gjBP3C26QpN+i+XQXVnH1pccw+m+JdioLhnEciCCM8S8acw5KOkegN/z7U
	 FGD0xJbUoEu9Cv3o/iWH5bN13GHb9TH8CP3OTmpzkFyFx55BcQlbRrOkRwtVrP3pB641q
	 ZVqAEALAE+20KGnVjwcDLbEAOf2T3Zokj+g1rCj6ULKjFxlGjY7ZvX4lTKgVWsnb+94Yr
	 2WB35xvjGpcGArifF1wZ0UqPltr/a77314jVQlrsGsbI0ChIaCTVCrWyoSQXEXR9W9d6W
	 xMXYsmN2QjhkNzBT2DrRZwNEdB+80KQ6xZiat6Zkxhjp8RaxuzDbJ3Tf866lJC6Shdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039380;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
	b=UtxJWDeKu5o1rEqqbVC88X9BM6uADyiPriSAWgnHaMMX0k/PHUtIMl8HQp+n0VQ9LcuG
	 Ff9/ZvgvpHVdgzhtBcAr2cd0VtDAOX4k1GvEPuGRrn2YkYwgqm49m8Go5LBUuMnWt+Qg8
	 APqsJBHn1FfFH9vrRU5VkVUFGOXjslMr7BVirOghjXbeL76N6KPrzYp1nWGevABhXa8Lt
	 AEb7i3hlnNcnd3TEahoI/GkXdVUVLE+JmQIX+oZGBqsRaGqFaBoyWbITMwUjdrrc8npVX
	 D9KAZQnNDLJXraGGIlnamdlNifiiSH7dK6eH7oAOYIPhai54Lh7/eBBk7y6nbluxD4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WkWvrgmd;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61040606A336
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 18:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61040606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WkWvrgmd
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso1863700a91.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039380; x=1793644180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
        b=kXm0ova3e2Sjkq5OVE4tE32ri2YBGk6mVa8qGHpT1XolmHo72ROiF/fprDNcMYG06f
         ZJ2cwo1rFIx4wuh0dXqvNYtu3rV2ncNRvsvO6Np6k73MSCuYagTpxiU1O75+sUfR5ATr
         pLOHJkCBEdIMEh7wrWXJXrWLAG75LJDeUE2/noNDUH8iy9YcYbx5fu5Bjt9kwjY0R0Pi
         77FE9h3THJ2/5p3KkCQEWdMfuCn7hni8KS1Djq2d7+kgrQhYGZpke7GCbQF8h+jbxzug
         u+EFCxQA5emuFjCsgxfAw1iW6+FPXZ/A1bFG4oUz3l7unyrR3POx+DlC8hJ8Mh1t48aW
         EL7A==
X-Forwarded-Encrypted: i=1; AKwUvBx1R3HBjV+F2reH3QfGknBsAOOCC1fmSdwbduVJYwdoSqqjiroVZ81ChZFwBfeqwebJgeN4cFvmt+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJupYkpCWZaESO4wZmIyC3DYG5+KQmUJkaHHTd6TqZw8JSi8xN3
	bXjEGCgVkIFw+/eSm4JsTpCpBJ9Me20lzLMURlRmxj7LUeutxczbuxlnO5nBzYBrtzBtvb2EkTg
	+wwPS7b3zD+PvFxsiVMpi+WtHQDiPqLL5vS9nH9mB2Yv517Lxc/pnURB/JPZIHqv+uOdZzC2Kg/
	+Mv8rW9HKpdaH0diUEA52F+lK6ro/ud63OKdhVTmBvKHG6fPv/TI/jMUZhyuXERV55Ei5QxQ7tO
	S6RpfbsfSxEFk3WXHGJ
X-Gm-Gg: AYBFou1obQqmFa376HlE7XM4ycphq2LS5uHq3Th2pSNrO8EJT5d2ZfpYTbntP0O7A/E
	KOLbmQBudBdzv0cyJQIt9iv1BJZzTFKGs/ywZfXk4LhqOlCBGTY7OEMiMrC7Axi5qyW8E8rbS3E
	aux4EtdWmRnj+64subEZR1z3JkeKYM6bW0SmNqazt6PZK+6jOg10/TDZVMxetrg8lrgqYglz//I
	HcWv7+gM6+qYPd6cnGVaD0uFmbTj216/LhRd7h3FTK/uRFQ4mX9pHuQb0xg4B5E0Z0SHAzI0F6B
	qsWdHSB2lGXdmP0E9tr4ChWwEM9Lojzq4Tpy8PE/qoMVwz1PIQ/Z/O0FZGi0W3d3yoDDtT0E7jq
	0g8n2zHO3zlLBnYWDiTPdqywsuFkrZzNqEcaNPUvCs3HPjkYWG6AeYEOHBTc59fpMGQSm2jpEgj
	BuyZrCpqSmieADqSH353c+MbryCjfOP0buGw4Um2DIoS8=
X-Received: by 2002:a17:90a:c2ce:b0:3ab:1b19:78f0 with SMTP id 98e67ed59e1d1-3adead4dcf3mr6347116a91.41.1793039379618;
        Mon, 26 Oct 2026 11:29:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae406dbad7sm251306a91.2.2026.10.26.11.29.38
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:29:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35cbea41088so5254700eec.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039377; x=1793644177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
        b=WkWvrgmdvdVuovyLoQ3QJgYuz1ZkJj9eQ56bDBXGJlNmvDc5/db+VnWwVBgraYA3BX
         5NqUKfVwLYOR5Uq5CWryYRJgPNXZ2AIdqgoaHz2WDjt3tA3B6N4nzczbwzWlzxEZFunG
         U6FMoXcAUqSPRCdf0kOkcjTd9hVjcAYxjwkvM=
X-Forwarded-Encrypted: i=1; AKwUvBybeS+132hrmKLmfGfVVQGurkgfEzp1E46nJq9+n5qEHQYYA2jvvdSpEHHtvm/XcbBqTqBmwFjwh1s=@vger.kernel.org
X-Received: by 2002:a05:7301:b0b:b0:365:921:8ce with SMTP id 5a478bee46e88-369e84e8888mr9413469eec.32.1793039376826;
        Mon, 26 Oct 2026 11:29:36 -0700 (PDT)
X-Received: by 2002:a05:7301:b0b:b0:365:921:8ce with SMTP id 5a478bee46e88-369e84e8888mr9413439eec.32.1793039376159;
        Mon, 26 Oct 2026 11:29:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm24657259eec.21.2026.10.26.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:29:35 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM ARCHITECTURE),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v2 6/6] ARM: dts: broadcom: Enable SATA on BCM958625HR
Date: Mon, 26 Oct 2026 11:28:56 -0700
Message-ID: <20261026182856.3168686-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
References: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Commit 77416ab35f57 ("ARM: dts: NSP: Disable AHCI controller for HR NSP
boards") disabled AHCI after reports of boot hangs. Both SATA PHYs
remain enabled, but the disabled controller leaves the eSATA ports
unavailable.

With explicit IDM clock/reset setup and the corrected shared PHY
register aperture in place, enable the controller on BCM958625HR.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm958625hr.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
index 53acae385822..f6717ca76aef 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
@@ -184,6 +184,7 @@ partition@700000 {
 
 &sata {
 	/delete-property/ dma-coherent;
+	status = "okay";
 };
 
 &sata_phy0 {
-- 
2.53.0

