From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/14] ahci: convert to new reset mechanism
Date: Mon, 19 Dec 2005 15:07:10 +0900
Message-ID: <43A64E0E.10807@gmail.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218134924.GL31571@htj.dyndns.org> <43A64642.7010502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:32469 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030273AbVLSGHP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 01:07:15 -0500
Received: by zproxy.gmail.com with SMTP id 14so1844710nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 22:07:15 -0800 (PST)
In-Reply-To: <43A64642.7010502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Convert ahci ->phy_reset to ->hard_reset.  The original ->phy_reset
>> simply called __sata_phy_reset() to perform reset; however, AHCI spec
>> mandates to turn off START bit during reset.  New ->hard_reset method
>> properly follows AHCI reset procedure.
> 
> 
> If you feel AHCI deviates from spec, it sounds like this fix should be 
> separated out into a new patch?
> 

Well, as I was writing a new reset method.  Maybe I can do this in two 
steps - first, fix ->phy_reset, then convert to ->hard_reset.  Hmmm... 
will send rewrite of ->phy_reset separately soon.

Thanks.

-- 
tejun
