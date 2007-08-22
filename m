From: "chia-ming liu" <chiaming.liu@gmail.com>
Subject: (unknown)
Date: Tue, 21 Aug 2007 20:40:58 -0500
Message-ID: <114377ad0708211840i638c4cb4v4187caab39868a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:63708 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXHVBlC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 21:41:02 -0400
Received: by nf-out-0910.google.com with SMTP id g13so16904nfb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 18:41:00 -0700 (PDT)
Subject: 
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org, liuc@okstate.edu

Dear Tejun, I am not very good at linux and just enough to get by. I
have tried to use your patch by issuing the command 'patch -p1 <
combined.patch' and I receive this

msvlsi63:~/libata-tj-2.6.18.1-20061020 # patch -p1 < combined.patch
can't find file to patch at input line 5
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|Index: work/drivers/scsi/Kconfig
|===================================================================
|--- work.orig/drivers/scsi/Kconfig     2006-10-20 10:48:25.000000000 +0900
|+++ work/drivers/scsi/Kconfig  2006-10-20 10:48:35.000000000 +0900
--------------------------
File to patch:

Then, I opened combined.path and look for line 5

 source "drivers/scsi/megaraid/Kconfig.megaraid"

which point out the file I don't have. Am I missing something? I have
Opensuse 10.2 and Norco DS-1220 disk array which has Silicon Image
3726 port multiplier.

I don't have any driver install but Suse has recognized the PCI card
with Silicon Image 3124.

Thanks!

--------------------------------------------------------------
Chia-Ming Liu, Ph.D.
Mixed Signal VLSI Design Group
Advanced Technology Research Center 235
Oklahoma State University

Website: http://cottonmouth.ecen.okstate.edu
US Mail: 202 Engineering South Stillwater, OK 74078
Phone: 405-744-6241, 405-744-4580
Fax: 405-744-9198
