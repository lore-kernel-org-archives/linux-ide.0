From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] hotplug polling, take 5
Date: Wed, 01 Nov 2006 12:38:04 +0900
Message-ID: <4548169C.9070305@gmail.com>
References: <11609518461142-git-send-email-htejun@gmail.com> <45480158.2030501@pobox.com> <45480E45.1050802@gmail.com> <454812EB.2050907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:1381 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423867AbWKADiO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 22:38:14 -0500
Received: by nf-out-0910.google.com with SMTP id c2so597808nfe
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 19:38:13 -0800 (PST)
In-Reply-To: <454812EB.2050907@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> Link powersave patchset should handle that together but I'm still not 
>> sure what to do w/ user interface (which sysfs node to use).  Also, 
>> controllers which are used on laptops && use hp-poll by default are 
>> sata_nv (old ones) and some variant of sata_sil used in ati chipset. 
>> So, it shouldn't cause trouble for most laptop users.
> 
> I'm not saying it causes trouble.  Just saying that polling unused ports 
> is practically guaranteed to require more power than never doing so.

Yeap, no objection there.

> It shouldn't be hard to figure out where to poke stuff into sysfs...

I dunno.  It's policy decision and we don't have ATA sysfs nodes yet. 
So, where do we begin?  Is it time to start /sys/class/ata_host/ataX tree?

Thanks.

-- 
tejun
