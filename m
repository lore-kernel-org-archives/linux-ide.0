Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4B45C70A
	for <linux-ide@vger.kernel.org>; Fri, 16 Oct 2026 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141035; cv=none; b=WtDKvt3SUQ27dzx9g7U+eqQjHB4ZfxJdyQIMcwBozNDeLNO0n0eAgCWrMk9iEBqe2E1Hj0mrjoW1/H0P8woFyFZJT+daDeB4dZLx8gJ7LCEQnmTjRwOMOzNVcYZf+636eErqomK4ddIJqpsxLwz6FzJlghyf1h1ZyNzgp2CABEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141035; c=relaxed/simple;
	bh=Jzh1968SQqZrKuqZBSdYez3bf0YmjMc4dZ3T3SOd6CA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IPUVd12ZL5PaysohHZ1BWSPdrY0M/7gIMeXT/bCJrK02S68JKMIai2LOKh2eplwfRHiGzbPFp/dR1dFt7kJcbdWjNOdM3Wpe8dtDLWXIU+9JPqyo4sR4w2pdy9sU32ziJdteDKSECrlqURIznjpK2FSjGW4WwINdzk4unm4eA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j5dm705w0zLlX2;
	Fri, 16 Oct 2026 16:44:39 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FE764057C;
	Fri, 16 Oct 2026 16:56:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 16 Oct 2026 16:56:58 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
CC: <yangxingui@h-partners.com>, <huangjunxian6@hisilicon.com>,
	<linuxarm@huawei.com>
Subject: [PATCH] ata: libata: Add debug dump around error handling and link resets
Date: Fri, 16 Oct 2026 16:56:57 +0800
Message-ID: <20261016085657.3703353-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Add a generic debug_dump() operation to struct ata_port_operations
so LLDDs can dump their own controller debug state around error
handling.

For the standard AHCI driver, implement this hook to dump the AHCI
controller registers through tracepoints:

  ahci_global_softreset_start / _done   - HBA global registers
  ahci_global_hardreset_start / _done
  ahci_global_eh_start / _done
  ahci_port_softreset_start / _done     - port registers
  ahci_port_hardreset_start / _done
  ahci_port_eh_start / _done

These tracepoints help debug error and link reset issues.

Example usage:

  $ echo 1 > /sys/kernel/tracing/events/libahci/ahci_global_eh_start/enable
  $ echo 1 > /sys/kernel/tracing/events/libahci/ahci_port_eh_start/enable
  ... trigger an error ...
  $ cat /sys/kernel/tracing/trace
  scsi_eh_4-899 [024] 717.683782: ahci_global_eh_start: ata_port=5 \
    global={0xef377fe1,...}
  scsi_eh_4-899 [024] 717.683808: ahci_port_eh_start: ata_port=5 \
    port={0xfffc0000,...}

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/ata/libahci.c          |  57 +++++++++++++++++
 drivers/ata/libata-eh.c        |   6 ++
 include/linux/libata.h         |   6 ++
 include/trace/events/libahci.h | 114 +++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 include/trace/events/libahci.h

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 08ab56e95566..4e1a327d8e68 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -30,6 +30,10 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/libahci.h>
+
 #include "ahci.h"
 #include "libata.h"
 
@@ -50,6 +54,7 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 			      size_t size);
 static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 					ssize_t size);
+static void ahci_debug_dump(struct ata_port *ap, enum ata_eh_dump phase);
 
 
 
@@ -168,6 +173,7 @@ struct ata_port_operations ahci_ops = {
 	.reset.postreset	= ahci_postreset,
 	.pmp_reset.softreset	= ahci_softreset,
 	.error_handler		= ahci_error_handler,
+	.debug_dump		= ahci_debug_dump,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 	.dev_config		= ahci_dev_config,
 
@@ -1457,6 +1463,49 @@ static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 	return 0;
 }
 
