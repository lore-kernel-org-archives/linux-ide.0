Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309145;
	b=sJVlB6UK5xDpiv6bqf/31edEOU1ipOmoKT6Sj/zI3jU7u7jY+GwBEZIkNzCBmwOp2DrN
	 NW5w4qdqIm1SbULoCQHUbhbgj5u/9tNAWW10jUv6ofhjhDdHZeVyOisLsLdlMrGLLURfj
	 gKO1RkcL6TIVdefnfFV+xuqBlJ4TaeEY30TUcrjjdlRJfLU2RX9lDW9H/jpjoze1f/3bz
	 8r8kOPsNin0VU/41wloRet8rQiWipQmmS5VVGtF6HvWbEmxvfwlhE/gSQsLscpQ85GJkz
	 s4tyOr9kb05CDd3dUDwH43yNbC7qQY0PJxSlyGKuYyePgpAF8aIGtaNt7wwcUrk9g1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309145;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
	b=nHOUeotA1eue5feDR7gUoKpzxM4BzXziWwSVTEbYPfAkixcfz9Q7QLUFkx/zGobXS5I9
	 gHZhGj/obe8rVjrIaSkwZWKQc2jWzWHTBz9jnU2mJ5SUW76wk7eRlzbfBGzfCzS3AjKm2
	 g62GcIAUmDdDhtlbpRqnntxt63lpAfhIZcoIit9y3m1cbM/gHWBmhbMRtDVMLeVEfKqT1
	 CDyc6ptqA1x+aHj6j4YVIU48EPIjrRq14guZSrL7RnGiyJgUGDFRD2bRWx6xHcaqBEP+g
	 ImPh51qQSBYBw/Gq+XxzI5TLNNtFfC6twm+NmgArx1jxNkjk9e7uMaXWMBq27k+BnCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Rs2bK4nk;
	arc=none smtp.remote-ip=74.125.82.97
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC3606A32E
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 21:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFBC3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Rs2bK4nk
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-1846bc43c28so43066c88.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309144; x=1793913944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
        b=GyivlIfS41qXraS6ek03j0ilfARk4lz9PpgdLAtPo+bsYYmK1+Ztm2K3W7Nn2ODK5O
         2iVumq7Kr7TlogkfsDpLwSivc3hpv6Y1Y+OAdStO3655AzrS19iAW98hDGdUxBcg/PPK
         IN5oFigpHCbRuvm1FnGZF89iq/F2ag24xF//CMqlSS4ZYdC0vbWxX0qAfHK54fMn1YMO
         OArxN2NJ31DZ8hQG9RG44T3hW+nF1MrvmNcMGAzzB03XaxsQabuIvzXM4TPDFH96NdII
         XXafA/A2loPHdMABa9L+mm2PYFzS6Nw1YeMCbW5eaBWbES392E7+UDgw5br1VDB5zTS0
         cVNQ==
X-Forwarded-Encrypted: i=1; AKwUvByNAbUgOCNNVQzii5NzVvKx9hJE/ujGlf/oF0C1uE2j4Teiz5AjqTm6OB7+D9Zu091PpIod/03/LlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBJsRgN4JagqmgZ/arncPiCICU0m86wnjtxwamUkjCc7Y/0WeH
	Jl8w2hxmlFtYuLjVH7OWLsGWB2KrlG95N0GaD0Pkneou0bx20ISmAvPWVizNdYkMEG6mM2zR022
	7GoovswNAvxRW+BQrdm9czPwUI3BDryg+jTMeLibZ3ZBYjA7yYeLRBylOoc/dP3keB5o7pXdqmh
	jdG1KIXfLlILGizFyjCTTq1kCC2RU9l70uWAmqjMNziPwbUpPZ8ksjW9iGKgudjb/6uPgStHev4
	hW9eg7NDwAR/B1HAUx9lkQ=
X-Gm-Gg: AYBFou3g7Vnel8YHPOX5vZeB5zt+77acIKxNH4NWWlllnaQ1KCF3eKO6lb3+ElE51Le
	sanNBqncd9wH5Sy43EZTD70mWdJbXPvUekuG2S9I3a7rZEEqpZw2q/LMCSvlzWHrPsaoZjgVGJ5
	ajDTOr+zS7cAtpPCdvSNTqmyv2T1naUFi7hjIbD65EARApaMEqRty4mGV4dxrgcVWa16PZoSxNg
	OPV1mhl5fHDZvldDLfvWndYCM3itecOTAsDkclIO7YazNOm+7vGkD+naE8OphX97OxxB60Lds/T
	Or3Bq4yOOEPVEhgBL1hJzRXE7Ix2Z4pJRAgeNMAvGigvcoO3lex9CikpxSN/yppaRA+F0MyxJDO
	9dJqeHTuoxletoj1wTQ77taKYHYGrLuFPdxQKKKMIZQ4gsHNHgqhkQWomIDUgtuaxDvXVA1mqvL
	He5K429L+gJlnBDoJuckHyu8BTxMHl39/Zp3zw9NgD
X-Received: by 2002:a05:701b:4211:10b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1ac5de4e8a1mr340169c88.27.1793309142786;
        Thu, 29 Oct 2026 14:25:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1ac17e90c4csm11054c88.4.2026.10.29.14.25.42
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:25:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5339739b343so56030991cf.2
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309141; x=1793913941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/JejeyXs+a2BV9S3GP+DdWRq7anNloDPZ8ebf8LoQg=;
        b=Rs2bK4nkBOivnc52MHFqCl1oW9Lha/BFHMGDBU/VMkaLsFOcAS5QQzdQwc4x/CTH9D
         upkYTM+uNILLD+eGTWWMIm0I1s/60qZ538/h1SE5TxsKbE7G4PftioJKnsEXnd3Ctl/G
         ZcV6iLeiYXWdGpYBAWrKbMTsiH/V42F+C6PHU=
X-Forwarded-Encrypted: i=1; AKwUvByeAk4wJebdbm9ngAi96FeObK1KAEOVaQzh8Q41rvPrnhfz53lkfi2tdJ9DcV8vQtkEVLQh0h+V7vc=@vger.kernel.org
X-Received: by 2002:ac8:5dd1:0:b0:536:7cc1:4b6b with SMTP id d75a77b69052e-542b6d60c04mr5567321cf.27.1793309141412;
        Thu, 29 Oct 2026 14:25:41 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:536:7cc1:4b6b with SMTP id d75a77b69052e-542b6d60c04mr5566901cf.27.1793309140847;
        Thu, 29 Oct 2026 14:25:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314fb6csm6384936d6.34.2026.10.29.14.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:40 -0700 (PDT)
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
Subject: [PATCH v4 6/6] ARM: dts: broadcom: Enable SATA on BCM958625HR
Date: Thu, 29 Oct 2026 14:25:13 -0700
Message-ID: <20261029212513.4126083-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
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

