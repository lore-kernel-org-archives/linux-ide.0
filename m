From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git-patch] hotplug fix patches added
Date: Sun, 11 Jun 2006 22:50:31 +0900
Message-ID: <448C1FA7.6030305@gmail.com>
References: <448B7FFD.9050507@gmail.com> <448C1C1E.7080109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:45114 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751299AbWFKNug (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jun 2006 09:50:36 -0400
Received: by nz-out-0102.google.com with SMTP id r28so1116838nza
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 06:50:36 -0700 (PDT)
In-Reply-To: <448C1C1E.7080109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello,
>>
>> Two hotplug fix patches have been added to libata-tj #for-jeff.
>>
>> * libata: add missing finish_wait() call in ata_port_wait_eh()
>> * libata: cosmetic change in struct ata_port
>>
>> The following two patches have been dropped as it hasn't been acked yet.
>>
>> * ata_piix: fix ghost device probing by honoring PCS present bits[1]
> 
> Seems vaguely OK to me...
> 
> 
>> * libata: add ata_port->private_flags[2]
> 
> What's the justification for this?  Running out of room in flags?

Yeap, ran out of bits while implementing power management.

> If we are going to do this, I would move any such flags to the 
> LLDD-allocated hpriv structure completely.  I wouldn't add hpriv_flags 
> to struct ata_port.

Several drivers only need flags.  IMHO, having to allocate hpriv just 
for flags is a bit annoying.  I also thought about separating capability 
flags and dynamic flags but couldn't think of proper field name. 
ap->dyn_flags?  Also, it would be easy to screw up and test the wrong 
field.  Another sucky option was using u64 for flags.

BTW, both patches are available in branch #for-jeff-pending.

-- 
tejun
