From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 19:01:14 +0000
Message-ID: <20090126190114.586879f5@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<20090125105045.65021406@lxorguk.ukuu.org.uk>
	<497DA356.2090206@ru.mvista.com>
	<20090126120107.20345a75@lxorguk.ukuu.org.uk>
	<497DFCD5.8040708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57746 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752914AbZAZTH0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 14:07:26 -0500
In-Reply-To: <497DFCD5.8040708@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

On Mon, 26 Jan 2009 21:11:33 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Alan Cox wrote:
> 
> >>why we have to check for ATA revision prior to that -- unless we're 
> >>trying to guard against pre ATA-3 values other than 0 or 0xFFFF.
> 
> > Which we are.
> 
>     On what grounds? Note that ATA-3 only names 0 and 0xFFFF as inappropriate 
> values.

On the grounds that there are devices that predate ATA-3 and that we
should be robust.
