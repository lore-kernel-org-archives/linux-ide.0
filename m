From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 11:22:05 +0100
Message-ID: <1171102925.19041.9.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <200702091527.08447.rootkit85@yahoo.it>
	 <1171032893.8134.13.camel@localhost>
	 <200702091839.52316.rootkit85@yahoo.it>
	 <1171044940.8134.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:33694 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbXBJKWH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Feb 2007 05:22:07 -0500
In-Reply-To: <1171044940.8134.22.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David M. Lloyd" <dmlloyd@flurg.com>
Cc: Matteo Croce <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

On Fri, 2007-02-09 at 12:15 -0600, David M. Lloyd wrote:
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

David, could you please point us to the patch/thread where this has been
discussed before ? Also as this is working nicely for me too, could you
please try this again with 2.6.20, that is enable ahci *builtin* in your
kernel config and apply Matteo's patch and post results ?

Thanks,
Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
