From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 22 Aug 2007 15:39:19 +0900
Message-ID: <46CBDA17.6010009@gmail.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com> <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com> <46CBCD18.7070507@gmail.com> <B209C20A-580B-4AD6-A6A0-B4377499B8FC@infogears.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070501090101010608060108"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:15440 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbXHVGjZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 02:39:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so70267rvb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 23:39:24 -0700 (PDT)
In-Reply-To: <B209C20A-580B-4AD6-A6A0-B4377499B8FC@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Conover <rconover@infogears.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070501090101010608060108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Does the attached patch make any difference?

-- 
tejun

--------------070501090101010608060108
Content-Type: text/plain;
 name="debug2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug2"

---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

Index: work1/drivers/ata/libata-core.c
===================================================================
--- work1.orig/drivers/ata/libata-core.c
+++ work1/drivers/ata/libata-core.c
@@ -6211,6 +6211,7 @@ int sata_link_init_spd(struct ata_link *
 	spd = (scontrol >> 4) & 0xf;
 	if (spd)
 		link->hw_sata_spd_limit &= (1 << spd) - 1;
+	link->hw_sata_spd_limit = 1
 
 	link->sata_spd_limit = link->hw_sata_spd_limit;
 

--------------070501090101010608060108--
