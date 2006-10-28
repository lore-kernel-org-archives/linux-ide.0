From: "Carlos Vidal" <carlos@tarkus.se>
Subject: Re: Sil 3124 Pci Express?
Date: Sat, 28 Oct 2006 21:57:37 +0200
Message-ID: <9dccd9b80610281257w7eaf852s32720753dfb9ee3e@mail.gmail.com>
References: <f4527be0610281237x33c05f75j82879ba1c90b9e4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:15677 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751377AbWJ1T5j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Oct 2006 15:57:39 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1704237nfe
        for <linux-ide@vger.kernel.org>; Sat, 28 Oct 2006 12:57:38 -0700 (PDT)
In-Reply-To: <f4527be0610281237x33c05f75j82879ba1c90b9e4a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: linux-ide@vger.kernel.org

I'm using the Stardom SC-SATA-II-X PCI-X card with very good results.
It has 3+1 ports, 3 internal and one external.

I bought also a Stardom SOHOTANK, a SATA external box with 5 disks
slots and plugged 3 disks of 750GB each, in Linux RAID5, so I have 1.5
TB expandable to 3TB at a very low price.

I had to recompile the driver to add the multiport support, thanks to
Tejun's help in this list. The SOHOTANK is connected with a single
cable to the external SATA port. I've been testing it for a week now
and I'm quite satisfied.

I'm running this on a couple of HP DL385 servers, with dual opteron
285 dual core and 7GB RAM. The server are used for calculations, not
too much I/O. Calculations are normally done in the local disk, and
valuable results are copied to the external RAID. If one of the
computers is down, the RAID can be plugged to the other one.

Carlos

On 10/28/06, Andrew Lyon <andrew.lyon@gmail.com> wrote:
> Hi,
>
> Can anybody recommend a Pci Express Sil 3124 card?
> http://linux-ata.org/driver-status.html#sii3124 shows that this is the
> best supported chip, I am looking for a card with 4 or more ports, any
> suggestions?
>
> Thanks
> Andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
