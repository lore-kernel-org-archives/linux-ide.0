From: Tejun Heo <htejun@gmail.com>
Subject: Re: Kernel driver for Sil 3112 (sata_sil.c) problems
Date: Sat, 25 Feb 2006 22:07:34 +0900
Message-ID: <44005696.9040705@gmail.com>
References: <20060224194919.6B81F37B09@relay.netbox.cz> <44005308.8030308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:24180 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932707AbWBYNHj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2006 08:07:39 -0500
Received: by zproxy.gmail.com with SMTP id 14so585183nzn
        for <linux-ide@vger.kernel.org>; Sat, 25 Feb 2006 05:07:38 -0800 (PST)
In-Reply-To: <44005308.8030308@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: kacer <kacerxy@seznam.cz>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> kacer wrote:
> 
>> Dear Jeff,
>> sorry for disturbing you, but I tried nearly everything to get this SATA
>> controller (Silicon Image Sil 3112) working, but it always crashes while
>> writing data (few hundred MBs or few GBs). In dmesg I can see 
>> something like
>> that:
> 
> 
> hrm, sounds like heat or power...
> 

He said he was using 2 out of 4 ports. Gotta be 3114. It *might* be 
R_ERR on DMA activate FIS.

-- 
tejun
