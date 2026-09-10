Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC3485922
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2026 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042753; cv=none; b=pjqEiPo3R+8Fw310kgI2yvvvbIiHA4abCAw4urm349M+xCaxVCxqdBKPiHMQyBvgtZt16T00qu0xi7xgHbH+wIn5x0qUeA9bJ1vxpSPR1fWWI//MlzWoRhVgbQLGUmjMOP47VaLIHYDagiM0+c5LGMNrs7tzB0aLPShgvyzdg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042753; c=relaxed/simple;
	bh=7HlLsDy2wvAzXZ1vWfxwhV/7o0hNOcZ4+2e4m3lLhMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmP9bI1yikdkVH1pHwwA5iyRrWF01LpThLecVQTjbxPr4TRnDQFOO2ifhhl555/USt2ret297g95ItyyOZMi0xZNsRLClaOEhplj/Qc1ixHEITuXa7CKZi+UgevRG31srjJcREyXv5nVxSjoqqvhPBNrHVOFAuhYDOCAlvwcF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dku4+BoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dku4+BoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5684E1F000FF;
	Thu, 10 Sep 2026 12:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042751;
	bh=2NPk8Bc6uV6uQrplbJC0j2BRezCpHA2sFhDQmYVuZLE=;
	h=From:To:Cc:Subject:Date;
	b=dku4+BoUW+/hDlMBRsgoAHQrgHSV/tvtuZkREpIwVwSdhpiYNmehGjQRrYx92Egop
	 SjqYsrTc/TjqUTjDQ+p3hukaRLka0sgk7R40W21VyT22QoXO0B7BlzW56Ky42bVhQd
	 Fpaoo81Oyz/A2c7/Z5WK5LqImTNu11+/eo6H9u82+49f2wuMHiVwKeT34+GH90GKpJ
	 OB8qb30PmvBWsqNURe7tcFkMROpsm7kzfXq9YJpUd9Ix6PTIPToAiDa/LHbiZhwXbS
	 BkK2fPA4DLTnHAmZuIaWYLmVlVtG/YPBSZqosN3FNZnUKk/xtja86TWtnQWNCzil6d
	 SYBm61f9ROIkg==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Lee Jones <lee@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Jeff Garzik <jgarzik@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v3 0/3] ata: Do not release the host resources twice on probe() failure
Date: Thu, 10 Sep 2026 14:19:00 +0200
Message-ID: <20260910121900.97676-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571; i=cassel@kernel.org; h=from:subject; bh=7HlLsDy2wvAzXZ1vWfxwhV/7o0hNOcZ4+2e4m3lLhMM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWLTCR+X4ytOJURVPMEyEbO0bTitCswyufmKaE1Xulv n0ew1LVUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIk0T2f4Z/K8VqNt6bRb6qI+ H3bbSFpP3hGktdeV3aDsysz12hc+pDIynFYKXvHK5uObmiVHl66pFC7+4zupr+Mjm8xLdZvsfUt YWQA=
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

Patch 2 adds ata_host_undo_start(), which stops the ports and drops the
devres action without calling ->host_stop(), and calls it from both
activation helpers when they fail, so that "on failure, the caller
releases what it acquired" holds for all of them. sata_qstor and sata_fsl
are the only drivers which implement ->host_stop() while having no error
handling at all for the activate host call, so they get some.

Patch 1 has to come first: ahci_st is the only ahci-platform driver whose
->host_stop() does more than its probe() error path, as it also asserts
the "pwr-dwn" reset. Without patch 1, patch 2 would silently stop that
reset from being asserted when activating the host fails.

Patch 3 is an unrelated kdoc fix that I noticed while documenting the
above.

Changes since v2:
- Do not take the host teardown back in ata_pci_sff_activate_host(), and
  drop the sata_nv change which went with it. None of its callers
  releases the host resources itself: ata_piix, pata_rdc and
  ata_pci_init_one() all rely on ->host_stop() being called through
  devres, ata_pci_init_one() by releasing the devres group of the host.
- Document who releases the host resources on failure in the kdoc of
  ata_host_activate(), ata_host_register(), ata_pci_sff_activate_host(),
  ahci_host_activate() and ahci_platform_init_host().
- New patch 1, so that patch 2 does not stop ahci_st from asserting its
  "pwr-dwn" reset on probe() failure.
- New patch 3.

Niklas Cassel (3):
  ata: ahci_st: Assert the power down reset in the probe() error path
  ata: libata: Do not leave ata_host_stop() registered when activation
    fails
  ata: libata-core: Fix the ata_host_register() kdoc

 drivers/ata/ahci_st.c          | 51 ++++++++++++---------
 drivers/ata/libahci.c          | 17 ++++++-
 drivers/ata/libahci_platform.c |  4 ++
 drivers/ata/libata-core.c      | 81 ++++++++++++++++++++++++++++++----
 drivers/ata/libata-sff.c       |  5 +++
 drivers/ata/sata_fsl.c         |  8 +++-
 drivers/ata/sata_qstor.c       |  8 +++-
 include/linux/libata.h         |  1 +
 8 files changed, 139 insertions(+), 36 deletions(-)

-- 
2.55.0

