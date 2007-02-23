From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: hdb: irq timeout: status=0xd0 { Busy }
Date: Fri, 23 Feb 2007 15:17:09 +0000
Message-ID: <20070223151709.3b819367@lxorguk.ukuu.org.uk>
References: <2fa647f60702230519u4dc178b8s6c28948cd824272d@mail.gmail.com>
	<20070223142840.7c771453@lxorguk.ukuu.org.uk>
	<2fa647f60702230530x48e5d558o422825892e428d1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54306 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932384AbXBWONR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 09:13:17 -0500
In-Reply-To: <2fa647f60702230530x48e5d558o422825892e428d1d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thue Janus Kristensen <thuejk@gmail.com>
Cc: linux-ide@vger.kernel.org

> Would it be possible for the kernel to realize that the drive stopped
> responding? And make sure that it doesn't make the whole computer
> unresponsive...

libata should eventually get rid of the drive. The old ide isn't quite so
smart.

