From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 14:13:22 +0900
Message-ID: <45FA2772.7020404@gmail.com>
References: <248173.18921.qm@web806.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:49413 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXCPFN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 01:13:29 -0400
Received: by nf-out-0910.google.com with SMTP id o25so117597nfa
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 22:13:28 -0700 (PDT)
In-Reply-To: <248173.18921.qm@web806.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Bob Stewart wrote:
> --- Tejun Heo <htejun@gmail.com> wrote:
> 
>> The driver is seriously broken regarding LBA48 support.  The timeout
>> goes away if max_sectors is decreased to ATA_MAX_SECTORS - 1, doh.
> 
> Tejun,
> 
> I should have commented on this earlier.  I still get occasional timeouts
> regardless of the max_sectors settings.  Yes, it's much much lower with
> some settings vs others, but they're still there.
> 
> I was just messing around and did this.  I still got the occasional timeouts.

I see.  Thanks.  We might really need to use the ADMA mode not the
TF/quasi-BMDMA mode.

-- 
tejun
