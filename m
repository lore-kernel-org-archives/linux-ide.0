From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: don't set PIO mode on pre-EIDE drives
Date: Fri, 16 Nov 2007 18:14:15 +0000
Message-ID: <20071116181415.3953df74@the-village.bc.nu>
References: <200711161626.25580.sshtylyov@ru.mvista.com>
	<20071116164240.40b02300@the-village.bc.nu>
	<473DC942.20803@ru.mvista.com>
	<20071116165629.6ba73708@the-village.bc.nu>
	<473DD117.1090808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60475 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752087AbXKPSPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 13:15:38 -0500
In-Reply-To: <473DD117.1090808@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

>     That's something at least.  I hope they also don't set bit 11 -- 
> otherwise, bad luck.  Or am I supposed to also check the CF signature? :-)

Libata issues the command but ignores an ABRT if the device is CFA or has
no iordy flag and PIO <= 2 or MWDMA0 is used and the device thinks its in
MWDMA0 anyway

drivers/ide at least just used to aim, fire and ignore the result.



Alan
