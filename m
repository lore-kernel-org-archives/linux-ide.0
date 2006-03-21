From: Gordon Atwood <gordon@cs.ualberta.ca>
Subject: Re: sata_promise does not see hardware RAID arrays on Fasttrak TX4000
Date: Tue, 21 Mar 2006 11:01:18 -0700
Message-ID: <20060321180118.GK17279@cs.ualberta.ca>
References: <20060320194728.GA17279@cs.ualberta.ca> <441F0932.1080001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sunkay.cs.ualberta.ca ([129.128.4.11]:6096 "EHLO
	sunkay.cs.ualberta.ca") by vger.kernel.org with ESMTP
	id S1751587AbWCUSBX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 13:01:23 -0500
Received: from fleet.cs.ualberta.ca ([129.128.22.22]:45450 "EHLO
	fleet.cs.ualberta.ca") by sunkay.cs.ualberta.ca with ESMTP
	id S559233AbWCUSBV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 11:01:21 -0700
Received: from fleet.cs.ualberta.ca (localhost.localdomain [127.0.0.1])
	by fleet-spampd (Postfix) with ESMTP id 6EA4E28002
	for <linux-ide@vger.kernel.org>; Tue, 21 Mar 2006 11:01:19 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <441F0932.1080001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Mon, Mar 20, 2006 at 02:57:38PM -0500, Jeff Garzik wrote:
> Gordon Atwood wrote:
> >Ok, I've searched thru dozens of webpages and done the RTFM thing.  If its
> >really obvious, sorry, I still missed it.
> 
> http://linux-ata.org/faq-sata-raid.html#tx2
> 
> http://linux-ata.org/faq-sata-raid.html#dmraid

Hmm...  Ok, so a TX4000 is equivalent to a TX4.  Nothing I read suggested that
so I missed this.  And this is a fake raid card.  Figures.  Should probably
just chuck it.

Unfortunately, although dmraid 'sees' sda-sdd it only recognizes the striped
array on sdc-sdd.  It totally ignores the striped array on sda-sdb.

Even if it did see them, I don't see how I'm any further ahead.

Why should I bother with dmraid when I should just go be able to go directly
to sda-d, format them and then layer software RAID or LVM on top of that.
I can set up the four disks as individual single-disk arrays in the Promise
BIOS and away we go.

If the Promise card has overhead for processing I/O it will be there
regardless of whether I go thru dmraid or mdadm or LVM.  At least in the
latter configuration, I can always go out and get a real 4 port ide
card and just hook up the disks to it.  Then this card can go in the
trash.

Thanks much for the pointer.  Interesting how no matter how hard you search,
there is always a direct thread to the info that you want that you'll
completely miss :-)

G.H.A.
