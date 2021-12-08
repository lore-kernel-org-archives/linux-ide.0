Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5987C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhLHQjC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37904 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbhLHQgp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1E4021FE28;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iN3cK2VHX+VmVB3ofzA1JsgUAigs+HBPN3jip7ZN41E=;
        b=JOBaFAx5aAkwl5aC6tTfTA3vmmUocWN+Dpb+4f/Sd12q3zT28Eut4kKA26hkt5JWRg0Ur7
        1zY317h+07vGri9ZJBeXurjNvDRH+EhpGDLet9hvClFb3nG1SlMA0SloDQfzRTX9RpOb8y
        eQ6NU2tAGB9RpNuOc/7jQYY8PJmZezw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iN3cK2VHX+VmVB3ofzA1JsgUAigs+HBPN3jip7ZN41E=;
        b=Kf5MkDvnCVoiwhZspDZhm1lIbmCCIuKiQxWiNMN2sTl0s3fHGp/K0+mXNrMWWFHRIsA1/J
        F/52YnV3xSAzS4DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1A7DCA3BC9;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 171D35191FC7; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 53/73] libata: remove debug compilation switches
Date:   Wed,  8 Dec 2021 17:32:35 +0100
Message-Id: <20211208163255.114660-54-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Unused now, so remove them.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/libata.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6bfbb419e141..ea3478d02cf5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -39,25 +39,9 @@
  * compile-time options: to be removed as soon as all the drivers are
  * converted to the new debugging mechanism
  */
-#undef ATA_DEBUG		/* debugging output */
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
-#undef ATA_NDEBUG		/* define to disable quick runtime checks */
 
 
-/* note: prints function name for you */
-#ifdef ATA_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#ifdef ATA_VERBOSE_DEBUG
-#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define VPRINTK(fmt, args...)
-#endif	/* ATA_VERBOSE_DEBUG */
-#else
-#define DPRINTK(fmt, args...)
-#define VPRINTK(fmt, args...)
-#endif	/* ATA_DEBUG */
-
 #define ata_print_version_once(dev, version)			\
 ({								\
 	static bool __print_once;				\
-- 
2.29.2

