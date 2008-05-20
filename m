From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream-fixes] git tree available
Date: Tue, 20 May 2008 13:43:43 +0900
Message-ID: <483256FF.1010200@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca> <4832535B.1080505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050709090401010903030500"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:54242 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbYETEnv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 00:43:51 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1820723rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 21:43:50 -0700 (PDT)
In-Reply-To: <4832535B.1080505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Brian & Chamaigne Scamman <scammanbc@earthlink.net>, jeff@garzik.org, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050709090401010903030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Mark Lord wrote:
>> Brian & Chamaigne Scamman wrote:
>>> Tejun-
>>>
>>> The hotplug fixes didn't solve the problem. After adding some "logic
>>> monitoring" statements, I found that the successful discovery of the 
>>> drives
>>> depends on the response from sil24_exec_polled_cmd.
>>>
>>> If the call from ata_wait_register is 327680, the drives are 
>>> recognized; if
>>> the response is 262144 the drives have timed out.
>>>
>>> I've also noticed that the drives respond to the EH entering with 
>>> DevExch
>>> vs. PHY RDY changed.
>>>
>>> Bottom line, the drives seem to be recognized almost every time I attach
>>> them to the PMP after the EH has completed processing the empty PMP.  
>>> If the
>>> drives are attached to the PMP before the PMP is attached to the 
>>> controller,
>>> the drives are almost never recognized (EH times out).
> 
> Can you please describe what you did exactly?  sil3726/4726 has some 
> problems when its first fan out port goes online and offline while it's 
> powered up.  You want to keep it occupied at all times.
> 
> Also, does putting sslep(5) right before followup-SRST help?

Can you please test whether the attached patch fixes the detection problem?

-- 
tejun

--------------050709090401010903030500
Content-Type: text/x-patch;
 name="simg3726-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simg3726-debug.patch"

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3374ec5..b65db30 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -322,9 +322,12 @@ static void sata_pmp_quirks(struct ata_port *ap)
 	if (vendor == 0x1095 && devid == 0x3726) {
 		/* sil3726 quirks */
 		ata_port_for_each_link(link, ap) {
-			/* class code report is unreliable */
+			/* Class code report is unreliable and SRST
+			 * times out under certain configurations.
+			 */
 			if (link->pmp < 5)
-				link->flags |= ATA_LFLAG_ASSUME_ATA;
+				link->flags |= ATA_LFLAG_NO_SRST |
+					       ATA_LFLAG_ASSUME_ATA;
 
 			/* port 5 is for SEMB device and it doesn't like SRST */
 			if (link->pmp == 5)

--------------050709090401010903030500--
