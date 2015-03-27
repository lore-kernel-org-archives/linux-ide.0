From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 9/9] libata: Add tracepoints
Date: Fri, 27 Mar 2015 16:46:38 +0100
Message-ID: <1427471198-62676-10-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: linux-ide@vger.kernel.org

Add some tracepoints for ata_qc_issue, ata_qc_complete, and
ata_eh_link_autopsy.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Makefile          |   3 +-
 drivers/ata/libata-core.c     |   8 +-
 drivers/ata/libata-eh.c       |   4 +-
 drivers/ata/libata-trace.c    | 151 ++++++++++++++++++++
 include/trace/events/libata.h | 325 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 488 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ata/libata-trace.c
 create mode 100644 include/trace/events/libata.h

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index ae41107..b67e995 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -111,7 +111,8 @@ obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 # Should be last libata driver
 obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
-libata-y	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
+libata-y	:= libata-core.o libata-scsi.o libata-eh.o \
+	libata-transport.o libata-trace.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 51cba76..1882fd2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -70,6 +70,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/libata.h>
+
 #include "libata.h"
 #include "libata-transport.h"
 
@@ -4904,6 +4907,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		 */
 		if (unlikely(ata_tag_internal(qc->tag))) {
 			fill_result_tf(qc);
+			trace_ata_qc_complete_internal(qc);
 			__ata_qc_complete(qc);
 			return;
 		}
@@ -4914,6 +4918,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		 */
 		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
 			fill_result_tf(qc);
+			trace_ata_qc_complete_failed(qc);
 			ata_qc_schedule_eh(qc);
 			return;
 		}
@@ -4924,6 +4929,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		if (qc->flags & ATA_QCFLAG_RESULT_TF)
 			fill_result_tf(qc);
 
+		trace_ata_qc_complete_done(qc);
 		/* Some commands need post-processing after successful
 		 * completion.
 		 */
@@ -5071,7 +5077,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	}
 
 	ap->ops->qc_prep(qc);
-
+	trace_ata_qc_issue(qc);
 	qc->err_mask |= ap->ops->qc_issue(qc);
 	if (unlikely(qc->err_mask))
 		goto err;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 77ef43e..07f41be 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -46,6 +46,7 @@
 
 #include <linux/libata.h>
 
+#include <trace/events/libata.h>
 #include "libata.h"
 
 enum {
@@ -2291,6 +2292,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		all_err_mask |= qc->err_mask;
 		if (qc->flags & ATA_QCFLAG_IO)
 			eflags |= ATA_EFLAG_IS_IO;
+		trace_ata_eh_link_autopsy_qc(qc);
 	}
 
 	/* enforce default EH actions */
@@ -2325,7 +2327,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 			eflags |= ATA_EFLAG_DUBIOUS_XFER;
 		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
 	}
-
+	trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
 	DPRINTK("EXIT\n");
 }
 
