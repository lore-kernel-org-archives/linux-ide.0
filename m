From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 16:07:07 +0100
Message-ID: <20100409160707.6116965e@lxorguk.ukuu.org.uk>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	<4BBE6CA6.1010808@gmail.com>
	<4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
	<n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
	<4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
	<o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
	<4BBEFDA1.5050607@buttersideup.com>
	<z2x51f3faa71004090747n908c389ez17cba33301c4c998@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48271 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753869Ab0DIPDZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 11:03:25 -0400
In-Reply-To: <z2x51f3faa71004090747n908c389ez17cba33301c4c998@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tim Small <tim@buttersideup.com>, =?ISO-8859-14?B?ROJuaWVs?= Fraga <fragabr@gmail.com>, linux-ide@vger.kernel.org

> Some laptop BIOSes do try to access the controller at certain points,
> like suspend or powerdown (presumably to make sure the drive heads are
> unloaded or something) - we've run into problems in the past when the
> controller was disabled at points where the BIOS didn't expect it to
> be and it was trying to poke at it, causing a big delay until it
> finally gave up.


Suspend/powerdown are less of a problem because any patch to put it into
AHCI mode should put it back as it was before during suspend/poweroff.

It's strange goings in in the background that are more of a concern.

Alan
