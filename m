From: joe@perches.com
Subject: [PATCH] [390/2many] MAINTAINERS - PROMISE SATA TX2/TX4 CONTROLLER LIBATA DRIVER
Date: Sun, 12 Aug 2007 23:34:21 -0700
Message-ID: <46bffb6d.0uoUvwTD9BzOVPUV%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:1565 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932216AbXHMGef (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Aug 2007 02:34:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org, mikpe@it.uu.se, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index f61f0a8..19f2a5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3730,6 +3730,7 @@ P:	Mikael Pettersson
 M:	mikpe@it.uu.se
 L:	linux-ide@vger.kernel.org
 S:	Maintained
+F:	drivers/ata/sata_promise.*
 
 PS3 NETWORK SUPPORT
 P:	Masakazu Mokuno
