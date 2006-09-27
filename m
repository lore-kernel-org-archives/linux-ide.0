From: Tejun Heo <htejun@gmail.com>
Subject: Re: multiple irqs per card on the sata_sil24
Date: Wed, 27 Sep 2006 10:07:06 +0900
Message-ID: <4519CEBA.90307@gmail.com>
References: <KMS--2046545466-1840@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:11331 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932192AbWI0BHN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Sep 2006 21:07:13 -0400
Received: by nz-out-0102.google.com with SMTP id n1so5841nzf
        for <linux-ide@vger.kernel.org>; Tue, 26 Sep 2006 18:07:12 -0700 (PDT)
In-Reply-To: <KMS--2046545466-1840@mail.norwalkdist.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trent George <trent@norwalkdist.com>
Cc: linux-ide@vger.kernel.org

Trent George wrote:
> While reading the specs, I noticed that the pci-x cards support splitting each port to a unique irq pin.

3124 doesn't seem to support multiple MSI interrupts either.  Multiple 
Message Capable field is 000b.  Where does the spec say that it can 
split each port to a unique irq pin?

> If you have 6 cards with 4 ports, can you spread the load over 24 irqs ?
> I dont know if the motherboard can support this, or the driver could be modified to do this.
> It would be nice when there is a lot of of disk traffic on lots of drives.... adding port multiplier drives to each channel.
> I am trying to build a VERY large duplication system using LOTS of bandwidth. the irq can really put stress on the system.

Theoretically, yes, but linux currently cannot do multiple MSI 
interrupts and I don't think it's gonna be supported anytime soon. 
pci-e + multiple MSIX interrupts are supported but AFAIK 3132 supports that.

sil24 is pretty efficient and it only takes one more register access to 
determine which port has raised interrupt.  Also, if you have multiple 
busy ports w/ PMP attached, single interrupt is likely to serve multiple 
ports, so I don't think it's gonna matter performance-wise.

> the final system would be 100+ drives all going over 22mb/s.
> It should give a nice supermicro board with 3 buses a real workout.

Impressive.  Good luck and please keep us posted.

-- 
tejun
