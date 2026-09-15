Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984847D926
	for <linux-ide@vger.kernel.org>; Tue, 15 Sep 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461731; cv=none; b=YVao1gUTsr0Bb3HTC897OJuxOWAnFJz8UtZVye7UETfl60Pps3K9YyM4pTZmL9t5u+lknUsmLY5i23dhLD5t9vB66OI/z81mq8RCXN4pc+FIinv406iuFCfq2oYRKgYGuzyxzUXlD5RNLsZqbKshjGpUwDPZkv5yno+II/ZMpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461731; c=relaxed/simple;
	bh=RJ7FOtw3WNj2xfrwTVSeuBJUjhKYQN7HgMoN3ZK9c3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RV+GsDBVodfpQ/kzHMDsTTORbszPnaLOlgp61qbdI7aad/Ku3Xahm8ZervyrSKbwa2Xz64fEOUX/pij2V5Ko/mtnNai2BMEvkc9b6vrIty3AMZxIN+79Gc8SO/IHJM91ZeTv0d3iT2AhohUk/g5Eb8YFgSSbVGnw2eGt7OuXNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzjqOWVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzjqOWVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7581F000FF;
	Tue, 15 Sep 2026 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461729;
	bh=QRNbibxywGtgwdSqTwR+dyJUSoGm1Uf4ktJLspis/FQ=;
	h=From:To:Cc:Subject:Date;
	b=FzjqOWVZAoWNT0lkbKT9jXqVf72r3e8so5HJPbl1vJmoCAEdt8x6kLUX/+nhd1d/V
	 nlVNFoBh0/Nr7wQiduNOErX2gRy6qBxQSZL1ldui12JWfj1uMJ57VcrGhrJGt6nbQE
	 crTIGXqkosfijlXos5mTpvMxk9N0a53KEOJa51ne3vnEKngBRiSXX6h2lCMqGzDLUF
	 Nu/wMf+qT8UAR4P6nQXiHNuz9YYstqTZOwdDgCqmZnYQPcMjqq0pBpBjNIRZFYOkNP
	 kp0DhfeQGte80PPXg/xpL5zNqJCfPj18vbO4wzUywUzCZGfLWZwapBf+ziehOTo591
	 W0nvL1H5ZqDyw==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Lee Jones <lee@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Baokun Li <libaokun1@huawei.com>,
	Dan Williams <djbw@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Jeff Garzik <jgarzik@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v5 0/6] ata: Do not release the host resources twice on probe() failure
Date: Tue, 15 Sep 2026 10:41:26 +0200
Message-ID: <20260915084127.692494-8-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4592; i=cassel@kernel.org; h=from:subject; bh=RJ7FOtw3WNj2xfrwTVSeuBJUjhKYQN7HgMoN3ZK9c3Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWsmzfcUXv+MrLU/5liEzI8o58P1WmuPnc8XehLuwxy iK/zlS86ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEXm5gZNh+NPpqZtXsjPvL 379Vn/e1S3B5YudZUx/HhpUzxJU+r5ZgZNjjeCJZtONkQ+6n+HN/bOK5kksMeDKvmX+pi70kPeP PTl4A
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

Patch 5 adds ata_host_undo_start(), which stops the ports and drops the
devres action without calling ->host_stop(), and calls it from both
activation helpers when they fail, so that "on failure, the caller
releases what it acquired" holds for all of them. sata_qstor and sata_fsl
are the only drivers which implement ->host_stop() while having no error
handling at all for the activate host call, so they get some.

Patches 2 to 4 have to come first, as they fix error paths which patch 5
builds upon, and which are worth fixing on their own:

- ahci_st is the only ahci-platform driver whose ->host_stop() does more
  than its probe() error path, as it also asserts the "pwr-dwn" reset,
  so patch 5 would stop that reset from being asserted (patch 2).
- sata_fsl releases hcr_base and host_priv in its probe() error path
  although sata_fsl_host_stop() does that as well, which is a
  use-after-free that the two device_create_file() calls after
  ata_host_activate() can trigger today (patch 3).
- ahci_host_activate_multi_irqs() never frees the IRQs which it
  requested when it fails, so the IRQ handlers stay registered while the
  caller releases the resources of the host (patch 4).

Patch 1 is an independent ahci_st fix, reported by Sashiko:
st_ahci_probe_resets() treats every error from devm_reset_control_get()
as "reset control not defined", including -EPROBE_DEFER, so probe()
continues with the SATA IP held in reset and powered down instead of
being deferred.

Patch 6 is an unrelated kdoc fix that I noticed while documenting the
above.

Changes since v4:
- New patch 1, which stops ahci_st from ignoring the errors returned
  when getting its reset controls, most notably -EPROBE_DEFER. The other
  patches are renumbered accordingly.
- Patch 3 no longer touches the ata_host_activate() error path, it only
  fixes the use-after-free which the two device_create_file() calls can
  trigger, so it no longer depends on the rest of the series. Checking
  the return value of ata_host_activate(), and releasing hcr_base and
  host_priv when activating the host fails, is now done by patch 5,
  where it can be done without leaking them.
- Drop the extern from the ata_host_undo_start() declaration in patch 5.

Niklas Cassel (6):
  ata: ahci_st: Do not ignore errors when getting the reset controls
  ata: ahci_st: Assert the power down reset in the probe() error path
  ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
  ata: libahci: Free the IRQs when activating a multi-IRQ host fails
  ata: libata: Do not leave ata_host_stop() registered when activation
    fails
  ata: libata-core: Fix the ata_host_register() kdoc

 drivers/ata/ahci_st.c          | 78 +++++++++++++++++---------------
 drivers/ata/libahci.c          | 28 +++++++++++-
 drivers/ata/libahci_platform.c |  4 ++
 drivers/ata/libata-core.c      | 81 ++++++++++++++++++++++++++++++----
 drivers/ata/libata-sff.c       |  5 +++
 drivers/ata/sata_fsl.c         | 24 +++++++---
 drivers/ata/sata_qstor.c       |  8 +++-
 include/linux/libata.h         |  1 +
 8 files changed, 173 insertions(+), 56 deletions(-)

-- 
2.55.0

