From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: implement ata_link, take 6
Date: Mon, 06 Aug 2007 15:12:06 +0900
Message-ID: <46B6BBB6.4020600@gmail.com>
References: <11862169601938-git-send-email-htejun@gmail.com> <1186232650.3439.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:7615 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbXHFGMM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 02:12:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1677003wah
        for <linux-ide@vger.kernel.org>; Sun, 05 Aug 2007 23:12:11 -0700 (PDT)
In-Reply-To: <1186232650.3439.1.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

James Bottomley wrote:
> On Sat, 2007-08-04 at 17:42 +0900, Tejun Heo wrote:
>> This is the sixth take of implement ata_link patchset.  This patchset
>> contains 14 patches which can be categorized as follows.
>>
>> #01-02: implement ata_link
>> #03-06: make libata deal with link instead of port
>> #07-09: misc link stuff (link init, reset_tries, ata_link_abort())
>> #10-14: add ap->pmp_link[] and update libata to deal with multiple
>> 	links
>>
>> ata_link abstracts PHY and sits between ata_port and ata_device.  The
>> following attributes are moved to ata_link from ata_port.
>>
>> - active command state (active_tag, sactive)
>> - [hw_]sata_spd_limit
>> - eh_info and eh_context
>> - device array
>>
>> With above and a few extra fields, a link can handle attached devices
>> including qc management and EH/hotplug.  This patchset makes libata
>> ready to handle PMP links.
>>
>> Changes from the last take[L] are.
>>
>> * adapted to the current upstream
>>
>> This patchset is against
>>
>>   libata-dev#upstream (80c51b13d8a73b9346ebe849cdeac6f539066fc2)
> 
> Sorry; there's another piece now: libsas:  drivers/scsi/libsas/sas_ata.c
> will need similar treatment to ipr.

Ah... right.  Sorry about that.  Will regenerate the patchset.

-- 
tejun
