From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: hdb: irq timeout: status=0xd0 { Busy }
Date: Fri, 23 Feb 2007 14:28:40 +0000
Message-ID: <20070223142840.7c771453@lxorguk.ukuu.org.uk>
References: <2fa647f60702230519u4dc178b8s6c28948cd824272d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59366 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932330AbXBWNYs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 08:24:48 -0500
In-Reply-To: <2fa647f60702230519u4dc178b8s6c28948cd824272d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thue Janus Kristensen <thuejk@gmail.com>
Cc: linux-ide@vger.kernel.org

> Feb 20 23:15:17 localhost kernel: hdb: irq timeout: status=0xd0 { Busy }
> Feb 20 23:15:27 localhost kernel: ide: failed opcode was: unknown
> Feb 20 23:15:27 localhost kernel: hdb: status timeout: status=0xd0 { Busy }
> Feb 20 23:15:27 localhost kernel: ide: failed opcode was: unknown

Your CD-ROM drive stopped responding

> Feb 20 23:17:30 localhost kernel: ide: failed opcode was: unknown
> Feb 20 23:17:30 localhost kernel: hdb: drive not ready for command
> Feb 20 23:17:36 localhost kernel: hdb: status timeout: status=0xd0 { Busy }
> repeats infinitely.

and never came back.

It would be very interesting to know if an older kernel doesn't trigger
this.
