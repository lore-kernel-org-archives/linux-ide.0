Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178A15442C;
	Tue, 19 Aug 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611274; cv=none; b=tYWUmsfIze9hnLccgH2Q20uW0D+dZfMzyeqvd2fXyvuAKsduw6+Lfcs56A0ETBopGN/YGKKc44dW7YqTcacW8wAROUMuN4gFCxUx75mvuyf0Gsx34SCXH9MRBuIxAgh1+v3mmPKNVkHRTjWurmeAMKeaaen3beVQ+DpRu5eHI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611274; c=relaxed/simple;
	bh=7OErGkHrL5Gjjdrfh0ZS4BJc3dz5o2tElYf6eNQynrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qyjd3uNDifanmxj7/yYyK3Mvvv8ysXZ+wEs/q2W88P7NWrJWb3cfu/o9mCFWv4myDEMEyCqKCk8JEWgxc56eICMJ+VcEtotwwmUSD/hsWWWRL8qFEJOZyyMLrgFCKiZTmba1/sDdOrZ9w6yd5BU7UpglW1EUDgk4Xpu6q5tMKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006800LT.eswin.cn (unknown [10.12.96.77])
	by app1 (Coremail) with SMTP id TAJkCgDX+xFugKRoCa7AAA--.21178S2;
	Tue, 19 Aug 2025 21:47:28 +0800 (CST)
From: Yulin Lu <luyulin@eswincomputing.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	zhengyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com,
	lianghujun@eswincomputing.com,
	luyulin <luyulin@eswincomputing.com>
Subject: [PATCH v2 0/3] ESWIN EIC7700 sata phy driver and yaml,
Date: Tue, 19 Aug 2025 21:47:22 +0800
Message-Id: <20250819134722.220-1-luyulin@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDX+xFugKRoCa7AAA--.21178S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1UWr4DCrWDCF43ZF4kXrb_yoW5XFyDpa
	1kCF9IyrsYqryxX3Z7Ja10kFy3J3Z3GrWakrZrJw15Zw4Y934Fqw43t3Z0vFy2yw18XryY
	qFn0ga4akFyUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/

From: luyulin <luyulin@eswincomputing.com>

  Implements support for the Eswin EIC7700 SoC sata phy.
  Implements the calling sequence to interface with dwc-ahci,
  ensuring correct hardware execution order.
  Integration with the Linux phy subsystem for consistency and
  scalability.
  Add documentation for ahci and sata phy on the ESWIN EIC7700
  SoC platform.

  Supported chips:
    Eswin EIC7700 SoC.

  Test:
    Tested this patch on the Sifive HiFive Premier P550 (which uses
    the EIC7700 SoC). Based on this driver, the SATA device read/write
    operations are functioning normally, supporting SATA 1.5 Gb/s,
    3.0 Gb/s, and 6.0 Gb/s speeds, so this verifies that this sata
    driver patch is working properly.

  This series depends on the vendor prefix patch [1] and config option patch [2].
  [1] https://lore.kernel.org/all/20250616112316.3833343-4-pinkesh.vaghela@einfochips.com/
  [2] https://lore.kernel.org/all/20250616112316.3833343-3-pinkesh.vaghela@einfochips.com/

Updates:

  Changes since V1:
    - Delete the original controller driver and use ahci_dwc.c instead.
    - Add eswin,eic7700-ahci.yaml
      - Correct the descriptions of reset, interrupt and other
        hardware resources for the sata controller on EIC7700 SoC.
      - The clocks for both sata controller and sata PHY are controlled
        via a register bit in the HSP bus and are not registered in the
        clock tree. Clock are managed within the PHY driver, therefore
        it is not described in this document.
      - Add $ref: snps,dwc-ahci-common.yaml#.
    - Add eswin,eic7700-sata-phy.yaml
      - Add this file to include the description of the PHY on EIC7700 SoC.
    - Add an eswin directory under the PHY driver path, and include the SATA
      PHY driver code for EIC7700 SoC.
    - Link to v1: https://lore.kernel.org/all/20250515085114.1692-1-hehuan1@eswincomputing.com/

luyulin (3):
  dt-bindings: ata: eswin: Document for EIC7700 SoC ahci
  dt-bindings: phy: eswin: Document for EIC7700 SoC SATA
  phy: eswin: Create eswin directory and add EIC7700 SATA PHY driver

 .../bindings/ata/eswin,eic7700-ahci.yaml      |  92 ++++++++
 .../bindings/phy/eswin,eic7700-sata-phy.yaml  |  36 ++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/eswin/Kconfig                     |  14 ++
 drivers/phy/eswin/Makefile                    |   2 +
 drivers/phy/eswin/phy-eic7700-sata.c          | 197 ++++++++++++++++++
 7 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/eswin,eic7700-sata-phy.yaml
 create mode 100644 drivers/phy/eswin/Kconfig
 create mode 100644 drivers/phy/eswin/Makefile
 create mode 100644 drivers/phy/eswin/phy-eic7700-sata.c

-- 
2.25.1

