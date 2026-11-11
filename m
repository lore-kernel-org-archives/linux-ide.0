Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415067;
	b=XJoYTe2YvsyJqbOIskqAi/1dNF9Mp7aVI+ua+kTmnIfVa8v7euXAfTB/s1bMI7v+7t6Q
	 jcEWUxqXI6WGuzuRz8brNUOwUdMXsmT1vBjwXosDEnQwVSaS5EnT7xL3Bb5fK+Ho6e2qI
	 CcBW839ZyBMv87Nc3MM9HdoxJOa5QHtATpvmABA02Zq08z1QJQ83DgiBVSAlwBhTxhgOR
	 XQgHNMjvbaw/JbZpO9CRgx2FBl/xK6zboAM9C/TfXSylGH4ZIoDPG3iekxncPTRcicQ0q
	 Ja+xvZrBVKO7Esqes5+FnalRW5ul/v0K3I/kxDAr38iGxEnS0eVRwWG9jzd+4N/vB4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ezDZnWkAys7yO2bhUCT3pd+sWH0EXaKqpmbbWyxZlHo=;
	b=wpWHAD8CGsNA+pVGP1aB47J/uhDAmzjocaFTPLr5OuUPLHU889TNdelWlPUQffyTJdu2
	 YNZLTNN+qevxDIglFllTbrpG9LSxMhxQYAE1Ifhtv7D4u2cgRQsUOgT3LNtBY42RGmqgq
	 KOw2VAGUHBdGCs+DwhN4OHQWrp+7ilIYROoe8gMdfPgGsBnlvZsKcs5wV1QrRm2+otZOi
	 p7VFLzyvepXOvgV37Ep0Wk+4bnuL7XDQ4+G9K/E+kF4KNuV4cesv80SVZiGpeEWrrJA10
	 1IZm73fPagNovRuqYNTeAS83pynPvWnhqk+6i6yWFNPQiVdiDEwsRgwp/WtrBjuQhCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IrWctNvj;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11560A261A
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC11560A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IrWctNvj
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso2987979f8f.2
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415065; x=1795019865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezDZnWkAys7yO2bhUCT3pd+sWH0EXaKqpmbbWyxZlHo=;
        b=IrWctNvjOvaL6ocQU1LbiGRbn9W6eJgptQD48aJkdMfZ2j/+pOjAd8WDSeXYeikNFM
         WDCGj0TLxpOh1BzdpgR+jUGN438NrwXG4JT9R1LFw4w04R43sRjU0Lbp7cfLf4LoG7az
         u8IiT9sshM2DnnF132icVOF6LCENjI6rk4Z3UE+fj55juduerCn+epa9xsRj5/EQEv+V
         ac787RQ6FzlvahVO3Isir9ZSKD8AG/iny1MJBK2mBw34iBbNyRMeehiOCWpTQkzbJ+iR
         vsgQmG+YiIRn27+O4xkRwWs3o2E3jCOUYO9iN1eMPV06bokzVDstkYMe0cVkOrnW2UN9
         ekqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415065; x=1795019865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezDZnWkAys7yO2bhUCT3pd+sWH0EXaKqpmbbWyxZlHo=;
        b=NUfdAjwcpE9VaZGKEesie7+7DXJZu0G9Cnn1FVzWgxKJ8YMGDc1Wpgav8zVI8Kfv/U
         UDFa7cUklRaCH9KDMHNRLakp0WIljOJHerIhRMPAIRvCKZ7xodV/2WYtWmDat7OnSw2K
         2TUBMnMClFQRGtXpgtmcNy/Ke71MfCMFQbxRrJUO3nJRRl2yB7e0DXSSzburzPMlUUsJ
         DEn5cToAu1EXTvSVPkQcQ8symqS/2hZWNXPs8J9sACtpVxtX/muKMgoDbV3LOnXiZgnA
         cJ+4wihpK6cXwSktmTz2q0sVAapoSZC9by88WdjLkK/Daats2kbIZpK3ygdSb6GHBucO
         PxeQ==
X-Forwarded-Encrypted: i=1; AL+hErEdGQ6b6etI1ZDwDRrRWlIN6WzNOmxe4dHstK9bJCpOnX4f3i2IfpNXzN/vWagpYC7TB1qSYumob6w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LC6L0Z72SIaPRHtVNC7o+v8ntBHxWwjcfFqCtRSSkxnLITxiV
	AWw8qyTlhZUtGNt6oBUZBleSahYpan6H5PLzaAIm4ocnxsci2NUl1JDBZ4UKA8o2
X-Gm-Gg: AYBFou0xoWkNlvhCdSDeKIoOZKdC6FJfPH9/ZElVVi/EI7DAeIEYSATYwbpcePCkqap
	fO6vylhBdvKxZ9EngvRl4Mp5mmRpWfxDVKEWAiRo+ZYJMdQHJSd39/j9J45LKeATdZKjC7Pg/N5
	OiVORfhu+raq6lBsbhkfqB2qZuB6OxMGRHw0d3O2xmHZAhh+zp/Kv9qeThuxTvw+D5U4S2sifZ3
	2nZ0jqLARzOayr5vQJPKaugFRrxW8B9znK/iwJFaercWSvGbovfUEz8MQC2zZj65tGzpiikCSlD
	nWxnzT/XHbJlfTtPecg4Ph9XY+/Qe+AxghpGJLNcik/Jqzp2G4339w7mwQ6onvfv25/xGB/uM8m
	TQ2Fm175eFKnTPieV9/uYgsodSTbqGCw53kMCqDv1RKshgBJbHbmSmVHM1c1jWGm+zRZWa8fcCS
	/4EC5BgzJKrUpHavJKJq+vYk0WKM/XMOEPeJ+CpYVuQN2H/aC/es/djwPuBPPL9TGiOfKZl/RTk
	JKEcvXAUq70+g6NmA1VD67R9mZYHy97vICY8sdey6rUMNZ9SDq2J7AzWM9Qzt+ZYSbO20zUGMmQ
	iefmYp8Fz7TjVXIew0nBeE4bOkLQvcrozisVEAuvEJiRvWU8NOq+127ZylAE5+Tle/BAUpaZSQM
	FOjiSUiSEcBF2
