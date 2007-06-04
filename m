From: Jeff Garzik <jeff@garzik.org>
Subject: legacy libata IDE missing reservation
Date: Mon, 4 Jun 2007 19:51:57 -0400
Message-ID: <20070604235157.GD31462@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:38617 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757123AbXFDXv6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jun 2007 19:51:58 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>


FYI:  I noticed this weekend that libata does not reserve the legacy
IDE control block I/O port region, like it does the command block
I/O region.

	Jeff



