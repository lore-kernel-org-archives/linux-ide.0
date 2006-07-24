From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: implement runtime link powersave
Date: Mon, 24 Jul 2006 16:33:26 +0900
Message-ID: <44C477C6.6070402@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com> <44BE8A25.9060804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:37659 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932098AbWGXJ4p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:45 -0400
Received: by py-out-1112.google.com with SMTP id t32so2506083pyc
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 02:56:11 -0700 (PDT)
In-Reply-To: <44BE8A25.9060804@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> This is the first take of powersave patchset.  It implements runtime
>> link-level power management.  To avoid confusion with regular
>> device/controller power management (suspend/resume), it's callsed
>> powersave.  It primarily implements partial/slumber/phy-off power
>> states SATA standard specifies but if LLD has different way of
>> implementing link powersave, it's allowed to.  Both host-initiated and
>> device-initiated operations are supported.
>>
>> This patchset contains the following patches.
>>
>> #01-07    : misc fixes/preps for powersave
>> #08-10    : implements core powersave infrastructure
>> #11-12    : implement powersave feature for ahci and sata_sil24
>>
>> Powersave can be configured at boot time or while running by writing
>> to kernel module parameter /sys/module/libata/parameters/powersave.
>> The following powersave modes are supported.
>>
>> * none        : no powersave, link is powered up all the time
>> * HIPS        : host-initiated powersave
>> * DIPS        : device-initiated powersave
>> * static    : no powersave on occupied link, power off empty link
>> * HIPS/static    : HIPS on occupied link, power off empty link
>> * DIPS/static    : DIPS on occupied link, power off empty link
>>
>> For more information, please read head messages of individual patches.
>>
>> All supported modes are tested on ICH7R AHCI, ICH6M AHCI, SiI3124,
>> SiI3132.  Unfortunately SiI3112/4 family controllers don't support
>> HIPS and choke on DIPS and thus dropped from supported list.
> 
> Any chance you tried ata_piix static PS, using PCS register?  :)

No, but I think both static and dynamic powersave can be implemented 
nicely on ICH8s as SCRs can be accessed on those controllers without 
mapping AHCI BAR.  Hmm.. yeah, STATIC powersave mode can be done with 
PCS although I'm pretty scared to mess with PCS at this point.  :(

-- 
tejun

