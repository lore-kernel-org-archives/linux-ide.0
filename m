From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Add fixup functionality to the PCI drivers
Date: Fri, 05 Nov 2004 23:43:56 +0000
Message-ID: <1099698235.5630.87.camel@localhost.localdomain>
References: <1099672842.5564.56.camel@localhost.localdomain>
	 <200411052313.06968.bzolnier@elka.pw.edu.pl>
	 <1099697347.5630.78.camel@localhost.localdomain>
	 <200411060144.13024.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:38341 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261238AbUKFAqv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:46:51 -0500
In-Reply-To: <200411060144.13024.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sad, 2004-11-06 at 00:44, Bartlomiej Zolnierkiewicz wrote:
> > > this chunk is not needed
> > 
> > Disagree. Look more carefully - we always need to pass d so we can pass
> > d->fixup
> 
> siimage is the only user of d->fixup right now,
> it doesn't use ide_setup_pci_devices()

If you think having the two API's differ in whether d->fixup is honoured
is good then I must disagree strongly with your taste in API's - you are
asking for the first person expecting it to work to get burned

