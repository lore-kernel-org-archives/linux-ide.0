From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-core when not ata_id_use_dmadir despite yes SiliconI
 mage
Date: Sat, 15 May 2004 12:15:37 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A64229.7000600@pobox.com>
References: <1084630807.5082.42.camel@patibmrh9> <200405151633.10473.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35741 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264664AbUEOQPv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 12:15:51 -0400
In-Reply-To: <200405151633.10473.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Pat LaVarre <p.lavarre@ieee.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 15 of May 2004 16:20, Pat LaVarre wrote:
> 
>>>>>Subject: Re: SATA ATAPI work in progress
>>>>>...
>>>>>I doubt I can use this patch as is.  I believe,
>>>>>because I assembled my drive from components myself,
>>>>>its op xA1 Identify data has not changed,
>>>>>so I will see a misleading 0 False at:
>>>>>
>>>>>#define ata_id_use_dmadir(dev) ((dev)->id[62] & (1 << 15))
>>>
>>>Theory confirmed!
>>
>>Consequently now:
>>
>>In t13.org since the dawn of time, I see the requirement that compliant
>>ATAPI devices tolerate hosts creatively choosing to copy
>>(cmd->sc_data_direction != SCSI_DATA_WRITE) into (ata_taskfile.feature &
>>x04 ATAPI_DMADIR).
>>
>>I see devices constructed with Silicon Image 3611CT80 1.4 require such a
>>courtesy from the host.
>>
>>Therefore I propose that Linux, as host, offer that courtesy always.
> 
> 
> Makes sense.
> 
> Jeff, if you decide to do this remember to kill ata_id_use_dmadir()
> and ATA_DFLAG_DMADIR completely.  [ I'm sure you will. :-) ]

According to ATA/ATAPI7,

	A device that does not support the DMADIR feature may abort a
	command if the DMADIR bit is set to 1.

And this language makes sense, since it is unknown what all those cheap 
old ATAPI devices will do.  It's too risky to simply set this bit for 
all ATAPI devices, without lots of testing.

We can do so for our development here, but a better solution based on 
released parts will need to be found...

	Jeff



