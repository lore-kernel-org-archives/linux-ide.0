From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Date: Thu, 12 Aug 2004 20:55:48 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092340539.22362.11.camel@localhost.localdomain>
References: <20040810161911.GA10565@devserv.devel.redhat.com>
	 <200408102148.57602.ianh@iahastie.local.net>
	 <20040810210630.GA30906@devserv.devel.redhat.com>
	 <200408110136.06137.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:44757 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268670AbUHLU6N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Aug 2004 16:58:13 -0400
In-Reply-To: <200408110136.06137.ianh@iahastie.local.net>
List-Id: linux-ide@vger.kernel.org
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: Alan Cox <alan@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Mer, 2004-08-11 at 01:36, Ian Hastie wrote:
> Yes it does.  It's certainly sold as a RAID card and it does have a RAID setup 
> menu.  I haven't had the opportunity to use it fully as the discs I needed to 
> use on it were already set up for software RAID.  Maybe I'll have a couple 
> spare(!) discs to play with if I upgrade to SATA.

Much obliged - I got one from Novatech and I've been doing a bit more
hammering on it. For non raid configurations but in smart mode my card
now seems to be working. Its in part dependant on a core IDE change
however so I'll push the relevant bits to Bart in order.

I've not tried raid yet (case logistics) but will do so very soon.


