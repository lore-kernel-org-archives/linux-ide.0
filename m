From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Organized summary of the pacthes
Date: Sat, 9 Jul 2005 23:44:44 -0400
Message-ID: <20050710034444.GD13883@havoc.gtf.org>
References: <1119981611.32381.32.camel@localhost.localdomain> <200507100054.j6A0s6Ct025796@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:21984 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261397AbVGJDoq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jul 2005 23:44:46 -0400
Content-Disposition: inline
In-Reply-To: <200507100054.j6A0s6Ct025796@falcon30.maxeymade.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@maxeymade.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Tejun Heo <htejun@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sat, Jul 09, 2005 at 07:54:06PM -0500, Doug Maxey wrote:
> >> However, I am pondering scrapping all the polling code, since on SATA,
> >> interrupt-driven mode is much more desirable.
> >
> >You need both interrupt and polled command issue. ACPI needs to be able
> >to issue taskfiles to the IDE drive fairly early during resume. Right
> >now this isn't done at all. If polled is there it might also prove a
> >useful way to reissue a command when you think the IRQ routing is hosed
> >8)
> 
> This would be an enhancement, rather than something required currently,
> correct?

Switching over to interrupt-driven for SATA is basically a requirement.

Since the polling code is what exists now, it MAY be easier to leave it
in, which puts "leave in polling code" in the enhancement category.

	Jeff



