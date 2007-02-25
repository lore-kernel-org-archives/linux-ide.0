From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug in cable detection
Date: Sun, 25 Feb 2007 18:39:36 +0100
Message-ID: <200702251839.36205.bzolnier@gmail.com>
References: <20070205080128.GH1625@htj.dyndns.org> <20070225132945.44299b0c@lxorguk.ukuu.org.uk> <45E19AE7.2020206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:63848 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965028AbXBYRdX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 12:33:23 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1491420nfa
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2007 09:33:22 -0800 (PST)
In-Reply-To: <45E19AE7.2020206@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


On Sunday 25 February 2007, Tejun Heo wrote:
> [cc'ing Mark, Bart and Sergei. Hi]
> 
> Alan wrote:
> >>> This makes unreliable cable detection even more unreliable.  Please
> >>> consider for -stable.  Thanks.
> > 
> > At minimum you also need to stop doing drive side detect for PATA_CBL_80
> > as many controllers don't do both so if you've got host side detect that
> > is what you must trust.
> > 
> > Fixed that in my internal tree and it seems happier
> 
> It seems libata is wrong about device side cable detection.  Device side
> cable detection tries to detect host side capacitor connected to PDIAG-,
> depends on the slave device releasing PDIAG- signal.
> 
> According to Annex B of ATA/ATAPI-5, IDENTIFY should be issued to the
> slave device first to ensure that it releases PDIAG- and then use the
> cable detection result from the master device.  As we IDENTIFY master
> first right after reset, slave if present is driving PDIAG-, so the
> master on IDENTIFY always thinks the capacitor is present and 40c limit
> is always applied.
> 
> IDE is better off because it doesn't reset before IDENTIFYing and it's
> likely that BIOS has issued some commands to the slave device prior to
> passing control to OS thus making it release PDIAG-.
> 
> 1. Device side cable detection can only be used to limit speed because
> if motherboard doesn't have capacitor attached to PDIAG-, the test
> result always indicates 80c.
> 
> 2. Host side detection involves issuing commands to attached devices
> because it depends on the slave device releasing PDIAG-, so most
> controllers do cable detection in BIOS and just put the result in PCI
> config region or wherever.  We dunno how BIOS does it exactly but many
> of them probably consider device side detection result as well.
> 
> So, considering #1 and #2, it might be best to just believe what the
> controller (BIOS) says and not bother about device side detection.  In
> fact, we've been effectively ignoring device side detection result
> before my "fix" for device side cable detection.
> 
> What do you think?

Why can't libata do the right thing and just send IDENTIFY command
to the slave device first?

Bart
