From: Tejun Heo <teheo@novell.com>
Subject: [PATCH #upstream-fixes] libata,pata_via: revert ata_wait_idle() removal
 from ata_sff/via_tf_load()
Date: Thu, 09 Sep 2010 17:13:31 +0200
Message-ID: <4C88F99B.9070408@novell.com>
References: <20100908182651.GA32114@seek.priv> <4C88F69E.6070000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55210 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab0IIPNf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2010 11:13:35 -0400
In-Reply-To: <4C88F69E.6070000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: gianluca <gianluca@sottospazio.it>, linux-ide@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, dieter@plaetinck.be, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <kernel@teksavvy.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Commit 978c0666 (libata: Remove excess delay in the tf_load path)
removed ata_wait_idle() from ata_sff_tf_load() and via_tf_load().
This caused obscure detection problems in sata_sil.

  https://bugzilla.kernel.org/show_bug.cgi?id=16606

The commit was pure performance optimization.  Revert it for now.

Reported-by: Dieter Plaetinck <dieter@plaetinck.be>
Reported-by: Jan Beulich <JBeulich@novell.com>
Bisected-by: gianluca <gianluca@sottospazio.it>
Cc: stable@kernel.org
---
Let's revert it until better solution is found.  Thanks.

 drivers/ata/libata-sff.c |    3 +++
 drivers/ata/pata_via.c   |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 030b1c4..f0531b0 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -418,6 +418,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		if (ioaddr->ctl_addr)
 			iowrite8(tf->ctl, ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
 	}

 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
@@ -453,6 +454,8 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->device, ioaddr->device_addr);
 		VPRINTK("device 0x%X\n", tf->device);
 	}
+
+	ata_wait_idle(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_tf_load);

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 5e65988..ac8d7d9 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -417,6 +417,8 @@ static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 			tf->lbam,
 			tf->lbah);
 	}
+
+	ata_wait_idle(ap);
 }

 static int via_port_start(struct ata_port *ap)
