From: "David M. Lloyd" <dmlloyd@flurg.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Fri, 09 Feb 2007 12:15:40 -0600
Message-ID: <1171044940.8134.22.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <200702091527.08447.rootkit85@yahoo.it>
	 <1171032893.8134.13.camel@localhost>
	 <200702091839.52316.rootkit85@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound2.mail.tds.net ([216.170.230.92]:45940 "EHLO
	outbound2.mail.tds.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992730AbXBISPo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 13:15:44 -0500
In-Reply-To: <200702091839.52316.rootkit85@yahoo.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matteo Croce <rootkit85@yahoo.it>
Cc: linux-ide@vger.kernel.org

On Fri, 2007-02-09 at 18:39 +0100, Matteo Croce wrote:
> On Friday 09 February 2007 15:54:53 you wrote:
> > On Fri, 2007-02-09 at 15:27 +0100, Matteo Croce wrote:
> > > +	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M */
> >
> > Wasn't this PCI ID proposed for addition a while ago, and subsequently
> > rejected?  Or am I missing something?
> >
> > - DML
> 
> rejected? why?

Because 0x27C4 is not an AHCI controller.... at least, the one in my
Dell laptop isn't.

- DML

