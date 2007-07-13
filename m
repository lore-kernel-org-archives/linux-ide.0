From: Chuck Ebbert <cebbert@redhat.com>
Subject: AHCI driver prints "D2H reg with I during NCQ" message, what is it?
Date: Fri, 13 Jul 2007 11:28:58 -0400
Message-ID: <46979A3A.2090005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58100 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936871AbXGMP3A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 11:29:00 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6DFSxjL018365
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 11:28:59 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6DFSwqc020001
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 11:28:58 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l6DFSwpf019699
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 11:28:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

I see this on boot with kernels 2.6.22.1 and 2.6.20.15:

     ata1: D2H reg with I during NCQ, this message won't be printed again

But I can't find anything that tells me what it means, or whether
it's a real problem.

x86_64 kernel with controller:

     00:1f.2 SATA controller: Intel Corporation 631xESB/632xESB SATA Storage Controller AHCI (rev 09)

and drive:

     ata1.00: ATA-7: HDS728080PLA380, PF2OA63A, max UDMA/133


