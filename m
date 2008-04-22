From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Tue, 22 Apr 2008 17:36:40 +0400
Message-ID: <480DE9E8.2070809@ru.mvista.com>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi> <480DE3C4.5@ru.mvista.com> <480DE6F5.8060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:29344 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756803AbYDVNhR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Apr 2008 09:37:17 -0400
In-Reply-To: <480DE6F5.8060403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:

>>    ADMA is not SFF-8038i compilant, it's the IDE DMA spec of its own. 
>> And I'm seeing references to libata-sff.c... confusing.

> In libata, SFF is used for controllers which have TF interface

    I can't figure out to which SFF specs this refers then... althought I'm 
not really familiar with them well enough.

> and BMDMA 
> is used for the BMDMA part of SFF-8038i.

    Is there any other part in it? One concerning PCI?

>  I think this is the source of confusion here.

    Yes.

>>    Looks like there's no clean separation within libata-sff.c itself 
>> between SFF-8038i (BMDMA spec) and IDE registers itself -- that 
>> confused me: at first I thought there's a big issue with a patch. :-/

>>    Jeff, Tejun, what "sff" in the file name actually means? Isn't it 
>> strange that the drivers lacking DMA support or not really compliant 
>> with SFF-8038i have to link with this file?

> Maybe it should be libata-tf and libata-bmdma, but sff (sans bmdma)
> and bmdma is acceptable, hopefully, right?

    What's sff sans bmdma?

> Thanks.

WBR, Sergei
