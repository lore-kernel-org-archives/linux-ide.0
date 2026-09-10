Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801C54489B
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2026 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060498; cv=none; b=l/7M96nzt0oM3GrmHuNfSRQt95DXtHkBPUr4UOd9xSPCD5k2qW/4e4KK7qIukHGEy+e+xcMUPuyOvQiDOdgCqaszCUMFVErEaApFJhH5lOBMo0hB7+GoP+ep1m+9a8RJXAm3pvk/atCLJpCQCUg43ffcDx6tDOlugKXvlTdUUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060498; c=relaxed/simple;
	bh=SnosydDSwmxL7sK+ulGyCtAug7hnbIi+5ML57Nugrhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4bCH5UsCipX1vT0SjFdTvp9/eBIZJ9NPl9qHKHZNuZmExmyTfm7qSWqumDyhTLKvrz5FMZk8zYmsIEyNrKVXCbrfhh12Pbq8k4lWXYfeUdEWpD6maIPfp0332nQUUPBDwSBtsncvqVJ/6elW1p1XjEBD/kSfkucjC1uWc8T+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzsokh0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzsokh0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B41F000FF;
	Thu, 10 Sep 2026 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060486;
	bh=b6cMTIVyWYSfqz7zZDXzFl6IUVvZPpU8dxAa/O++ohM=;
	h=From:To:Cc:Subject:Date;
	b=hzsokh0scgdT37E/ec0juI4GPxZVURS1bk987fZCTyd0KgbP1O5cGl207Uud1ECJH
	 EeaAdAfzNDd8bNiFvUPGkCs04bO7K3eg4g2zajeF5V05OgaALAMKHVTkvszrjklHHm
	 HyV/4N986BoQez5XAb+pgVSAJ44ubQY7eckGmhq3vo3eMQTk2Y1qIar89EigAzYGlj
	 meiLFxyOacBRpOy1GLM9yNwMQk9ULGjTLCvhqXWGRzhrLk2BouJP8PboUAzt7RXTKU
	 JN9kXaeczON3pJZ87D2C5FL5Ur98EptVGASCrQiktkthZI8rDfS0m867XeLU1os6ua
	 gV4DSROdeBR0Q==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Baokun Li <libaokun1@huawei.com>,
	Dan Williams <djbw@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Jeff Garzik <jgarzik@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v4 0/5] ata: Do not release the host resources twice on probe() failure
Date: Thu, 10 Sep 2026 19:14:06 +0200
Message-ID: <20260910171406.131211-7-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4020; i=cassel@kernel.org; h=from:subject; bh=SnosydDSwmxL7sK+ulGyCtAug7hnbIi+5ML57Nugrhs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWPY2r+jjR5tu33Xzz633Zq6tjQ/2On9SRsnp8/N/rs 8LeL+UsO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR4FxGhlN6q3xlsxP9Q2Rd NuoXvTve27d+4lJtYT8n7/7kaRv2nmdkuHxifbvn011HJgnYz+XScDx2sP8u0+KT2uar5oWKp3k v5gUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_host_start() registers ata_host_stop() as a devres action as soon as
it has succeeded:

	if (have_stop) {
		start_dr = devres_alloc(ata_host_stop, 0, GFP_KERNEL);
	...
	if (start_dr)
		devres_add(host->dev, start_dr);
	host->flags |= ATA_HOST_STARTED;

From that point on, releasing the host resources is owned by devres: when
probe() fails, the driver core calls devres_release_all(), which calls
ata_host_stop(), which calls ->port_stop() and ->host_stop().

ata_host_activate() and ahci_host_activate_multi_irqs() can however fail
after ata_host_start() has succeeded - devm_kasprintf(),
devm_request_irq() (a shared IRQ conflict) and ata_host_register()
(scsi_add_host(), ata_tport_add()) can all fail - and they return the
error with the devres action still registered. Since the caller cannot
tell whether ata_host_start() succeeded, and since it has to release the
resources for the failures happening before that, all the ahci-platform
drivers release the host resources in their probe() error path, e.g.
ahci_probe() calls ahci_platform_disable_resources() while
ahci_host_stop() does the same through devres.

The clocks, regulators, resets and PHYs of the host are therefore
released twice, which gives refcount underflow warnings from the clk,
regulator and phy cores and, for shared resources, can disable resources
which are still in use by other devices.

Patch 4 adds ata_host_undo_start(), which stops the ports and drops the
devres action without calling ->host_stop(), and calls it from both
activation helpers when they fail, so that "on failure, the caller
releases what it acquired" holds for all of them. sata_qstor and sata_fsl
are the only drivers which implement ->host_stop() while having no error
handling at all for the activate host call, so they get some.

Patches 1 to 3 have to come first, as they fix error paths which patch 4
would otherwise turn into resource leaks, and which are worth fixing on
their own:

- ahci_st is the only ahci-platform driver whose ->host_stop() does more
  than its probe() error path, as it also asserts the "pwr-dwn" reset
  (patch 1).
- sata_fsl releases hcr_base and host_priv in its probe() error path
  although sata_fsl_host_stop() does that as well, which is a
  use-after-free that the two device_create_file() calls after
  ata_host_activate() can trigger today (patch 2).
- ahci_host_activate_multi_irqs() never frees the IRQs which it
  requested when it fails, so the IRQ handlers stay registered while the
  caller releases the resources of the host (patch 3).

Patch 5 is an unrelated kdoc fix that I noticed while documenting the
above.

Changes since v3:
- New patch 2, which fixes the use-after-free of host_priv in the
  probe() error path of sata_fsl. Patch 4 would otherwise make sata_fsl
  leak hcr_base and host_priv when activating the host fails.
- New patch 3, which frees the IRQs requested by
  ahci_host_activate_multi_irqs() when it fails, like
  ata_host_activate() already does.
- Reword the "if failed, just free the IRQ and leave ports alone"
  comment in ata_host_activate(), as the ports are no longer left alone.

Niklas Cassel (5):
  ata: ahci_st: Assert the power down reset in the probe() error path
  ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
  ata: libahci: Free the IRQs when activating a multi-IRQ host fails
  ata: libata: Do not leave ata_host_stop() registered when activation
    fails
  ata: libata-core: Fix the ata_host_register() kdoc

 drivers/ata/ahci_st.c          | 51 ++++++++++++---------
 drivers/ata/libahci.c          | 28 +++++++++++-
 drivers/ata/libahci_platform.c |  4 ++
 drivers/ata/libata-core.c      | 81 ++++++++++++++++++++++++++++++----
 drivers/ata/libata-sff.c       |  5 +++
 drivers/ata/sata_fsl.c         | 24 +++++++---
 drivers/ata/sata_qstor.c       |  8 +++-
 include/linux/libata.h         |  1 +
 8 files changed, 161 insertions(+), 41 deletions(-)

-- 
2.55.0

