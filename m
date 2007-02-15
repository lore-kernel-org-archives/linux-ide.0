From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiI 3114 and sata_sil
Date: Thu, 15 Feb 2007 13:42:18 -0500
Message-ID: <45D4A98A.7070705@pobox.com>
References: <45D4A705.4050407@andrei.myip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57965 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030512AbXBOSmX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 13:42:23 -0500
In-Reply-To: <45D4A705.4050407@andrei.myip.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florin Andrei <florin@andrei.myip.org>
Cc: linux-ide@vger.kernel.org

Florin Andrei wrote:
> (I'm not subscribed to linux-ide)
> 
> I've two almost identical systems (slightly different CPUs) that use SiI 
> 3114 for SATA and RAID.
> 
> One of them was installed a while ago with Fedora Core 5 (kernel 
> 2.6.15-1.2054_FC5smp) and whoever installed it was able to turn on 
> hardware RAID.

This chip does not support hardware RAID.  The capability simply isn't 
there in the silicon.

http://linux-ata.org/faq-sata-raid.html#sii

	Jeff


