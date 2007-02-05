From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add a host flag to indicate lack of IORDY
 capability
Date: Mon, 5 Feb 2007 23:13:12 +0000
Message-ID: <20070205231312.03565c3e@localhost.localdomain>
References: <20070205161515.38b8107d@localhost.localdomain>
	<20070205145120.546feb43.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58908 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964894AbXBEXAX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 18:00:23 -0500
In-Reply-To: <20070205145120.546feb43.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Mon, 5 Feb 2007 14:51:20 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 5 Feb 2007 16:15:15 +0000
> Alan <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > This is the first preparation to doing the !IORDY cases properly. Further
> > diffs will then add the needed logic to do it right.
> > 
> >...
> >
> >  static int pio_mask = 0x1F;		/* PIO range for autospeed devices */
> > ++static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */
> 
> That isn't compileable.  Are you sure you sent the correct patch?
> 
> This patch needed some fixups against git-libata-all, but they were pretty
> obvious.

Right patch. The patch on disk here lacks the +, the mail I sent includes
it. Looks like a typing slip or something while sending. Sorry about that.

Alan
