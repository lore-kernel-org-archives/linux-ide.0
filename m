Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380C715E5DC;
	Mon, 15 Sep 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944312; cv=none; b=eW5gLG2uycc7tRBr51iVqeWCN0lXiJJfOdq6ZeOwyvxhn46uZhxu3uzlezj8+duHX9DESzwiHhZANlkOa3q+LWc0Qq0dLXdJuFAIux22DrLasUP7/e75Z8OEMzNuHOzaZizJD8QyWEB/l2YMSxoIQmQBsGXSQLm++lPckAPnjNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944312; c=relaxed/simple;
	bh=4VkDJOiB0y7OLO69mz485c1iz/UZXU1pQ2zaSsoHrEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GUPvLu+bRUlHRuhUUdhLRfDFHqo1Gs/rCgVJ8yYI3gYpUyZ/VbKrBOZMKr4yodqqmcn66r5b9GcsNVBwot994hoHcc8M7tfQhke+dDi4zqXm5V48NGf70DVSn2KfO5/tXPoI0wajW0f7s2xQAyY2qoGj2CcZLTKClV2V4l/YzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006800LT.eswin.cn (unknown [10.12.96.77])
	by app1 (Coremail) with SMTP id TAJkCgC3zg_qGchovXXRAA--.27513S2;
	Mon, 15 Sep 2025 21:51:40 +0800 (CST)
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
	Yulin Lu <luyulin@eswincomputing.com>
Subject: [PATCH v4 0/3] Add driver support for Eswin EIC7700 SoC SATA Controller and PHY
Date: Mon, 15 Sep 2025 21:51:38 +0800
Message-Id: <20250915135138.877-1-luyulin@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgC3zg_qGchovXXRAA--.27513S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4DtF1ktFWfWryxCrykZrb_yoWrKw15pa
	1kCry7Jrn5tryxta97J3WI9a4fZan7GF43urs3Jw1UZ3y3XFyvv39ak3WYvFykCw4kKryY
	qF4agFy5CFyUAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRJrcTUUUUU
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/

This series depends on the config option patch [1].

[1] https://lore.kernel.org/all/20250825132427.1618089-3-pinkesh.vaghela@einfochips.com/

Updates:
  v4 (resend):
    - Fix patch 1/3 subject prefix: add missing "dt-bindings: ata:"

  v4 -> v3:
    - eswin,eic7700-ahci.yaml
      - Fix grammatical errors in patch subject and commit message
      - Add an explanation in the commit message of patch 1 for retaining the
        "ports-implemented" field, which Rob Herring suggested to remove
        in the review comments on v2.
        Link to Rob Herring's review:
        https://lore.kernel.org/lkml/CAL_JsqKFotNLZZXwiy7S6K8qXLdGRAnsa-1zvZRDQBE39Gf5kg@mail.gmail.com/
        Link to my question and Niklas Cassel's reply:
        https://lore.kernel.org/lkml/aLBUC116MdJqDGIJ@flawful.org/
        In this reply, Niklas Cassel mentioned his view:
        If the ports-implemented register gets reset from
        ahci_platform_assert_rsts(), then it seems acceptable to
        retain the ports-implemented property in the device tree.
        This aligns with our design.
        Link to my reply:
        https://lore.kernel.org/lkml/4ab70c6a.8be.198f47da494.Coremail.luyulin@eswincomputing.com/
        Link to Niklas Cassel's question and my further explanation:
        https://lore.kernel.org/lkml/aLlYkZWBaI5Yz6fo@ryzen/
        https://lore.kernel.org/lkml/7206383a.d98.19918c22570.Coremail.luyulin@eswincomputing.com/
    - eswin,eic7700-sata-phy.yaml
      - Fix grammatical errors in patch subject and commit message
      - Adjust the position of reg in the properties and required arrays
      - Add reviewed-by tag of Krzysztof Kozlowski
    - phy-eic7700-sata.c
      - Correct the loop condition in wait_for_phy_ready() to use the current
        jiffies instead of the fixed start time
      - Change the return value from -EFAULT to -ETIMEDOUT to correctly
        indicate a timeout condition
      - Remove redundant clock disable handling in probe error path, as
        SATA_SYS_CLK_EN is managed in phy_init() and phy_exit()
      - Use dev_err_probe return in probe
      - Reorder local variables to follow reverse Xmas tree order
      - Wrap each line in the extended comments to 80 columns before splitting lines
      - Adjust the position of `#include <linux/io.h>` for proper ordering
    - Link to v3: https://lore.kernel.org/lkml/20250904063427.1954-1-luyulin@eswincomputing.com/

  v2 -> v3:
    - Use full name in "From" and "Signed-off-by" fields information
    - eswin,eic7700-ahci.yaml
      - Remove the introduction to the reg, interrupts, phys, and phy-names fields
      - Modify the usage of the clocks field in the examples
      - Correct the order of dt properties
    - phy-eic7700-sata.c
      - Register operations use the GENMASK macro and FIELD_PREP instead of
        the original bit offset method, and add "#include <linux/bitfield.h>"
      - Modify some macro definition names.
      - Remove the redundant initialization assignments for "ret" and "val"
      - Delete ".suppress_bind_attrs = true"
      - Modify the driver name
      - Add "#include <linux/io.h>" to fix the robot test issue
    - Link to v2: https://lore.kernel.org/lkml/20250819134722.220-1-luyulin@eswincomputing.com/

  v2 -> v1:
    - Delete the original controller driver and use ahci_dwc.c instead
    - Add eswin,eic7700-ahci.yaml
      - Correct the descriptions of reset, interrupt and other
        hardware resources for the sata controller on EIC7700 SoC
      - The clocks for both sata controller and sata PHY are controlled
        via a register bit in the HSP bus and are not registered in the
        clock tree. Clock are managed within the PHY driver, therefore
        it is not described in this document
      - Add $ref: snps,dwc-ahci-common.yaml#.
    - Add eswin,eic7700-sata-phy.yaml
      - Add this file to include the description of the PHY on EIC7700 SoC
    - Add an eswin directory under the PHY driver path, and include the SATA
      PHY driver code for EIC7700 SoC
    - Link to v1: https://lore.kernel.org/all/20250515085114.1692-1-hehuan1@eswincomputing.com/

Yulin Lu (3):
  dt-bindings: ata: eswin: Document for EIC7700 SoC ahci
  dt-bindings: phy: eswin: Document the EIC7700 SoC SATA PHY
  phy: eswin: Create eswin directory and add EIC7700 SATA PHY driver

 .../bindings/ata/eswin,eic7700-ahci.yaml      |  79 +++++++
 .../bindings/phy/eswin,eic7700-sata-phy.yaml  |  36 ++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/eswin/Kconfig                     |  14 ++
 drivers/phy/eswin/Makefile                    |   2 +
 drivers/phy/eswin/phy-eic7700-sata.c          | 192 ++++++++++++++++++
 7 files changed, 325 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/eswin,eic7700-sata-phy.yaml
 create mode 100644 drivers/phy/eswin/Kconfig
 create mode 100644 drivers/phy/eswin/Makefile
 create mode 100644 drivers/phy/eswin/phy-eic7700-sata.c

-- 
2.25.1

