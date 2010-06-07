From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: redo stopping DMA engines on empty
 ports
Date: Mon, 07 Jun 2010 16:08:43 -0400
Message-ID: <4C0D51CB.2060908@garzik.org>
References: <4C0CF0DC.7060901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57638 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab0FGUIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2010 16:08:46 -0400
Received: by mail-gw0-f46.google.com with SMTP id 15so1452875gwb.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Jun 2010 13:08:46 -0700 (PDT)
In-Reply-To: <4C0CF0DC.7060901@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, Marc Dionne <marc.c.dionne@gmail.com>, Robert Hancock <hancockrwd@gmail.com>

On 06/07/2010 09:15 AM, Tejun Heo wrote:
> Commit 96d60303fd (ahci: Turn off DMA engines when there's no device)
> implemented stopping DMA engines on empty ports but it used single
> sampling of status registers to determine device presence which led to
> disabling of DMA engines on occupied ports.  Do it after all EH
> actions are complete using device presence state determined by EH.
> This avoids spurious disabling of DMA engines and simplifies the code.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Tested-by: Marc Dionne<marc.c.dionne@gmail.com>
> Cc: Matthew Garrett<mjg@redhat.com>
> Cc: Robert Hancock<hancockrwd@gmail.com>
> ---
>   drivers/ata/libahci.c |   21 +++------------------
>   1 file changed, 3 insertions(+), 18 deletions(-)

applied


