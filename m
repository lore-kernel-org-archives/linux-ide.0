From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise TX4 + SiI 3726 : only one disk visible
Date: Tue, 16 May 2006 08:24:00 +0900
Message-ID: <44690D90.2030208@gmail.com>
References: <6EB652BF05BEE44FA2A29B23F3A71528045B3857@UBIMAIL1.ubisoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:17036 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750751AbWEOXYE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 19:24:04 -0400
Received: by nz-out-0102.google.com with SMTP id 18so228524nzp
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 16:24:03 -0700 (PDT)
In-Reply-To: <6EB652BF05BEE44FA2A29B23F3A71528045B3857@UBIMAIL1.ubisoft.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jerome Vuarand <jerome.vuarand@ubisoft.com>
Cc: linux-ide@vger.kernel.org, jerome.vuarand@gmail.com, Jeff Garzik <jgarzik@pobox.com>

Jerome Vuarand wrote:
> Hi,
>  
> Abstract : SiI3726 based port multiplier on Promise SATA300 TX4 don't 
> work on Slackware 10.2 with 2.6.16.16 kernel and libata-tj-stable 
> combined patch : only one disk accessible behind the port multiplier. 
> Don't bother reading the long mail if that is a known issue.

 From README...

The following drivers support new features.

ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
sata_sil:	new EH, irq-pio, hotplug
ahci:		new EH, irq-pio, NCQ, hotplug
sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier
^^^^^^^^^^^                                    ^^^^^^^^^^^^^^^

[--snip--]
> I don't know really what the problem is, and I don't know what else to 
> try. Your libata-tj README mention the SiI 4726 chipset, but there is no 
> such chipset on Silicon Image website, so I guessed you meant SiI 3726, 
> but I may be wrong on that point.

Yes, there is 4726.  I don't have 3726 yet but 4726 is probably 3726 + 
storage processor (so that it can do disk virtualization/RAID stuff). 
I'll add support for 3726 soon.

PMP support requires support from low-level drivers (sata_sil24, 
sata_promise,...) and sata_promise doesn't have it yet.  As noted above, 
the only supported card is SiI3124/32 and I'm working on AHCI.  As for 
sata_promise, I don't know.  I don't have the card nor the document, so 
it won't come out of me.  Jeff is planning to work on sata_promise and 
he might also do PM stuff, I guess.

-- 
tejun