diff --git a/drivers/ata/libata-trace.c b/drivers/ata/libata-trace.c
new file mode 100644
index 0000000..fd30b8c
--- /dev/null
+++ b/drivers/ata/libata-trace.c
@@ -0,0 +1,151 @@
+/*
+ * libata-trace.c - trace functions for libata
+ *
+ * Copyright 2015 Hannes Reinecke
+ * Copyright 2015 SUSE Linux GmbH
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/trace_seq.h>
+#include <trace/events/libata.h>
+
+const char *
+libata_trace_parse_status(struct trace_seq *p, unsigned char status)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "{ ");
+	if (status & ATA_BUSY)
+		trace_seq_printf(p, "BUSY ");
+	if (status & ATA_DRDY)
+		trace_seq_printf(p, "DRDY ");
+	if (status & ATA_DF)
+		trace_seq_printf(p, "DF ");
+	if (status & ATA_DSC)
+		trace_seq_printf(p, "DSC ");
+	if (status & ATA_DRQ)
+		trace_seq_printf(p, "DRQ ");
+	if (status & ATA_CORR)
+		trace_seq_printf(p, "CORR ");
+	if (status & ATA_SENSE)
+		trace_seq_printf(p, "SENSE ");
+	if (status & ATA_ERR)
+		trace_seq_printf(p, "ERR ");
+	trace_seq_putc(p, '}');
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *
+libata_trace_parse_eh_action(struct trace_seq *p, unsigned int eh_action)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "%x", eh_action);
+	if (eh_action) {
+		trace_seq_printf(p, "{ ");
+		if (eh_action & ATA_EH_REVALIDATE)
+			trace_seq_printf(p, "REVALIDATE ");
+		if (eh_action & (ATA_EH_SOFTRESET | ATA_EH_HARDRESET))
+			trace_seq_printf(p, "RESET ");
+		else if (eh_action & ATA_EH_SOFTRESET)
+			trace_seq_printf(p, "SOFTRESET ");
+		else if (eh_action & ATA_EH_HARDRESET)
+			trace_seq_printf(p, "HARDRESET ");
+		if (eh_action & ATA_EH_ENABLE_LINK)
+			trace_seq_printf(p, "ENABLE_LINK ");
+		if (eh_action & ATA_EH_PARK)
+			trace_seq_printf(p, "PARK ");
+		trace_seq_putc(p, '}');
+	}
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *
+libata_trace_parse_eh_err_mask(struct trace_seq *p, unsigned int eh_err_mask)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "%x", eh_err_mask);
+	if (eh_err_mask) {
+		trace_seq_printf(p, "{ ");
+		if (eh_err_mask & AC_ERR_DEV)
+			trace_seq_printf(p, "DEV ");
+		if (eh_err_mask & AC_ERR_HSM)
+			trace_seq_printf(p, "HSM ");
+		if (eh_err_mask & AC_ERR_TIMEOUT)
+			trace_seq_printf(p, "TIMEOUT ");
+		if (eh_err_mask & AC_ERR_MEDIA)
+			trace_seq_printf(p, "MEDIA ");
+		if (eh_err_mask & AC_ERR_ATA_BUS)
+			trace_seq_printf(p, "ATA_BUS ");
+		if (eh_err_mask & AC_ERR_HOST_BUS)
+			trace_seq_printf(p, "HOST_BUS ");
+		if (eh_err_mask & AC_ERR_SYSTEM)
+			trace_seq_printf(p, "SYSTEM ");
+		if (eh_err_mask & AC_ERR_INVALID)
+			trace_seq_printf(p, "INVALID ");
+		if (eh_err_mask & AC_ERR_OTHER)
+			trace_seq_printf(p, "OTHER ");
+		if (eh_err_mask & AC_ERR_NODEV_HINT)
+			trace_seq_printf(p, "NODEV_HINT ");
+		if (eh_err_mask & AC_ERR_NCQ)
+			trace_seq_printf(p, "NCQ ");
+		trace_seq_putc(p, '}');
+	}
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *
+libata_trace_parse_qc_flags(struct trace_seq *p, unsigned int qc_flags)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "%x", qc_flags);
+	if (qc_flags) {
+		trace_seq_printf(p, "{ ");
+		if (qc_flags & ATA_QCFLAG_ACTIVE)
+			trace_seq_printf(p, "ACTIVE ");
+		if (qc_flags & ATA_QCFLAG_DMAMAP)
+			trace_seq_printf(p, "DMAMAP ");
+		if (qc_flags & ATA_QCFLAG_IO)
+			trace_seq_printf(p, "IO ");
+		if (qc_flags & ATA_QCFLAG_RESULT_TF)
+			trace_seq_printf(p, "RESULT_TF ");
+		if (qc_flags & ATA_QCFLAG_CLEAR_EXCL)
+			trace_seq_printf(p, "CLEAR_EXCL ");
+		if (qc_flags & ATA_QCFLAG_QUIET)
+			trace_seq_printf(p, "QUIET ");
+		if (qc_flags & ATA_QCFLAG_RETRY)
+			trace_seq_printf(p, "RETRY ");
+		if (qc_flags & ATA_QCFLAG_FAILED)
+			trace_seq_printf(p, "FAILED ");
+		if (qc_flags & ATA_QCFLAG_SENSE_VALID)
+			trace_seq_printf(p, "SENSE_VALID ");
+		if (qc_flags & ATA_QCFLAG_EH_SCHEDULED)
+			trace_seq_printf(p, "EH_SCHEDULED ");
+		trace_seq_putc(p, '}');
+	}
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
new file mode 100644
index 0000000..8b0fbd9
--- /dev/null
+++ b/include/trace/events/libata.h
@@ -0,0 +1,325 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM libata
+
+#if !defined(_TRACE_LIBATA_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LIBATA_H
+
+#include <linux/ata.h>
+#include <linux/libata.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#define ata_opcode_name(opcode)	{ opcode, #opcode }
+#define show_opcode_name(val)					\
+	__print_symbolic(val,					\
+		 ata_opcode_name(ATA_CMD_DEV_RESET),		\
+		 ata_opcode_name(ATA_CMD_CHK_POWER),		\
+		 ata_opcode_name(ATA_CMD_STANDBY),		\
+		 ata_opcode_name(ATA_CMD_IDLE),			\
+		 ata_opcode_name(ATA_CMD_EDD),			\
+		 ata_opcode_name(ATA_CMD_DOWNLOAD_MICRO),	\
+		 ata_opcode_name(ATA_CMD_DOWNLOAD_MICRO_DMA),	\
+		 ata_opcode_name(ATA_CMD_NOP),			\
+		 ata_opcode_name(ATA_CMD_FLUSH),		\
+		 ata_opcode_name(ATA_CMD_FLUSH_EXT),		\
+		 ata_opcode_name(ATA_CMD_ID_ATA),		\
+		 ata_opcode_name(ATA_CMD_ID_ATAPI),		\
+		 ata_opcode_name(ATA_CMD_SERVICE),		\
+		 ata_opcode_name(ATA_CMD_READ),			\
+		 ata_opcode_name(ATA_CMD_READ_EXT),		\
+		 ata_opcode_name(ATA_CMD_READ_QUEUED),		\
+		 ata_opcode_name(ATA_CMD_READ_STREAM_EXT),	\
+		 ata_opcode_name(ATA_CMD_READ_STREAM_DMA_EXT),	\
+		 ata_opcode_name(ATA_CMD_WRITE),		\
+		 ata_opcode_name(ATA_CMD_WRITE_EXT),		\
+		 ata_opcode_name(ATA_CMD_WRITE_QUEUED),		\
+		 ata_opcode_name(ATA_CMD_WRITE_STREAM_EXT),	\
+		 ata_opcode_name(ATA_CMD_WRITE_STREAM_DMA_EXT), \
+		 ata_opcode_name(ATA_CMD_WRITE_FUA_EXT),	\
+		 ata_opcode_name(ATA_CMD_WRITE_QUEUED_FUA_EXT), \
+		 ata_opcode_name(ATA_CMD_FPDMA_READ),		\
+		 ata_opcode_name(ATA_CMD_FPDMA_WRITE),		\
+		 ata_opcode_name(ATA_CMD_FPDMA_SEND),		\
+		 ata_opcode_name(ATA_CMD_FPDMA_RECV),		\
+		 ata_opcode_name(ATA_CMD_PIO_READ),		\
+		 ata_opcode_name(ATA_CMD_PIO_READ_EXT),		\
+		 ata_opcode_name(ATA_CMD_PIO_WRITE),		\
+		 ata_opcode_name(ATA_CMD_PIO_WRITE_EXT),	\
+		 ata_opcode_name(ATA_CMD_READ_MULTI),		\
+		 ata_opcode_name(ATA_CMD_READ_MULTI_EXT),	\
+		 ata_opcode_name(ATA_CMD_WRITE_MULTI),		\
+		 ata_opcode_name(ATA_CMD_WRITE_MULTI_EXT),	\
+		 ata_opcode_name(ATA_CMD_WRITE_MULTI_FUA_EXT),	\
+		 ata_opcode_name(ATA_CMD_SET_FEATURES),		\
+		 ata_opcode_name(ATA_CMD_SET_MULTI),		\
+		 ata_opcode_name(ATA_CMD_PACKET),		\
+		 ata_opcode_name(ATA_CMD_VERIFY),		\
+		 ata_opcode_name(ATA_CMD_VERIFY_EXT),		\
+		 ata_opcode_name(ATA_CMD_WRITE_UNCORR_EXT),	\
+		 ata_opcode_name(ATA_CMD_STANDBYNOW1),		\
+		 ata_opcode_name(ATA_CMD_IDLEIMMEDIATE),	\
+		 ata_opcode_name(ATA_CMD_SLEEP),		\
+		 ata_opcode_name(ATA_CMD_INIT_DEV_PARAMS),	\
+		 ata_opcode_name(ATA_CMD_READ_NATIVE_MAX),	\
+		 ata_opcode_name(ATA_CMD_READ_NATIVE_MAX_EXT),	\
+		 ata_opcode_name(ATA_CMD_SET_MAX),		\
+		 ata_opcode_name(ATA_CMD_SET_MAX_EXT),		\
+		 ata_opcode_name(ATA_CMD_READ_LOG_EXT),		\
+		 ata_opcode_name(ATA_CMD_WRITE_LOG_EXT),	\
+		 ata_opcode_name(ATA_CMD_READ_LOG_DMA_EXT),	\
+		 ata_opcode_name(ATA_CMD_WRITE_LOG_DMA_EXT),	\
+		 ata_opcode_name(ATA_CMD_TRUSTED_NONDATA),	\
+		 ata_opcode_name(ATA_CMD_TRUSTED_RCV),		\
+		 ata_opcode_name(ATA_CMD_TRUSTED_RCV_DMA),	\
+		 ata_opcode_name(ATA_CMD_TRUSTED_SND),		\
+		 ata_opcode_name(ATA_CMD_TRUSTED_SND_DMA),	\
+		 ata_opcode_name(ATA_CMD_PMP_READ),		\
+		 ata_opcode_name(ATA_CMD_PMP_READ_DMA),		\
+		 ata_opcode_name(ATA_CMD_PMP_WRITE),		\
+		 ata_opcode_name(ATA_CMD_PMP_WRITE_DMA),	\
+		 ata_opcode_name(ATA_CMD_CONF_OVERLAY),		\
+		 ata_opcode_name(ATA_CMD_SEC_SET_PASS),		\
+		 ata_opcode_name(ATA_CMD_SEC_UNLOCK),		\
+		 ata_opcode_name(ATA_CMD_SEC_ERASE_PREP),	\
+		 ata_opcode_name(ATA_CMD_SEC_ERASE_UNIT),	\
+		 ata_opcode_name(ATA_CMD_SEC_FREEZE_LOCK),	\
+		 ata_opcode_name(ATA_CMD_SEC_DISABLE_PASS),	\
+		 ata_opcode_name(ATA_CMD_CONFIG_STREAM),	\
+		 ata_opcode_name(ATA_CMD_SMART),		\
+		 ata_opcode_name(ATA_CMD_MEDIA_LOCK),		\
+		 ata_opcode_name(ATA_CMD_MEDIA_UNLOCK),		\
+		 ata_opcode_name(ATA_CMD_DSM),			\
+		 ata_opcode_name(ATA_CMD_CHK_MED_CRD_TYP),	\
+		 ata_opcode_name(ATA_CMD_CFA_REQ_EXT_ERR),	\
+		 ata_opcode_name(ATA_CMD_CFA_WRITE_NE),		\
+		 ata_opcode_name(ATA_CMD_CFA_TRANS_SECT),	\
+		 ata_opcode_name(ATA_CMD_CFA_ERASE),		\
+		 ata_opcode_name(ATA_CMD_CFA_WRITE_MULT_NE),	\
+		 ata_opcode_name(ATA_CMD_REQ_SENSE_DATA),	\
+		 ata_opcode_name(ATA_CMD_SANITIZE_DEVICE),	\
+		 ata_opcode_name(ATA_CMD_RESTORE),		\
+		 ata_opcode_name(ATA_CMD_READ_LONG),		\
+		 ata_opcode_name(ATA_CMD_READ_LONG_ONCE),	\
+		 ata_opcode_name(ATA_CMD_WRITE_LONG),		\
+		 ata_opcode_name(ATA_CMD_WRITE_LONG_ONCE))
+
+#define ata_error_name(result)	{ result, #result }
+#define show_error_name(val)				\
+	__print_symbolic(val,				\
+		ata_error_name(ATA_ICRC),		\
+		ata_error_name(ATA_UNC),		\
+		ata_error_name(ATA_MC),			\
+		ata_error_name(ATA_IDNF),		\
+		ata_error_name(ATA_MCR),		\
+		ata_error_name(ATA_ABORTED),		\
+		ata_error_name(ATA_TRK0NF),		\
+		ata_error_name(ATA_AMNF))
+
+#define ata_protocol_name(proto)	{ proto, #proto }
+#define show_protocol_name(val)				\
+	__print_symbolic(val,				\
+		ata_protocol_name(ATA_PROT_UNKNOWN),	\
+		ata_protocol_name(ATA_PROT_NODATA),	\
+		ata_protocol_name(ATA_PROT_PIO),	\
+		ata_protocol_name(ATA_PROT_DMA),	\
+		ata_protocol_name(ATA_PROT_NCQ),	\
+		ata_protocol_name(ATAPI_PROT_NODATA),	\
+		ata_protocol_name(ATAPI_PROT_PIO),	\
+		ata_protocol_name(ATAPI_PROT_DMA))
+
+const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
+#define __parse_status(s) libata_trace_parse_status(p, s)
+
+const char *libata_trace_parse_eh_action(struct trace_seq *, unsigned int);
+#define __parse_eh_action(a) libata_trace_parse_eh_action(p, a)
+
+const char *libata_trace_parse_eh_err_mask(struct trace_seq *, unsigned int);
+#define __parse_eh_err_mask(m) libata_trace_parse_eh_err_mask(p, m)
+
+const char *libata_trace_parse_qc_flags(struct trace_seq *, unsigned int);
+#define __parse_qc_flags(f) libata_trace_parse_qc_flags(p, f)
+
+TRACE_EVENT(ata_qc_issue,
+
+	TP_PROTO(struct ata_queued_cmd *qc),
+
+	TP_ARGS(qc),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	ata_dev	)
+		__field( unsigned int,	tag	)
+		__field( unsigned char,	cmd	)
+		__field( unsigned char,	dev	)
+		__field( unsigned char,	lbal	)
+		__field( unsigned char,	lbam	)
+		__field( unsigned char,	lbah	)
+		__field( unsigned char,	nsect	)
+		__field( unsigned char,	feature	)
+		__field( unsigned char,	hob_lbal )
+		__field( unsigned char,	hob_lbam )
+		__field( unsigned char,	hob_lbah )
+		__field( unsigned char,	hob_nsect )
+		__field( unsigned char,	hob_feature )
+		__field( unsigned char,	ctl )
+		__field( unsigned char,	proto )
+		__field( unsigned long,	flags )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= qc->ap->print_id;
+		__entry->ata_dev	= qc->dev->link->pmp + qc->dev->devno;
+		__entry->tag		= qc->tag;
+		__entry->proto		= qc->tf.protocol;
+		__entry->cmd		= qc->tf.command;
+		__entry->dev		= qc->tf.device;
+		__entry->lbal		= qc->tf.lbal;
+		__entry->lbam		= qc->tf.lbam;
+		__entry->lbah		= qc->tf.lbah;
+		__entry->hob_lbal	= qc->tf.hob_lbal;
+		__entry->hob_lbam	= qc->tf.hob_lbam;
+		__entry->hob_lbah	= qc->tf.hob_lbah;
+		__entry->feature	= qc->tf.feature;
+		__entry->hob_feature	= qc->tf.hob_feature;
+		__entry->nsect		= qc->tf.nsect;
+		__entry->hob_nsect	= qc->tf.hob_nsect;
+	),
+
+	TP_printk("ata_port=%u ata_dev=%u tag=%d proto=%s cmd=%s " \
+		  " tf=(%02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x)",
+		  __entry->ata_port, __entry->ata_dev, __entry->tag,
+		  show_protocol_name(__entry->proto),
+		  show_opcode_name(__entry->cmd),
+		  __entry->cmd, __entry->feature, __entry->nsect,
+		  __entry->lbal, __entry->lbam, __entry->lbah,
+		  __entry->hob_feature, __entry->hob_nsect,
+		  __entry->hob_lbal, __entry->hob_lbam, __entry->hob_lbah,
+		  __entry->dev)
+);
+
+DECLARE_EVENT_CLASS(ata_qc_complete_template,
+
+	TP_PROTO(struct ata_queued_cmd *qc),
+
+	TP_ARGS(qc),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	ata_dev	)
+		__field( unsigned int,	tag	)
+		__field( unsigned char,	status	)
+		__field( unsigned char,	dev	)
+		__field( unsigned char,	lbal	)
+		__field( unsigned char,	lbam	)
+		__field( unsigned char,	lbah	)
+		__field( unsigned char,	nsect	)
+		__field( unsigned char,	error	)
+		__field( unsigned char,	hob_lbal )
+		__field( unsigned char,	hob_lbam )
+		__field( unsigned char,	hob_lbah )
+		__field( unsigned char,	hob_nsect )
+		__field( unsigned char,	hob_feature )
+		__field( unsigned char,	ctl )
+		__field( unsigned long,	flags )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= qc->ap->print_id;
+		__entry->ata_dev	= qc->dev->link->pmp + qc->dev->devno;
+		__entry->tag		= qc->tag;
+		__entry->status		= qc->result_tf.command;
+		__entry->dev		= qc->result_tf.device;
+		__entry->lbal		= qc->result_tf.lbal;
+		__entry->lbam		= qc->result_tf.lbam;
+		__entry->lbah		= qc->result_tf.lbah;
+		__entry->hob_lbal	= qc->result_tf.hob_lbal;
+		__entry->hob_lbam	= qc->result_tf.hob_lbam;
+		__entry->hob_lbah	= qc->result_tf.hob_lbah;
+		__entry->error		= qc->result_tf.feature;
+		__entry->hob_feature	= qc->result_tf.hob_feature;
+		__entry->nsect		= qc->result_tf.nsect;
+		__entry->hob_nsect	= qc->result_tf.hob_nsect;
+	),
+
+	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s status=%s " \
+		  " res=(%02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x)",
+		  __entry->ata_port, __entry->ata_dev, __entry->tag,
+		  __parse_qc_flags(__entry->flags),
+		  __parse_status(__entry->status),
+		  __entry->status, __entry->error, __entry->nsect,
+		  __entry->lbal, __entry->lbam, __entry->lbah,
+		  __entry->hob_feature, __entry->hob_nsect,
+		  __entry->hob_lbal, __entry->hob_lbam, __entry->hob_lbah,
+		  __entry->dev)
+);
+
+DEFINE_EVENT(ata_qc_complete_template, ata_qc_complete_internal,
+	     TP_PROTO(struct ata_queued_cmd *qc),
+	     TP_ARGS(qc));
+
+DEFINE_EVENT(ata_qc_complete_template, ata_qc_complete_failed,
+	     TP_PROTO(struct ata_queued_cmd *qc),
+	     TP_ARGS(qc));
+
+DEFINE_EVENT(ata_qc_complete_template, ata_qc_complete_done,
+	     TP_PROTO(struct ata_queued_cmd *qc),
+	     TP_ARGS(qc));
+
+TRACE_EVENT(ata_eh_link_autopsy,
+
+	TP_PROTO(struct ata_device *dev, unsigned int eh_action, unsigned int eh_err_mask),
+
+	TP_ARGS(dev, eh_action, eh_err_mask),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	ata_dev	)
+		__field( unsigned int,	eh_action )
+		__field( unsigned int,	eh_err_mask)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= dev->link->ap->print_id;
+		__entry->ata_dev	= dev->link->pmp + dev->devno;
+		__entry->eh_action	= eh_action;
+		__entry->eh_err_mask	= eh_err_mask;
+	),
+
+	TP_printk("ata_port=%u ata_dev=%u eh_action=%s err_mask=%s",
+		  __entry->ata_port, __entry->ata_dev,
+		  __parse_eh_action(__entry->eh_action),
+		  __parse_eh_err_mask(__entry->eh_err_mask))
+);
+
+TRACE_EVENT(ata_eh_link_autopsy_qc,
+
+	TP_PROTO(struct ata_queued_cmd *qc),
+
+	TP_ARGS(qc),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	ata_dev	)
+		__field( unsigned int,	tag	)
+		__field( unsigned int,	qc_flags )
+		__field( unsigned int,	eh_err_mask)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= qc->ap->print_id;
+		__entry->ata_dev	= qc->dev->link->pmp + qc->dev->devno;
+		__entry->tag		= qc->tag;
+		__entry->qc_flags	= qc->flags;
+		__entry->eh_err_mask	= qc->err_mask;
+	),
+
+	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s err_mask=%s",
+		  __entry->ata_port, __entry->ata_dev, __entry->tag,
+		  __parse_qc_flags(__entry->qc_flags),
+		  __parse_eh_err_mask(__entry->eh_err_mask))
+);
+
+#endif /*  _TRACE_LIBATA_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.8.5.2
