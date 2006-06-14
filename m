From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: convert several bmdma-style controllers to new
 EH, take #2
Date: Thu, 15 Jun 2006 00:44:49 +0900
Message-ID: <44902EF1.7030503@gmail.com>
References: <20060613115131.GA17964@htj.dyndns.org> <20060613214313.GA10142@htj.dyndns.org> <448F5BD2.6060905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:27454 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965011AbWFNPo4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jun 2006 11:44:56 -0400
Received: by nz-out-0102.google.com with SMTP id s18so214545nze
        for <linux-ide@vger.kernel.org>; Wed, 14 Jun 2006 08:44:55 -0700 (PDT)
In-Reply-To: <448F5BD2.6060905@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Convert sata_sis, svw, uli and vsc drivers to new EH.  All the drivers
>> used to specify ATA_FLAG_SATA_RESET to tell libata to use SATA
>> hardreset instead of SRST.
>>
>> This patch preserves the behavior by defining private error handler
>> for each driver which only supports SATA hardreset.  It is likely that
>> all these controllers support SRST and can simply use the stock bmdma
>> EH.  The private EH methods will be removed after each driver is
>> tested w/ the stock bmdma EH.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Too cautious :)  I don't want to add the duplicate code, and then just 
> remove it later when things are they are supposed to work.
> 
> Just make sure your changes will either (a) work or (b) fail in an 
> obvious way :)
> 
> Then call for testers...

Cool, I like that.  For get this and the via patch.  Will post braver 
version tomorrow.  :)

-- 
tejun
