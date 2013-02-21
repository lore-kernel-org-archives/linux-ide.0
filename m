From: Rado Vrbovsky <rvrbovsk@redhat.com>
Subject: Re: [PATCH] ata_piix: Add MODULE_PARM_DESC to prefer_ms_hyperv
Date: Thu, 21 Feb 2013 14:01:50 -0500 (EST)
Message-ID: <774443881.7195405.1361473310424.JavaMail.root@redhat.com>
References: <51266C7F.8040904@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47592 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab3BUTBv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2013 14:01:51 -0500
In-Reply-To: <51266C7F.8040904@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff <jgarzik@redhat.com>

From: Andrew Brownfield <abrownfi@redhat.com>

In reference to the commit cd006086fa5d91414d8ff9ff2b78fbb593878e3c 
"ata_piix: defer disks to the Hyper-V drivers by default",
this trivial patch adds a description to prefer_ms_hyperv.

[rvrbovsk@redhat.com: MODULE_PARM_DESC() string formatting modified]

Signed-off-by: Andrew Brownfield <abrownfi@redhat.com>
Signed-off-by: Radomir Vrbovsky <rvrbovsk@redhat.com>

---
 drivers/ata/ata_piix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 174eca6..b9bf99a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1530,6 +1530,10 @@ static bool piix_broken_system_poweroff(struct pci_dev *pdev)
 
 static int prefer_ms_hyperv = 1;
 module_param(prefer_ms_hyperv, int, 0); 
+MODULE_PARM_DESC(prefer_ms_hyperv,
+       "Prefer Hyper-V paravirtualization drivers instead of ATA, "
+       "0 - Use ATA drivers, "
+       "1 (Default) - Use the paravirtualization drivers.");
 
 static void piix_ignore_devices_quirk(struct ata_host *host)
 {
-- 
1.7.11.7
