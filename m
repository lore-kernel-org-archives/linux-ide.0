From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 07/11] libata-eh-fw: implement freeze/thaw
Date: Tue, 16 May 2006 18:43:06 +0800
Message-ID: <4469ACBA.2000400@tw.ibm.com>
References: <11473504441058-git-send-email-htejun@gmail.com> <4469A63F.3040705@tw.ibm.com> <4469A9D3.5030006@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:47520 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751767AbWEPKnN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 06:43:13 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4GAh9Mk029045
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 06:43:09 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4GAh9r2255946
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:43:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4GAh8KV012380
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:43:09 -0600
In-Reply-To: <4469A9D3.5030006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Albert Lee wrote:
> 
>> With the new ata_drive_probe_reset(), my old Acer 787E drive still got
>> "irq nobody cared"
>> when probed. (dmesg attached. The problem only seen on this drive;
>> other CD-ROM drives works ok.)
>> The pata_pdc2027x driver has been converted to the ->probe_reset()
>> interface.
>> Is there anything else I should do for pata_pdc2027x driver to avoid
>> the "irq nobody cared"?
> 
> 
> You need to implement both ->probe_reset() and ->error_handler() &
> friends to avoid "irq nobody cared".  Note that hotplug merges probing
> into ->error_handler() and removes ->probe_reset().
> 
> The actual part which helps avoiding "irq nobody cared" during
> initialization is proper implementation of ->freeze() and ->thaw().  If
> the controller can detect spurious interrupts, freezing on spurious
> interrupts can help avoiding screaming interrupts, too.
> 

I will try adding ->freeze() etc.
Thanks for the advice,

Albert


