From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI: connection status changed + hard resetting link with 2.6.30+
Date: Thu, 09 Jul 2009 07:45:25 +0900
Message-ID: <4A552185.7090301@kernel.org>
References: <4A4FD162.30604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60179 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbZGHWp3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2009 18:45:29 -0400
In-Reply-To: <4A4FD162.30604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zdenek Kaspar <zkaspar82@gmail.com>
Cc: linux-ide@vger.kernel.org

Zdenek Kaspar wrote:
> Hi, when booted latest -stable kernel (2.6.30.1) got this in dmesg:
> 
> [    1.521856] ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
> [    1.521908] ata8: irq_stat 0x00400040, connection status changed
> [    1.521962] ata8: hard resetting link
> 
> Same result with 2.6.31-rc2, with 2.6.29.6 it works OK.
> 
> Could this cause any trouble ?

Most likely not.  Looks like the device going through an extra PHY
event cycle during initial probing.  I don't recall any change since
2.6.29 which could cause such behavior difference.  Can you please
post the output of "lspci -nn" and full boot log?

Thanks.

-- 
tejun
