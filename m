From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 3/5] libata-dev: Let ata_hsm_move() work with both
 irq-pio and polling pio
Date: Sat, 11 Mar 2006 02:32:33 +0900
Message-ID: <4411B831.6030607@gmail.com>
References: <440FEA4B.10500@tw.ibm.com> <440FEC98.4010500@tw.ibm.com> <20060310093128.GC20207@htj.dyndns.org> <441184B6.9060302@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.207]:63854 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751382AbWCJR70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 12:59:26 -0500
Received: by xproxy.gmail.com with SMTP id i30so10660wxd
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 09:59:26 -0800 (PST)
In-Reply-To: <441184B6.9060302@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Tejun Heo wrote:
>>
>>For ATA PIO write transfers, the first transfer and n'th transfers
>>aren't really different.  The code would be simpler if it handles the
>>first ATA PIO write in HSM_ST.  And if we do that, HSM_ST_FIRST can be
>>renamed to HSM_ST_CDB.  Hmmm.. Maybe this should be done in separate
>>series of patches.
>>
> 
> 
> For ATA PIO write transfer, the first transfer is different:
> It is always done by polling, even if irq is turned on.
> 
> If we treat the first PIO write transfer as HSM_ST, we need to add some
> additional logic to HSM_ST and check whether it is first transfer or not. If it is,
> and irq is on, the transition from polling to interrupt-driven must be protected
> by spinlock, similar to what's done in HSM_ST_FIRST.

Oh, you're right. I wasn't thinking of the spinlock. I implemented HSM 
for sata_sil vdma (still slightly broken) and made its HSM function 
always called under the host spinlock, so I could merge ATA HSM_ST_FIRST 
into HSM_ST for ATA WRITE's and got confused about your HSM.  :-)

Hmmm.. I'm not sure but I recall to read about IDE controllers reacting 
badly when disturbed during PIO thus requiring irq-off during PIO. Does 
anyone know better about this?

-- 
tejun
