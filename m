Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309137;
	b=bwPxWBNQ54m6SZ1q6XruWjtRwhLZVR75sfkW5Om8OoaBi4C3rX1lPLr5/LJu/VCxbl6u
	 KAW2Rps37pl/sLY1l9z9dAHX3+uNW1E+JHYSkCDaIyhfHblaK20GwqZAizfE3bsYBc3O2
	 vCwIhwZfmk6URq7x2RC7C1vSPZozJ9hRZdxqLaWkQWcwBrrkSHw8mxwgxzrM339Jb8QyS
	 GbFK40LShkcGWvj9LIOnM6xq2FIX5f5nF9qGITuQ9GtXwAX4kE915Lc/pipk62ih/7AvB
	 Rk2YORIC3FjvhhSnFZ9M2hIwlhFbCwN7IfxvmOUfRBeeXNHP8Pwqq8Z6o3Hls3Uybpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309137;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
	b=ZGeLMEp9R+pZ1zRx8M+eZA3m4VggRdYYRK0ViayiDUSKi79VGImGKi5pLEThCuuBWdJi
	 D0s4XQU9En0StGkdlaV5h3vn/hLhp4ycsdfaULF7O+ufEu+AcoVh6rrLRvjByvCOajIJV
	 PZkTNhqlpvBNjP9BUGCeJFyy1T+aUJxODUBs7H8FkTe6H4vLh0PHDjyougmtJR8BJX3Ge
	 1ShxMqqAf/ivoTJ3xc90V50j7XPredOecZ9K697LylXDHjPWPdrmbzJ0984WLi7jPZHax
	 iAK694fDe05NwBSJcoLhIwHvAskvPiJLErkjHRK5SEE8goCPEIp0tx4/WhQMlM6CC2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bFHPBXlr;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E1606A33D
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 21:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1E1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bFHPBXlr
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so36387a91.3
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309137; x=1793913937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
        b=zXAxV3ICnC2kO+Y3AZF9eJRu+QOc3MgVbn5aLpCxoChxF52ANt36sHECrr4ZhdPcP8
         /2l3fJ4GkEkhmqoYfHNVR8i4bUw/yHkrx20A9OxvQHX9qE5mYkpDjDtunQJXI0AxcR+7
         fgEDc62ub5xQyl1sosSZwMFbqZW9qcdYBa3nQvDJ32XiMLmItAFASBqgYOIayLLhK6x8
         IY7OhbPlR4rrLGEu8VQRWzrn8tUdCbR5XgnpSrB5XaYl5ASeqdoTlUEnGDC+s0A8QbtK
         VcyyDujvO0nNsfD+Aa5qbCXqDv6pJjKUeuoS5j5gfmC2MlEqpmWSQomaJvS2EfZ/C2t3
         fJaQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7b1xiDhfDSAveZdqe3NdkWtBb4PZSUA01i6fm6d06/HHlTjWm9Q65JYn/aalNNSVALn7GzQ1NXN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsf2jltg/A+EzV1/xnW+tOwUL2/2dwbNfYigNycYn7e9c9RJ0x
	6qMWmXb7Qp4ulTJFdMeowLSNg7rNNGSWUMlgpYER731a0H64HsdwemY6+DHJhNLkKQFyXu4q/y2
	g8J1EfeVaHEKq0wAydsx0f0IQwuV/xLTGzuJJ5nGANC51EoUwbG8h16voZD+MWp4a6V93YlRsbM
	2FEqYA9J51vGV6vhM6JBiQ9mELcz0qI+rr3nbRUeHMYT3CCyk0OybgwdGUdQKDXQK9I1ZDeL84R
	fPIWOG9aOflzPmgpOFGRvs=
