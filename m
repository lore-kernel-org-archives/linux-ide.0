From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v2 0/2]ata: Fix the dma state machine lockup for APM X-Gene SoC
Date: Mon, 16 Jun 2014 15:05:34 +0530
Message-ID: <1402911336-31788-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:44821 "EHLO
	denmail01.apm.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754788AbaFPJgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2014 05:36:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

Suman Tripathi (2):
  libahci: Implement the function ahci_restart_engine to restart the
    port dma engine.
  ata: Fix the dma state machine lockup for the IDENTIFY DEVICE PIO mode
    command.

 drivers/ata/ahci.h       |  4 ++++
 drivers/ata/ahci_xgene.c | 17 +++--------------
 drivers/ata/libahci.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 14 deletions(-)

--
1.8.2.1

