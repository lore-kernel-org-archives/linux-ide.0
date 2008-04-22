From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Tue, 22 Apr 2008 22:24:05 +0900
Message-ID: <480DE6F5.8060403@gmail.com>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi> <480DE3C4.5@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:17558 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbYDVNYN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 09:24:13 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1206541wra.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2008 06:24:13 -0700 (PDT)
In-Reply-To: <480DE3C4.5@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

Sergei Shtylyov wrote:
>    ADMA is not SFF-8038i compilant, it's the IDE DMA spec of its own. 
> And I'm seeing references to libata-sff.c... confusing.

In libata, SFF is used for controllers which have TF interface and BMDMA 
is used for the BMDMA part of SFF-8038i.  I think this is the source of 
confusion here.

>    Looks like there's no clean separation within libata-sff.c itself 
> between SFF-8038i (BMDMA spec) and IDE registers itself -- that confused 
> me: at first I thought there's a big issue with a patch. :-/
> 
>    Jeff, Tejun, what "sff" in the file name actually means? Isn't it 
> strange that the drivers lacking DMA support or not really compliant 
> with SFF-8038i have to link with this file?

Maybe it should be libata-tf and libata-bmdma, but sff (sans bmdma) and 
bmdma is acceptable, hopefully, right?

Thanks.

-- 
tejun
