From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Fri, 11 Jan 2008 16:49:28 +0900
Message-ID: <47871F88.8070109@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com> <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca> <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca> <4785BD03.10809@gmail.com> <4786C42A.10403@shaw.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090201080801090000090805"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:60792 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759646AbYAKHte (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 02:49:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so853914rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 23:49:34 -0800 (PST)
In-Reply-To: <4786C42A.10403@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201080801090000090805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Ryder wrote:
> For the regular power on detected, are you referring to cold/warm
> booting the system and verifying initialization or only power cycling
> the 4726?
> 
> Here are my test results, TestingRoutine.txt is the procedure I followed
> and test results obtained. If I missed something, please let me know.
> 
> From what I could find, the problem with ata1.03 not being detected is
> consistent with the port. In my testing, I moved the last drive to the
> 5th port on the 4726 and the problem carried through. The issue seemed
> to only occur when the 4726 was powered on/off, not when it was
> unplugged and re-plugged with the power on.
> 
> If I have some time on the weekend, I will do a test routine of several
> hot un-plugs / re-plugs of the 4726 and see what happens.

Thanks a lot for all the testing.  Can you please apply the attached
patch and see whether things improve?

Thanks.

-- 
tejun

--------------090201080801090000090805
Content-Type: text/x-patch;
 name="sil24-freeze-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sil24-freeze-fix.patch"

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b4c674d..864c1c1 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -301,7 +301,7 @@ static struct sil24_cerr_info {
 	[PORT_CERR_PKT_PROT]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
 				    "invalid data directon for ATAPI CDB" },
 	[PORT_CERR_SGT_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_SOFTRESET,
-				     "SGT no on qword boundary" },
+				     "SGT not on qword boundary" },
 	[PORT_CERR_SGT_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
 				    "PCI target abort while fetching SGT" },
 	[PORT_CERR_SGT_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
@@ -1094,10 +1094,13 @@ static void sil24_error_intr(struct ata_port *ap)
 		if (ci && ci->desc) {
 			err_mask |= ci->err_mask;
 			action |= ci->action;
+			if (action & ATA_EH_RESET_MASK)
+				freeze = 1;
 			ata_ehi_push_desc(ehi, "%s", ci->desc);
 		} else {
 			err_mask |= AC_ERR_OTHER;
 			action |= ATA_EH_SOFTRESET;
+			freeze = 1;
 			ata_ehi_push_desc(ehi, "unknown command error %d",
 					  cerr);
 		}

--------------090201080801090000090805--
