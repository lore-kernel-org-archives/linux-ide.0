From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] pata_legacy: fix no device fail path
Date: Thu, 16 Apr 2009 15:23:08 -0400
Message-ID: <49E7859C.2080701@pobox.com>
References: <19f34abd0804200329j3308b081vc0732c3ec5c0b721@mail.gmail.com> <1208782090.7115.179.camel@twins> <480FF821.9050208@gmail.com> <49E0C102.4020705@pobox.com> <49E22ED9.40100@gmail.com> <49E40A07.6010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37873 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbZDPTXQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 15:23:16 -0400
In-Reply-To: <49E40A07.6010905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Vegard Nossum <vegard.nossum@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> When pata_legacy can't detect any device, it unregisters the
> platform_device and fails detection.  However, it forgets to detach
> ata host triggering weird failures as the host later gets freed by
> devres while still attached.  Fix it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> ---
> Well, with or without test verification, this patch is correct.  Thanks.
> 
>  drivers/ata/pata_legacy.c |    1 +
>  1 file changed, 1 insertion(+)

applied


