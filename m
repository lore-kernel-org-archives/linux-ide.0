From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] devres: release resources on device_del()
Date: Fri, 9 Mar 2007 19:34:19 +0900
Message-ID: <20070309103419.GB32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:52183 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993106AbXCIKeU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:34:20 -0500
Received: by wr-out-0506.google.com with SMTP id 71so1250763wri
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 02:34:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Some platform devices are driven without driver attached, so managed
resources can be acquired without driver attached.  Make sure such
resources are released by calling devres_release_all() in
device_del().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This one fixes oops on pata_platform and pata_legacy unload.  libata
being the only user of devres at the moment.  I think this can go
through libata-dev#upstream.

 drivers/base/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cf2a398..89ebe36 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -787,6 +787,13 @@ void device_del(struct device * dev)
 	device_remove_attrs(dev);
 	bus_remove_device(dev);
 
+	/*
+	 * Some platform devices are driven without driver attached
+	 * and managed resources may have been acquired.  Make sure
+	 * all resources are released.
+	 */
+	devres_release_all(dev);
+
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
-- 
1.5.0.1

