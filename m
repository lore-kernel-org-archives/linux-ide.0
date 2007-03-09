From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Change prototype of mode_filter to remove ata_port
 *
Date: Fri, 09 Mar 2007 09:34:43 -0500
Message-ID: <45F17083.6030702@garzik.org>
References: <20070308234542.01176a18@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56670 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767312AbXCIOeq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 09:34:46 -0500
In-Reply-To: <20070308234542.01176a18@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> With Tejun having added adev->ap some time ago we can get rid of the
> almost unused port being passed to mode filters. And while we are doing filters,
> lets turn on the !IORDY filter as well.
> 
> (Versus -mm tree and queued diffs so may not 100% match your tree Jeff
> but cc'd so you can comment on if this is a good idea or
> not)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied by hand.  pdc2027x got dropped in the mess, as you might have 
guessed from my last reply relating to that driver