+#define AHCI_DUMP_FN(site)					\
+static void ahci_dump_##site(struct ata_link *link)		\
+{								\
+	struct ahci_host_priv *hpriv = link->ap->host->private_data; \
+	void __iomem *port_mmio = ahci_port_base(link->ap);	\
+	int i;							\
+								\
+	if (trace_ahci_global_##site##_enabled()) {		\
+		u32 global_regs[AHCI_TRACE_GLOBAL_REGS];	\
+								\
+		for (i = 0; i < AHCI_TRACE_GLOBAL_REGS; i++)	\
+			global_regs[i] = readl(hpriv->mmio + i * 4); \
+								\
+		trace_ahci_global_##site(link, global_regs);	\
+	}							\
+								\
+	if (trace_ahci_port_##site##_enabled()) {		\
+		u32 port_regs[AHCI_TRACE_PORT_REGS];		\
+								\
+		for (i = 0; i < AHCI_TRACE_PORT_REGS; i++)	\
+			port_regs[i] = readl(port_mmio + i * 4); \
+								\
+		trace_ahci_port_##site(link, port_regs);	\
+	}							\
+}
+
+AHCI_DUMP_FN(softreset_start)
+AHCI_DUMP_FN(softreset_done)
+AHCI_DUMP_FN(hardreset_start)
+AHCI_DUMP_FN(hardreset_done)
+AHCI_DUMP_FN(eh_start)
+AHCI_DUMP_FN(eh_done)
+#undef AHCI_DUMP_FN
+
+static void ahci_debug_dump(struct ata_port *ap,
+			      enum ata_eh_dump phase)
+{
+	if (phase == ATA_EH_DUMP_ENTER)
+		ahci_dump_eh_start(&ap->link);
+	else
+		ahci_dump_eh_done(&ap->link);
+}
+
 int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 		      int pmp, unsigned long deadline,
 		      int (*check_ready)(struct ata_link *link))
@@ -1471,6 +1520,8 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	bool fbs_disabled = false;
 	int rc;
 
+	ahci_dump_softreset_start(link);
+
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_kick_engine(ap);
 	if (rc && rc != -EOPNOTSUPP)
@@ -1530,6 +1581,8 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	if (fbs_disabled)
 		ahci_enable_fbs(ap);
 
+	ahci_dump_softreset_done(link);
+
 	return 0;
 
  fail:
@@ -1613,6 +1666,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	struct ata_taskfile tf;
 	int rc;
 
+	ahci_dump_hardreset_start(link);
+
 	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
@@ -1630,6 +1685,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	if (*online)
 		*class = ahci_dev_classify(ap);
 
+	ahci_dump_hardreset_done(link);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_do_hardreset);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c93c24b22d9c..a8eb651ffb60 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -573,6 +573,9 @@ void ata_scsi_error(struct Scsi_Host *host)
 	int nr_timedout;
 	LIST_HEAD(eh_work_q);
 
+	if (ap->ops->debug_dump)
+		ap->ops->debug_dump(ap, ATA_EH_DUMP_ENTER);
+
 	spin_lock_irqsave(host->host_lock, flags);
 	list_splice_init(&host->eh_cmd_q, &eh_work_q);
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -591,6 +594,9 @@ void ata_scsi_error(struct Scsi_Host *host)
 		scsi_eh_flush_done_q(&ap->eh_done_q);
 
 	WARN_ON(!list_empty(&eh_work_q));
+
+	if (ap->ops->debug_dump)
+		ap->ops->debug_dump(ap, ATA_EH_DUMP_EXIT);
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 313e96173b19..71b658dd4bdb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -966,6 +966,11 @@ struct ata_reset_operations {
 	ata_postreset_fn_t	postreset;
 };
 
