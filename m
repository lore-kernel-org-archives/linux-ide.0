From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v1 0/2] Add the PMP support for APM X-Gene SoC AHCI SATA Host Controller driver.
Date: Tue,  6 Jan 2015 15:32:14 +0530
Message-ID: <1420538536-32165-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:48837 "EHLO
	denmail01.apm.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752753AbbAFKDH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2015 05:03:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch set implements the PMP support for APM X-Gene SoC AHCI SATA Host Controller driver.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (2):
  ahci_xgene: Implement the xgene_ahci_poll_reg_val to support PMP.
  ahci_xgene: Implement the workaround to support PMP enumeration and
    discovery.

 drivers/ata/ahci_xgene.c | 189 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 7 deletions(-)

--
1.8.2.1

