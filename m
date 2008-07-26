From: sivaji <rameshmrm@gmail.com>
Subject: Ultra DMA problem
Date: Sat, 26 Jul 2008 01:38:14 -0700 (PDT)
Message-ID: <18664594.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:42606 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYGZIiQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 04:38:16 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KMfI6-0005EY-KS
	for linux-ide@vger.kernel.org; Sat, 26 Jul 2008 01:38:14 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,
We are using MCF5253 procesoor. In this processor we have dedicated ATA DMA
controller.  Right now we are testing the ATA interface using the  PIO and
UDMA modes. PIO modes works perfectly. When moving to the  UDMA mode,  First
we configured the ATA DMA controller registers,  then we are setting the
command in the command register. 

Before configuring the ATA DMA Misccr Reigster the value of Device status
and Alternate status registers is 0x50. After configuring the Misccr
Registers the values of status and Alternate status register is 0x0. I don't
know why the STATUS register and ALTSTATUS register values are changing when
configuring the ATADMA Controller Register.  Due to this i am facing HSM
violation. Here i have attached the log. Give some idea to fix this issue.

Linux Version : 2.6.23-uc1

Thanks and Regards
Sivaji
-- 
View this message in context: http://www.nabble.com/Ultra-DMA-problem-tp18664594p18664594.html
Sent from the linux-ide mailing list archive at Nabble.com.

