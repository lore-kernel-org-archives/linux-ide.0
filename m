Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415063;
	b=n5wzb5g0Gf3ZRijuDqIOykSdEF0jQBnxmqSjcTogJZ6usJggIpD83Q26+WTwaEevMa8Z
	 UItpQdlb7RI3oF1HeR4gXaTY52UsG5p3ljqsExfJdz6AphLf3uLBtgRR2pGjdLUjkFaIx
	 3Wy6sECmqzjEu1rAlPb4Nts/DaYwHwvux35QaNWgWq1Gb5bJc+7JEC1LozGJhIfpY10ve
	 wQcoyGNO6OCBHurIGsQXTmz4aa6whGtThm3FDfNn7O7W8vi0MSq1QH8dEUtIhiaRt0sgH
	 TXmawm8rU50qDbDFf7PmcoqA7FN8FqH3J5NrsETcX9WQjDUvZH3GAyuVI6Qpn1YYerQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mCjNParZzdOX77K6kaHe/ftOL71cep5honadbqy1WaI=;
	b=iC6g1nem/D6Pjw9smfGxGkLmMPAtHM/6g12E3KXTzsv8SPQAImAm6WyzOfv+jXG1bgP+
	 +QyadwlSkkDZhk9AU3FGWEChts5PUFme8fRPs9N3sQWoCc4Ok3ZAo4ei3LRievIYsljWg
	 QNee0jei9dMf6MUJmQFzcv9bCb2BLk7uWCRPq2aFWUVoDGNM2n55YwqvLhymo9bJahaHn
	 Uy2HW+RZCu/XVHid7xGsubfYXb38TK2R5jvUfA6wHWPvzCzYDL4ABPR5ur/zsV+ufGB4M
	 lxrlvFQ1RG9jYtWOq1ycBXCbibcjrJ5i2GHd/RZgjtpWBDbRtoT77miZVLTRkbWe8GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWhEvOwA;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A408606A31C
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A408606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWhEvOwA
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so29456855e9.0
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415062; x=1795019862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mCjNParZzdOX77K6kaHe/ftOL71cep5honadbqy1WaI=;
        b=bWhEvOwAzZ/AT8LxnTsf+G+Gmp9SnAZPYCgs7wEizp/TIVIAh2Y1eMyYrgGN6V2DZN
         uyzdL/89uMe9qO8WDTbG8AyGRqZMhshhUW6llLRLIP6xXq0v5mOH342MXChtZPF7v+OG
         j1yp42JFnhV7kdwhxglWgxRz1d5YfqUm4vQ8sktR1hZFj2+tDmlO2KjyL7xD3Z0gP/vX
         VDxq33oP253tVkEGZ6jLodbqqPjw9/jZhZVRcNB0G0vxb4Yw3Uin7MDvgoU5iVIREXOA
         bXb56nQy9HQXRGnG4QJ4dm2T8f+TAAJyYdxpDGM4YkDljkUfGi6pHibkQexmeokzdLLN
         zjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415062; x=1795019862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mCjNParZzdOX77K6kaHe/ftOL71cep5honadbqy1WaI=;
        b=v3BwA36DR7lg9xb1Y3UZzaJdDN9nwyF5C9GUZvAhvPKfrc1Q74H8yHjvzy7ZVCQW4M
         ZjWzlGc7YBiJcxrU/Up92hBsn6cV8x8all5r0815XfjhKJK/PX0K0XMSqA2EegPNOpXH
         5LvQTgMggyDnh6fSfNsPR8CLGLKtilN2p5vFYqQR88PeOAKwbqLyRjflnIWqP3M0rF3v
         zDX9GFDzmvQ+X3KrEWOZVKaw/lBHo02rUxCR7YhomzXCg/QpZUK6DQkjUscnNNsz/lEL
         4ZuJaNfoa+VMKoKCLixb/U+JhzgeZ7c0tvi8Y6/aCb+Y/9fF2A/xzdp2cOZfSyczAjdf
         UJoQ==
X-Forwarded-Encrypted: i=1; AL+hErFC+L8Mxi5dDeZLjA0S6h0sNWoRnBaT1M0IkYTPy0qgC71+alsdNpvAFb4V4QXDTQfR4EqcvwZAxTA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ygz28ty+z99w6omgj/TswmrM++atQuZCxg/j1c9VdSSu0Tfwv
	YB84zSpRXfu6utFgv73M2QcM7F0JkIVL0rDEl9VEJlhDcJ8tj3tcIoWB
