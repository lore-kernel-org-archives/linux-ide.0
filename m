From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] libata: implement per-dev xfer masks
Date: Sun, 12 Mar 2006 13:37:26 +0000
Message-ID: <1142170646.18565.3.camel@localhost.localdomain>
References: <11421469551948-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51646 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750863AbWCLNcP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Mar 2006 08:32:15 -0500
In-Reply-To: <11421469551948-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sul, 2006-03-12 at 16:02 +0900, Tejun Heo wrote:
> I marked with comment where the mode filtering for low level drivers
> should be done but I'm not sure how the interface should look like.

Currently the libata pata patch code calls a filter function if present
which returns an updated bitmap for the mode type. I did that because we
need to combine the cable, bridge, core and chip specific rules neatly
and not have one forcing a mode the other cannot do.

> ->pre_set_mode(ap) is okay but then the LLDD should iterate over all
> devices.  Maybe ->pre_set_mode(ap, dev) or ->filter_xfer_mask(ap, dev)?

Providing

1.	The proposed speeds are set for both devices on the cable before the
call.
2.	We reselect the speed of both devices on changedown or hotplug

then we should be just fine.


