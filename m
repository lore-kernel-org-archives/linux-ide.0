From: "rmanzhos" <rmanzhos@yandex.ru>
Subject: A question to Uwe Koziolek (raid on sis180)
Date: Tue, 2 Jan 2007 11:51:21 +0300 (MSK)
Message-ID: <459A1D09.000001.14988@tide.yandex.ru>
Reply-To: rmanzhos@yandex.ru
Mime-Version: 1.0
Content-Type: text/plain;
  charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tide.yandex.ru ([213.180.200.37]:50317 "EHLO tide.yandex.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbXABJAe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 04:00:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.
Could you help me with such a question.
A have sis180 and raid0 on two sata disks. In windows all works: simply give it a driver and I have access to the raid like to an ordinary disk (nothing to think about). But when I try linux, I obtain two disks (sdb and sdc, for exaple) and interestingly on one disk I can "see" (I mean dmesg output) 3 partitions (sdb1, sdb2 and sdb3) and on the other  - 2 (sdc1, sdc2) - in windows I partitioned the disk on 3 partitions. I tried the driver from sis.com (sis18x_20060508.zip). As I understood the sata_sis from sis.com is the same or almost the same as in kernel tree (I've tried 2.6.11). Then I looked at dmraid - it supports a lot of fakeraids, but not the sis:( I thought about software raid, but this frights me:)
And now the question: is there any posibility to obtain acces to my raid0-disk in linux or would I better find different problem to solve:)
Thank you in advance.
Sincerely yours.
