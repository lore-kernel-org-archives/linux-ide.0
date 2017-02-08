From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Wed, 8 Feb 2017 14:43:30 -0500
Message-ID: <20170208194330.GB25826@htj.duckdns.org>
References: <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org>
 <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
 <20170120191946.GA9280@mtj.duckdns.org>
 <20170120193828.GB9280@mtj.duckdns.org>
 <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
 <CAP8WD_aya3junhovXtc=iUaaX43=Y1s8-eya_LvN_BQjXGLbew@mail.gmail.com>
 <20170124161937.GE12281@htj.duckdns.org>
 <CAP8WD_b2PXXXQgTQ_-a=8Z7ppNMa5xGuhsEvJGDT_WvT1EFwog@mail.gmail.com>
 <CAMHSBOUAMxTj7u5Jg4_VkxHmG5BUCr-AhDHY2UT+VMchn8daLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36588 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdBHTnr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2017 14:43:47 -0500
Received: by mail-yb0-f193.google.com with SMTP id o65so6573343ybo.3
        for <linux-ide@vger.kernel.org>; Wed, 08 Feb 2017 11:43:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMHSBOUAMxTj7u5Jg4_VkxHmG5BUCr-AhDHY2UT+VMchn8daLQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: whiteheadm@acm.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

On Tue, Feb 07, 2017 at 12:21:37PM -0800, Gwendal Grignou wrote:
> I am wondering if we don't have a circular dependency:
> We do the final put_device (in scsi_host_put) on ap->scsi_host in
> ata_host_release(), but it is not called because
> [scsi_host]->shost_gendev.parent is &ap->tdev which hold the put on
> its parent, ap.
> 
> If my understanding is correct, as Tejun pointed out, removing the put
> on ap in ata_tport_release and the get_device(parent) in ata_tport_add
> should unlock the situation.

Heh, I'm not quite sure I follow but something like the following, right?

Matthew, can you please give this a try?

Thanks.

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 7ef16c0..20e2b7a 100644
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
