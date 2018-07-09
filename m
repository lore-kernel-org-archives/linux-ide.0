From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 07/12] ide: use for_each_if
Date: Mon,  9 Jul 2018 10:36:45 +0200
Message-ID: <20180709083650.23549-7-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Avoids complaints from gcc about ambigious else clauses. Not that any
of those are likely to show up in ide ...

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
---
 include/linux/ide.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index c74b0321922a..1530d81319ef 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1601,7 +1601,7 @@ static inline void ide_set_drivedata(ide_drive_t *drive, void *data)
 
 #define ide_port_for_each_present_dev(i, dev, port) \
 	for ((i) = 0; ((dev) = (port)->devices[i]) || (i) < MAX_DRIVES; (i)++) \
-		if ((dev)->dev_flags & IDE_DFLAG_PRESENT)
+		for_each_if ((dev)->dev_flags & IDE_DFLAG_PRESENT)
 
 #define ide_host_for_each_port(i, port, host) \
 	for ((i) = 0; ((port) = (host)->ports[i]) || (i) < MAX_HOST_PORTS; (i)++)
-- 
2.18.0
