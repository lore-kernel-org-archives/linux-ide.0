From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata_acpi: A different strategy for using ACPI
 information
Date: Wed, 4 Jul 2007 10:49:54 +0100
Message-ID: <20070704104954.16812248@the-village.bc.nu>
References: <fa.rEwk8NvbygVfpOfb23QZ97ZMeXs@ifi.uio.no>
	<468AE196.9070202@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45787 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757019AbXGDJnj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:43:39 -0400
In-Reply-To: <468AE196.9070202@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

> Looks fairly reasonable to me. However, I suspect any use of _GTM is 
> somewhat dangerous (at least after the resume) unless we use the _STM 
> and _GTF methods in the proper sequence when resuming. (Is that in the 
> -mm tree now?)

Yes - and we only use it in these drivers to check for cable evidence not
for anything more serious.

> speed we give it is valid, since there is no sane way for the function 
> to indicate failure. (Thus the problem with the "cram in all possible 
> values to see what it supports" strategy for determining mode limits..)

The spec I have says it'll hand back the mode it actually uses which is
effectively a solution for 'failure'
