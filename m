From: Tejun Heo <htejun@gmail.com>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using ahci module
Date: Wed, 21 Jun 2006 00:37:32 +0900
Message-ID: <4498163C.90601@gmail.com>
References: <1149787827.4180.8.camel@anja> <1150745738.4302.1.camel@anja> <20060620023312.GA1250@htj.dyndns.org> <200606201721.26291.boac@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:47352 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751326AbWFTPhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 11:37:31 -0400
Received: by py-out-1112.google.com with SMTP id i49so1668240pye
        for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 08:37:30 -0700 (PDT)
In-Reply-To: <200606201721.26291.boac@wanadoo.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: boac@wanadoo.nl
Cc: linux-ide@vger.kernel.org, b.jacques@planet.nl

[CC'ing Bastiaan Jacques. Hi!]

Aalderd Bouwman wrote:
> Copy 5gig data and compare it 4 times with success :-)
> 
> Unmount and remove driver:
> Jun 20 17:06:30 ACPI: PCI interrupt for device 0000:00:0f.0 disabled
> 
> As you can see it works.
> Now I will check the hotplug functionality and if you have a patch for maybe 
> better NCQ usage I want to test him for you.

Do you happen to have a different drive which can do NCQ?  Preferably, 
one from another vendor?  AFAICS, the ahci driver is doing NCQ as the 
AHCI spec specifies and all ICH controllers seem to be quite happy with 
it.  I wanna know whether the problem is from the specific combination 
of the controller and the drive or the via controller needs a different 
programming sequence for NCQ in general.  Does the Windows driver do NCQ?

Bastiaan, do you know whether we need to do things differently to use 
NCQ on vt8251?

Thanks.

-- 
tejun
