From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: Problem with SiS Ide/Pata/Sata on 2.6.22-rc7-git4
Date: Tue, 10 Jul 2007 01:40:26 +0300
Message-ID: <4692B95A.2020400@mandriva.org>
References: <4692A7C3.9030802@mandriva.org> <20070709232742.004def28@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mbox1.netikka.net ([213.250.81.202]:55591 "EHLO
	mbox1.netikka.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbXGIWk3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 18:40:29 -0400
In-Reply-To: <20070709232742.004def28@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox skrev:
>> If you modprobe only sis5513
>>   OR
>> If you modprobe only sis5513 and then sata_sis/pata_sis:
>>   - you get this:
>>     (the hdb drive does not get detected/usable)
> 
> Don't mix old and new IDE like that. We allow both so you can use old SIS
> and new Jmicron etc for example but there are some cases where trying to
> load both old and new IDE support for the same chip will do strange
> things.
> 
> Alan
> 
> 

So this means that if you want to use pata & sata disks connected to sis 
chipset you cant use sis5513 at all, if I understand this correct?

If that's the case I guess we simply have to blacklist (or stop 
building) the sis5513 and force all sis ide users to pata_sis...

Now, do you consider pata_sis as stable as the sis5513 ?

--
Thomas
