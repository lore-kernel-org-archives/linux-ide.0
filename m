From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 13:49:00 +0900
Message-ID: <446AAB3C.6050303@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <20060516190507.35c1260f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:12166 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751249AbWEQEtG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 00:49:06 -0400
Received: by nz-out-0102.google.com with SMTP id 8so159784nzo
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 21:49:05 -0700 (PDT)
In-Reply-To: <20060516190507.35c1260f.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Hello, Andrew.

Andrew Morton wrote:
[--snip--]
> [   44.719422] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
> [   44.719425] ata2.00: ATAPI, max UDMA/66
> [   44.765263] ata2.00: applying bridge limits
> [   74.928836] ata2.01: qc timeout (cmd 0xa1)
> [   74.977811] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   75.468853] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
> [   75.468856] ata2.00: ATAPI, max UDMA/66
> [   75.514678] ata2.00: applying bridge limits
> [  105.674130] ata2.01: qc timeout (cmd 0xa1)

Did this device work with previous versions of kernel?

libata used to give up on the first failure during probe, so the boot 
time would have been shorter in failure cases.  I think controlled 
retries during boot probe is a good thing, but the timeout of 30s for 
IDENTIFY commands can be shortened, I guess.

-- 
tejun
