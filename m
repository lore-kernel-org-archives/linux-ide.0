From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH #upstream-fixes] sata_nv: make hardreset return -EAGAIN on success
Date: Tue, 22 Apr 2008 20:24:53 -0700
Message-ID: <adaej8xckxm.fsf@cisco.com>
References: <480EA97D.8080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:34615 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbYDWDYy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 23:24:54 -0400
In-Reply-To: <480EA97D.8080704@gmail.com> (Tejun Heo's message of "Wed, 23 Apr
	2008 12:14:05 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: marc.c.dionne@gmail.com, Petr Vandrovec <vandrove@vc.cvut.cz>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

 > sata_nv hardreset can't classify but was left out while unifying
 > follow-up SRST request mechanism[1].  This caused detection failures
 > on those controllers.  Fix it.

Yep, fixes my system too.

Tested-by: Roland Dreier <rolandd@cisco.com>
