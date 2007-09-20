From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: First cut at verifying and validating all the
 id checks.
Date: Thu, 20 Sep 2007 22:43:52 +0100
Message-ID: <20070920224352.0685a0e4@the-village.bc.nu>
References: <20070808144045.5189496b@the-village.bc.nu>
	<46F2DE49.1040405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47463 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751145AbXITVgr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 17:36:47 -0400
In-Reply-To: <46F2DE49.1040405@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Thu, 20 Sep 2007 16:55:37 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > - Fix those which require a word is checked for validity
> > - Note limits on version information with ancient ATA
> > - Correct EIDE dword_io check ready for adding 32bit PIO
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> any update on this?

Its sitting in -mm and I've heard no screaming so far
