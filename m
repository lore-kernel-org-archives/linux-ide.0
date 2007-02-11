From: "David M. Lloyd" <dmlloyd@flurg.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sun, 11 Feb 2007 09:40:37 -0600
Message-ID: <1171208437.4308.3.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <200702091527.08447.rootkit85@yahoo.it>
	 <1171032893.8134.13.camel@localhost>
	 <200702091839.52316.rootkit85@yahoo.it>  <45CDD0CB.2070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound1.mail.tds.net ([216.170.230.91]:38752 "EHLO
	outbound1.mail.tds.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXBKPkm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 10:40:42 -0500
In-Reply-To: <45CDD0CB.2070608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matteo Croce <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

On Sat, 2007-02-10 at 09:03 -0500, Tejun Heo wrote:
> Matteo Croce wrote:
> > On Friday 09 February 2007 15:54:53 you wrote:
> >> On Fri, 2007-02-09 at 15:27 +0100, Matteo Croce wrote:
> >>> +	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M */
> >> Wasn't this PCI ID proposed for addition a while ago, and subsequently
> >> rejected?  Or am I missing something?
> > 
> > rejected? why?
> 
> Ah... right.
> 
> All ICH7 R/M silicons can be put into either IDE or AHCI mode. <...>

I see... so probably my Dell laptop doesn't (and maybe can't) enable it,
but Matteo's Macbook does.  That makes sense...

- DML

