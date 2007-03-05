From: "Paul Rolland" <rol@as2917.net>
Subject: RE: [git patches] libata fixes
Date: Mon, 5 Mar 2007 10:54:30 +0100
Message-ID: <00a001c75f0c$47f19750$4b00a8c0@donald>
References: <45EBA6E6.10907@gmail.com>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:58476 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932812AbXCEJyr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Mar 2007 04:54:47 -0500
In-Reply-To: <45EBA6E6.10907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Jeff Garzik' <jeff@garzik.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Linus Torvalds' <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Hello,

> Your drive has some issues with NCQ and is scheduled to be blacklisted
> such that it isn't enabled.  libata used to ignore the 
> condition but now
> considers it NCQ protocol violation and fails all pending commands.

OK, do you need an hdparm report to fully identify the disk ?
 
> libata EH should turn NCQ off automatically after a few of the above
> errors.  I'd love to see how that actually works in the field (full
> dmesg please).  If it doesn't, it needs fixing.

I'll get you one tonite, I don't have access to the machine right now.

Regards,
Paul

