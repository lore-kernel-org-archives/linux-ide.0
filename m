From: Steven Haigh <netwiz@crc.id.au>
Subject: Re: sata-sil drive detection issues.
Date: Fri, 18 Feb 2011 10:20:43 +1100
Message-ID: <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au>
References: <4D5C92F4.5000906@crc.id.au> <4D5CA2B1.8020905@crc.id.au>
 <20110217095815.GN19830@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vm.crc.id.au ([203.56.246.92]:55243 "EHLO
	mail.vm.crc.id.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab1BQXXV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 18:23:21 -0500
In-Reply-To: <20110217095815.GN19830@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

 On Thu, 17 Feb 2011 10:58:15 +0100, Tejun Heo wrote:
> Hello,
>
> On Thu, Feb 17, 2011 at 03:23:13PM +1100, Steven Haigh wrote:
>> I might have acted a bit prematurely on this. After booting off the
>> CentOS 5.5 installation DVD, I noticed that the esata drive at the
>> same problem. After lots of cable swapping and testing, I have found
>> that the esata cable may be faulty as a direct SATA -> drive
>> connection works perfectly.
>>
>> I am unsure however why my previous test of plugging the esata drive
>> directly to the onboard SATA controller worked - however now this
>> also fails.
>>
>> I shall attempt to try some different eSATA cables and report back
>> if I manage to isolate the issue directly to the sata_sil module.
>
> It's probably dependent on timing and not completely reliable.  It's
> rather complicated.  The AC_ERR_NODEV_HINT thing is there primarily
> for PATA controllers so that they don't spend time trying to probe
> empty ports.
>
> Does the following patch resolve the problem?
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d4e52e2..d08383f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1908,7 +1908,13 @@ retry:
>  		err_mask = ata_do_dev_read_id(dev, &tf, id);
>
>  	if (err_mask) {
> -		if (err_mask & AC_ERR_NODEV_HINT) {
> +		/*
> +		 * AC_ERR_NODEV_HINT is primarily used to detect empty PATA
> +		 * ports.  Some SATA devices incorrectly trigger it.
> +		 * Ignore if the physical link is positively online.
> +		 */
> +		if ((err_mask & AC_ERR_NODEV_HINT) &&
> +		    !ata_phys_link_online(ata_dev_phys_link(dev))) {
>  			ata_dev_printk(dev, KERN_DEBUG,
>  				       "NODEV after polling detection\n");
>  			return -ENOENT;

 With this patch applied, my rebuilt kernel based on 2.6.32.26 (due to 
 Xen Dom0 requirements) gives the following:

 ata9: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xe frozen
 ata9: SError: { PHYRdyChg CommWake }
 ata9: hard resetting link
 ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata9.00: failed to IDENTIFY (I/O error, err_mask=0x202)
 ata9: hard resetting link
 ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata9.00: failed to IDENTIFY (I/O error, err_mask=0x202)
 ata9: hard resetting link
 ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata9.00: failed to IDENTIFY (I/O error, err_mask=0x202)
 ata9: hard resetting link
 ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata9: EH complete

 I would really like to eliminate the possibility of it being my esata 
 enclosure or the sata -> esata cable by using another cable and/or array 
 for testing. New cables will be a few days off as I don't have any of 
 these cables hanging around. My gut feeling says its the cable - as the 
 enclosure works fine via the USB port - however that isn't conlusive 
 proof that the esata port is working as it should!

 --
 Steven Haigh
 
 Email: netwiz@crc.id.au
 Web: http://www.crc.id.au
 Phone: (03) 9001 6090 - 0412 935 897
 Fax: (03) 8338 0299
