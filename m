From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata
Date: Wed, 13 Oct 2004 15:58:50 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416D88FA.1050200@pobox.com>
References: <00bb01c4b10c$4b2ab330$7301a8c0@tw.ibm.com> <58cb370e04101312321c78f3b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40865 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269643AbUJMT7E
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Oct 2004 15:59:04 -0400
In-Reply-To: <58cb370e04101312321c78f3b8@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>


I'll use this message to respond to both Albert and you (Bart).

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 13 Oct 2004 18:06:19 +0800, Albert Lee <albertcc@tw.ibm.com> wrote:
> 
>>Hi, Jeff and Bart:
> 
> 
> Hi!
>  
> 
>>  I am trying to port the Promise pdc202xx_new driver to libata and adding
>>the
>>PLL tuning code to it. (The motivation is hotplug of the Promise host
>>adapter.)
> 
> 
> I have libata version of pdc202xx_new for a long time now
> but this one looks superior as it handles PLL. :-)
> 
> 
>>The ported driver has been tested with pdc20269 and pdc20275 on i386 and
>>x86_64 boxes, with 33 MHz PCI bus and 66 MHz PCI bus respectively.
>>It seems to be working fine with harddisk drives.

I got a report that sata_promise has problems in some >=66Mhz 
configurations, but works fine with 33Mhz configuration.  I bet I could 
learn a few things from this driver too, as the concepts probably apply 
to newer hardware.


>>(However, CD-ROM drives not working yet, even when
>>ATA_ENABLE_PATA and ATA_ENABLE_ATAPI are enabled.)
> 
> 
> Somehow this doesn't surprise me...

hehe :)


>>My question is, in the current kernel, the IDE subsystem drives PATA chips
>>and libata drives SATA chips. Will PATA driver like this be accepted into
>>libata?
> 
> 
> My opinion is: yes but not now, final answer is of course left to Jeff.

With the progress currently being made, I think my preference would be 
to start collecting PATA drivers such this in my libata-dev queue.

I would not send these PATA drivers upstream until the PATA to-do items 
are complete (see other email), but it would be nice to have a central 
location (both BK and patch on kernel.org) for developers and users to 
mess with PATA support.

So, send PATA drivers to me and I will merge... but please understand 
that I will not send upstream for quite some time.



>>Albert Lee
>>(The patch is against 2.6.8.1.)
> 
> 
> It seems your mail client screwed it.
> 
> I will try to comment on the patch anyway...

I agree with Bart's comments on the patch.  It was also mangled here.

Albert, if you would resend a patch with Bart's fixes, I'll merge into 
libata-dev.

My own comments:

>> obj-$(CONFIG_SCSI_ATA_PIIX) += libata.o ata_piix.o
>>> +obj-$(CONFIG_SCSI_PATA_PDC_NEW) += libata.o pata_pdc202xx_new.o
> 
> 
> why not jus pata_pdc_new? or pata_pdc_27x?

I would prefer to eliminate the "_new" suffix.  Other than that I don't 
really care.  If I had written the driver, I would have named it 
pata_pdc202xx I suppose.


> +} pdc_pata_controller_tbl [] = {
>> + { "Ultra100 TX2",        PDC_UDMA_100, PDC_100_MHZ }, /* pdc20268 */
>> + { "Ultra133 TX2",        PDC_UDMA_133, PDC_133_MHZ }, /* pdc20269 */
>> + { "FastTrak LP/TX2/TX4", PDC_UDMA_100, PDC_100_MHZ }, /* pdc20270 */
>> + { "FastTrak TX2000",     PDC_UDMA_133, PDC_133_MHZ }, /* pdc20271 */
>> + { "MBUltra133",          PDC_UDMA_133, PDC_133_MHZ }, /* pdc20275 */
>> + { "MBFastTrak 133 Lite", PDC_UDMA_133, PDC_133_MHZ }, /* pdc20276 */
>> + { "SBFastTrak 133 Lite", PDC_UDMA_133, PDC_133_MHZ }, /* pdc20277 */
>> +};

In general I prefer to eliminate _all_ "marketing strings" from all 
drivers.  Model names appear on the market far faster than any 
maintainer could hope to keep up.  (granted, this is old hardware and 
not changing, in this case)  So as a general rule, it is preferred to 
only use strings when absolutely necessary, eliminating them completely 
if at all possible.

> what exacty (besides PLL support) are the advantages
> of libata driver?

IDE controller hotplug is a lot easier, and proper locking is already 
there :)

	Jeff


