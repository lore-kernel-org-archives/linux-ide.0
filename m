From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: transport: Remove circular dependency at free
 time
Date: Mon, 6 Mar 2017 15:09:52 -0500
Message-ID: <20170306200952.GG19696@htj.duckdns.org>
References: <CAP8WD_ZJ9EgssJgTu8EOtKodtnfxO8tqhN6iAnuMHq2VQ7MoaQ@mail.gmail.com>
 <20170303170009.36744-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34370 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbdCFUKf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Mar 2017 15:10:35 -0500
Received: by mail-yw0-f194.google.com with SMTP id o4so2724481ywd.1
        for <linux-ide@vger.kernel.org>; Mon, 06 Mar 2017 12:09:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170303170009.36744-1-gwendal@chromium.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: gregkh@linuxfoundation.org, sergei.shtylyov@cogentembedded.com, linux-ide@vger.kernel.org

Hello,

Applied the following to libata/for-4.11-fixes.

Thanks.
------ 8< ------
>From d4a32919c3d9c959af268d33bab24eb134dab0cc Mon Sep 17 00:00:00 2001
From: Gwendal Grignou <gwendal@chromium.org>
Date: Fri, 3 Mar 2017 09:00:09 -0800
Subject: [PATCH] libata: transport: Remove circular dependency at free time

Without this patch, failed probe would not free resources like irq.

ata port tdev object currently hold a reference to the ata port
object.  Therefore the ata port object release function will not get
called until the ata_tport_release is called. But that would never
happen, releasing the last reference of ata port dev is done by
scsi_host_release, which is called by ata_host_release when the ata
port object is released.

The ata_tranport device objects actually do not need to explicitly
hold a reference to their real counterpart, given the transport
objects are the children of these objects and device_add() is call for
each child.  We know the parent will not be deleted until we call the
child's device_del().

Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-transport.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 4669823..19e6e53 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -224,7 +224,6 @@ static DECLARE_TRANSPORT_CLASS(ata_port_class,
 
 static void ata_tport_release(struct device *dev)
 {
-	put_device(dev->parent);
 }
 
 /**
@@ -284,7 +283,7 @@ int ata_tport_add(struct device *parent,
 	device_initialize(dev);
 	dev->type = &ata_port_type;
 
-	dev->parent = get_device(parent);
+	dev->parent = parent;
 	dev->release = ata_tport_release;
 	dev_set_name(dev, "ata%d", ap->print_id);
 	transport_setup_device(dev);
@@ -348,7 +347,6 @@ static DECLARE_TRANSPORT_CLASS(ata_link_class,
 
 static void ata_tlink_release(struct device *dev)
 {
-	put_device(dev->parent);
 }
 
 /**
@@ -410,7 +408,7 @@ int ata_tlink_add(struct ata_link *link)
 	int error;
 
 	device_initialize(dev);
-	dev->parent = get_device(&ap->tdev);
+	dev->parent = &ap->tdev;
 	dev->release = ata_tlink_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
@@ -589,7 +587,6 @@ static DECLARE_TRANSPORT_CLASS(ata_dev_class,
 
 static void ata_tdev_release(struct device *dev)
 {
-	put_device(dev->parent);
 }
 
 /**
@@ -662,7 +659,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	int error;
 
 	device_initialize(dev);
-	dev->parent = get_device(&link->tdev);
+	dev->parent = &link->tdev;
 	dev->release = ata_tdev_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
-- 
2.9.3

