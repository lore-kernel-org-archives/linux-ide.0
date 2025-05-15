Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596E1F428C;
	Thu, 15 May 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299113; cv=none; b=g25EA8+3RfVjv0eJSIq010FuzIqfqUGDaZVnjDN0mrzwuk8hNRmtXZljqNK5zbKKBy2HcHKZbbVuFdLkaEs86C1RDjAldkaNeAcKO8k2mrK/l8ruuPUk5zZ9dfG29IKgi0Co9veXC7LSJy9IiOh4TcvnwHGVKiRDraewdoE91Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299113; c=relaxed/simple;
	bh=SeDdOef3yDkOgcGIcb3LONYBgYdCqryApP+EmNYzoxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBgACT1Yg4ey++H2tsj8khaKiIFaNWcZngaLBAzEMzAuKzoGAHBByHdFZUNjnu9AEVAZ1yzCnvdoUE0/ClWwsqLDtkCUNaUIJHvkmVSnpQS8Ky9LSa/oE29wAZWIPHAlJj6pwBzmFiA8UjoC9IpT/F7yhhUBAJjE9pV22S//MtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app2 (Coremail) with SMTP id TQJkCgAnuZINqyVotTx8AA--.47783S2;
	Thu, 15 May 2025 16:51:29 +0800 (CST)
From: hehuan1@eswincomputing.com
To: dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	luyulin@eswincomputing.com,
	Huan He <hehuan1@eswincomputing.com>
Subject: [PATCH v1 0/2] ESWIN EIC7700 sata driver
Date: Thu, 15 May 2025 16:51:14 +0800
Message-ID: <20250515085114.1692-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAnuZINqyVotTx8AA--.47783S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF47Wr1fJF1xZF4rurW3KFg_yoWkXwc_Cr
	yxZayDG345uFZ0y3WjyrZ7uFyYka1rAF92vF4UtFn8Kryvq3y3JFyqyasrZFn7tFWrXr9x
	CrnYyr1rCFy3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbhxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

  Implements support for the Eswin eic7700 SoC sata controller.
  Provides basic functionality to initialize and manage the sata
  controller  for the eic7700 SoC. Integrates with the Linux AHCI subsystem
  for standardized SATA host control and scalability.

  Supported chips:
    Eswin eic7700 SoC.

  Test:
    I tested this patch on the Sifive HiFive Premier P550 (which uses the EIC7700 SoC),
    Ensure the hard drive is properly connected via the SATA interface on the hardware,
    and confirm that the SATA controller within the chip can read/write to the hard drive
    normally. The SATA driver patch is working properly.

Huan He (2):
  dt-bindings: sata: eswin: Document for EIC7700 SoC
  sata: eswin: Add eic7700 sata driver

 .../bindings/ata/eswin,eic7700-sata.yaml      |  80 ++++++
 drivers/ata/Kconfig                           |  12 +
 drivers/ata/Makefile                          |   1 +
 drivers/ata/ahci_eic7700.c                    | 248 ++++++++++++++++++
 4 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml
 create mode 100644 drivers/ata/ahci_eic7700.c

-- 
2.25.1

