From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Bart's efforts?
Date: Fri, 9 Nov 2007 11:27:40 +0100
Message-ID: <18228.13852.23698.993650@alkaid.it.uu.se>
References: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:43724 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbXKIK1w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Nov 2007 05:27:52 -0500
In-Reply-To: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, greg.freemyer@gmail.com, linux-ide@vger.kernel.org

Mikael Pettersson writes:
 > On Sat, 3 Nov 2007 14:10:22 +0000, Alan Cox wrote:
 > > > My question is if the drivers/ide infrastructure is slowly moving in
 > > > the direction of being leverageable by libata when/if it moves out of
 > > > scsi.  Or does the drivers/ide code simply have the wrong kind of
 > > > plumbing for libata to ever use.
 > > 
 > > I don't think there is anything useful in old IDE that isn't in the new.
 > 
 > For semi-modern machines that might be true. However:
 > 
...
 > 2) pata_pdc202xx_old can't do UDMA on my 440BX PIII box

See <http://bugzilla.kernel.org/show_bug.cgi?id=9337> for details.

