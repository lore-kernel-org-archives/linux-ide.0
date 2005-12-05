From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/4] libata: move err_mask to ata_queued_cmd (revised #2)
Date: Mon, 05 Dec 2005 14:58:27 +0800
Message-ID: <4393E513.5070203@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com> <43924E11.60500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:22986 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932303AbVLEG6o
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 01:58:44 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jB56wYJb001065
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 01:58:34 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jB5706WB098488
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 00:00:06 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jB56wXBY032614
	for <linux-ide@vger.kernel.org>; Sun, 4 Dec 2005 23:58:34 -0700
In-Reply-To: <43924E11.60500@pobox.com>
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

Revised patch against the upstream branch of libata-dev tree 
(4ef679e6caf1261b6380a610a705a90d7e2738c6).

For your review, thanks.

Albert



