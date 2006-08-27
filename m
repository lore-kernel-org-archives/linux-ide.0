From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: implement new initialization model w/ iomap
 support, take 2
Date: Sun, 27 Aug 2006 19:12:08 +0900
Message-ID: <44F16FF8.7010706@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com> <44EB80BB.5040309@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:61247 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932088AbWH0KMP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Aug 2006 06:12:15 -0400
Received: by py-out-1112.google.com with SMTP id n25so2047588pyg
        for <linux-ide@vger.kernel.org>; Sun, 27 Aug 2006 03:12:15 -0700 (PDT)
In-Reply-To: <44EB80BB.5040309@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@us.ibm.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Hello,

Brian King wrote:
> Tejun Heo wrote:
>> Brian, can you please take a look at how LLDs use new init functions
>> and see if SAS can use the same approach?  If you pass NULL as @sht to
>> ata_host_alloc(), it won't associate ports as part of Scsi_Host just
>> as ata_sas_port_alloc() does and ata_host_free() will do the right
>> thing when freeing a host allocated that way.
> 
> I started looking through your patch set and have a few comments.
> 
> The idea of a static number of "ata ports" per ata host in SAS doesn't
> really work. Since you can have ATA devices under a SAS expander, the
> number of possible ATA devices that can be attached to a SAS adapter
> can be rather large and can change depending on the SAS fabric. If libata
> ever needed to iterate over the ata_port's for a SAS ata_host, then we would
> probably need to convert the static array of ata_ports to a linked
> list, allowing it to be more dynamic.

Making the array dynamically-sized isn't difficult at all; however, the 
current libata code assumes that ata_host->ports[] array is packed - ie. 
no intervening empty entry.  Can SAS keep this restriction or does it 
need more flexibility?

> Object lifetime rules also have me concerned. Currently, for SAS,
> there are a couple objects that libata is concerned with. The first is
> an ata_host_set, which I am allocating as part of the scsi_host struct,
> so it inherits the object lifetime rules of that. The second is the
> ata_port, which I allocate and free in target_alloc/target_destroy,
> so I get refcounting for free there as well. Your patch set introduces
> an ata_host struct, which is kmalloc'ed and doesn't inherit any of the
> above refcounting. 

Actually, ata_host is ata_host_set.  It's just renamed recently.

cca3974e48607c3775dc73b544a5700b2e37c21a in libata-dev#upstream

Hmmm.... I was kind of hoping SAS could use ata_host_alloc() and store 
its pointer and then later release it w/ ata_host_free(), hmmm.. maybe 
you can call ata_host_free from ->slave_destroy?.  That gives libata 
more control over the host structure (e.g. if we implement dynamic ports 
array, it needs to be freed too).  Port lifetime rules aren't changed by 
these updates and host free does need some changes but IMHO that 
shouldn't be difficult.

>> sata_sil24.c is a pretty straight-forward example.  If you can't
>> determine the number of ports when allocating host, please take a look
>> at how ahci.c initializes its host.
>>
>> The intention was to allow SAS to use all the regular init/deinit
>> functions just as other LLDs.  If something doesn't seem to be right,
>> please let me know.
> 
> I think it can use bits of it, but I think the actual device discovery
> process is better initiated by the SAS layer. The SAS layer knows what
> devices are out there when it does discovery and can tell libata about
> them.

Hmmm.... I see.  Something like ata_dev_attach(adev) after initialized 
by SAS maybe?

-- 
tejun
