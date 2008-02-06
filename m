From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: fix CAP.NP and PI handling
Date: Wed, 06 Feb 2008 07:03:37 -0500
Message-ID: <47A9A219.8060303@garzik.org>
References: <47A9501F.5020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40508 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761659AbYBFMDk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 07:03:40 -0500
In-Reply-To: <47A9501F.5020501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>

Tejun Heo wrote:
> AHCI uses CAP.NP to indicate the number of ports and PI to tell which
> ports are enabled.  The only requirement is that the number of ports
> indicated by CAP.NP should equal or be higher than the number of
> enabled ports in PI.
> 
> CAP.NP and PI carry duplicate information and there have been some
> interesting cases.  Some early AHCI controllers didn't set PI at all
> and just implement from port 0 to CAP.NP.  An ICH8 board which wired
> four out of six available ports had 3 (4 ports) for CAP.NP and 0x33
> for PI.  While ESB2 has less bits set in PI than the value in CAP.NP.
> 
> Till now, ahci driver assumed that PI is invalid if it doesn't match
> CAP.NP exactly.  This violates AHCI standard and the driver ends up
> accessing unmimplemented ports on ESB2.
> 
> This patch updates CAP.NP and PI handling such that PI can have less
> number of bits set than indicated in CAP.NP and the highest port is
> determined as the maximum port of what CAP.NP and PI indicate.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jan Beulich <jbeulich@novell.com>

applied


