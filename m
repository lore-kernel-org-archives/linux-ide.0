From: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 20:27:03 +0200
Message-ID: <429A0977.5040601@gmail.com>
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299EF16.2050208@pobox.com>	 <1117385429.4851.8.camel@localhost.localdomain>	 <4299F4E2.4020305@pobox.com>	 <1117387432.4851.13.camel@localhost.localdomain>	 <20050529172949.GA3578@havoc.gtf.org> <1117388703.4851.21.camel@localhost.localdomain> <429A036D.8090104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:14201 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261386AbVE2S1K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 May 2005 14:27:10 -0400
Received: by wproxy.gmail.com with SMTP id 68so1395308wri
        for <linux-ide@vger.kernel.org>; Sun, 29 May 2005 11:27:06 -0700 (PDT)
In-Reply-To: <429A036D.8090104@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Slagter <erik@slagter.name>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Jeff Garzik schrieb:

> Erik Slagter wrote:
>
>> I guess the only way to have, for example the ICH6, not using legacy
>> IRQ/ports, is to switch it to AHCI, which only the BIOS can do (if
>> implemented).
>
>
> "native mode" is where PATA and/or SATA PCI device is programmed into
> full PCI mode -- PCI BARs, PCI irq, etc.  Some BIOSen allow you to
> enable mode, which disables all use of legacy IRQ/ports.
>
> Also, ICH6 silicon does not support AHCI, only ICH6-R and ICH6-M.
>
>     Jeff
>
Hello Jeff,

AHCI also works when the so called option "RAID mode" on ICH6R/ICH7 is set.

One question in addition when will the patch of Jens in libata-2.6
tree?or is it already merged?


/Michael
