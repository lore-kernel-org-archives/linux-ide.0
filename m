From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 1/2] sata_via: Correctly setup PIO/DMA for pata slave
 on vt6421.
Date: Wed, 20 Jan 2010 12:33:05 +0900
Message-ID: <4B567971.7000904@gmail.com>
References: <20100116235653.898098245@gmail.com> <20100116235849.969478053@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:39938 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890Ab0ATD1C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 22:27:02 -0500
In-Reply-To: <20100116235849.969478053@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Hartgers <bart.hartgers@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 01/17/2010 08:56 AM, Bart Hartgers wrote:
> Before only the timings for master were set. Datasheet can be found
> here: ftp://ftp.vtbridge.org/Docs/Storage/DS_VT6421A_100_CCPL.PDF
> Surprisingly, a slave drive works without this patch. According to the
> datasheet, the controller by default derives the DMA mode from the 
> Set Features command issued to a drive. Not sure about the PIO
> timings, though. The real problem is that the timings for the master
> effectively are the ones tuned for the slave. If these support
> different UDMA-settings, there is trouble, especially when the slave
> supports a higher UDMA than the master. 
> 
> Anyhow, using the same mechanism for both master and slave seems like 
> a good idea.
> 
> Signed-off-by: Bart Hartgers <bart.hartgers@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
