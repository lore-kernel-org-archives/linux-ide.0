From: hab <hab@hbahr.org>
Subject: libata patches in 2.6.7bk6 Hang Maxtor on SP bridge
Date: Mon, 28 Jun 2004 17:07:50 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E096B6.8090108@hbahr.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060709000700020704010700"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf21.cluster1.charter.net ([209.225.28.221]:52435 "EHLO
	mxsf21.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265266AbUF1W1V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jun 2004 18:27:21 -0400
Received: from mxip07.cluster1.charter.net (mxip07a.cluster1.charter.net [209.225.28.137])
	by mxsf21.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id i5SMRW1o002532
	for <linux-ide@vger.kernel.org>; Mon, 28 Jun 2004 18:27:32 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709000700020704010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sir
    I resolved problem by baking out scsi portion of patches, athough
some general configs such as FC2 development still introduce
the same problem as identified in the attached message.
Please assist me in resolving this problem.
Hubert Bahr

--------------060709000700020704010700
Content-Type: message/rfc822;
 name="Sata-Sil bk6-bk8 hangs Maxtor with S-P bridge"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Sata-Sil bk6-bk8 hangs Maxtor with S-P bridge"

Message-ID: <40DDC641.1070403@hbahr.org>
Date: Sat, 26 Jun 2004 13:53:53 -0500
From: hab <hab@hbahr.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sata-Sil bk6-bk8 hangs Maxtor with S-P bridge
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With Bk6 and beyond I recieve a
command 0x25 Timeout Stat 0x50 host-stat 0x4  and then a hang in init.
I can cntl alt del to reboot.
This is with a Maxtor 6y160po  YAR4,  I also have a Maxtor 6y250P0

Earlier in the boot sequence I recieve a screaming interupt message and
interupt turned off message for the interupt used by the controller.

These work for 2.6.7 and 2.6.7 bk5.
It works for the ide implementation with the thousands of

sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq

messages.

thanks  Hubert


--------------060709000700020704010700--
