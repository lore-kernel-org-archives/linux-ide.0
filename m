From: "Tuc at T-B-O-H.NET" <ml@t-b-o-h.net>
Subject: Wasn't thinking (Was: Correct partition table geometry?)
Date: Fri, 30 May 2008 22:57:17 -0400 (EDT)
Message-ID: <200805310257.m4V2vHWP034806@himinbjorg.tucs-beachin-obx-house.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vjofn.tucs-beachin-obx-house.com ([204.107.90.128]:4255 "EHLO
	vjofn.tucs-beachin-obx-house.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165AbYEaC5e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2008 22:57:34 -0400
Received: from himinbjorg.tucs-beachin-obx-house.com (cpe-24-161-6-139.hvc.res.rr.com [24.161.6.139])
	(authenticated bits=0)
	by vjofn.tucs-beachin-obx-house.com (8.14.2/8.14.2) with ESMTP id m4V2vNTP092646
	for <linux-ide@vger.kernel.org>; Fri, 30 May 2008 22:57:33 -0400 (EDT)
Received: from himinbjorg.tucs-beachin-obx-house.com (localhost.tucs-beachin-obx-house.com [127.0.0.1])
	by himinbjorg.tucs-beachin-obx-house.com (8.13.8/8.13.6) with ESMTP id m4V2vHGL034807
	for <linux-ide@vger.kernel.org>; Fri, 30 May 2008 22:57:18 -0400 (EDT)
	(envelope-from ml@t-b-o-h.net)
Received: (from tbohml@localhost)
	by himinbjorg.tucs-beachin-obx-house.com (8.13.8/8.13.6/Submit) id m4V2vHWP034806
	for linux-ide@vger.kernel.org; Fri, 30 May 2008 22:57:17 -0400 (EDT)
	(envelope-from tbohml)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

	Ok, scratch 90% of that, I'm a bit tired . Realized I could make 
the edits in memory and see if things "adjusted". They do. So its really
not bad. I'll probably just delete the partitions in the extended and
re-create them. I think at that point I can do what I want. 

	I guess I could still use :

	* Standard mk2fs line options
	* Just as an FYI when we swap the 500 to primary, and put ANOTHER
500 in as a backup.... How to install grub to be bootable on a disk
(But I'm sure I could visit the grub site to find that out.... :) )

	Sorry for the previous ramble. This time *I* wasn't thinking.

			Tuc
