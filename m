From: Harsha Padmanabha <harsha@purplevisiontech.com>
Subject: Re: Sil 3512 and Seagate ST3802110AS
Date: Fri, 11 Aug 2006 21:58:09 +0530
Message-ID: <93F5C7A2-8122-405F-B4E6-5800B0B26793@purplevisiontech.com>
References: <455FCE13-2A0E-4BBE-8D1B-45C02C3C1C69@purplevisiontech.com> <44DCA97D.2070900@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms16.webminders.com ([64.37.88.34]:9988 "EHLO
	ms16.webminders.com") by vger.kernel.org with ESMTP id S932244AbWHKQbL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Aug 2006 12:31:11 -0400
In-Reply-To: <44DCA97D.2070900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

The only bus mastering device the resides on the PCI is the SIL card.  
I will try another bus mastering device and see if the host arbiter  
is enabled. Thanks for useful pointers.

On Aug 11, 2006, at 9:29 PM, Tejun Heo wrote:

> Harsha Padmanabha wrote:
>> I am trying to get sata_sil running on a MPC8349(PPC) board, I  
>> runto the following errors. I cannot upgrade my kernel to the  
>> latest one since most of my changes for MPC8349 to work  are for  
>> 2.6.11.
>> 1) How can i patch the latest release of libata for 2.6.11 without  
>> having to change to 2.6.17
>
> It's difficult.  You'll have to update not only libata but also  
> some SCSI midlayer stuff too.
>
>> 2) I have tried SIL 3112 card with the same results
>> 3) I have also tried different hard drives like samsung and WDC
>> Please let me know what i can do to get this running.
>> sda:<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08
>> ata_scsi_translate: ENTER
>> ata_scsi_rw_xlat: ten-byte command
>> ata_sg_setup: ENTER, ata2
>> ata_sg_setup: 1 sg elements mapped
>> ata_fill_sg: PRD[0] = (0x3748000, 0x1000)
>> ata_dev_select: ENTER, ata2: device 0, wait 1
>> ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
>> ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
>> ata_tf_load_mmio: device 0xE0
>> ata_exec_command_mmio: ata2: cmd 0x25
>> ata_scsi_translate: EXIT
>> ata_scsi_error: ENTER
>> ata_eng_timeout: ENTER
>> ata_qc_timeout: ENTER
>> ata2: command 0x25 timeout, stat 0x58 host_stat 0x2
>> ata_sg_clean: unmapping 1 sg elements
>> ata2: status=0x58 { DriveReady SeekComplete DataRequest }
>> SCSI error : <1 0 0 0> return code = 0x8000002
>> sda: Current: sense key: Aborted Command
>>     Additional sense: Scsi parity error
>> end_request: I/O error, dev sda, sector 0
>> Buffer I/O error on device sda, logical block 0
>> ata_qc_complete: EXIT
>> ata_qc_timeout: EXIT
>> ata_eng_timeout: EXIT
>> ata_scsi_error: EXIT
>
> Your first DMA command failed.  IIRC, there was one errata fix  
> which fixes a possible controller lock up problem on 3512 and 3114  
> but it only happens under relatively heavy IO and 3112 isn't  
> affected, so I don't think you're experiencing that.
>
> At the first glance, your hw seems to have a problem w/ PCI bus  
> mastering.  Does any other device live on the same bus - a NIC  
> maybe? If so, can it do DMA okay?
>
> -- 
> tejun
>

