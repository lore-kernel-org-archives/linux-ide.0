From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 1/2] sata_via: Correctly setup PIO/DMA for pata slave
 on vt6421.
Date: Wed, 20 Jan 2010 14:35:13 -0500
Message-ID: <4B575AF1.5020607@pobox.com>
References: <20100116235653.898098245@gmail.com> <20100116235849.969478053@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53110 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab0ATTfS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 14:35:18 -0500
In-Reply-To: <20100116235849.969478053@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Hartgers <bart.hartgers@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 01/16/2010 06:56 PM, Bart Hartgers wrote:
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
> Signed-off-by: Bart Hartgers<bart.hartgers@gmail.com>

applied


