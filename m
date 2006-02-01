From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: sata_mv and MV88SX6041 don't work
Date: Wed, 1 Feb 2006 16:18:55 +0100
Message-ID: <200602011618.55374.sojkam1@fel.cvut.cz>
References: <EXCHG2003qSOc7wo95E00001106@EXCHG2003.microtech-ks.com>
Reply-To: sojkam1@fel.cvut.cz
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:51924 "EHLO
	relay.felk.cvut.cz") by vger.kernel.org with ESMTP id S1161085AbWBAPTq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 10:19:46 -0500
In-Reply-To: <EXCHG2003qSOc7wo95E00001106@EXCHG2003.microtech-ks.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kelbelj@fel.cvut.cz

Hello Roger,

thank you for reply. Just after sending my previous email, we have find, that 
current sata_mv driver is not working with MSI enabled. We disabled MSI and 
the driver in working now (under 2.6.15.1). This kernel has also fixed 
another problem we had (ACPI), so now we are happy :).

Michal

On Wednesday 01 February 2006 16:15, Roger Heflin wrote:
> We have reported highpoints Marvell GPL derivative not working
> on 2.6.14+, it does work on 2.6.13 kernels.
>
> I suspect that it will be a while before it works, Highpoint
> (and I assume Marvell) are supposed to be working on
> correcting the issues.
>
> I also suspect that it will be a while before the sata_mv is
> fully operational.
>
>                          Roger
