From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: understanding the cause of ATA failures
Date: Sun, 21 Mar 2010 21:37:14 -0600
Message-ID: <4BA6E5EA.2080108@gmail.com>
References: <4BA2A02F.7040200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33038 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab0CVDhU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2010 23:37:20 -0400
Received: by gwaa18 with SMTP id a18so786966gwa.19
        for <linux-ide@vger.kernel.org>; Sun, 21 Mar 2010 20:37:19 -0700 (PDT)
In-Reply-To: <4BA2A02F.7040200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Cc: linux-ide@vger.kernel.org

On 03/18/2010 03:50 PM, Ludovico Cavedon wrote:
> Hi,
>
> I am trying to understand what might have been the cause for the
> following two errors. The machine has 6 SATA drives, configured with
> software RAID6.
>
>
>> [513080.136611] ata5: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
>> [513080.136632] ata5: irq_stat 0x00400040, connection status changed
>> [513080.136648] ata5: SError: { HostInt PHYRdyChg 10B8B DevExch }
>> [513080.136666] ata5: hard resetting link
>> [513080.878347] ata5: SATA link down (SStatus 0 SControl 300)
>> [513085.869812] ata5: hard resetting link
>> [513086.219198] ata5: SATA link down (SStatus 0 SControl 300)
>> [513086.219206] ata5: limiting SATA link speed to 1.5 Gbps
>> [513091.210623] ata5: hard resetting link
>> [513091.560036] ata5: SATA link down (SStatus 0 SControl 310)
>> [513091.560044] ata5.00: disabled
>> [513091.560055] ata5: EH complete
>> [513091.560128] ata5.00: detaching (SCSI 4:0:0:0)
>> [513091.560492] sd 4:0:0:0: [sde] Stopping disk
>> [513091.560522] sd 4:0:0:0: [sde] START_STOP FAILED
>> [513091.560524] sd 4:0:0:0: [sde] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>> [513659.777152] ata5: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
>> [513659.777173] ata5: irq_stat 0x00000040, connection status changed
>> [513659.777189] ata5: SError: { CommWake DevExch }
>> [513659.777206] ata5: hard resetting link
>> [513665.555794] ata5: link is slow to respond, please be patient (ready=0)
>> [513669.808493] ata5: COMRESET failed (errno=-16)
>> [513669.808509] ata5: hard resetting link
>> [513672.593726] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [513674.832573] ata5.00: ATA-8: WDC WD20EADS-00S2B0, 01.00A01, max UDMA/133
>> [513674.832577] ata5.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> [513674.835549] ata5.00: configured for UDMA/133
>> [513674.835557] ata5: EH complete
>> [513674.835716] scsi 4:0:0:0: Direct-Access     ATA      WDC WD20EADS-00S 01.0 PQ: 0 ANSI: 5
>> [513674.835860] sd 4:0:0:0: Attached scsi generic sg4 type 0
>> [513674.836739] sd 4:0:0:0: [sde] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
>> [513674.836783] sd 4:0:0:0: [sde] Write Protect is off
>> [513674.836786] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
>> [513674.836807] sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [513674.836936]  sde: unknown partition table
>> [513674.849972] sd 4:0:0:0: [sde] Attached SCSI disk
>
> One month later
>
>> [2953663.906081] ata3.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
>> [2953663.906136] ata3.00: cmd 61/08:00:9d:87:e0/00:00:e8:00:00/40 tag 0 ncq 4096 out
>> [2953663.906137]          res 40/00:14:1d:69:81/00:00:77:00:00/40 Emask 0x4 (timeout)
>> [2953663.906226] ata3.00: status: { DRDY }
>> [2953663.906254] ata3: hard resetting link
>> [2953669.287889] ata3: link is slow to respond, please be patient (ready=0)
>> [2953673.900888] ata3: COMRESET failed (errno=-16)
>> [2953673.900917] ata3: hard resetting link
>> [2953679.282709] ata3: link is slow to respond, please be patient (ready=0)
>> [2953683.895706] ata3: COMRESET failed (errno=-16)
>> [2953683.895735] ata3: hard resetting link
>> [2953689.277538] ata3: link is slow to respond, please be patient (ready=0)
>> [2953718.872602] ata3: COMRESET failed (errno=-16)
>> [2953718.872632] ata3: limiting SATA link speed to 1.5 Gbps
>> [2953718.872635] ata3: hard resetting link
>> [2953723.894975] ata3: COMRESET failed (errno=-16)
>> [2953723.895005] ata3: reset failed, giving up
>> [2953723.895030] ata3.00: disabled
>> [2953723.895040] ata3: EH complete
>> [2953723.895053] sd 2:0:0:0: [sdc] Unhandled error code
>> [2953723.895056] sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>> [2953723.895060] end_request: I/O error, dev sdc, sector 3907028893
>
> I believe that the same error also happened for the other drives. The
> RAID6 failed because other drivers were removed as faulty. I have no
> logs though.

Well, this shows that the outstanding request timed out and it appeared 
the SATA link was down after that. Sounds rather like a hardware problem 
(cable, drive, backplane, etc.) It can't really tell much more specific 
than that.
