From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sil680: PIO1 taskfile transfers overclocking fix
 (repost)
Date: Tue, 30 Jan 2007 09:16:26 -0500
Message-ID: <45BF533A.8080503@garzik.org>
References: <200701282133.44760.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45914 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965468AbXA3OQ3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 09:16:29 -0500
In-Reply-To: <200701282133.44760.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> Fix PIO mode 1 overclocked taskfile transfers -- probably a typo carried over
> from drivers/ide/pci/siimage.c where I've found it by documentation check...
> 
>  drivers/ata/pata_sil680.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied.

Please put the diffstat /after/ the standard "---" terminator, as noted 
in Documentation/SubmittingPatches.

All text that should not be copied verbatim into the kernel changelog 
should follow the "---" terminator.

	Jeff


