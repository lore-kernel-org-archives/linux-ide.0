From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Re: PCI IRQ problems -- update
Date: Fri, 7 Jan 2005 03:22:24 +0100
Message-ID: <58cb370e0501061822596bffde@mail.gmail.com>
References: <20041211173538.GA21216@jim.sh>
	 <1102783555.7267.37.camel@localhost.localdomain>
	 <20041211202314.GA22731@jim.sh> <20041211220307.GA23848@jim.sh>
	 <1102851831.1371.23.camel@localhost.localdomain>
	 <20041216111656.GA12740@jim.sh>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:17686 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261224AbVAGCWZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 21:22:25 -0500
Received: by wproxy.gmail.com with SMTP id 37so116234wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2005 18:22:24 -0800 (PST)
In-Reply-To: <20041216111656.GA12740@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 16 Dec 2004 06:16:56 -0500, Jim Paris <jim@jtan.com> wrote:
> Alan Cox wrote:
> > > I added a quirk for this case.  This is against 2.6.10-rc3, and it
> > > makes all of my problems go away cleanly.  Is this reasonable?
> >
> > I think so. You might want to send a copy to linux-ide@vger.kernel.org
> > so that Bartlomiej doesn't miss it.

Bart of course missed it, applied now
