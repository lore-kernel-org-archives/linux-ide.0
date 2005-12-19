From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/14] libata: implement new reset mechanism
Date: Mon, 19 Dec 2005 15:33:01 +0900
Message-ID: <43A6541D.3040302@gmail.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218133833.GC31571@htj.dyndns.org> <43A645B9.8050009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:13829 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965229AbVLSGdH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 01:33:07 -0500
Received: by zproxy.gmail.com with SMTP id 14so1848227nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 22:33:06 -0800 (PST)
In-Reply-To: <43A645B9.8050009@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> +int ata_reset(struct ata_port *ap, unsigned int flags, unsigned int 
>> *r_classes)
>> +{
>> +    const unsigned int unknown[2] = { ATA_DEV_UNKNOWN, 
>> ATA_DEV_UNKNOWN };
>> +    unsigned int classes[2];
>> +    int ret = 0;
>> +
>> +    DPRINTK("ENTER\n");
>> +
>> +    if (ap->ops->soft_reset == NULL)
>> +        flags &= ~ATA_RESET_SOFT;
>> +    if (ap->ops->hard_reset == NULL)
>> +        flags &= ~ATA_RESET_HARD;
>> +
>> +    if (!(flags & (ATA_RESET_SOFT | ATA_RESET_HARD))) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> + retry:
>> +    if (flags & ATA_RESET_SOFT) {
>> +        memcpy(classes, unknown, sizeof(classes));
>> +        ret = ap->ops->soft_reset(ap, classes);
>> +        if (ret == 0) {
>> +            if (!(flags & ATA_RESET_CLASSIFY) ||
>> +                classes[0] != ATA_DEV_UNKNOWN)
>> +                goto success;
>> +            /* no signature on SRST, try HRST */
>> +            flags &= ~ATA_RESET_SOFT;
>> +            ret = -ENODEV;    /* no sigature */
>> +        }
>> +        /* SRST failed, try HRST */
>> +    }
>> +
>> +    if (flags & ATA_RESET_HARD) {
>> +        memcpy(classes, unknown, sizeof(classes));
>> +        ret = ap->ops->hard_reset(ap, classes);
>> +        if (ret == 0) {
>> +            if (!(flags & ATA_RESET_CLASSIFY) ||
>> +                classes[0] != ATA_DEV_UNKNOWN)
>> +                goto success;
>> +            /* no signature on HRST, retry SRST */
>> +            flags &= ~ATA_RESET_HARD;
>> +            ret = -ENODEV;    /* no sigature */
>> +            goto retry;
>> +        }
>> +        /* HRST failed, give up */
>> +    }
>> +
>> +    goto out;
> 
> 
> Fundamental problem:  you should not hard code this execution order. 
> Each controller has a different way it likes to handle global and port 
> resets.  Sometimes COMRESET is automatically executed for you, when you 
> do a controller reset (AHCI does this).

Just to clear things up.  ata_reset() handles only port resets. 
->hard_reset would be COMRESET on most SATA controllers and ->soft_reset 
SRST.  Maybe it should be renamed to ata_port_reset().

Above code executes hardreset only if softreset fails.  I thought that 
ordering was pretty generic and hardcoded it.  Even for AHCI, it will 
try SRST and if SRST fails, COMRESET.  I think we can make ata_reset() 
more flexible when need arises.  No?

> Looking at the bigger picture of error handling, we will want to 
> basically run the entire probe sequence, after we reset.  I would look 
> into a few key areas:
> 
> * figuring out how to safely stop SCSI from submitting commands, while 
> you are doing the reset (important!).  SCSI errors are delivered to SATA 
> ports -- thus if you are doing a global reset in the EH path, only one 
> port's command submission is frozen, and the SCSI layer is happily 
> sending commands to the other ports.

Port resets don't need to freeze the whole host_set.  For host resets, I 
think we can achieve synchronization by....

* invoking EH's on all ports
* after all EH's are parked, perform host reset
* release EH's.
* each EH reconfigures devices

> 
> * get libata error handlers to start using scsi_eh_flush_done_q() and 
> scsi_eh_finish_cmd(), which enables retrying of commands.

Have patches for this and other EH stuff in my repository now.  Once 
this reset thing is settled, I'll follow up with those patches.

> 
> * making sure ata_bus_probe() can be called again and again
> 

Probing and EH are similar but not identical.  I think it's better to 
factor things out from ata_bus_probe() - this patchset factors resets, 
configuration can be factored later - and drive those things from 
ata_bus_probe() or recover method properly.

> * implementing srst and hard-reset as taskfile protocols, and supporting 
> them via qc_prep/qc_issue

As I wrote in the other reply, not a big fan of this idea.  :-(

Thanks.

-- 
tejun
