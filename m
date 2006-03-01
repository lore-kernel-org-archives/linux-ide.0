From: David Greaves <david@dgreaves.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 01 Mar 2006 17:41:03 +0000
Message-ID: <4405DCAF.6030500@dgreaves.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932477AbWCARkv@vger.kernel.org>
In-Reply-To: <44046D86.7050809@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:

> Mark Lord wrote:
>
>> David Greaves wrote:
>>
>>>
>>> scsi1 : sata_sil
>>>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>>>   Type:   Direct-Access                      ANSI SCSI revision: 05
>>>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>>>   Type:   Direct-Access                      ANSI SCSI revision: 05
>>
>>
>>
>> I wonder if the non-FUA component here is the sata_sil,
>> rather than the two Maxtor drives.
>>
>> Also, your drives have different firmware,
>> but both have trouble with FUA here.
>
>
> sata_sil is indeed a piece of hardware that needs to know the opcodes
> ahead of time...
>
>     Jeff
>
I actually have 3 of those drives - one runs through sata_via and
doesn't have the same problem.

(the sata_via ones *do* have :
 ata3: status=0x50 { DriveReady SeekComplete }
 ata3: PIO error
problems with SMART)

David
