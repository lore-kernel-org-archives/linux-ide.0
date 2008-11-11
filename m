From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Tue, 11 Nov 2008 11:56:16 +0900
Message-ID: <4918F450.50404@kernel.org>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org> <20081018165209.GA7754@cleopatra.jogback.se> <20081023181443.GA7323@cleopatra.jogback.se> <49056F2C.20101@kernel.org> <49056FEA.4070405@kernel.org> <20081027194038.GA7004@cleopatra.jogback.se> <4917D8F6.4020305@kernel.org> <20081110182628.GA6281@cleopatra.jogback.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060003000808090901030404"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53865 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbYKKC4Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 21:56:25 -0500
In-Reply-To: <20081110182628.GA6281@cleopatra.jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lars Michael Jogback <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060003000808090901030404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Lars Michael Jogback wrote:
>> Can you please try the attached patch and see whether anything is
>> different?
> 
> Yes, it made it working.

Heh... Okay, that's unexpected.

> You don't think it has something todo with the spin-up time?
> 
> The spin-up time on these disks is quite long:
> smartctl -a /dev/sdn | grep Spin_Up_Time
>   3 Spin_Up_Time            0x0007   068   068   011    Pre-fail  Always       -       10240

Maybe but I don't know.  Spin up is usually waited upon by device
readiness wait after SRST which libata does every time it probes or
resets a device behind PMP.  The drive is bringing link down briefly
after SRST is complete.  It doesn't make much sense.  Maybe some
quirkiness in the firmware?

Can you please try the attached patch?  If it doesn't work, please
increment the constant 200LU by 100 each time and find out where it
starts to work.

Thanks.

-- 
tejun

--------------060003000808090901030404
Content-Type: text/x-patch;
 name="deb-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="deb-debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0cd3ad4..7f1a469 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3799,10 +3799,17 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 		       unsigned long deadline)
 {
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	const unsigned long *t = sata_ehc_deb_timing(&link->eh_context);
+	unsigned long timing[3] = { t[0], t[1], t[2] };
 	bool online;
 	int rc;
 
+	ata_link_printk(link, KERN_INFO, "XXX0 hardreset debounce %lu %lu %lu\n",
+			timing[0], timing[1], timing[2]);
+	timing[1] = max(timing[1], 200LU);
+	ata_link_printk(link, KERN_INFO, "XXX1 hardreset debounce %lu %lu %lu\n",
+			timing[0], timing[1], timing[2]);
+
 	/* do hardreset */
 	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
 	return online ? -EAGAIN : rc;

--------------060003000808090901030404--
