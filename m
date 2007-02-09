From: Matteo Croce <rootkit85@yahoo.it>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Fri, 9 Feb 2007 19:51:32 +0100
Message-ID: <200702091951.32801.rootkit85@yahoo.it>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com> <200702091839.52316.rootkit85@yahoo.it> <1171044940.8134.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out109.alice.it ([85.37.17.109]:3172 "EHLO
	smtp-out109.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992454AbXBISvf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 13:51:35 -0500
In-Reply-To: <1171044940.8134.22.camel@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Friday 09 February 2007 19:15:40 you wrote:
> On Fri, 2007-02-09 at 18:39 +0100, Matteo Croce wrote:
> > On Friday 09 February 2007 15:54:53 you wrote:
> > > On Fri, 2007-02-09 at 15:27 +0100, Matteo Croce wrote:
> > > > +	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M */
> > >
> > > Wasn't this PCI ID proposed for addition a while ago, and subsequently
> > > rejected?  Or am I missing something?
> > >
> > > - DML
> >
> > rejected? why?
>
> Because 0x27C4 is not an AHCI controller.... at least, the one in my
> Dell laptop isn't.
>
> - DML
if so, how could it works with my laptop?
i also have NCQ enabled...

