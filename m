From: Brian King <brking@us.ibm.com>
Subject: Re: [PATCHSET] libata: implement new initialization model w/ iomap
 support, take 2
Date: Wed, 30 Aug 2006 15:58:10 -0500
Message-ID: <44F5FBE2.3030201@us.ibm.com>
References: <11559778241753-git-send-email-htejun@gmail.com> <44EB80BB.5040309@us.ibm.com> <44F16FF8.7010706@gmail.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:23720 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751570AbWH3U6S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Aug 2006 16:58:18 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7UKwG9v005824
	for <linux-ide@vger.kernel.org>; Wed, 30 Aug 2006 16:58:16 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7UKwG8a175634
	for <linux-ide@vger.kernel.org>; Wed, 30 Aug 2006 16:58:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7UKwFhS011627
	for <linux-ide@vger.kernel.org>; Wed, 30 Aug 2006 16:58:16 -0400
In-Reply-To: <44F16FF8.7010706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Brian King wrote:
>> The idea of a static number of "ata ports" per ata host in SAS doesn't
>> really work. Since you can have ATA devices under a SAS expander, the
>> number of possible ATA devices that can be attached to a SAS adapter
>> can be rather large and can change depending on the SAS fabric. If libata
>> ever needed to iterate over the ata_port's for a SAS ata_host, then we would
>> probably need to convert the static array of ata_ports to a linked
>> list, allowing it to be more dynamic.
> 
> Making the array dynamically-sized isn't difficult at all; however, the 
> current libata code assumes that ata_host->ports[] array is packed - ie. 
> no intervening empty entry.  Can SAS keep this restriction or does it 
> need more flexibility?

This could be made to work with the addition of a new API. Rather than
having just ata_sas_port_destroy, we would need ata_sas_port_delete
and ata_sas_port_free. ata_sas_port_delete would remove the port from
the ata_host and do everything except free the ata port since there
could still be references to it. Then ata_sas_port_free would get called
once all the references were deleted.

>> Object lifetime rules also have me concerned. Currently, for SAS,
>> there are a couple objects that libata is concerned with. The first is
>> an ata_host_set, which I am allocating as part of the scsi_host struct,
>> so it inherits the object lifetime rules of that. The second is the
>> ata_port, which I allocate and free in target_alloc/target_destroy,
>> so I get refcounting for free there as well. Your patch set introduces
>> an ata_host struct, which is kmalloc'ed and doesn't inherit any of the
>> above refcounting. 
> 
> Actually, ata_host is ata_host_set.  It's just renamed recently.

Right. I saw that.

> cca3974e48607c3775dc73b544a5700b2e37c21a in libata-dev#upstream
> 
> Hmmm.... I was kind of hoping SAS could use ata_host_alloc() and store 
> its pointer and then later release it w/ ata_host_free(), hmmm.. maybe 
> you can call ata_host_free from ->slave_destroy?.  That gives libata 
> more control over the host structure (e.g. if we implement dynamic ports 
> array, it needs to be freed too).  Port lifetime rules aren't changed by 
> these updates and host free does need some changes but IMHO that 
> shouldn't be difficult.

The current design for SAS is to have a single ata_host per scsi host.
This means the ata_host is really tied to the object lifetime rules
of the scsi host. In the current SAS code, ata_host_set does not get allocated
as a separate piece of memory, but rather as part of the scsi_host
object. This means the memory for the ata_host doesn't get freed until
the last reference to the scsi host is released. Making ata_host
a separate allocation changes these rules and forces the caller to
know when to free the ata_host memory, which they currently do not know.

In order to do what you are proposing, I think we would need to add
some refcounting to the ata_host object. Each allocated ata_port would
get a reference to its parent ata_host and would put a reference when the
port is freed. Otherwise I am concerned that we would end up in the situation
where the ata_host is freed before all the ata ports and the scsi_host is
freed. It might be appropriate to create an ata_host class device and
an ata_port class device...


>>> sata_sil24.c is a pretty straight-forward example.  If you can't
>>> determine the number of ports when allocating host, please take a look
>>> at how ahci.c initializes its host.
>>>
>>> The intention was to allow SAS to use all the regular init/deinit
>>> functions just as other LLDs.  If something doesn't seem to be right,
>>> please let me know.
>> I think it can use bits of it, but I think the actual device discovery
>> process is better initiated by the SAS layer. The SAS layer knows what
>> devices are out there when it does discovery and can tell libata about
>> them.
> 
> Hmmm.... I see.  Something like ata_dev_attach(adev) after initialized 
> by SAS maybe?

Possibly. Are you proposing that ata_dev_attach would then end up calling
scsi_add_device after doing the ATA initialization stuff?


Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
