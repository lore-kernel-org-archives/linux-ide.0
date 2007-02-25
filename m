From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug
 in cable detection
Date: Sun, 25 Feb 2007 19:13:19 +0000
Message-ID: <20070225191319.33d928c9@lxorguk.ukuu.org.uk>
References: <20070205080128.GH1625@htj.dyndns.org>
	<45E0EBD6.2010008@garzik.org>
	<20070225132945.44299b0c@lxorguk.ukuu.org.uk>
	<45E19AE7.2020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55740 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932103AbXBYSLM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 13:11:12 -0500
In-Reply-To: <45E19AE7.2020206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

> According to Annex B of ATA/ATAPI-5, IDENTIFY should be issued to the
> slave device first to ensure that it releases PDIAG- and then use the
> cable detection result from the master device.  As we IDENTIFY master
> first right after reset, slave if present is driving PDIAG-, so the
> master on IDENTIFY always thinks the capacitor is present and 40c limit
> is always applied.

I had to go read this and its news to me but nice to know what is going
on.

> So, considering #1 and #2, it might be best to just believe what the
> controller (BIOS) says and not bother about device side detection.  In

The BIOS is run once at boot, on an x86 box, maybe only for some
controllers.

> What do you think?

I think we need to do the identify first. We could actually tidy up a lot
of duplicate driver code if there was a ->cable_detect() method, as many
of them could use the standard ata error handler without hooks. Right now
it is mostly hooked just to do cable type setup.

There are far too many cases from non-x86 through to hotplug we can't
trust any BIOS bits.

Alan