+enum ata_eh_dump {
+	ATA_EH_DUMP_ENTER,
+	ATA_EH_DUMP_EXIT,
+};
+
 struct ata_port_operations {
 	/*
 	 * Command execution
@@ -1000,6 +1005,7 @@ struct ata_port_operations {
 	void (*post_internal_cmd)(struct ata_queued_cmd *qc);
 	void (*sched_eh)(struct ata_port *ap);
 	void (*end_eh)(struct ata_port *ap);
+	void (*debug_dump)(struct ata_port *ap, enum ata_eh_dump phase);
 
 	/*
 	 * Optional features
diff --git a/include/trace/events/libahci.h b/include/trace/events/libahci.h
new file mode 100644
index 000000000000..33ff2487cc84
--- /dev/null
+++ b/include/trace/events/libahci.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Hisilicon Limited.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM libahci
+
+#if !defined(_TRACE_LIBAHCI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LIBAHCI_H
+
+#include <linux/libata.h>
+#include <linux/tracepoint.h>
+
+#define AHCI_TRACE_GLOBAL_REGS	64
+#define AHCI_TRACE_PORT_REGS	32
+
+DECLARE_EVENT_CLASS(ahci_global_reg_dump,
+
+	TP_PROTO(struct ata_link *link, const u32 *global_regs),
+
+	TP_ARGS(link, global_regs),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, ata_port)
+		__array(u32, global_regs, AHCI_TRACE_GLOBAL_REGS)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port = link->ap->print_id;
+		memcpy(__entry->global_regs, global_regs,
+		       sizeof(__entry->global_regs));
+	),
+
+	TP_printk("ata_port=%u global=%s",
+		  __entry->ata_port,
+		  __print_array(__entry->global_regs,
+				AHCI_TRACE_GLOBAL_REGS, 4))
+);
+
+DEFINE_EVENT(ahci_global_reg_dump, ahci_global_softreset_start,
+	     TP_PROTO(struct ata_link *link, const u32 *global_regs),
+	     TP_ARGS(link, global_regs));
+
+DEFINE_EVENT(ahci_global_reg_dump, ahci_global_softreset_done,
+	     TP_PROTO(struct ata_link *link, const u32 *global_regs),
+	     TP_ARGS(link, global_regs));
+
+DEFINE_EVENT(ahci_global_reg_dump, ahci_global_hardreset_start,
+	     TP_PROTO(struct ata_link *link, const u32 *global_regs),
+	     TP_ARGS(link, global_regs));
+
+DEFINE_EVENT(ahci_global_reg_dump, ahci_global_hardreset_done,
+	     TP_PROTO(struct ata_link *link, const u32 *global_regs),
+	     TP_ARGS(link, global_regs));
+
+DEFINE_EVENT(ahci_global_reg_dump, ahci_global_eh_start,
+	     TP_PROTO(struct ata_link *link, const u32 *global_regs),
+	     TP_ARGS(link, global_regs));
+
+DEFINE_EVENT(ahci_global_reg_dump, ahci_global_eh_done,
+	     TP_PROTO(struct ata_link *link, const u32 *global_regs),
+	     TP_ARGS(link, global_regs));
+
+DECLARE_EVENT_CLASS(ahci_port_reg_dump,
+
+	TP_PROTO(struct ata_link *link, const u32 *port_regs),
+
+	TP_ARGS(link, port_regs),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, ata_port)
+		__array(u32, port_regs, AHCI_TRACE_PORT_REGS)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port = link->ap->print_id;
+		memcpy(__entry->port_regs, port_regs,
+		       sizeof(__entry->port_regs));
+	),
+
+	TP_printk("ata_port=%u port=%s",
+		  __entry->ata_port,
+		  __print_array(__entry->port_regs,
+				AHCI_TRACE_PORT_REGS, 4))
+);
+
+DEFINE_EVENT(ahci_port_reg_dump, ahci_port_softreset_start,
+	     TP_PROTO(struct ata_link *link, const u32 *port_regs),
+	     TP_ARGS(link, port_regs));
+
+DEFINE_EVENT(ahci_port_reg_dump, ahci_port_softreset_done,
+	     TP_PROTO(struct ata_link *link, const u32 *port_regs),
+	     TP_ARGS(link, port_regs));
+
+DEFINE_EVENT(ahci_port_reg_dump, ahci_port_hardreset_start,
+	     TP_PROTO(struct ata_link *link, const u32 *port_regs),
+	     TP_ARGS(link, port_regs));
+
+DEFINE_EVENT(ahci_port_reg_dump, ahci_port_hardreset_done,
+	     TP_PROTO(struct ata_link *link, const u32 *port_regs),
+	     TP_ARGS(link, port_regs));
+
+DEFINE_EVENT(ahci_port_reg_dump, ahci_port_eh_start,
+	     TP_PROTO(struct ata_link *link, const u32 *port_regs),
+	     TP_ARGS(link, port_regs));
+
+DEFINE_EVENT(ahci_port_reg_dump, ahci_port_eh_done,
+	     TP_PROTO(struct ata_link *link, const u32 *port_regs),
+	     TP_ARGS(link, port_regs));
+
+#endif /* _TRACE_LIBAHCI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.33.0

