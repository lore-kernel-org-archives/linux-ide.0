From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Bug is fixed in 2.6.23.1: sata_promise: port is slow to respond, reset failed
Date: Mon, 15 Oct 2007 10:21:17 +0200 (MEST)
Message-ID: <200710150821.l9F8LHdS025458@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:45273 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbXJOIVX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 04:21:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@how.dk, linux-ide@vger.kernel.org

On Sun, 14 Oct 2007 11:21:13 +0200, Peter Favrholdt wrote:
> The problem is solved in 2.6.23.1 regarding the "port slow to respond" 
> issue.
> 
> I'm using sata_promise on Promise Technology, Inc. PDC40718 (SATA 300 
> TX4) (rev 02) and 4 Seagate 500GB ES drives.
> 
> Using 2.6.23.1 it is possible to run
> 
> dd if=/dev/sda of=/dev/null bs=1M &
> dd if=/dev/sdb of=/dev/null bs=1M &
> dd if=/dev/sdc of=/dev/null bs=1M &
> dd if=/dev/sdd of=/dev/null bs=1M &
> 
> And it just runs perfectly to the end with no hickups :-)

That's very good to hear.

However, I don't see how the sata_promise changes from 2.6.22 to 2.6.23
can explain this. The only functional changes there are a critical fix
for FastTrack TX4200 (not your card), and support for SATA hotplugging
(not happening here).

So I'm suspecting something in libata core might have changed to fix this.

Just to make sure, what's the numerical PCI IDs for your card?

(No big deal, but I'd like to know what the error was.)

/Mikael
