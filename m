From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 12:17:36 -0400
Message-ID: <48A30920.5030803@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:49216 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbYHMQRg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 12:17:36 -0400
In-Reply-To: <48A2CE09.9090806@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Artem Bokhan wrote:
> When I run 'dd if=/dev/sda of=/dev/null skip=9700 bs=1M' and it meets 
> bad block, it takes about 
> '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/timeout 
> + about 10 seconds' to determine I/O error. Until that IO to device is 
> locked, as I understand. I want to reduce the time of lock as  much as 
> possible.
..

Tell the SCSI layer to stop flogging the drive with unnecessary retries.
A quick and dirty way, is this patch below, but it really should be more
intelligent than this for some situations:

--- linux/include/scsi/sd.h.orig	2008-06-09 14:27:19.000000000 -0400
+++ linux/include/scsi/sd.h	2008-08-13 12:16:01.000000000 -0400
@@ -23,7 +23,7 @@
 /*
  * Number of allowed retries
  */
-#define SD_MAX_RETRIES		5
+#define SD_MAX_RETRIES		1
 #define SD_PASSTHROUGH_RETRIES	1
 
 /*
