From: Aron Rubin <arubin@atl.lmco.com>
Subject: Re: SII 3512+Seagate on Athlon64 system
Date: Wed, 03 Dec 2003 07:43:01 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FCDDA55.8000608@atl.lmco.com>
References: <3FCD07C4.7090205@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [192.35.37.50] ([192.35.37.50]:31185 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S264505AbTLCMnM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Dec 2003 07:43:12 -0500
In-Reply-To: <3FCD07C4.7090205@atl.lmco.com>
List-Id: linux-ide@vger.kernel.org
To: Aron Rubin <aron.rubin@lmco.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Justin M. Forbes" <64bit_fedora@comcast.net>, Andre Hedrick <andre@linux-ide.org>

Ryan Earl's patch did not fix this particular problem, so I am back to 
needing help. Does slow but correct comms with an occational "hda: lost 
interrupt" (about four total while talking to the drive) indicate that I 
should be looking into something specific?

Aron

Aron Rubin wrote:
> SATA controller SII 3512 not recognized by driver. It looks like SII 
> 3512 is almost identical to 3112 interface. I copy/paste/alterred all 
> code in ide/pci/siimage.[ch] with "3112" in it to "3512". It seems about 
> 95% functional. Need help with remaining 5%, related to very, very, slow 
> controller comms during init with occational "Interrupt Lost" messages. 
> Seems like comms are out of sync and then resync over and over. Other 
> than that all drive info comes over. Ryan Earl's patch may fix, I would 
> be suprised if it was that simple though. I will try later today.
> 
> Aron
> 


-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com