X-Received: by 2002:a05:6000:230f:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-499c69cae4emr5038162f8f.18.1794415064910;
        Wed, 11 Nov 2026 08:37:44 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2bf91sm12200583f8f.23.2026.11.11.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:44 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 7/7] zorro: warp mfd: expose the Kickstart slot selection
Date: Wed, 11 Nov 2026 17:37:34 +0100
Message-ID: <20261111163735.227286-8-p.pisati@gmail.com>
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

The board keeps several Kickstart images and the ARM boots the 68k from
the selected one.

Writing kickslot makes the ARM reset the machine on the spot. That is
how the board works, not a crash.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 .../ABI/testing/sysfs-driver-warp-mfd         | 11 +++++
 drivers/zorro/warp-mfd.c                      | 49 +++++++++++++++++++
 drivers/zorro/warp-mfd.h                      |  7 +++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-warp-mfd b/Documentation/ABI/testing/sysfs-driver-warp-mfd
index a8213affb153..8cb7df076e15 100644
--- a/Documentation/ABI/testing/sysfs-driver-warp-mfd
+++ b/Documentation/ABI/testing/sysfs-driver-warp-mfd
@@ -40,3 +40,14 @@ KernelVersion:	7.5
 Contact:	Paolo Pisati <p.pisati@gmail.com>
 Description:
 		(RO) Fan drive, as a percentage.
+
+What:		/sys/bus/zorro/devices/zorro<N>/kickslot
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Paolo Pisati <p.pisati@gmail.com>
+Description:
+		(RW) Kickstart slot the ARM boots the 68k from. The board keeps
+		several Kickstart images.
+
+		Writing a slot number selects it and makes the ARM reset the
+		machine at once: that is how the board works, not a crash.
diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
index a438faeaa232..637ff4eccca3 100644
--- a/drivers/zorro/warp-mfd.c
+++ b/drivers/zorro/warp-mfd.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -302,6 +303,52 @@ out:									\
 }									\
 static DEVICE_ATTR_RO(name)
 
+static ssize_t kickslot_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct warp_mfd *warp = dev_get_drvdata(dev);
+	union warp_reply *rpl;
+
+	rpl = kmalloc_obj(*rpl);
+	if (!rpl)
+		return -ENOMEM;
+	ret = warp_get_status(warp, rpl);
+	if (ret)
+		goto out;
+	ret = sysfs_emit(buf, "%u\n", rpl->diag.kickstart_nr);
+out:
+	kfree(rpl);
+	return ret;
+}
+
+/*
+ * WARNING:
+ * changing softkick slot will initiate a forced reboot - your Amiga is not
+ * crashing, it's the ARM MCU that is abruptly pulling the plug
+ */
+static ssize_t kickslot_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct warp_mfd *warp = dev_get_drvdata(dev);
+	union warp_cmd *cmd;
+	int ret;
+
+	cmd = kzalloc_obj(*cmd);
+	if (!cmd)
+		return -ENOMEM;
+	cmd->hdr.cmd = WARP_CMD_SELECT_KICK;
+	ret = kstrtou8(buf, 10, &cmd->select_kick.kick_nr);
+	if (ret)
+		goto done;
+	ret = warp_exec_cmd(warp, cmd, NULL);
+done:
+	kfree(cmd);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(kickslot);
+
 warp_config_string_attr(boardname, board_name);
 warp_config_uint_attr(fanspeedpercent, fan_percent, "%u");
 warp_config_uint_attr(fmwver, fmw_ver, "%04X");
@@ -324,6 +371,8 @@ static struct attribute *warp_attrs[] = {
 	&dev_attr_tarm.attr,
 	&dev_attr_vbatt.attr,
 	&dev_attr_vcc5v.attr,
+	/* RW attr */
+	&dev_attr_kickslot.attr,
 	NULL
 };
 
diff --git a/drivers/zorro/warp-mfd.h b/drivers/zorro/warp-mfd.h
index 4fa09fa972d4..6bc7b38b5e4b 100644
--- a/drivers/zorro/warp-mfd.h
+++ b/drivers/zorro/warp-mfd.h
@@ -59,6 +59,7 @@
 
 /* Command opcodes. Only the ones this driver issues are listed. */
 enum warp_cmd_id {
+	WARP_CMD_SELECT_KICK	= 5,
 	WARP_CMD_GET_DIAG	= 6,
 };
 
@@ -72,8 +73,14 @@ struct warp_cmd_hdr {
 	u32	cmd;			/* enum warp_cmd_id */
 };
 
+struct warp_cmd_select_kick {
+	struct warp_cmd_hdr	hdr;
+	u8			kick_nr;
+};
+
 union warp_cmd {
 	struct warp_cmd_hdr		hdr;
+	struct warp_cmd_select_kick	select_kick;
 };
 
 struct warp_rpl_hdr {
-- 
2.43.0

