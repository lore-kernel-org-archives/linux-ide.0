From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/3] libata-dev: irq-pio minor fixes (respin)
Date: Mon, 13 Mar 2006 15:20:51 +0800
Message-ID: <44151D53.3040606@tw.ibm.com>
References: <44119BC9.8080502@tw.ibm.com> <44136B04.4090203@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:18141 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751822AbWCMHVG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 02:21:06 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7Ku6B025543
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:20:56 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7Nnfw172260
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:23:49 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7KtNL029159
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:20:56 -0700
In-Reply-To: <44136B04.4090203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Minor fixes for irq-pio (respin).

Changes:
1/3: Remove trailing whitespaces
2/3: Fix merge problem with upstream
3/3: Remove atapi_packet_task()

Patch against the irq-pio branch (54da9a3968448681d0ddf193ec90f2480c5cba1c). 

For your review, thanks,

Albert



