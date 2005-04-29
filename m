From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/2] libata-2.6: Fix races caused by the interrupt handler
Date: Fri, 29 Apr 2005 17:27:30 +0800
Message-ID: <4271FE02.1080009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:54760 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262172AbVD2J2F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Apr 2005 05:28:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

Hi Jeff:

Two patches on the libata ATAPI interrupt handling for your review:
- patch 1/2: fix race between the interrupt handler and the scsi error handler.
- patch 2/2: fix race between the interrupt handler and atapi_packet_task().

Thanks,

Albert


