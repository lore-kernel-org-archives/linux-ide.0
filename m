From: Brian King <brking@us.ibm.com>
Subject: Re: [PATCHSET] libata: implement new initialization model w/ iomap
 support, take 2
Date: Tue, 22 Aug 2006 17:10:03 -0500
Message-ID: <44EB80BB.5040309@us.ibm.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:17584 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751279AbWHVWKH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2006 18:10:07 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7MMA6oR001740
	for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 18:10:06 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7MMA6ZT225456
	for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 18:10:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7MMA5tC029997
	for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 18:10:06 -0400
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Brian, can you please take a look at how LLDs use new init functions
> and see if SAS can use the same approach?  If you pass NULL as @sht to
> ata_host_alloc(), it won't associate ports as part of Scsi_Host just
> as ata_sas_port_alloc() does and ata_host_free() will do the right
> thing when freeing a host allocated that way.

I started looking through your patch set and have a few comments.

The idea of a static number of "ata ports" per ata host in SAS doesn't
really work. Since you can have ATA devices under a SAS expander, the
number of possible ATA devices that can be attached to a SAS adapter
can be rather large and can change depending on the SAS fabric. If libata
ever needed to iterate over the ata_port's for a SAS ata_host, then we would
probably need to convert the static array of ata_ports to a linked
list, allowing it to be more dynamic.

Object lifetime rules also have me concerned. Currently, for SAS,
there are a couple objects that libata is concerned with. The first is
an ata_host_set, which I am allocating as part of the scsi_host struct,
so it inherits the object lifetime rules of that. The second is the
ata_port, which I allocate and free in target_alloc/target_destroy,
so I get refcounting for free there as well. Your patch set introduces
an ata_host struct, which is kmalloc'ed and doesn't inherit any of the
above refcounting. 


> sata_sil24.c is a pretty straight-forward example.  If you can't
> determine the number of ports when allocating host, please take a look
> at how ahci.c initializes its host.
> 
> The intention was to allow SAS to use all the regular init/deinit
> functions just as other LLDs.  If something doesn't seem to be right,
> please let me know.

I think it can use bits of it, but I think the actual device discovery
process is better initiated by the SAS layer. The SAS layer knows what
devices are out there when it does discovery and can tell libata about
them.

I'm still looking through your patch set, but wanted to get a few comments
out...

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
