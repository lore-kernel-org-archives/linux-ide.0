From: Jim Paris <jim@jtan.com>
Subject: Re: [2.6.22-rc6] NForce4 soft and hard resetting ports and exceptions
Date: Tue, 26 Jun 2007 16:02:59 -0400
Message-ID: <20070626200259.GA5816@jim.sh>
References: <pan.2007.06.26.17.45.21@telenet.be> <pan.2007.06.26.18.54.37@telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:43317 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759674AbXFZUSy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 16:18:54 -0400
Content-Disposition: inline
In-Reply-To: <pan.2007.06.26.18.54.37@telenet.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frederik Himpe <fhimpe@telenet.be>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Frederik Himpe wrote:
> On Tue, 26 Jun 2007 17:45:22 +0000, Frederik Himpe wrote:
> 
> > I tried Linux 2.6.22-rc6 on my machine with an Asus A8N-SlI Deluxe
> > motherboard (NForce 4 chipset).
> > 
> > When booting, the system hangs for a long time, but it continues after a
> > long wait. I found these kind of errors in the logs afterwards:
> 
> [...]
> 
> > With Linux 2.6.21 this did not happen.
> > 
> > config, dmesg and lspci can be found here:
> > http://artipc10.vub.ac.be/kernelbug/
> 
> After disabling hddtemp and smartd services, these errors do not happen 
> anymore.

This was a bug in smartmontools.  It is fixed in CVS and should be in
the next released version.
  http://article.gmane.org/gmane.linux.utilities.smartmontools/4621

-jim
