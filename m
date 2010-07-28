From: Dominic Curran <dominic.curran@citrix.com>
Subject: Re: Possible bug in ide_cd_queue_pc() or ide_wait_stat() ?
Date: Wed, 28 Jul 2010 16:23:13 +0100
Message-ID: <4C504B61.4050409@citrix.com>
References: <4C500A82.2040805@citrix.com> <20100728115107.GA1690@a1.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:18120 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab0G1PNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2010 11:13:14 -0400
In-Reply-To: <20100728115107.GA1690@a1.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



Borislav Petkov wrote:
>> I have some TEAC DV-28E-V CDROM drives that after polling for status
>> starts to timeout requests (the time it takes to do this varies
>> between 5mins and 24hrs).
>>     
>
> Which kernel is that? Can we see a complete dmesg? Which tool does the
> polling (udev... )?
>
>   
We have cooked our own usermode tool (we dont use udev).
Tool is very simple:
1) polls cdrom drive using ioctl CDROM_DRIVE_STATUS
2) Looks for a CDS_DISC_OK return
3) Once it sees that it tries to mount CD

The problem is that for this specific drive it starts timing out STATUS 
requests, and then returns CDS_DISC_OK.
This cause the tools to try to mount (non existent disc), which then 
eats 100% cpu time.

So even if the drive goes bad, I'd like to get back a error status from 
the ioctl rather than CDS_DISC_OK.

Kernel is 2.6.27.  Based on CentOS I believe.
>> The problem is that even when the requests timeout the ioctl
>> CDROM_DRIVE_STATUS will receive a status of CDS_DISC_OK.
>>     
>
> Can you add some more instrumentation code to ide_cdrom_drive_status()
> to see which "return CDS_DISC_OK" is being hit since there are a couple
> of them in that function.
>
>   
In ide_cdrom_drive_status() the return happens in the following if:

    stat = cdrom_check_status(drive, &sense);
printk("ide_cdrom_drive_status(stat=%i sense_key=%u)\n",stat, 
sense.sense_key);
    if (!stat || sense.sense_key == UNIT_ATTENTION) {
        printk("ide_cdrom_drive_status(#1) ret=CDS_DICS_OK)\n");
        return CDS_DISC_OK;
    }



As for dmesg, it is filled with my own instrumentation:
This is a ioctl that worked correctly....

Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ======= cdrom_ioctl() =======
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom: entering 
CDROM_DRIVE_STATUS
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_cdrom_drive_status()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ENTER: cdrom_check_status()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=0,cf=0x00000000)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x00082000 retries=10
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBDE00 
rq->errors=0 err=0)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x00086640
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() Other. 
retries=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() retries=-1
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=-5)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: EXIT: 
cdrom_check_status(ret=-5)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_cdrom_drive_status(stat=-5 sense_key=2)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=700,cf=0x00008000)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x0008A000 retries=10
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=0008A640)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=0008A640)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBDE00 
rq->errors=0 err=0)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x0008A640
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=0)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom: 
cdrom_ioctl_drive_status (ret=1)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom: entering cdrom_release
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom: Use count for 
"/dev/hda" now zero
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom: hda: No DVD+RW
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom: Unlocking door!
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=0,cf=0x00000000)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x00082000 retries=10
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBDE00 
rq->errors=0 err=0)
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x00082640
Jul 27 16:48:37 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=0)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom: entering cdrom_open
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom: Use count for 
"/dev/hda" now 1
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ENTER: cdrom_check_status()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=0,cf=0x00000000)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x00082000 retries=10
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBDE00 
rq->errors=0 err=0)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x00086640
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() Other. 
retries=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() retries=-1
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=-5)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: EXIT: 
cdrom_check_status(ret=-5)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ENTER: cdrom_check_status()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=0,cf=0x00000000)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x00082000 retries=10
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBDE00 
rq->errors=0 err=0)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x00086640
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() Other. 
retries=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() retries=-1
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=-5)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: EXIT: 
cdrom_check_status(ret=-5)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=0,cf=0x00008000)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x0008A000 retries=10
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=0008A640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=0008A640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBDE00 
rq->errors=0 err=0)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x0008E640
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() Other. 
retries=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() retries=-1
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=-5)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=0,cf=0x00008000)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x0008A000 retries=10
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=0008A640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=0008A640)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: cdrom_transfer_packet_command()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00010440)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: 
cdrom_transfer_packet_command(#2)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBDE00 
rq->errors=0 err=0)
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x0008E640
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() Other. 
retries=0
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc() retries=-1
Jul 27 16:48:39 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=-5)


Note the line early on that reads...

EXIT: cdrom_check_status(ret=-5)
ide_cdrom_drive_status(stat=-5 sense_key=2)


A sense_key=2 means NOT_READY. Thats good.

Here is the spew when requests have started to timeout...

Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ======= cdrom_ioctl() =======
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: cdrom: entering 
CDROM_DRIVE_STATUS
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ide_cdrom_drive_status()
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ENTER: cdrom_check_status()
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: 
ide_cd_queue_pc(timeout=0,cf=0x00000000)
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: About to call 
blk_execute_rq() rq->cmd_flags=0x00082000 retries=10
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ide_wait_stat()
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: 
ide_wait_stat(rq->cmd_flags=00082640)
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ide_error(stat=0xD0)
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: hda: status timeout: 
status=0xd0 { Busy }
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ide: failed opcode was: unknown
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ide_error(#2)[rq=EDEBD380 
errors=0 cmd_flags=00082640]
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: ide_wait_stat() ret=-16
Jul 27 16:51:27 xsdubianh-srdeaor131 kernel: hda: drive not ready for 
command
Jul 27 16:51:32 xsdubianh-srdeaor131 kernel: blk_execute_rq(rq=EDEBD380 
rq->errors=0 err=0)
Jul 27 16:51:32 xsdubianh-srdeaor131 kernel: blk_execute_rq() error=0 
rq->cmd_flags=0x00082640
Jul 27 16:51:32 xsdubianh-srdeaor131 kernel: ide_cd_queue_pc(ret=0)
Jul 27 16:51:32 xsdubianh-srdeaor131 kernel: EXIT: cdrom_check_status(ret=0)
Jul 27 16:51:32 xsdubianh-srdeaor131 kernel: 
ide_cdrom_drive_status(stat=0 sense_key=0)
Jul 27 16:51:32 xsdubianh-srdeaor131 kernel: ide_cdrom_drive_status(#1) 
ret=CDS_DICS_OK)
Jul 27 16:51:32 xsdubianh-srdeaor131 kernel: cdrom: 
cdrom_ioctl_drive_status (ret=4)

Note that CDS_DISC_OK is being returned.
Of course this is my own instrumentation so I doubt it will mean that 
much to you.


