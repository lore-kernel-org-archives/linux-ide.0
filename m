From: Othmar Pasteka <pasteka@kabsi.at>
Subject: Re: Serial ATA (SATA) for Linux status report
Date: Thu, 4 Dec 2003 00:49:07 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031203234907.GA4184@tron.at>
References: <20031203204445.GA26987@gtf.org> <1070494030.15415.111.camel@slurv.pasop.tomt.net> <3FCE737C.1080105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h081217022198.dyn.cm.kabsi.at ([81.217.22.198]:29825 "EHLO
	botticelli.tron.priv.at") by vger.kernel.org with ESMTP
	id S262375AbTLCXtJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Dec 2003 18:49:09 -0500
Content-Disposition: inline
In-Reply-To: <3FCE737C.1080105@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

hi,

On Wed, Dec 03, 2003 at 06:36:28PM -0500, Jeff Garzik wrote:
> Alas, there is no hotplug support in the ICH5 or ICH5-R SATA hardware.
> 
> One could argue there is "coldplug" support in that hardware -- disable 
> the entire interface, including any active devices, then re-enable and 
> re-scan -- but it's a bit of a hack.  If there's enough demand, I could 
> write some code for that.  It would involve something like
> 
> 	# /sbin/sata off
> 	{ plug in or remove a device }
> 	# /sbin/sata on
> 
> You really, really, really don't want to actually unplug a SATA drive 
> while it's active, on ICH5 hardware.

are there chipsets which support SATA hot plugging? afaik sata is
supposed to be hotplugable.

TIA
Othmar Pasteka
