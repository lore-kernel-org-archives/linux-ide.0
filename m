From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata/sata status on ich[?]
Date: Tue, 04 Apr 2006 18:35:37 +0900
Message-ID: <44323DE9.7030106@gmail.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it> <44323C24.4010402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:7045 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932435AbWDDJfx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 05:35:53 -0400
Received: by pproxy.gmail.com with SMTP id f25so1606082pyf
        for <linux-ide@vger.kernel.org>; Tue, 04 Apr 2006 02:35:53 -0700 (PDT)
In-Reply-To: <44323C24.4010402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mauro Tassinari <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mauro Tassinari wrote:
>> Hi Jeff, All,
>>
>> our latest tests on previously reported ICH6 platforms show
>> 2.6.16.git not reporting any device on 4th master port.
>> The same behaviour was previously observed with 2.6.16-mm2,
>> regardless the hd brand and type.
> 
> Is this fixed in 2.6.17-rc1?
> 
> 
>> 2.6.16.1
>> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
>> ata2: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48
> 
>> 2.6.16-git16
>> ata_piix 0000:00:1f.2: MAP [ P0 P1 P2 P3 ]
>> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
>> ata2: SATA port has no device.
> 
> Thanks for that info.  Can you also provide 'lspci -vvv' (run as root)?
> 

Hello, all.

This should be fixed by the ata_piix map patch I've submitted and is 
currently in #upstream. [ P0 P1 P2 P3 ] should be [ P0 P2 P1 P3 ].

Thanks.

-- 
tejun
