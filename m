From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/14] libata-hp-prep: add prereset() method and	implement
 ata_std_prereset()
Date: Mon, 29 May 2006 11:14:11 +0900
Message-ID: <447A58F3.1090401@gmail.com>
References: <11480445853715-git-send-email-htejun@gmail.com>	 <446DE24E.4070501@pobox.com>  <44731FD4.6050008@gmail.com> <1148423372.25255.130.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:57791 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751090AbWE2COU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 May 2006 22:14:20 -0400
Received: by py-out-1112.google.com with SMTP id e30so249191pya
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 19:14:19 -0700 (PDT)
In-Reply-To: <1148423372.25255.130.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, mlord@pobox.com, albertcc@tw.ibm.com, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-05-23 at 07:44 -0700, Tejun Heo wrote:
>> Waiting for spinup is common operation for both PATA and SATA although I 
>> don't know how many PATA controllers support hotplug.
> 
> Most do, but few vendors ship the required extra buffers for many of the
> chips. Unfortunately it means we have to add code for lots of chips each
> with few hot/warmplug users 8(
> 
> 
>> ata_port_offline() applies to both PATA and SATA.  It's just that the 
>> current implmentation always returns 0 for PATA.  Well, I don't know. 
>> Maybe we should rename all those to sata_*() and rename them again when 
>> actual PATA support is implemented.
>>
> 
> What is ata_port_offline() intended to do ?
> 

ata_port_online(@ap) returns 1 if @ap knows that one or more devices are
attached to it; otherwise, 0

ata_port_offline(@ap) returns 1 if @ap knows that no device is attached
to it; otherwise, 0

With later ata_link addition, above functions are changed to
ata_link_on/offline(@link) respectively.

-- 
tejun
