From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug
 in cable detection
Date: Sun, 25 Feb 2007 23:19:19 +0900
Message-ID: <45E19AE7.2020206@gmail.com>
References: <20070205080128.GH1625@htj.dyndns.org>	<45E0EBD6.2010008@garzik.org> <20070225132945.44299b0c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:22873 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964856AbXBYOTc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 09:19:32 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1070763wxd
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2007 06:19:32 -0800 (PST)
In-Reply-To: <20070225132945.44299b0c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

[cc'ing Mark, Bart and Sergei. Hi]

Alan wrote:
>>> This makes unreliable cable detection even more unreliable.  Please
>>> consider for -stable.  Thanks.
> 
> At minimum you also need to stop doing drive side detect for PATA_CBL_80
> as many controllers don't do both so if you've got host side detect that
> is what you must trust.
> 
> Fixed that in my internal tree and it seems happier

It seems libata is wrong about device side cable detection.  Device side
cable detection tries to detect host side capacitor connected to PDIAG-,
depends on the slave device releasing PDIAG- signal.

According to Annex B of ATA/ATAPI-5, IDENTIFY should be issued to the
slave device first to ensure that it releases PDIAG- and then use the
cable detection result from the master device.  As we IDENTIFY master
first right after reset, slave if present is driving PDIAG-, so the
master on IDENTIFY always thinks the capacitor is present and 40c limit
is always applied.

IDE is better off because it doesn't reset before IDENTIFYing and it's
likely that BIOS has issued some commands to the slave device prior to
passing control to OS thus making it release PDIAG-.

1. Device side cable detection can only be used to limit speed because
if motherboard doesn't have capacitor attached to PDIAG-, the test
result always indicates 80c.

2. Host side detection involves issuing commands to attached devices
because it depends on the slave device releasing PDIAG-, so most
controllers do cable detection in BIOS and just put the result in PCI
config region or wherever.  We dunno how BIOS does it exactly but many
of them probably consider device side detection result as well.

So, considering #1 and #2, it might be best to just believe what the
controller (BIOS) says and not bother about device side detection.  In
fact, we've been effectively ignoring device side detection result
before my "fix" for device side cable detection.

What do you think?

-- 
tejun
