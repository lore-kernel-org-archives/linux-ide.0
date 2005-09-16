From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata sata_sil broken on 2.6.13.1
Date: Fri, 16 Sep 2005 02:41:39 -0400
Message-ID: <432A6923.2070000@pobox.com>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br><60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br><43290893.7070207@pobox.com><1126790860.19133.75.camel@localhost.localdomain><61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>    <1126823405.7034.14.camel@localhost.localdomain> <61375.200.141.106.169.1126842173.squirrel@correio.lps.ele.puc-rio.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48604 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161055AbVIPGlt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2005 02:41:49 -0400
In-Reply-To: <61375.200.141.106.169.1126842173.squirrel@correio.lps.ele.puc-rio.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: izvekov@lps.ele.puc-rio.br
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

izvekov@lps.ele.puc-rio.br wrote:
>From what i understand up to now, my problem wasnt that the controller
> triggered an interrupt with NIEN set, but that the handler was returning
> it as not handled.

Essentially that is what happened.  Albert's patch simply fixed it 
another way.

ATA is a bit annoying in that, we try to "know" when an interrupt is 
expected.  There is no 100% solution that simply allows us to check for 
pending interrupts, without side effects.

Thus the explosion when unexpected interrupts are received.

	Jeff


