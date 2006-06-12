From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: kill ATA_FLAG_SRST
Date: Tue, 13 Jun 2006 00:09:52 +0900
Message-ID: <448D83C0.3090900@gmail.com>
References: <20060612144100.GB3892@htj.dyndns.org> <448D8152.1080902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:17542 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752023AbWFLPJ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:09:58 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1654362nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:09:58 -0700 (PDT)
In-Reply-To: <448D8152.1080902@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> As EDD support is removed, a LLD must implement either SRST or SATA
>> reset.  ATA_FLAG_SATA_RESET is enough to represent which one a LLD
>> implements.  Kill ATA_FLAG_SRST.
>>
>> Note that both flags are already marked obsolete.  ATA_FLAG_SATA_RESET
>> will be removed too once all LLDs are converted to new probing
>> mechanism.  This partial removal is to make room for a new flag needed
>> for new PM.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> NAK.  This will break too many drivers right now (e.g. even more in the 
> #pata-drivers branch).
> 
> My suggestion would be to create a patch that converts as many LLDDs as 
> you can to the new probing/EH.  Ripping through the bmdma+PHY style 
> controllers should be easy, for example.
> 
> Additionally, I would appreciate it if you would patch the #pata-drivers 
> branch (in a separate patch), if you make a change across all libata 
> LLDDs.  Otherwise the pata-drivers branch will _rapidly_ fall behind, 
> which is something that I don't want to happen.

Okay, will do that.  But, for now, I'll post PM patches above these two 
patches for review purpose.

> Finally, please update Documentation/DocBook/libata.tmpl, at least for 
> the ata_port_operations changes made by you.  I can work on updating the 
> EH and other sections myself, if you still dislike DocBook :)  But I 
> really want the libata driver API reference to stay current.  (Alan 
> grumbled at me about this, which I agree)

Agreed.  I still don't like DocBook :p but will update it.

As to when, I don't think I can get to it very soon.  A lot of things on 
todo list and doc update tends to get low priority.  Also, I want to 
update API doc after BMDMA separation as that will shake things quite a bit.

-- 
tejun