X-Gm-Gg: AYBFou0fSpSR/AWdoaR9fme8QCEJdveD8sCtZ0sC7izwMlJV4gJgnFsPzo4YZVLUFnJ
	rleq5WcfPK7xZZlQ8mwTxWEIRPolxJd+xZ2+dPYGBwFXYtqwBlmVoxfFa91TwwXniSdEBtQ9sa2
	kg2Wr5ygNJ7S6/vI9MNXrJAyWdalW+WtikZpHA8DmW6zGRiOL8HUZcyDHWkR7n74HxWYPlByDpR
	2kMRTpi6Fi6ap/qM2Rvsdf5VNPma6wldqToS4iVVoQ5AGUwZEUrZ8r4htQxyN2Foh/34WaljMvY
	YV7NP/TKTrgQ64sD2EPuOcA44dMejncbgYf8maBHBNLGTS+jIvd4kXF9lSSPIZrRf01eP0gV93g
	5NsaN4eTimDnI/MJkmR/TiYgnOCBP3xeIySzWDGDxTQ1y1mxzijEaHOmko2MO0e5U9yvk+CEAN/
	Hg/c5mzBRwLLIVbmyC16Ts38q/HGyeerLxQ1Q1QUEOXhErnluoL+L8mQjHeHsYizc+9E4rzF14s
	M7zqT1FwkiHoE15F8nJhNLpoUaq//2ohjrCLP9yrRawJCEv95SEfCBl8kflgmt71dBrylKK+aXY
	dKKG7X9Nw7ZkUeJ3rmc7h+H+FxhACjNyitizbEEMYlM2g1x/LaLHj/uI2h5Ze5di4PZtll5QZZn
	t1fupB49w4E+o
X-Received: by 2002:a05:600c:3b93:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4ba0936efb2mr57598825e9.22.1794415061433;
        Wed, 11 Nov 2026 08:37:41 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983f7801bbsm11950615f8f.5.2026.11.11.08.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:40 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 4/7] zorro: warp mfd: add the dual-port RAM command channel and expose the board identity
Date: Wed, 11 Nov 2026 17:37:31 +0100
Message-ID: <20261111163735.227286-5-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111163735.227286-1-p.pisati@gmail.com>
References: <20261111163735.227286-1-p.pisati@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARM co-processor is reached through a dual-port RAM window and an
interrupt control register: the 68k writes a command frame, rings the
ARM, and the ARM acknowledges and then answers in the same buffer,
raising a flag for each on the shared IRQ_AMIGA_PORTS line.

The protocol header describes only what the driver uses: the control
bits, GetDiag and its reply frame, laid out as the 68k sees it, with
static_assert()s pinning the offsets - the firmware decides them, not
the compiler.

Use it for the first attributes: boardname, hwver and fmwver, read from
a fresh diagnostic frame on every access.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 .../ABI/testing/sysfs-driver-warp-mfd         |  16 ++
 MAINTAINERS                                   |   1 +
 drivers/zorro/warp-mfd.c                      | 259 +++++++++++++++++-
 drivers/zorro/warp-mfd.h                      | 120 +++++++-
 4 files changed, 392 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-warp-mfd

diff --git a/Documentation/ABI/testing/sysfs-driver-warp-mfd b/Documentation/ABI/testing/sysfs-driver-warp-mfd
new file mode 100644
index 000000000000..8996d1961b96
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-warp-mfd
@@ -0,0 +1,16 @@
+What:		/sys/bus/zorro/devices/zorro<N>/boardname
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Paolo Pisati <p.pisati@gmail.com>
+Description:
+		(RO) Name of the CS-Lab Warp board, as reported by its ARM
+		co-processor.
+
+What:		/sys/bus/zorro/devices/zorro<N>/fmwver
+What:		/sys/bus/zorro/devices/zorro<N>/hwver
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Paolo Pisati <p.pisati@gmail.com>
+Description:
+		(RO) Firmware and hardware version, as four hexadecimal digits:
+		an fmwver of 2027 is firmware release 20.27.
diff --git a/MAINTAINERS b/MAINTAINERS
index cfabc4609c9d..7b5e01300418 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7177,6 +7177,7 @@ CS-LAB WARP MULTIFUNCTION DRIVER
 M:	Paolo Pisati <p.pisati@gmail.com>
 L:	linux-m68k@lists.linux-m68k.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-warp-mfd
 F:	drivers/zorro/warp-mfd.c
 F:	drivers/zorro/warp-mfd.h
 
diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
index 94af7c9d0ea5..61866f678b61 100644
--- a/drivers/zorro/warp-mfd.c
+++ b/drivers/zorro/warp-mfd.c
@@ -9,22 +9,50 @@
  * and the IDE interface and RTG display controller, which the 68k drives
  * directly.
  *
- * This driver claims the Zorro device and hands the IDE window to pata_cswarp
- * as an mfd cell.
+ * This driver claims the Zorro device, talks to the co-processor over the
+ * dual-port RAM to expose the board's configuration and telemetry in sysfs,
+ * and hands the IDE window to pata_cswarp as an mfd cell.
  */
 
 #include <linux/array_size.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/zorro.h>
+#include <asm/amigaints.h>
 
 #include <linux/mfd/core.h>
 
 #include "warp-mfd.h"
 
+/**
+ * struct warp_mfd - per-board state
+ * @dev:    the zorro device we hang off
+ * @dpram:  mapped dual-port RAM, shared with the ARM co-processor
+ * @reg_cr: mapped dual-port interrupt control register
+ * @recv:   completed when the ARM acknowledges a message
+ * @reply:  completed when the ARM has a reply waiting in @dpram
+ * @lock:   serialises use of @dpram, which is one shared buffer
+ */
+struct warp_mfd {
+	struct device		*dev;
+	void __iomem		*dpram;
+	void __iomem		*reg_cr;
+	struct completion	recv;
+	struct completion	reply;
+	struct mutex		lock;	/* serialises @dpram */
+};
+
 static const struct mfd_cell warp_mfd_cells[] = {
 	{
 		.name		= "warp-pata",
@@ -36,13 +64,235 @@ static const struct mfd_cell warp_mfd_cells[] = {
 	}
 };
 
+static irqreturn_t warp_irq(int irq, void *data)
+{
+	struct warp_mfd *warp = data;
+	u32 cr = z_readl(warp->reg_cr);
+	irqreturn_t ret = IRQ_NONE;
+
+	/*
+	 * More than one of these can be latched by the time we run - the ARM
+	 * acknowledges and answers a GetDiag in quick succession - so test
+	 * them all. Returning after the first would leave the others set and
+	 * their waiter asleep until it times out.
+	 */
+	if (cr & DPREG_CR_MR_ARM) {
+		z_writel(DPREG_CR_CLR | DPREG_CR_MR_ARM, warp->reg_cr);
+		/* the ARM has taken the message out of the dual-port RAM */
+		complete(&warp->recv);
+		ret = IRQ_HANDLED;
+	}
+
+	if (cr & DPREG_CR_MP_68K) {
+		z_writel(DPREG_CR_CLR | DPREG_CR_MP_68K, warp->reg_cr);
+		/* the ARM has left a reply in the dual-port RAM */
+		complete(&warp->reply);
+		ret = IRQ_HANDLED;
+	}
+
+	if (cr & DPREG_CR_IF_ETHRX) {
+		z_writel(DPREG_CR_CLR | DPREG_CR_IF_ETHRX, warp->reg_cr);
+		/*
+		 * Acknowledged only. There is no network driver behind this
+		 * yet; the ARM stops re-raising it once the flag is cleared.
+		 */
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+/*
+ * The AmigaOS library waits on SIGBREAKF_CTRL_C alongside the ARM's signal,
+ * so a user can always break out of a stalled exchange. We have no such
+ * escape from inside a sysfs store, so bound the wait instead - and stay
+ * interruptible, which is the part of that behaviour worth keeping.
+ */
+#define WARP_MSG_TIMEOUT	msecs_to_jiffies(2000)
+
+/* send a message to the ARM coprocessor, optionally waiting for a reply */
+static int warp_send_msg(struct warp_mfd *warp, bool wait_reply)
+{
+	struct completion *done = wait_reply ? &warp->reply : &warp->recv;
+	long ret;
+
+	/* a previous exchange may have timed out and completed late */
+	reinit_completion(done);
+
+	/* enable 68k & ARM interrupts */
+	z_writel(DPREG_CR_SET | DPREG_CR_IE_68K | DPREG_CR_IE_ARM, warp->reg_cr);
+
+	/* send irq to ARM */
+	z_writel(DPREG_CR_SET | DPREG_CR_MP_ARM, warp->reg_cr);
+
+	/* wait for a reply, or just wait for a receiver ack */
+	ret = wait_for_completion_interruptible_timeout(done,
+							WARP_MSG_TIMEOUT);
+
+	/* disable ARM & 68k interrupts */
+	z_writel(DPREG_CR_CLR | DPREG_CR_IE_68K | DPREG_CR_IE_ARM, warp->reg_cr);
+
+	if (ret < 0)
+		return ret;
+	if (!ret) {
+		dev_err(warp->dev, "no answer from the ARM co-processor\n");
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+/*
+ * Submit one command frame and, when @rpl is given, collect the answer.
+ */
+static int warp_exec_cmd(struct warp_mfd *warp, const union warp_cmd *cmd,
+			 union warp_reply *rpl)
+{
+	int ret;
+
+	ret = mutex_lock_interruptible(&warp->lock);
+	if (ret)
+		return ret;
+
+	z_memcpy_toio(warp->dpram, cmd, sizeof(*cmd));
+	ret = warp_send_msg(warp, rpl);
+	if (!ret && rpl)
+		z_memcpy_fromio(rpl, warp->dpram, sizeof(*rpl));
+
+	mutex_unlock(&warp->lock);
+	return ret;
+}
+
+static int warp_get_status(struct warp_mfd *warp, union warp_reply *rpl)
+{
+	union warp_cmd *cmd;
+	int ret;
+
+	cmd = kzalloc_obj(*cmd);
+	if (!cmd)
+		return -ENOMEM;
+	cmd->hdr.cmd = WARP_CMD_GET_DIAG;
+	ret = warp_exec_cmd(warp, cmd, rpl);
+	kfree(cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * The dual-port RAM still holds the last frame written to it. If the
+	 * board answered something else - or did not answer and we picked up
+	 * a stale completion - the bytes look like a perfectly good reading.
+	 * The vendor library checks this on every command; so do we.
+	 */
+	if (rpl->hdr.rpl != WARP_RPL_DIAG) {
+		dev_err(warp->dev, "unexpected reply %u, wanted a diag frame\n",
+			rpl->hdr.rpl);
+		return -EIO;
+	}
+	return 0;
+}
+
+#define warp_config_uint_attr(name, field, format_string)		\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	int ret;							\
+	struct warp_mfd *warp = dev_get_drvdata(dev);			\
+	union warp_reply *rpl;						\
+									\
+	rpl = kmalloc_obj(*rpl);					\
+	if (!rpl)							\
+		return -ENOMEM;						\
+	ret = warp_get_status(warp, rpl);				\
+	if (ret)							\
+		goto out;						\
+	ret = sysfs_emit(buf, format_string "\n", rpl->diag.field);	\
+out:									\
+	kfree(rpl);							\
+	return ret;							\
+}									\
+static DEVICE_ATTR_RO(name)
+
+#define warp_config_string_attr(name, field)				\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	int ret;							\
+	struct warp_mfd *warp = dev_get_drvdata(dev);			\
+	union warp_reply *rpl;						\
+									\
+	rpl = kmalloc_obj(*rpl);					\
+	if (!rpl)							\
+		return -ENOMEM;						\
+	ret = warp_get_status(warp, rpl);				\
+	if (ret)							\
+		goto out;						\
+	ret = sysfs_emit(buf, "%.*s\n", (int)sizeof(rpl->diag.field),	\
+			 rpl->diag.field);				\
+out:									\
+	kfree(rpl);							\
+	return ret;							\
+}									\
+static DEVICE_ATTR_RO(name)
+
+warp_config_string_attr(boardname, board_name);
+warp_config_uint_attr(fmwver, fmw_ver, "%04X");
+warp_config_uint_attr(hwver, hw_ver, "%04X");
+
+static struct attribute *warp_attrs[] = {
+	/* RO attr */
+	&dev_attr_boardname.attr,
+	&dev_attr_fmwver.attr,
+	&dev_attr_hwver.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(warp);
+
 static int warp_mfd_probe(struct zorro_dev *z,
 			  const struct zorro_device_id *ent)
 {
+	unsigned long base = z->resource.start;
+	struct warp_mfd *warp;
 	int error;
 
 	dev_info(&z->dev, "Warp at %pR\n", &z->resource);
 
+	warp = devm_kzalloc(&z->dev, sizeof(*warp), GFP_KERNEL);
+	if (!warp)
+		return -ENOMEM;
+	warp->dev = &z->dev;
+	mutex_init(&warp->lock);
+	init_completion(&warp->recv);
+	init_completion(&warp->reply);
+	zorro_set_drvdata(z, warp);
+
+	if (!devm_request_mem_region(&z->dev, base + WARP_OFFSET_DPREG_CR,
+				     sizeof(u32), "warp-mfd")) {
+		dev_err(&z->dev, "cannot reserve the interrupt control register\n");
+		return -EBUSY;
+	}
+
+	if (!devm_request_mem_region(&z->dev, base + WARP_OFFSET_DPRAM,
+				     WARP_DPRAM_SIZE, "warp-mfd")) {
+		dev_err(&z->dev, "cannot reserve the dual-port RAM window\n");
+		return -EBUSY;
+	}
+
+	warp->dpram = devm_ioremap(&z->dev, base + WARP_OFFSET_DPRAM,
+				   WARP_DPRAM_SIZE);
+	warp->reg_cr = devm_ioremap(&z->dev, base + WARP_OFFSET_DPREG_CR,
+				    sizeof(u32));
+	if (!warp->dpram || !warp->reg_cr) {
+		dev_err(&z->dev, "cannot map the dual-port RAM window\n");
+		return -ENOMEM;
+	}
+
+	error = devm_request_irq(&z->dev, IRQ_AMIGA_PORTS, warp_irq,
+				 IRQF_SHARED, "warp-mfd", warp);
+	if (error) {
+		dev_err(&z->dev, "cannot request irq %u\n", IRQ_AMIGA_PORTS);
+		return error;
+	}
+
 	error = mfd_add_devices(&z->dev, z->dev.id, warp_mfd_cells,
 				ARRAY_SIZE(warp_mfd_cells), &z->resource,
 				0, NULL);
@@ -68,7 +318,10 @@ static struct zorro_driver warp_mfd_driver = {
 	.name		= "warp-mfd",
 	.id_table	= warp_mfd_ids,
 	.probe		= warp_mfd_probe,
-	.remove		= warp_mfd_remove
+	.remove		= warp_mfd_remove,
+	.driver		= {
+		.dev_groups	= warp_groups,
+	},
 };
 
 static int __init warp_mfd_init(void)
diff --git a/drivers/zorro/warp-mfd.h b/drivers/zorro/warp-mfd.h
index 3f44f2b57c76..366848545ea4 100644
--- a/drivers/zorro/warp-mfd.h
+++ b/drivers/zorro/warp-mfd.h
@@ -1,13 +1,34 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * CS-Lab Warp - board window layout
+ * CS-Lab Warp - 68k <-> ARM dual-port RAM protocol
  *
  * Copyright 2026 Paolo Pisati <p.pisati@gmail.com>
+ *
+ * The Warp boards pair the 68k with an ARM co-processor. The two talk
+ * through a dual-port RAM window and a shared interrupt control register,
+ * both of which sit at fixed offsets inside the board's Zorro space.
+ *
+ * This describes only the small part of that interface this driver uses:
+ * the control register bits, the handful of commands behind the sysfs
+ * attributes, and the diagnostic reply. The board firmware implements many
+ * more commands - see the vendor sources for the full protocol.
+ *
+ * Multi-byte fields are laid out as the 68k sees them, and the wire format
+ * assumes 2-byte alignment for 32-bit members. That is what m68k gcc does
+ * by default, so no packing attribute is needed here - but it does mean the
+ * kernel must not be built with -malign-int, which would push every 32-bit
+ * member to a 4-byte boundary and desynchronise the layout from the board.
+ * The static_assert()s at the end of this file catch that.
  */
 
 #ifndef _WARP_MFD_H
 #define _WARP_MFD_H
 
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
 /* Offsets from the start of the board's Zorro window. */
 #define WARP_OFFSET_DPREG_CR	0x1000	/* dual-port interrupt control reg */
 #define WARP_OFFSET_DPRAM	0x2000	/* dual-port RAM */
@@ -16,4 +37,101 @@
 #define WARP_DPRAM_SIZE		0x2000
 #define WARP_ATA_SIZE		0x1800
 
+/*
+ * Interrupt control register. Writes are read-modify-write requests rather
+ * than plain stores: OR in DPREG_CR_SET to set the named bits, or write them
+ * with DPREG_CR_CLR to clear them. Reads return the raw bit state.
+ */
+#define DPREG_CR_SET		0x80000000	/* set the bits in this word */
+#define DPREG_CR_CLR		0x00000000	/* clear the bits in this word */
+#define DPREG_CR_IE_ARM		BIT(0)		/* ARM irq enable */
+#define DPREG_CR_IE_68K		BIT(1)		/* 68k irq enable */
+#define DPREG_CR_MP_ARM		BIT(2)		/* message pending (ARM) */
+#define DPREG_CR_MP_68K		BIT(3)		/* message pending (68k) */
+#define DPREG_CR_MR_ARM		BIT(4)		/* message received (ARM) */
+#define DPREG_CR_MR_68K		BIT(5)		/* message received (68k) */
+#define DPREG_CR_IE_ETHRX	BIT(6)		/* ethernet rx irq enable */
+#define DPREG_CR_IF_ETHRX	BIT(9)		/* ethernet rx irq flag */
+
+#define WARP_BOARDNAME_LEN	32
+#define WARP_WIFI_SSID_LEN	128
+#define WARP_WIFI_PASS_LEN	128
+
+/* Command opcodes. Only the ones this driver issues are listed. */
+enum warp_cmd_id {
+	WARP_CMD_GET_DIAG	= 6,
+};
+
+/* Reply opcodes, as reported in struct warp_rpl_hdr::rpl. */
+enum warp_rpl_id {
+	WARP_RPL_NOP		= 0,
+	WARP_RPL_DIAG		= 1,
+};
+
+struct warp_cmd_hdr {
+	u32	cmd;			/* enum warp_cmd_id */
+};
+
+union warp_cmd {
+	struct warp_cmd_hdr		hdr;
+};
+
+struct warp_rpl_hdr {
+	u32	rpl;
+};
+
+/*
+ * Reply to WARP_CMD_GET_DIAG. Fields this driver does not expose are kept
+ * so the ones after them land at the right offset.
+ *
+ * turbo_level and tz_corr_secs are reported by the firmware but no longer
+ * maintained by it; treat their contents as stale.
+ */
+struct warp_diag {
+	struct warp_rpl_hdr	hdr;
+	u32			vcc5v;			/* binary32 */
+	u32			vbatt;			/* binary32 */
+	u32			t60_ntc;		/* binary32 */
+	u32			t60_internal;		/* binary32 */
+	u32			t_arm;			/* binary32 */
+	u32			hw_ver;
+	u32			fmw_ver;
+	u32			turbo_level;		/* obsolete, stale */
+	u32			fan_percent;
+	char			board_name[WARP_BOARDNAME_LEN] __nonstring;
+	u32			kickstart_nr;
+	u32			usb_dev_status[2];
+	char			wifi_ssid[WARP_WIFI_SSID_LEN] __nonstring;
+	char			wifi_pass[WARP_WIFI_PASS_LEN] __nonstring;
+	u32			native_ide_enabled;
+	s32			temp_reg_cpu;
+	s32			temp_reg_min_pwm;
+	u8			ide_ior_as;
+	u8			ide_ior_ng;
+	u8			ide_iow_as;
+	u8			ide_iow_ng;
+	u8			ide_ack_as;
+	s32			tz_corr_secs;		/* obsolete */
+	u8			board_type;
+	u32			wifi_state;
+	u32			cpu_freq_mhz;		/* binary32 */
+	u32			cpu_clk_phase_shift_deg; /* binary32 */
+};
+
+union warp_reply {
+	struct warp_rpl_hdr	hdr;
+	struct warp_diag	diag;
+};
+
+/*
+ * The board decides these offsets, not the compiler. If a toolchain change
+ * moves them, every field past the first mismatch decodes as garbage, so
+ * fail the build instead.
+ */
+static_assert(offsetof(struct warp_diag, board_name) == 40);
+static_assert(offsetof(struct warp_diag, wifi_ssid) == 84);
+static_assert(offsetof(struct warp_diag, wifi_pass) == 212);
+static_assert(offsetof(struct warp_diag, wifi_state) == 364);
+static_assert(sizeof(struct warp_diag) == 376);
+
 #endif /* _WARP_MFD_H */
-- 
2.43.0

