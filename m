From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/4] libata: move err_mask to ata_queued_cmd (revised)
Date: Thu, 10 Nov 2005 15:56:53 +0800
Message-ID: <4372FD45.8080404@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37567 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751314AbVKJH5E
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 02:57:04 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAA7uwka005435
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 02:56:58 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAA7urxP065382
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 00:56:53 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAA7uvwv027288
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 00:56:58 -0700
In-Reply-To: <43719670.20708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Dear all,

Description:
  Move the err_mask parameter of the complete functions to ata_queued_cmd.
  This can make the err_mask more accessible outside the complete functions;
  also can make the HSM easier to determine and pass err_mask between states.

patch 1/4: minor patch to pave the road for patch 2 and 3
patch 2/4: move err_mask to ata_queued_cmd
patch 3/4: determine the err_mask when the error is found
patch 4/4: determine the err_mask directly in atapi_packet_task()

Revised patch against the mainline tree 
(e4d76e1c0b15590f2ad9bba89426c2520cd22ca6).

For your review and advice, thanks.

Albert

