From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata: add ata_id_has_sata() and use it in ata_id_has_ncq()
Date: Mon, 17 Jul 2006 15:52:31 +0900
Message-ID: <11531191512856-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:59265 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751321AbWGQGvN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:13 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398403nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:12 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

If word 76 is 0 or 0xffff, all SATA IDENTIFY words are invalid.  Add
ata_id_has_sata() for this test and use it in ata_id_has_ncq().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/ata.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

bd18162e08a1508a802a188d6cec69ac3cd5bc8b
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 3671af8..a7798c3 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -286,7 +286,8 @@ #define ata_id_has_wcache(id)	((id)[82] 
 #define ata_id_has_pm(id)	((id)[82] & (1 << 3))
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
-#define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
+#define ata_id_has_sata(id)	((id)[76] && (id)[76] != 0xffff)
+#define ata_id_has_ncq(id)	(ata_id_has_sata(id) && ((id)[76] & (1 << 8)))
 #define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
-- 
1.3.2


