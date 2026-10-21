Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.166.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601765;
	b=iroBANMkUjqV9T0Xg0rtoZdNFpdbtUrPV2Y/vZ1OPOFrwpgFE0J+YIdopYgMuWtq6C/V
	 7s1wt/7TM6rmDDPj0KvRfMi26+ltzG1q/NpPjCpcQn9/Z0OcAHcz56EMy9lzXiAbeYFwM
	 wYj+7TOvYcll9drAcTmiHHln/VsIVf4+WlSc9jqKtls6WTmjPb17gilCTIP5o8JGqXW8Z
	 3JX4a+9PmHdWNVG8hxXng98m3rXMazfDzt6Vi7Wpa68SX3XrK6bUGdVwYN47zlCxoFEVj
	 kf83kjcHLiUg7InTUkRSyHxBo06+TSRiwqXSGtvANvRWsNtIOQAY/a0s8Z/ZuNe34wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601765;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vCYl/cG9mX38DVQ9PrBsJRE3D7JHxtZQpczintLIVfc=;
	b=GqEs9nSXpqTQGhyEcXcsVK5eJO08fhBNkLbrsL9fAv8kFih64GZBEb9iA+gDOxzvoDZU
	 iIPx+CV26NOmCL5YyXCU+6b6wZCrNQIhKyXoEL0G4Q+c49TNwcPe0/uFwdW4K9NFmK8os
	 L0Z/F569KyT7DrTcuSbLvahmmvilBU7b07HJ69gkryoaXtk6M0Dt9BwSRct3iyWSM5NZi
	 hmQSLBrkai+4o4NJFpFk0t2QK2yyEgs5M+5CcjACJxokg9gU0gEkbcqt9aeMqfMwrZo20
	 IBQ+V80qxH1qh0BJI2oOoQ0EbNZajLFzjc8ThDwT4o64ZHU2X3C8BUqba2DzxMelssA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=UJMM4Kzc;
	arc=none smtp.remote-ip=192.19.166.228
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDE606A31A;
	Wed, 21 Oct 2026 16:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8BDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=UJMM4Kzc
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5EDCCC0000E4;
	Wed, 21 Oct 2026 09:55:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5EDCCC0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792601758;
	bh=AjIbc+URFeF2b/ujubFUnYivbl6fayG3tnEmJ0uSfys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJMM4KzcKDBfnLZzk6Kii5ri3Pfnz4lE2ofyzcP4XPweStUUapd76sDXDhgzpflJZ
	 q+/tJPCD+tLF/afHDtl1ExCi86DUgn/odnIi+0tVCOj5R5T8tCoqjrO6wFDJlxiXC+
	 uWq/SJOFmtqdK5jsRkSReempvrlOIdlAGVn9q8Ek=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 2DCE4A8A;
	Wed, 21 Oct 2026 09:55:58 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
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
	linux-kernel@vger.kernel.org (open list),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH 5/6] ARM: dts: broadcom: Enable SATA on BCM958625HR
Date: Wed, 21 Oct 2026 09:55:52 -0700
Message-ID: <20261021165555.652102-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021165555.652102-1-florian.fainelli@broadcom.com>
References: <20261021165555.652102-1-florian.fainelli@broadcom.com>
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

Commit 77416ab35f57 ("ARM: dts: NSP: Disable AHCI controller for HR NSP
boards") disabled AHCI after reports of boot hangs. Both SATA PHYs
remain enabled, but the disabled controller leaves the eSATA ports
unavailable.

With explicit IDM clock/reset setup and the corrected shared PHY
register aperture in place, enable the controller on BCM958625HR.

This enablement has been build and schema checked. Cold-boot and eSATA
I/O validation on HR hardware are still required to establish whether
the original hang is resolved.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm958625hr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm958625hr.dts b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
index a9b6aa04d573..3e86f3c2593a 100644
--- a/arch/arm/boot/dts/broadcom/bcm958625hr.dts
+++ b/arch/arm/boot/dts/broadcom/bcm958625hr.dts
@@ -182,6 +182,10 @@ partition@700000 {
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 &sata_phy0 {
 	status = "okay";
 };
-- 
2.53.0

