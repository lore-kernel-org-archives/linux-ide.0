From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] [POWERPC] Fix build errors when BLOCK=n
Date: Mon, 17 Sep 2007 23:34:42 +0100
Message-ID: <16939.1190068482@redhat.com>
References: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756524AbXIQWez (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Sep 2007 18:34:55 -0400
In-Reply-To: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
Cc: dhowells@redhat.com, paulus@samba.org, kumar.gala@Freescale.com, linuxppc-dev@ozlabs.org, bzolnier@gmail.com, linux-ide@vger.kernel.org


Try the attached.

David
---
[PATCH] VFS: Make BSG declarations dependent on CONFIG_BLOCK

From: David Howells <dhowells@redhat.com>

Make BSG function declarations dependent on CONFIG_BLOCK as they are not
compilable if the block layer is compiled out.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/bsg.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/bsg.h b/include/linux/bsg.h
index 60e377b..28f5d44 100644
--- a/include/linux/bsg.h
+++ b/include/linux/bsg.h
@@ -52,6 +52,7 @@ struct sg_io_v4 {
 };
 
 #ifdef __KERNEL__
+#ifdef CONFIG_BLOCK
 
 #if defined(CONFIG_BLK_DEV_BSG)
 struct bsg_class_device {
@@ -73,6 +74,7 @@ static inline void bsg_unregister_queue(struct request_queue *rq)
 }
 #endif
 
+#endif /* CONFIG_BLOCK */
 #endif /* __KERNEL__ */
 
 #endif
