From: Greg KH <greg@kroah.com>
Subject: Re: pata sc1200 fix crash boot, bug #14227
Date: Thu, 5 Nov 2009 15:21:15 -0800
Message-ID: <20091105232115.GG20799@kroah.com>
References: <4AE1F29B.1090009@computer.org>
 <4AE1F525.5090207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:34141 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758986AbZKEX2O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Nov 2009 18:28:14 -0500
Content-Disposition: inline
In-Reply-To: <4AE1F525.5090207@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jan Ceuleers <jan.ceuleers@computer.org>, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, stable@kernel.org

On Fri, Oct 23, 2009 at 02:25:41PM -0400, Jeff Garzik wrote:
> On 10/23/2009 02:14 PM, Jan Ceuleers wrote:
> > A little while ago [1], a fix was posted here for a boot-time crash in the sc1200 module.
> >
> > [1]: http://marc.info/?l=linux-kernel&m=125484259025909&w=2
> >
> > Submission to stable was also briefly discussed, but has apparently not happened, despite the fact that this bug appears to have existed since 2.6.29.
> >
> > I would therefore like to request that this fix now be submitted to stable.
> 
> Looks like commit 6d4f950e9ea15816c6a4f266ce6b9e438346771e is missing 
> the "CC:stable@kernel.org".  Added implicitly via this message...

Now queued up.

thanks,

greg k-h
