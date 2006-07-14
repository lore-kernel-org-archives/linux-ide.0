From: Mark Lord <liml@rtr.ca>
Subject: Re: Marvell 88SX6081 Support
Date: Fri, 14 Jul 2006 13:35:17 -0400
Message-ID: <44B7D5D5.1030501@rtr.ca>
References: <1152678246.11313.53.camel@eliza>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:8411 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422667AbWGNRfS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jul 2006 13:35:18 -0400
In-Reply-To: <1152678246.11313.53.camel@eliza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Charles Tassell <ctassell@isn.net>
Cc: linux-ide@vger.kernel.org

Charles Tassell wrote:
> Hello,
> 
>   I'm interested in buying a system (a SuperMicro 6024H-TR) with the
> Marvell 88SX6081 SATA RAID controller, but the "highly experimental"
> marker in the kernel config worries me.  Is there an alternate driver (I
> saw reference to Adaptec AAR81xx being used), or is this thing actually
> ready for production?

"Moderately experimental" might be a better label now in 2.6.17.

I believe the kernel driver to be as good as most of the other chipset
drivers on 32-bit x86.  Not so sure about 64-bit AMD yet, though, as a few
people have observed some strange behaviour there, even with 2.6.17.

I suspect it is simply running afoul of the recently discovered libata EH
bugs that exist prior to 2.6.18, and which have yet to be fully characterized
and resolved.

Cheers
