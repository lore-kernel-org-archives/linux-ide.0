From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 10/14] ahci: separate out ahci_stop/start_engine()
Date: Mon, 19 Dec 2005 15:05:51 +0900
Message-ID: <43A64DBF.9000504@gmail.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218134822.GK31571@htj.dyndns.org> <43A64624.8040106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:60737 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030270AbVLSGF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 01:05:56 -0500
Received: by zproxy.gmail.com with SMTP id 13so1226626nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 22:05:55 -0800 (PST)
In-Reply-To: <43A64624.8040106@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Separate out ahci_stop/start_engine() from ahci_restart_port().  This
>> is preparation for conversion to new reset mechanism.
> 
> 
> this sort of patch should be sent first, since it is "easy to apply" 
> even though I might disagree with earlier patches in the series.
> 

Will do.  Just trying to place them just before they are needed.

Thanks.

-- 
tejun
