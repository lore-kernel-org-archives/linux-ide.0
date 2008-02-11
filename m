From: Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH] fix swim3.c modular build
Date: Mon, 11 Feb 2008 17:45:05 -0500
Message-ID: <20080211224505.GI4516@phobos.i.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:28583 "EHLO
	phobos.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbYBKWwD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 17:52:03 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ppc-dev@ozlabs.org
Cc: linux-ide@vger.kernel.org

While updating Fedora to 2.6.25-rc1, I noticed this little gem...

This swim3 and mediabay dependancy is pretty grody. Commit
34394e45c3387bd66619d9a51b4be507e4222b02 moved the ifdef around, which
meant the EXPORT_SYMBOL wasn't happening, which was bad, since if swim3
is built modularly, and CONFIG_PMAC_MEDIABAY is defined the internal
replacement isn't used.

Anyway, a powerpc person should probably look at making this less than
completely broken, but at least it will now build.

I'm not entirely sure why this is conditional at all, really.

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 9367882..635a140 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -416,9 +416,9 @@ static void poll_media_bay(struct media_bay_info* bay)
 	}
 }
 
-#ifdef CONFIG_MAC_FLOPPY
 int check_media_bay(struct device_node *which_bay, int what)
 {
+#ifdef CONFIG_MAC_FLOPPY
 	int	i;
 
 	for (i=0; i<media_bay_count; i++)
@@ -428,10 +428,10 @@ int check_media_bay(struct device_node *which_bay, int what)
 			media_bays[i].cd_index = -1;
 			return -EINVAL;
 		}
+#endif /* CONFIG_MAC_FLOPPY */
 	return -ENODEV;
 }
 EXPORT_SYMBOL(check_media_bay);
-#endif /* CONFIG_MAC_FLOPPY */
 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC
 int check_media_bay_by_base(unsigned long base, int what)
