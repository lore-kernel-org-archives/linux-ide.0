From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Tue, 20 Dec 2005 21:08:49 -0800
Message-ID: <43A8E361.5060503@physics.ucsd.edu>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com> <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu> <E1Eoq94-00009u-SS@highlab.com> <43A8BF6B.1090006@physics.ucsd.edu> <E1Eovpp-0000XC-S5@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl093-032-179.snd1.dsl.speakeasy.net ([66.93.32.179]:25805
	"EHLO partlyharmless.local") by vger.kernel.org with ESMTP
	id S1751084AbVLUFIx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 00:08:53 -0500
In-Reply-To: <E1Eovpp-0000XC-S5@highlab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: linux-ide@vger.kernel.org

In my case this is actually an onboard Marvell Sata controller. There is 
nothing in the two PCI-X slots at all. :(

I am going to ask Supermicro what the story is. Even the driver from 
Marvell that I have code for, of which I have found several versions, 
refuses to work correctly either on the Xeon system below or some new 
Opteron systems.

In any case I am happy to work with whoever is making the linux kernel 
driver for marvell to try to get to the bottom of the issue. I could 
even provide a login on a dedicated system if that would help.

Cheers,

Terrence



Sebastian Kuzminsky wrote:

>Terrence Martin <tmartin@physics.ucsd.edu> wrote:
>  
>
>>ata8: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
>>ata8: slow completion (cmd ef)
>>ata8: dev 0 configured for UDMA/133
>>    
>>
>...
>  
>
>>SCSI device sdc: drive cache: write back
>> sdc:<3>ata8: Entering mv_eng_timeout
>>mmio_base f8880000 ap f6b91314 qc f6b917f0 scsi_cmnd f6393e00 &cmnd f6393e44
>>ata8: status=0x50 { DriveReady SeekComplete }
>>ata8: error=0x01 { AddrMarkNotFound }
>>sdc: Current: sense key: No Sense
>>    Additional sense: No additional sense information
>> unknown partition table
>>    
>>
>
>I've seen this error on my system.  It went away and things work well now.
>I did two things at the same time and I'm not sure which one fixed things.
>
>My system has two PCI 32/33 slots and three PCI-X 64/66 slots.
>
>
>Non-working configuration:
>
>      PCI slot 1: Promise TX2 
>      PCI slot 2: Adaptec 2930 (5V card)
>    PCI-X slot 1: Promise TX2
>    PCI-X slot 2: Marvell 6081
>    PCI-X slot 3: empty
>
>
>Working configuration:
>
>      PCI slot 1: Promise TX2
>      PCI slot 2: Promise TX2
>    PCI-X slot 1: empty
>    PCI-X slot 2: empty
>    PCI-X slot 3: Marvell 6081
>
>
>Could be getting rid of the 5V Adaptec card, could be taking all the
>non-PCI-X cards out of the PCI-X slots.  Could be something else.
>I'm not sure.  Good luck!
>
>
>  
>

