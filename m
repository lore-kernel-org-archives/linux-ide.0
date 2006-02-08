From: Tejun Heo <htejun@gmail.com>
Subject: Re: irq-pio branch updated with Tejun's patches
Date: Wed, 08 Feb 2006 17:46:39 +0900
Message-ID: <43E9AFEF.4010909@gmail.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:59095 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030575AbWBHIqp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2006 03:46:45 -0500
Received: by pproxy.gmail.com with SMTP id f25so255222pyf
        for <linux-ide@vger.kernel.org>; Wed, 08 Feb 2006 00:46:44 -0800 (PST)
In-Reply-To: <43E9AAE0.8020302@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Jeff Garzik wrote:
> 
>>I updated the libata irq-pio branch with Tejun's patches.  I would
>>appreciate it if you could check my work, and make sure that everything
>>continues to function properly.
>>
> 
> 
> Sorry for the late reply.
> Still checking Tejun's patches, especially the EH vs polling PIO racing fix.
> 
> Fixed minor compiliation problem in the irq-pio branch with Tejun and your patches.
> Will submit those minor patches first.
> 

Hello, Albert.

This is sort of OT, but would it be possible to separate PIO 
issuing/interrupt handling from ata_qc_issue_prot and ata_host_intr?

As PIO implementation currently stands, a lldd must use those standard 
methods to use PIO, but some controllers need PIO handling but the stock 
issue and interrupt routines don't really fit. e.g. not-yet-working 
sata_inic162x.  Something like ata_qc_issue_pio and ata_qc_pio_intr maybe?

-- 
tejun
