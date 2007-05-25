From: Jeff Garzik <jeff@garzik.org>
Subject: sil680 MMIO changes moved to branch
Date: Thu, 24 May 2007 23:33:46 -0400
Message-ID: <4656591A.6090701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50898 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755493AbXEYDdt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 23:33:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan <alan@lxorguk.ukuu.org.uk>

I moved the sil680 MMIO changes from 'upstream' (queued for 2.6.23) to a 
side branch 'sil680-mmio'.

To be clear, I am still quite interested in the patch (w/ the reset 
fix), but I did not want to delay other unrelated stuff that was about 
to be queued into #upstream.

The patch will still appear in -mm, and it is trivial to pull it from 
#sil680-mmio into #upstream once people are happy.

	Jeff


