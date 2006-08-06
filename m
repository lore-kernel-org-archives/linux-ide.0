From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/9] libata: implement per-dev xfermask
Date: Mon, 07 Aug 2006 01:08:58 +0900
Message-ID: <44D6141A.3080902@gmail.com>
References: <11547252932391-git-send-email-htejun@gmail.com>	 <1154785137.10971.20.camel@localhost.localdomain>	 <44D5FF90.7000602@gmail.com> <1154879804.22906.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:30031 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932602AbWHFQJF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 12:09:05 -0400
Received: by py-out-1112.google.com with SMTP id z74so1135589pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 09:09:05 -0700 (PDT)
In-Reply-To: <1154879804.22906.8.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, davej@redhat.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

Alan Cox wrote:
> Ar Sul, 2006-08-06 am 23:41 +0900, ysgrifennodd Tejun Heo:
>> I see.  I have a question though.  ATM, there are a few drives in the 
>> current #upstream which deal with PATA devices (ata_piix, pdc_adma and 
>> sata_promise).  Will they all act correctly without the above logic?  If 
>> so, I'll drop the above part and regenerate the tree.  If not, it can 
>> stay till those drivers are patched.
> 
> I went through them checking earlier. The majority of chipsets snoop the
> drive select bit and will generate appropriate cycles by device
> according to that bit.  Not everything does but I have been through and
> made sure the ones that don't correctly merge timings. At least I hope I
> have them all anyway.

I'm sure you've got them all correct in #pata-drivers :) but what I was 
worried about was whether the drivers in libata-dev#upstream are ready 
because, if not, those timing merge bits should be merged into #upstream 
first.  Hmmm... Diffing pata-drivers and upstream... Only ata_piix has 
set_piomode() update in #pata-drivers.  Can you please check whether 
ata_piix in #upstream will be safe?

Thanks.

-- 
tejun
