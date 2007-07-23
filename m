From: Chuck Ebbert <cebbert@redhat.com>
Subject: No equivalent for ide-scsi available with the new PATA drivers?
Date: Mon, 23 Jul 2007 12:36:44 -0400
Message-ID: <46A4D91C.3090509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762062AbXGWQgq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 12:36:46 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6NGajTN007511
	for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 12:36:45 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6NGaiIH019102
	for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 12:36:45 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l6NGaiUp008680
	for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 12:36:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

People with IDE tape drives are complaining there's no ide-scsi
driver available anymore with the new PATA layer. Is anyone
working on one?
