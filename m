From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug
 in cable detection
Date: Mon, 26 Feb 2007 17:27:52 +0000
Message-ID: <20070226172752.75c58741@lxorguk.ukuu.org.uk>
References: <20070205080128.GH1625@htj.dyndns.org>
	<20070225132945.44299b0c@lxorguk.ukuu.org.uk>
	<45E19AE7.2020206@gmail.com>
	<200702251839.36205.bzolnier@gmail.com>
	<45E1CA42.6070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57061 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752441AbXBZQYW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 11:24:22 -0500
In-Reply-To: <45E1CA42.6070707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Mon, 26 Feb 2007 02:41:22 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Bartlomiej Zolnierkiewicz wrote:
> > Why can't libata do the right thing and just send IDENTIFY command
> > to the slave device first?
> 
> That's my plan B.  I'm just not sure whether it would do any good, would it?

Should find out soon. I've updated my tree to add the ->cable_detect()
method, along with finishing off the (ap, adev) cleanup by passing only
adev to set_pio_mode and friends, also killing the un-needed
->post_set_mode() now that set_mode can be wrapped.

Having a separate ->cable_detect() method cleans stuff up a ton btw. Will
post my tree soon for discussion.

Alan
