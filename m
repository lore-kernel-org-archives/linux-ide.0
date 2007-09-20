From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: First cut at verifying and validating all the
 id checks.
Date: Thu, 20 Sep 2007 16:55:37 -0400
Message-ID: <46F2DE49.1040405@garzik.org>
References: <20070808144045.5189496b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51548 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbXITUzj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 16:55:39 -0400
In-Reply-To: <20070808144045.5189496b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> - Fix those which require a word is checked for validity
> - Note limits on version information with ancient ATA
> - Correct EIDE dword_io check ready for adding 32bit PIO
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

any update on this?

I definitely agree we should be checking the validity values.

	Jeff



