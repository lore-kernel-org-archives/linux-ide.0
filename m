From: Tejun Heo <htejun@gmail.com>
Subject: Re: Another SATA device with spurious NCQ completions
Date: Wed, 04 Jul 2007 13:39:09 +0900
Message-ID: <468B246D.30506@gmail.com>
References: <46800AD3.7050803@redhat.com> <4689FDE6.2080806@gmail.com> <468A43E7.2030001@ans.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:63806 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbXGDEjP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 00:39:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1455203nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 21:39:14 -0700 (PDT)
In-Reply-To: <468A43E7.2030001@ans.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Krzysztof Oledzki wrote:
> On 2007-07-03 09:42, Tejun Heo wrote:
>> Chuck Ebbert wrote:
>>> From:
>>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=245512
>>>
>>>
>>> The following error consistently appears at apparently random
>>> intervals in syslog:
>>>
>>> kernel: ata1.00: exception Emask 0x2 SAct 0x1001 SErr 0x0 action 0x2
>>> frozen
>>> kernel: ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x1001
>>> FIS=004040a1:00000800)
>>> kernel: ata1.00: cmd 61/08:00:39:2b:cc/00:00:08:00:00/40 tag 0 cdb
>>> 0x0 data 4096 out
>>> kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2
>>> (HSM violation)
>>> kernel: ata1.00: cmd 61/08:60:e1:2b:cc/00:00:08:00:00/40 tag 12 cdb
>>> 0x0 data
>>> 4096 out
>>> kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2
>>> (HSM violation)
>>>
>>> Controller is ATI SB600 using the AHCI driver.
>>> 64-bit DMA is disabled.
>>> Disk is:
>>> ata1.00: ATA-7: ST3160812AS, 3.ADJ, max UDMA/133
>>>
>>>
>>> Can't we just turn off NCQ automatically when this happens?
>>
>> After sever such occasions, NCQ will be turned off automatically.
>> Hmm... It's a bit surprising to see this on a Seagate drive tho.  Can
>> someone crosscheck this by attaching the drive to an intel ahci?
>>
> 
> After upgradin kernel on one of my firewallas (2.6.14->2.6.20) I noticed
> similar problem with another Seagate: ST380817AS connected to ICH6.

Can you please give a shot at 2.6.22-rc7?  The log you posted lacks
information about why it's happening.

Thanks.

-- 
tejun
