From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Fri, 9 Nov 2007 12:04:25 +0000
Message-ID: <20071109120425.543971bf@the-village.bc.nu>
References: <20071109020235.GA2031@ceren>
	<20071109023129.GA25581@havoc.gtf.org>
	<4733D421.7000505@rtr.ca>
	<20071109034622.GB25581@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35440 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751578AbXKIMEc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 07:04:32 -0500
In-Reply-To: <20071109034622.GB25581@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

On Thu, 8 Nov 2007 22:46:22 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> On Thu, Nov 08, 2007 at 10:29:37PM -0500, Mark Lord wrote:
> > And I might even privately patch my own kernels to map the ACHI BAR
> > in the cases where the BIOS didn't...
> 
> The inability to do this in the general case is the main reason why
> AHCI was not unconditionally enabled, even in IDE mode, when it was
> originally added...  :/

We've done it all the time for various devices without problems (eg S3
video cards). I'd like to see it go in - although perhaps attached to a
force_ahci boot param initially
