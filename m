From: Vincent Bernat <Vincent.Bernat@wallix.com>
Subject: Re: SATA update in 2.4, ICH8
Date: Fri, 22 Jun 2007 08:29:15 +0200
Message-ID: <87myysfqo4.fsf@naruto.ifr.lan>
References: <87y7idiwjd.fsf@naruto.ifr.lan> <20070621182119.GB26637@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wallix.com ([212.43.221.50]:55770 "EHLO postman.wallix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbXFVG3b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jun 2007 02:29:31 -0400
In-Reply-To: <20070621182119.GB26637@1wt.eu> (Willy Tarreau's message of "Thu,
	21 Jun 2007 20:21:19 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: linux-ide@vger.kernel.org, JF Taltavull <jean-francois.taltavull@wallix.com>, Jeff Garzik <jeff@garzik.org>

Hi Willy !

> I do not have any idea right now. I recall having had some difficulties some
> time ago with ata_piix when piix itself was not disabled, but those were in
> the early libata times. I *believe*  it's OK now but you might want to
> check.

I will try to compile a kernel without piix enabled and keep you in touch.

> Also, is your CDROM driver parallel ATA or SATA ? It is not clear to me from
> your logs. Because if it is ATA, you should need to run with piix enabled just
> for it,  and, if my memory  serves me correctly, to  start piix before
> ata_piix.

This is a SATA CDROM. There is no PATA controller on the motherboard.

> BTW, what motherboard is it ?

It is a Dell OptiPlex 745.

> And provided that the CDROM drive finally works,
> or that we find a valid reason for it not to work, are you implicitly asking
> for mainline inclusion of your patch (or a fixed one) or is it here just for
> explanation purposes ?

If ICH8 can work with a 2.4  with just this tiny patch, yes, it could be
included into mainline.  In this case, we may want to  add more ICH8 PCI
ID (I have only included the ones that appear in lspci for me).
-- 
Vincent Bernat
118 rue de Tocqueville, 75017 Paris
Tel: +33 1 53 42 12 86
http://www.wallix.com
