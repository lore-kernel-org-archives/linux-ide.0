From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: [PATCH #upstream 2/2] libata: track SLEEP state and issue SRST to wake it up
Date: Sat, 13 Oct 2007 21:02:09 -0400
Message-ID: <76366b180710131802s2f4e8b58g68fc5d15cd20d507@mail.gmail.com>
References: <20071012115631.GA11510@htj.dyndns.org>
	 <20071012115657.GB11510@htj.dyndns.org>
	 <76366b180710122157s506fd467m10181ceca7badf6f@mail.gmail.com>
	 <4710CE58.9060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:52273 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbXJNBCK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 21:02:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1125339rvb
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 18:02:10 -0700 (PDT)
In-Reply-To: <4710CE58.9060903@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Tejun,

This patch applied on top of your set works for me. It clears the
error mask and completes any ATA_CMD_SLEEP when the drive is already
sleeping. I tried `hdparm -Y` twice and it didn't loop like before.

Thanks,
-Andrew

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 45b781b..7e0627f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5763,6 +5763,16 @@ void ata_qc_issue(struct ata_queued_cmd *qc)

        /* if device is sleeping, schedule softreset and abort the link */
        if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
+               if (unlikely(qc->tf.command == ATA_CMD_SLEEP)) {
+                       /* to prevent a loop, do not wake up if sleeping
+                        * and a sleep cmd is sent. instead, simply clear
+                        * the error mask and complete as if it was
+                        * successful.
+                        */
+                       qc->err_mask = 0;
+                       ata_qc_complete(qc);
+                       return;
+               }
                link->eh_info.action |= ATA_EH_SOFTRESET;
                ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
                ata_link_abort(link);

On 10/13/07, Tejun Heo <htejun@gmail.com> wrote:
> Jeff, please forget about this patchset.  I'll re-post updated version.
