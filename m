From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Hard freeze / interrupt-related death / instability
Date: Wed, 09 Apr 2008 00:47:26 +0200
Message-ID: <87skxwynep.fsf@denkblock.local>
References: <d55656c10804080627r6cb7ba2ao37476b602e4f157e@mail.gmail.com>
	<1207687673.3091.12.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:56049 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbYDHWrd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Apr 2008 18:47:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Gervai <grinapo@gmail.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

--=-=-=

Hi there,

Thomas Renninger <trenn@suse.de> wrote:
> Hi,
>
> I expect this is more a ata/ahci or chipset problem (this is ICH7,
> right?), maybe ide list has an idea or has seen something similar
> already?
[...]
> On Tue, 2008-04-08 at 15:27 +0200, Peter Gervai wrote:
[...]
>> Kernel: vanilla, released 2.6.24.* (right now .2, doesn't seem to matter)
>> Hw: board Intel D945PVS, cpu Intel(R) Pentium(R) D CPU 3.00GHz (Type 0, Family
>> 15, Model 6, Stepping 2), ram 2G, 2 SATA HDD (AHCI), 1 IDE HDD, 1 DVDROM, usb
>> mouse, onboard e1000 eth, onboard intel HDA sound, NVidia 8400 GS, madwifi
>> driven pci card.
[...]
>> 
>> The machine started to "freeze" daily/2-3 daily, somwehere around the
>> upgrade to 2.6.24
[...]
>> 
>> The freeze occurs under Xwindow and usually goes the way that mouse became
>> _extremely_ jerky, cpu load goes up and usege on both cores top 100%, often the
>> hdd led stays lit. (That's why I started to blame sata/disks first.)
>> 
>> While the mouse works (kind of), the system isn't usable, and dies instantly
>> (hard freeze) if I try to switch to console (by any means, including UnRaw/SAK
>> sysrq combinations).

I wonder whether this could be related to an issue I brought up several
weeks ago. See [1] for a summary of the thread.

If you're alright with patching and compiling, you might give the
following patch a try.

Hope that helps,

Elias

[1] <http://permalink.gmane.org/gmane.linux.ide/28348>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=adjust-blocked-counters.patch

---

 drivers/ata/libata-scsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index df25aa4..5bc33a0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -823,7 +823,7 @@ static void ata_scsi_sdev_config(struct scsi_device *sdev)
 	 * prevent SCSI midlayer from automatically deferring
 	 * requests.
 	 */
-	sdev->max_device_blocked = 1;
+	sdev->max_device_blocked = 2;
 }
 
 static void ata_scsi_dev_config(struct scsi_device *sdev,
@@ -3204,7 +3204,7 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 		 * Set host_blocked to 1 to prevent SCSI midlayer from
 		 * automatically deferring requests.
 		 */
-		shost->max_host_blocked = 1;
+		shost->max_host_blocked = 2;
 
 		rc = scsi_add_host(ap->scsi_host, ap->host->dev);
 		if (rc)

--=-=-=--
