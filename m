From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Unregister devices if initialization fails.
Date: Tue, 27 Jan 2009 17:41:44 +0100
Message-ID: <200901271741.44704.bzolnier@gmail.com>
References: <1232715869-31039-1-git-send-email-Ian.Campbell@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:62111 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbZA0QmN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 11:42:13 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1471163eye.37
        for <linux-ide@vger.kernel.org>; Tue, 27 Jan 2009 08:42:12 -0800 (PST)
In-Reply-To: <1232715869-31039-1-git-send-email-Ian.Campbell@citrix.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Friday 23 January 2009, Ian Campbell wrote:
> On reboot the loop in device_shutdown gets confused by these devices
> and goes into an infinite loop. I think this is because they don't
> have dev->bus or dev->driver which is because hwif_register_devices
> doesn't get called if !hwif->present.
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-probe.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index 312127e..120f65b 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -1520,6 +1520,8 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
>  		if (hwif_init(hwif) == 0) {
>  			printk(KERN_INFO "%s: failed to initialize IDE "
>  					 "interface\n", hwif->name);
> +			device_unregister(&hwif->gendev);
> +			device_destroy(ide_port_class, MKDEV(0, 0));
>  			hwif->present = 0;

I've been wondering about this a bit and I think that we should just nuke
port from struct ide_host in such situation so I added ide_disable_port()
helper for this (+ fixed ide_register_port() handling while at it).

Could you please re-base your fix on top of attached patch?

Please also remove superflous device_destroy() call -- device_unregister()
should be enough and if it is not we need to fix ide_register_port() to
use unique dev_t instead of MKDEV(0, 0).

>  			continue;
>  		}
> @@ -1550,11 +1552,11 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
>  		if (hwif == NULL)
>  			continue;
>  
> -		ide_sysfs_register_port(hwif);
> -		ide_proc_register_port(hwif);
> -
> -		if (hwif->present)
> +		if (hwif->present) {
> +			ide_sysfs_register_port(hwif);
> +			ide_proc_register_port(hwif);
>  			ide_proc_port_register_devices(hwif);

This code have to stay unchanged for proper warm-plug support
(luckily after re-basing this chunk shouldn't be needed).

Here is the ide_disable_port() patch:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix ide_register_port() failure handling

* Factor out port freeing from ide_host_free() to ide_free_port().

* Add ide_disable_port() and use it on ide_register_port() failure.

Cc: Ian Campbell <Ian.Campbell@citrix.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1466,6 +1466,30 @@ struct ide_host *ide_host_alloc(const st
 }
 EXPORT_SYMBOL_GPL(ide_host_alloc);
 
+static void ide_port_free(ide_hwif_t *hwif)
+{
+	ide_port_free_devices(hwif);
+	ide_free_port_slot(hwif->index);
+	kfree(hwif);
+}
+
+static void ide_disable_port(ide_hwif_t *hwif)
+{
+	struct ide_host *host = hwif->host;
+	int i;
+
+	printk(KERN_INFO "%s: disabling port\n", hwif->name);
+
+	for (i = 0; i < MAX_HOST_PORTS; i++) {
+		if (host->ports[i] == hwif) {
+			host->ports[i] = NULL;
+			host->n_ports--;
+		}
+	}
+
+	ide_port_free(hwif);
+}
+
 int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
 		      hw_regs_t **hws)
 {
@@ -1506,8 +1530,12 @@ int ide_host_register(struct ide_host *h
 			hwif->present = 1;
 
 		if (hwif->chipset != ide_4drives || !hwif->mate ||
-		    !hwif->mate->present)
-			ide_register_port(hwif);
+		    !hwif->mate->present) {
+			if (ide_register_port(hwif)) {
+				ide_disable_port(hwif);
+				continue;
+			}
+		}
 
 		if (hwif->present)
 			ide_port_tune_devices(hwif);
@@ -1659,12 +1687,8 @@ void ide_host_free(struct ide_host *host
 	int i;
 
 	ide_host_for_each_port(i, hwif, host) {
-		if (hwif == NULL)
-			continue;
-
-		ide_port_free_devices(hwif);
-		ide_free_port_slot(hwif->index);
-		kfree(hwif);
+		if (hwif)
+			ide_port_free(hwif);
 	}
 
 	kfree(host);
