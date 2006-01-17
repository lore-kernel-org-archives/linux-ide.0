From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: additional PCI device ID for the sata_svw driver
Date: Tue, 17 Jan 2006 07:58:51 -0500
Message-ID: <43CCEA0B.2080502@pobox.com>
References: <1716960.1137003815347.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:42666 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932474AbWAQM65 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 07:58:57 -0500
In-Reply-To: <1716960.1137003815347.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oliver Weihe <o.weihe@deltacomputer.de>
Cc: benh@kernel.crashing.org, linux-ide@vger.kernel.org

Oliver Weihe wrote:
> Hello,
> 
> please add the following device ID into the sata_svw driver:
> 
> [root@localhost ~]# lspci -d 1166:024b
> 01:0e.0 IDE interface: Broadcom: Unknown device 024b
> 01:0e.1 IDE interface: Broadcom: Unknown device 024b
> 
> Broadcom (Serverworks) HT2000/HT1000 chipset
> 
> I've _MINIMALLY_ tested it with a vanilla 2.6.15 (x86_64) and it seems
> to work
> (created some partitions and filesystems, wrote and read some files).

added


