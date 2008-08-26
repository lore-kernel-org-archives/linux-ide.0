From: Tejun Heo <tj@kernel.org>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 12:43:39 +0200
Message-ID: <48B3DE5B.1020607@kernel.org>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk> <20080826101713.GW20055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39809 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbYHZKrI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 06:47:08 -0400
In-Reply-To: <20080826101713.GW20055@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>, Gwendal Grignou <gwendal@google.com>

(cc'ing Mark Lord, Kay Sievers and Gwendal Grignou)

Jens Axboe wrote:
>> d) Assume the bridge is ok but teach the SATA error handling code that if
>> there is a timeout immediately with such a bridge then to flip down to
>> UDMA5 and knobble the transfer length.
> 
> That would be nice, assuming that we can rely on safe behaviour (eg not
> data corrupting badness).

Obstacles to such approaches are...

* The current IO timeouts are too long.  It's not like reducing this is
difficult.  The only reason why we haven't reduced it yet is because we
haven't been able to agree on what's the proper timeout value.
According to Mark, 8 secs should be fine (Windows uses it) for
read/writes but there seem to be some corner cases.

* Some rare controllers fail miserably after a timeout but this is
pretty rare and getting rarer.  I don't think we need to consider this
the main deciding factor.

* Currently, the transfer speed setting reached by EH actions is not
persistent.  On the next boot, the device would have to go through the
same thing all over again, which isn't too pleasant.  It would be great
if we can make this setting persistent.  Maybe this can be done libata
sysfs and udev?

Thanks.

-- 
tejun
