From: Harri Olin <harri.olin@gmail.com>
Subject: Re: [PATCH] sata_mv: fix timeouts on lower ports of 508x/6081 chips
Date: Fri, 16 Jan 2009 22:08:56 +0200
Message-ID: <4970E958.1040800@gmail.com>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com> <496E61E8.5010602@rtr.ca> <496E72D7.2070206@gmail.com> <496EA53F.7000605@rtr.ca> <496F34BF.5010701@ngs.ru> <4970BDC6.7020201@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:41594 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbZAPUJK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 15:09:10 -0500
In-Reply-To: <4970BDC6.7020201@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Artem Bokhan <aptem@ngs.ru>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>, stable@kernel.org

Mark Lord wrote:
> Fix a longstanding bug for the 8-port Marvell Sata controllers 
> (508x/6081),
> where accesses to the upper 4 ports would cause lost-interrupts / 
> timeouts
> for the lower 4-ports.  With this patch, the 6081 boards should 
> finally be
> reliable enough for mainstream use with Linux.
>
> This patch is for 2.6.29, but should also get reviewed/released
> for the -stable branches of 2.6.28, 2.6.27, and 2.6.26.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
>

After patching no timeouts have occurred for 22 hours on 2.6.28 and 24 
hours on 2.6.27.6.

Tested-by: Harri Olin <harri.olin@gmail.com>

-- 
Harri.

