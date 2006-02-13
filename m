From: Aubin LaBrosse <aubin@stormboxes.com>
Subject: Re: [PATCH] Replace assert() with WARN_ON in drivers/scsi/libata-core.c
Date: Mon, 13 Feb 2006 18:56:46 -0500
Message-ID: <43F11CBE.10107@stormboxes.com>
References: <20060213233518.15196.57162.stgit@localhost.localdomain> <Pine.LNX.4.58.0602131543270.18300@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020209050401000909020106"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.stormboxes.com ([207.234.184.232]:46485 "EHLO
	dedicated.stormboxes.com") by vger.kernel.org with ESMTP
	id S1030313AbWBMX4t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Feb 2006 18:56:49 -0500
In-Reply-To: <Pine.LNX.4.58.0602131543270.18300@shark.he.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020209050401000909020106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:
> On Mon, 13 Feb 2006, Aubin LaBrosse wrote:
>
>   
>> Replace assert() with WARN_ON in drivers/scsi/libata-core.c
>>
>> This is my first patch to the kernel - this work was suggested by Jeff Garzik as a janitorial task for libata.  If I could get some feedback letting me know that this is the correct format and my tools are setup right, I'll do the rest of these.
>>
>> Signed-off-by: Aubin LaBrosse <aubin@stormboxes.com>
>>     
>
> Jeff wrote an email a couple of days ago that he already has
> several of these patches...
>
>   
>> @@ -1251,8 +1251,8 @@ static void ata_dev_identify(struct ata_
>>
>>  	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
>>
>> -	assert (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ATAPI ||
>> -		dev->class == ATA_DEV_NONE);
>> +	WARN_ON(dev->class != ATA_DEV_ATA &&&dev->class != ATA_DEV_ATAPI &&
>> +		dev->class != ATA_DEV_NONE);
>>     
>
> Does that one compile cleanly?
>
>   
>>  	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
>>
>>     
>
> Otherwise it looks pretty good to me.
>
>   
Oops.  I guess it wouldn't have compiled. :(  I was so fixated on 
getting the tools to work right I didn't even try.  thanks for the 
feedback, even if someone beat me to it. guess i'll go check out 
kernelnewbies for other janitorial type stuff to work on (and won't 
forget to compile and boot-test my patches, sorry!)


-aubin

--------------020209050401000909020106
Content-Type: text/x-vcard; charset=utf-8;
 name="aubin.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aubin.vcf"

begin:vcard
fn:Aubin LaBrosse
n:LaBrosse;Aubin
email;internet:aubin@stormboxes.com
tel;work:589-0692
tel;home:429-1520
tel;cell:493-0121
version:2.1
end:vcard


--------------020209050401000909020106--
