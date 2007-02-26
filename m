From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Current PATA working tree
Date: Mon, 26 Feb 2007 22:17:15 +0000
Message-ID: <20070226221715.3cdb2ce8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44160 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161211AbXBZVNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 16:13:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

While Andrew and -mm are taking a bit of a break...

I've uploaded a patch file of the libata PATA working tree versus
2.6.20-mm2 to

	http://zeniv.linux.org.uk/~alan/IDE

2.6.20-mm2-ac1 has the cable detect method, the identify slave first
change, and assorted core cleanups to methods like ->set_pio_mode() that
were deferred due to the number of things they touched.

The current -ac1 tree I would class as "unstable", its a work in progress
having done all the merging and updating but not yet enough testing to
shake all the bugs out

Alan
