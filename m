From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [REGRESSION] 8a3e33cf92c7 "ata: ahci: find eSATA ports and flag
 them as removable" changes userspace behavior
Date: Thu, 25 Feb 2016 20:09:10 +0100
Message-ID: <CAOLZvyG4JAdir0F1b2V==qdkM0+NvqxviQeqZ86t=0rbqys7oQ@mail.gmail.com>
References: <56CF35FA.1070500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35233 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114AbcBYTJw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 14:09:52 -0500
In-Reply-To: <56CF35FA.1070500@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 25, 2016 at 6:12 PM, Laura Abbott <labbott@redhat.com> wrote:
> Hi,
>
> We received a bugzilla report
> https://bugzilla.redhat.com/show_bug.cgi?id=1310682
> of partitions being automounted unexpectedly. Testing showed that
> 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as removable") was
> responsible.
> This seems to be classified as 'breaking' userspace given that this behavior
> results
> in partitions that were previously unmounted now being being mounted
> unwanted
> automatically which is unwanted behavior for the user. Can we revert this
> patch or
> give a fix to change this behavior?

Can you test this?  I think the old HPCP bit should just be ignored,
although windows does use it, i.e. when I enable hotplug capability
in the bios on my desktop it shows the  "eject device" icon for a device
attached to the port on the motherboard, we probably can ignore it
on linux to not break all automounting distros.  On my laptop, where
I care about this, it still works as intended.

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4029679..e029e3c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1164,8 +1164,7 @@ static void ahci_port_init(struct device *dev,
struct ata_port *ap,

        /* mark esata ports */
        tmp = readl(port_mmio + PORT_CMD);
-       if ((tmp & PORT_CMD_HPCP) ||
-           ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)))
+       if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
                ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
