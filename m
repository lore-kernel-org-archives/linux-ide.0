From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Fwd: Re: libata , Silicon Image 3124]
Date: Tue, 08 Jan 2008 12:47:15 +0900
Message-ID: <4782F243.6060606@gmail.com>
References: <473A5B03.2020808@gmail.com> <4780B387.1050600@kasimir-mueller.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020506010903060704030904"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:45008 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYAHDrW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 22:47:22 -0500
Received: by po-out-1718.google.com with SMTP id c31so1786476poi.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 19:47:21 -0800 (PST)
In-Reply-To: <4780B387.1050600@kasimir-mueller.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-15?Q?Kasimir_M=FCller?= <kjm@kasimir-mueller.de>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, christian.kuehn@hamburg.de

This is a multi-part message in MIME format.
--------------020506010903060704030904
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Kasimir Müller wrote:
> Hi Tejun,
> 
> Old communication appended below.
> 
> I wish you a Happy Xmas and a successful New Year.
> 
> I spent some time during Christmas to further investigate the problem. I
> bought a new 500GB disk and put all data on this disk.
> This is also contineously watched by nagios and cacti
> Then
> 1.) All 5 disks in the external case connected via Portmapper and sil24
> card have excellent health-status with smartd.
> 2.) I get no(!!!!) errors at all if I use the disks as single drives or
> with lvm. I verified this by copying large amounts of data (100-200GB)
>      with rsync , cp-av and running bonnie++ single and simultaneously 
> to  various combinations of drives.
> 3.) I get the errors as soon as I use raid. Same errors with raid0 (2
> disks), 1 (2 disks), 5 (3 disks) in any combination of the drives
> 4.) The errors appear usually first during mkfs (same with ext3 and
> reiserfs) and than
>      after writing about 10-50 GB to the raid, and repeat then at 5 to
> 10 minute intervals according the disk activity.
> 5.) I used Kernel 2.6.23.1 with Your latest patch: same result
> 6.) I used kernel 2.6.24 patch rc-6 : same result
> 7.) during the tests I marked all files with md5-sums:  No data
> corruption (!!!), so maybe I can live with it.

Please apply the attached patch on top of 2.6.24-rc6 and report whether
anything changes.

Thanks.

-- 
tejun

--------------020506010903060704030904
Content-Type: text/x-patch;
 name="propagate-timeout-to-host-link.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="propagate-timeout-to-host-link.patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f0124a8..74269ed 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1733,11 +1733,15 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.action &= ~ATA_EH_PERDEV_MASK;
 	}
 
-	/* consider speeding down */
+	/* propagate timeout to host link */
+	if ((all_err_mask & AC_ERR_TIMEOUT) && !ata_is_host_link(link))
+		ap->link.eh_context.i.err_mask |= AC_ERR_TIMEOUT;
+
+	/* record error and consider speeding down */
 	dev = ehc->i.dev;
-	if (!dev && ata_link_max_devices(link) == 1 &&
-	    ata_dev_enabled(link->device))
-		dev = link->device;
+	if (!dev && ((ata_link_max_devices(link) == 1 &&
+		      ata_dev_enabled(link->device))))
+	    dev = link->device;
 
 	if (dev)
 		ehc->i.action |= ata_eh_speed_down(dev, is_io, all_err_mask);
@@ -1759,8 +1763,14 @@ void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_link *link;
 
-	__ata_port_for_each_link(link, ap)
+	ata_port_for_each_link(link, ap)
 		ata_eh_link_autopsy(link);
+
+	/* Autopsy of fanout ports can affect host link autopsy.
+	 * Perform host link autopsy last.
+	 */
+	if (ap->nr_pmp_links)
+		ata_eh_link_autopsy(&ap->link);
 }
 
 /**

--------------020506010903060704030904--
