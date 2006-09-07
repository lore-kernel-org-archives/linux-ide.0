From: Brian King <brking@us.ibm.com>
Subject: Re: [PATCHSET] libata: implement new initialization model w/ iomap
 support, take 2
Date: Thu, 07 Sep 2006 08:22:58 -0500
Message-ID: <45001D32.3080109@us.ibm.com>
References: <11559778241753-git-send-email-htejun@gmail.com> <44EB80BB.5040309@us.ibm.com> <44F16FF8.7010706@gmail.com> <44F5FBE2.3030201@us.ibm.com> <44F83988.20102@gmail.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56711 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932084AbWIGNXB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Sep 2006 09:23:01 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87DN077009054
	for <linux-ide@vger.kernel.org>; Thu, 7 Sep 2006 09:23:00 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k87DN0mS136364
	for <linux-ide@vger.kernel.org>; Thu, 7 Sep 2006 09:23:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k87DMxTF025076
	for <linux-ide@vger.kernel.org>; Thu, 7 Sep 2006 09:23:00 -0400
In-Reply-To: <44F83988.20102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, uchang@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> You're right.  I was confused that ->slave_destroy() is called on host 
> release.  SCSI doesn't have host release callback.  What do you think 
> about adding a host release callback?  That should make things easier 
> and it is generally useful.

Sounds reasonable. 


>> In order to do what you are proposing, I think we would need to add
>> some refcounting to the ata_host object. Each allocated ata_port would
>> get a reference to its parent ata_host and would put a reference when the
>> port is freed. Otherwise I am concerned that we would end up in the situation
>> where the ata_host is freed before all the ata ports and the scsi_host is
>> freed. It might be appropriate to create an ata_host class device and
>> an ata_port class device...
> 
> Or we can just keep ata_host_init() and let sas allocate ata_host as 
> part of SCSI host and free all dynamic stuff when all ports are 
> detached.  It's a bit hacky but should work for the time being.

I think that's a fine approach for now.

> 
>>> Hmmm.... I see.  Something like ata_dev_attach(adev) after initialized 
>>> by SAS maybe?
>> Possibly. Are you proposing that ata_dev_attach would then end up calling
>> scsi_add_device after doing the ATA initialization stuff?
> 
> For SAS, libata isn't controlling SCSI host, so I think it's more 
> logical to leave SCSI devices to SAS too. 

I agree.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
