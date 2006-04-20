From: =?ISO-8859-1?Q?Markus_M=FCller?= <mm@priv.de>
Subject: Re: sata_sil: write corruption on parallel access of two or more
 drives on same controller
Date: Thu, 20 Apr 2006 09:07:13 +0200
Message-ID: <44473321.5010705@priv.de>
References: <4446BE3C.7050902@priv.de> <20060420022527.GA3697@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.priv.de ([80.237.225.190]:31138 "EHLO mail.priv.de")
	by vger.kernel.org with ESMTP id S1750715AbWDTHHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Apr 2006 03:07:16 -0400
In-Reply-To: <20060420022527.GA3697@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun Heo,
> On Thu, Apr 20, 2006 at 12:48:28AM +0200, Markus M?ller wrote:
>   
>> Hi sil_sata.c-Developers,
>>
>> I've a problem accessing discs on my SIL 3114 controller: If I write
>> to it and if during this any other access (= read or write) to a disc
>> on same controller occures, there are write errors.
>>
>> The kernel doesn't realise this at all, there is no message about
>> that in dmesg or syslog.
>>
>>     
> [--snip--]
>   
>> This problem doesn't occure with this sil controllers and sata
>> hdds on a Neo2 Board with AMD64 from MSI so...
>>
>> -> Maybe the SIL-Driver isn't useable with the NForce2 Chipset?!
>>     
>
> This sounds like something is going wrong on the host bus.
>
>   
>> Please inculde me in answers as CC, cause I am currently
>> not on the kernel mailing list.
>>     
>
> I used to do the same but you don't have to ask for cc'ing.  It's the
> way things are done here.  People are not supposed to trim cc-list
> unless there are specific reasons.
>
> Can you try the following patch?  Be careful, I've only compile-tested
> it.
>
> [--snip--]
The problem does still occure same with the following patch installed. 
There are still no messages in dmesg.

What can I further do? Thanks for any help! I have no problem to install 
futher test patches, my data on raid are all safed, so it doesn't matter 
what happens at all on this system, as long as it don't work cause of 
this problem.

stacker:/usr/src# diff -u10 linux-2.6.16.9/drivers/scsi/libata-core.c 
linux-2.6.16.9.new/drivers/scsi/libata-core.c
--- linux-2.6.16.9/drivers/scsi/libata-core.c   2006-04-19 
08:10:14.000000000 +0200
+++ linux-2.6.16.9.new/drivers/scsi/libata-core.c       2002-01-22 
08:47:57.000000000 +0100
@@ -4051,20 +4051,27 @@
                host_stat = ap->ops->bmdma_status(ap);
                VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);

                /* if it's not our irq... */
                if (!(host_stat & ATA_DMA_INTR))
                        goto idle_irq;

                /* before we do anything else, clear DMA-Start bit */
                ap->ops->bmdma_stop(qc);

+                /* check host bus error */
+                if (host_stat & ATA_DMA_ERR) {
+                        printk(KERN_ERR "ata%u: BMDMA host bus error\n",
+                               ap->id);
+                       qc->err_mask |= AC_ERR_HOST_BUS;
+                }
+
                /* fall through */

        case ATA_PROT_ATAPI_NODATA:
        case ATA_PROT_NODATA:
                /* check altstatus */
                status = ata_altstatus(ap);
                if (status & ATA_BUSY)
                        goto idle_irq;

                /* check main status, clearing INTRQ */
stacker:/usr/src#

My test was:

stacker:/var/log# badblocks /dev/sda &
[1] 1249
stacker:/var/log# badblocks -n /dev/sdb
123
382
576
616
1217
1255
2645
3664

Interrupt caught, cleaning up
stacker:/var/log# dmesg|tail
ReiserFS: loop0: replayed 15 transactions in 0 seconds
ReiserFS: loop0: Using r5 hash to sort names
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
br0: port 1(eth0) entering learning state
br0: topology change detected, propagating
br0: port 1(eth0) entering forwarding state
stacker:/var/log#

gReeTings,
Markus Mueller
