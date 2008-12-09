From: "Rob OpenSuSE" <rob.opensuse.linux@googlemail.com>
Subject: Re: [RFC PATCH] pata_hpt366: fix mode configuration
Date: Tue, 9 Dec 2008 21:02:29 +0000
Message-ID: <ce9d8ed60812091302k37b220d1l3dce6878274d8be2@mail.gmail.com>
References: <493CC897.9080406@kernel.org> <493CF9A8.301@ru.mvista.com>
	 <ce9d8ed60812081518g5d9166baia9fb9531b472dbff@mail.gmail.com>
	 <493ECB6C.3040304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:39748 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbYLIVCc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Dec 2008 16:02:32 -0500
Received: by an-out-0708.google.com with SMTP id d40so81979and.1
        for <linux-ide@vger.kernel.org>; Tue, 09 Dec 2008 13:02:30 -0800 (PST)
In-Reply-To: <493ECB6C.3040304@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

2008/12/9 Mark Lord <liml@rtr.ca>:
> Rob OpenSuSE wrote:
> There are tons of PCI add-on cards still out there with these chips,
> and they will continue to work fine so long as PCI slots
> and PATA drives exist.  So we may as well ensure Linux does the Right Things (tm).

Yes, my point was in support of pragmatism; so that new kernel builds
and distro installs can have a chance to succeed in boxes with these
cards used, without opening case,  reconfiguring, and finding special
boot paramters.  Those cards need working code now, not next year.  So
"The Right Thing (tm)" would be bad, if it caused perfectly capable
kit to be non-functioning, whilst perfection is under discussion and
development.

> Nice work, Tejun!

Seconded!  If you are the Mark who sent the card, thanks to you to from me to.
