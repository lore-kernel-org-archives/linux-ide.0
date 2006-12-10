From: Jim Paris <jim@jtan.com>
Subject: Re: sata_nv fails to reattach drive during hotswap?
Date: Sun, 10 Dec 2006 12:48:27 -0500
Message-ID: <20061210174827.GA3689@jim.sh>
References: <457BE447.2000705@gmail.com> <457BE050.9090109@uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:57967 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762289AbWLJRsi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Dec 2006 12:48:38 -0500
Content-Disposition: inline
In-Reply-To: <457BE447.2000705@gmail.com> <457BE050.9090109@uci.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hoka ME Tichenci <melkin@uci.edu>, hokatichenci <hokatichenci@gmail.com>
Cc: linux-ide@vger.kernel.org

Hoka ME Tichenci wrote:
> I'm currently using an Asus A8N-SLI Premium which offers 8 ports (4
> each) through a SI3114 and CK804 chipset. I have a generic istar/athena
> 4 in 3 SATA hot swap cage thats worked for very well with my Areca array
> on another system. When booting, it detects the drive just fine
> connected to the sata_nv controller. When I detach the drive, it also
> cleanly removes the device node. The problem is reattaching a drive
> (turning the power back on), libata will apparently detect the new
> drive, but then the port will "fail to respond" about twice before the
> link is determined.

Hi Hoka,

I think this patch fixes your problem:

  http://www.spinics.net/lists/linux-ide/msg04992.html

-jim
