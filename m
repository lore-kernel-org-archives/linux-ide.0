From: Albert Lee <albertcc@tw.ibm.com>
Subject: [RFC] libata: add MODE_SENSE(6) emulation?
Date: Wed, 06 Apr 2005 15:46:35 +0800
Message-ID: <425393DB.3010702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:5092 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262136AbVDFHre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Apr 2005 03:47:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Hi Jeff,

   Even though libata sets  sdev->use_10_for_ms = 1;
libata still receives MODE_SENSE(6) and MODE_SELECT(6) commands during the test.
(These commands seems to be coming from the user space, not from the SCSI mid-layer.)

Most ATAPI devices don't like it, and either return error or time out.
(Ex.
Attached scsi CD-ROM sr0 at scsi7, channel 0, id 0, lun 0
ata7: command 0xa0 timeout, stat 0x50 host_stat 0x1)

Should MODE_SENSE(6) / MODE_SELECT(6) emulation be added to libata
to fix this? This can also make the ATAPI devices look more like real SCSI devices.

Albert


