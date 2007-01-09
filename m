From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: DMA errors with HTP370 IDE in <= 2.6.18.2
Date: Tue, 09 Jan 2007 15:42:23 +0300
Message-ID: <45A38DAF.6020408@ru.mvista.com>
References: <45A2A0AC.1050203@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:5344 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751356AbXAIMmX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2007 07:42:23 -0500
In-Reply-To: <45A2A0AC.1050203@berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Bueker <m.bueker@berlin.de>
Cc: linux-ide@vger.kernel.org

Michael Bueker wrote:

  > In the controller's setup utility, I can choose access modes. If i
> switch it from UDMA5 to PIO0, the only difference during boot is:

    PIO0 is outrageously slow, use PIO4 (very slow as well but at least 
somewhat faster).  Anyway, this won't help with Linux...

>> ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio

> instead of

>> ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA

    You should specify the option ide=nodma to the kernel to disable IDE core 
from using DMA.

> Please help me getting DMA to work with this controller.

    For starters, please try the driver from 2.6.20-rc1 and (if that doesn't 
help) from the -mm tree. I rewrote it and it's working OK on at least my HPT370...

> Thanks in advance,
> ~Mik

WBR, Sergei
