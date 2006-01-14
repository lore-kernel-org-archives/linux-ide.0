From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: additional PCI device ID for the sata_svw driver
Date: Sat, 14 Jan 2006 18:35:56 +1100
Message-ID: <1137224156.4854.59.camel@localhost.localdomain>
References: <1716960.1137003815347.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:9616 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932763AbWANHgV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2006 02:36:21 -0500
In-Reply-To: <1716960.1137003815347.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oliver Weihe <o.weihe@deltacomputer.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, 2006-01-11 at 19:23 +0100, Oliver Weihe wrote:
> Hello,
> 
> please add the following device ID into the sata_svw driver:

Jeff, you'll take care of it or do you want me to submit a patch ? I'm
more than happy to leave you maintainership of this driver ;)

Ben.

> [root@localhost ~]# lspci -d 1166:024b
> 01:0e.0 IDE interface: Broadcom: Unknown device 024b
> 01:0e.1 IDE interface: Broadcom: Unknown device 024b
> 
> Broadcom (Serverworks) HT2000/HT1000 chipset
> 
> I've _MINIMALLY_ tested it with a vanilla 2.6.15 (x86_64) and it seems
> to work
> (created some partitions and filesystems, wrote and read some files).
> 
> Regards,
>   Oliver Weihe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

