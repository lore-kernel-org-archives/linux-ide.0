From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Sat, 13 May 2006 08:10:40 +0900
Message-ID: <446515F0.7070702@gmail.com>
References: <200605121534.k4CFYodu020885@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:38040 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751194AbWELXKr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 19:10:47 -0400
Received: by nz-out-0102.google.com with SMTP id r28so531046nza
        for <linux-ide@vger.kernel.org>; Fri, 12 May 2006 16:10:47 -0700 (PDT)
In-Reply-To: <200605121534.k4CFYodu020885@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
>> The following drivers support new features.
>>
>> ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
>> sata_sil:	new EH, irq-pio, hotplug
>> ahci:		new EH, irq-pio, NCQ, hotplug
>> sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier
> 
> If you were to add new EH and NCQ support to sata_promise,
> then I'd test it on my News server.
> 

I have a promise card and played with it a little bit but I don't have
access to hardware doc.  So...

-- 
tejun
