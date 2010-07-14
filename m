From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Wed, 14 Jul 2010 14:26:39 +0200
Message-ID: <4C3DACFF.2060504@kernel.org>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>    <4B5D26EF.4030709@kernel.org> <loom.20100205T041929-66@post.gmane.org>    <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>    <13096cdf5e0e6704e30364a746e60467.squirrel@thechecks.ca> <8276efbfebcbfc3e58033ab8d5996d9d.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090408050706020008020002"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40334 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab0GNM0p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jul 2010 08:26:45 -0400
In-Reply-To: <8276efbfebcbfc3e58033ab8d5996d9d.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090408050706020008020002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

On 07/12/2010 06:36 PM, Paul Check wrote:
>> Tejun & Co:
>>
>> I have finally upgraded to the 2.6.34 kernel, and I am still having
>> problems with some of my drives not coming up some of the time (different
>> drives, at different times, never more than one).
>>
>> Here are some lines from /var/log/messages on the most recent boot below.
>> Do you have any suggestions for this? I'm getting tired of having to
>> reconstitute my raid 30-50% of the time, and will try anything to see if
>> it fixes. Note the "link up (unknown)" and "link down" lines. I don't know
>> what should appear, but I have 4 hard drives and one optical drive plugged
>> into 5 of the 6 SATA ports on the board.
...
>> Jul 12 12:25:22 min kernel: [    2.078489] ata2.01: SATA link up <unknown>
>> (SStatus 300 SControl 123)

Hmm, yeah, it seems like SCR access via SIDPR is more flaky than
covered by the previous commit.  There's another thread where similar
problem is being debugged.  Can you please do the following?  I'm
attaching patch here too.

  http://thread.gmane.org/gmane.linux.kernel/1005983/focus=46749

Thanks.

-- 
tejun

--------------090408050706020008020002
Content-Type: text/x-patch;
 name="resume-dbg-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="resume-dbg-1.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2984e45..ce87bfe 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3712,7 +3712,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		     unsigned long deadline)
 {
 	int tries = ATA_LINK_RESUME_TRIES;
-	u32 scontrol, serror;
+	u32 scontrol, scontrol1, serror;
 	int rc;
 
 	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
@@ -3739,6 +3739,14 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			return rc;
 	} while ((scontrol & 0xf0f) != 0x300 && --tries);
 
+	/* check once more */
+	msleep(100);
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol1)))
+			return rc;
+	ata_link_printk(link, KERN_ERR,
+			"XXX SControl after resume = %X %X, tries=%d\n",
+			scontrol, scontrol1, ATA_LINK_RESUME_TRIES - tries + 1);
+
 	if ((scontrol & 0xf0f) != 0x300) {
 		ata_link_printk(link, KERN_ERR,
 				"failed to resume link (SControl %X)\n",
@@ -6007,7 +6015,7 @@ static void async_port_probe(void *data, async_cookie_t cookie)
 
 		ehi->probe_mask |= ATA_ALL_DEVICES;
 		ehi->action |= ATA_EH_RESET | ATA_EH_LPM;
-		ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+		ehi->flags |= ATA_EHI_NO_AUTOPSY/* | ATA_EHI_QUIET*/;
 
 		ap->pflags &= ~ATA_PFLAG_INITIALIZING;
 		ap->pflags |= ATA_PFLAG_LOADING;

--------------090408050706020008020002--