X-Gm-Gg: AYBFou3qQwoDRFLX8GZczQuugrJbSQthqwKkS4lGbDRUdO2x58ylVJbFteWzmWv8mIp
	vt+j7vPF6tejQyjdymrduKmqFoSh2vrsGwyoy1GOIHCPerWMia91yOMvBNdq5nLh3Ic0JS5VYdw
	DYd4h3Y1K4FwHZE50D5HoLRADn+taB5xBntB/nWIDycvYlhs+w+FCvwZwGgoD4ehY9/BuF6CmHP
	+oFl2QDzVZsOCIZd73qX1wO0KGucdh7nymSK9YY7wpCUgUtkzi+j48No5aqfs4qWwzgIDiE+6fW
	PxVwGrQLINpe16Fpnz7jhhNzwVYyVymVnYdUUrLeVyxcGMBYenfoC3ynHnMJ2PjHo9+JG04xyw4
	CNAvWnEvFjjvqVX+z4mBZn5rso2KqZbK/2Z16C1xkcOKvYKYdEMzvCqlpDr4ObPy/ck7ZTvnpia
	7BNNtye+DOmjruT6/Q368baxgBtz+op/tzwzO6+0aV
X-Received: by 2002:a17:90b:2ccf:b0:3a7:9adb:2a18 with SMTP id 98e67ed59e1d1-3ae8984df8emr176122a91.62.1793309136590;
        Thu, 29 Oct 2026 14:25:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae8444ce5esm627362a91.2.2026.10.29.14.25.36
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:25:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f559420f3so235673085a.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309135; x=1793913935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1MIbl2zx8FaPW7oX7ST7fbgJ9gFOgJZeuRxXV0E1qzg=;
        b=bFHPBXlrCZqeSrza6y9QN/PCksgH3GlMFsd0qYxVx2yWQRFasH6roXUKzbyfRvd8ah
         97E3wRJmHt+zcAoPnSwWQ8Z+AuXDKYp4rNmCwOwkgVI4Rc5ts2zKtGASHV3zriPn7bJ3
         UW2fT8u5h/SXTFZUAUnGfmLt+WbqWsgLa6eOQ=
X-Forwarded-Encrypted: i=1; AKwUvBzArRXs3E9qvfNay4Zygzeo+BEtxNu3prmjptynfWxQ5JRSSrW+RKRM0MYt1DbgSuuK/vP2KzIR2SQ=@vger.kernel.org
X-Received: by 2002:a05:620a:8385:b0:93e:48fc:aa88 with SMTP id af79cd13be357-944217118e3mr84084385a.44.1793309135501;
        Thu, 29 Oct 2026 14:25:35 -0700 (PDT)
X-Received: by 2002:a05:620a:8385:b0:93e:48fc:aa88 with SMTP id af79cd13be357-944217118e3mr84081485a.44.1793309134993;
        Thu, 29 Oct 2026 14:25:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314fb6csm6384936d6.34.2026.10.29.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:34 -0700 (PDT)
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
Subject: [PATCH v4 4/6] ARM: dts: broadcom: Add the NSP SATA IDM registers
Date: Thu, 29 Oct 2026 14:25:11 -0700
Message-ID: <20261029212513.4126083-5-florian.fainelli@broadcom.com>
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

The NSP SATA description omits the IDM block at 0x1811e000, leaving the
interface clock and core reset dependent on firmware initialization.

Supply the IDM as the third controller register region so ahci_brcm can
perform the downstream clock/reset sequence. Extend the AXI bus range to
cover the complete IDM aperture.

Fixes: 8dbcad020f2e ("ARM: dts: nsp: Add sata device tree entry")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi b/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
index 6a4482c93167..9dbcd810e27b 100644
--- a/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm-nsp.dtsi
@@ -168,7 +168,7 @@ periph_clk: periph_clk {
 
 	axi: axi@18000000 {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0x18000000 0x0011c40c>;
+		ranges = <0x00000000 0x18000000 0x0011f000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -538,8 +538,9 @@ sata_phy1: sata-phy@1 {
 
 		sata: sata@41000 {
 			compatible = "brcm,bcm-nsp-ahci";
-			reg-names = "ahci", "top-ctrl";
-			reg = <0x41000 0x1000>, <0x40020 0x1c>;
+			reg-names = "ahci", "top-ctrl", "idm";
+			reg = <0x41000 0x1000>, <0x40020 0x1c>,
+			      <0x11e000 0x1000>;
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.53.0

