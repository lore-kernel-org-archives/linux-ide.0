From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH: Add fixup functionality to the PCI drivers
Date: Sat, 6 Nov 2004 17:05:39 +0100
Message-ID: <58cb370e041106080527177f8c@mail.gmail.com>
References: <1099672842.5564.56.camel@localhost.localdomain>
	 <200411052313.06968.bzolnier@elka.pw.edu.pl>
	 <1099697347.5630.78.camel@localhost.localdomain>
	 <200411060144.13024.bzolnier@elka.pw.edu.pl>
	 <1099698235.5630.87.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.200]:41073 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261411AbUKFQFn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Nov 2004 11:05:43 -0500
Received: by rproxy.gmail.com with SMTP id a36so175030rnf
        for <linux-ide@vger.kernel.org>; Sat, 06 Nov 2004 08:05:39 -0800 (PST)
In-Reply-To: <1099698235.5630.87.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, 05 Nov 2004 23:43:56 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sad, 2004-11-06 at 00:44, Bartlomiej Zolnierkiewicz wrote:
> > > > this chunk is not needed
> > >
> > > Disagree. Look more carefully - we always need to pass d so we can pass
> > > d->fixup
> >
> > siimage is the only user of d->fixup right now,
> > it doesn't use ide_setup_pci_devices()
> 
> If you think having the two API's differ in whether d->fixup is honoured
> is good then I must disagree strongly with your taste in API's - you are
> asking for the first person expecting it to work to get burned

OK, I agree and I will fix that.
