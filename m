From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/14] libata-hp-prep: add prereset() method and implement
 ata_std_prereset()
Date: Tue, 23 May 2006 07:44:36 -0700
Message-ID: <44731FD4.6050008@gmail.com>
References: <11480445853715-git-send-email-htejun@gmail.com> <446DE24E.4070501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:56034 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932188AbWEWVzR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 17:55:17 -0400
Received: by nz-out-0102.google.com with SMTP id 8so1673597nzo
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 14:55:17 -0700 (PDT)
In-Reply-To: <446DE24E.4070501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> +static void ata_wait_spinup(struct ata_port *ap)
>> +{
>> +    struct ata_eh_context *ehc = &ap->eh_context;
>> +    unsigned long end, secs;
>> +    int rc;
>> +
>> +    /* first, debounce */
>> +    rc = sata_phy_debounce(ap, sata_deb_timing_eh);
> 
> unconditionally calls a sata_xxx function, and so "sata_wait_spinup" 
> naming is preferred.

Waiting for spinup is common operation for both PATA and SATA although I 
don't know how many PATA controllers support hotplug.  The following 
code pattern is used a lot to avoid explicit support testing in the 
caller.  ie. The function which uses optional controller feature is 
responsible for testing whether it is implemented by the controller.

rc = sata_xxx(args);
if (rc && rc != -EOPNOTSUPP) {
	/* handle error */
}

Also, if we rename this function to sata_wait_spinup() because it calls 
sata_*() unconditionally then ata_std_prereset() should be renamed to 
sata_std_prereset() as it calls sata_wait_spinup() unconditionally.

>> +    /* if debounced successfully and offline, no need to wait */
>> +    if (rc == 0 && ata_port_offline(ap))
>> +        return;
> 
> ISTR ata_port_offline being SATA-specific too, but anyway...  :)

ata_port_offline() applies to both PATA and SATA.  It's just that the 
current implmentation always returns 0 for PATA.  Well, I don't know. 
Maybe we should rename all those to sata_*() and rename them again when 
actual PATA support is implemented.

>> +    /* okay, let's give the drive time to spin up */
>> +    end = ehc->i.hotplug_timestamp + ATA_SPINUP_WAIT * HZ / 1000;
>> +    secs = ((end - jiffies) + HZ - 1) / HZ;
>> +
>> +    if (time_after(jiffies, end))
>> +        return;
>> +
>> +    if (secs > 5)
>> +        ata_port_printk(ap, KERN_INFO, "waiting for device to spin up "
>> +                "(%lu secs)\n", secs);
>> +
>> +    schedule_timeout_uninterruptible(end - jiffies);
> 
> BTW:  Medium-term, re-read Hale Landis's ATADRVR probe code 
> (http://www.ata-atapi.com/) to make sure the PATA probe path is still 
> intact.

Will do.

-- 
tejun

