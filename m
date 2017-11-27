From: Mark Hounschell <markh@compro.net>
Subject: Re: AM4 B350 chipset Sata/IDE problem
Date: Mon, 27 Nov 2017 15:50:28 -0500
Message-ID: <0c91363b-4c74-d21d-eadd-94bb8908df60@compro.net>
References: <20171123064050.37A674E0025@mta-1.openmailbox.og>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp89.ord1c.emailsrvr.com ([108.166.43.89]:54829 "EHLO
        smtp89.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752708AbdK0U4m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2017 15:56:42 -0500
In-Reply-To: <20171123064050.37A674E0025@mta-1.openmailbox.og>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sonofagun@openmailbox.org, linux-ide@vger.kernel.org

On 11/23/2017 01:40 AM, sonofagun@openmailbox.org wrote:
> 
> Hello again, I wonder why my previous mail was wrapped like that. Leafpad and me are to blame!
> 
> 
>> libata.force=noncq option seems to prevent the messages from occurring. 5 kernel builds (j16) with none.
> I knew it, I was sure!
> 
>> [    2.314441] ata2.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
> I suppose that your third ST3160815AS with 4.AAB firmware has no issue, correct?

The one with 4.AAB firmware has issues also:
Nov 27 08:54:32 harley kernel: ata2.00: exception Emask 0x11 SAct 0x7ffbffff SErr 0x400000 action 0x6 frozen
Nov 27 08:54:32 harley kernel: ata2.00: irq_stat 0x48000008, interface fatal error
Nov 27 08:54:32 harley kernel: ata2: SError: { Handshk }
Nov 27 08:54:32 harley kernel: ata2.00: failed command: WRITE FPDMA QUEUED
Nov 27 08:54:32 harley kernel: ata2.00: cmd 61/00:00:08:3b:a6/08:00:0c:00:00/40 tag 0 ncq dma 1048576 ou\x0a         res 40/00:e0:98:30:90/00:00:0b:00:00/40 Emask 0x10 (ATA bus error)
Nov 27 08:54:32 harley kernel: ata2.00: status: { DRDY }
Nov 27 08:54:32 harley kernel: ata2.00: failed command: WRITE FPDMA QUEUED
.
.
.
Nov 27 08:54:32 harley kernel: ata2.00: status: { DRDY }
Nov 27 08:54:32 harley kernel: ata2: hard resetting link
Nov 27 08:54:32 harley kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 27 08:54:33 harley kernel: ata2.00: configured for UDMA/133
Nov 27 08:54:33 harley kernel: ata2: EH complete

>> [    2.933706] ata5.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
> I suppose that your second ST3160815AS with 3.AAE firmware has no issue, correct?
> 

This one (3.AAE) has started acting up, in a totally different way though. So I can't at
this time say one way or the other.

> They were produced in different years but all of them have no firmware update!
> If you see the datecode on its sticker, the 3.AAD datecode must start from 07 or 08 while the 3.AAE datecode must start from 08 or 09 while the 4.AAB must start from 08, 09 or even 10.
> You must contact seagate and inform them that the older one is incompatible with B350 when NCQ enabled. I bet they already know it but you can try.
> 
>> [    1.721248] ata9.00: ATA-6: ST3500320NS, SN04, max UDMA/133
> I assume that your Barracuda ES.2 has caused no trouble, right?
> 
That one is not connected to the B350 MB Sata ports. There are only 4 ports. The 3 160GB disks and one DVD are connected to the B350 MB. My other 4 disks are connected to a pci-e (x1) Sata card. I can connect
the 160GB disks to that Sata card and I have no problems. Only when connected to the B350 
chipset do issues arise.

On B350:
[    1.680027] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)    ata1.00:  ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.336040] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)    ata2.00:  ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[    2.976043] ata5: SATA link up 1.5 Gbps (SStatus 123 SControl 300)    ata5.00:  ATA-7: ST3160811AS, 3.AAE, max UDMA/133
[    3.608030] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)    ata6.00:  ATAPI: SONY    DVD RW AD-7260S, 1.61, max UDMA/100

On pci-e Sata card:
[    1.731482] ata9:  SATA link up 3.0 Gbps (SStatus 123 SControl 300)   ata9.00:  ATA-6: ST3500320NS, SN04, max UDMA/133
[    1.707825] ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)   ata10.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max UDMA/133
[    1.696032] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)   ata11.00: ATA-8: ST3500320NS, SN06, max UDMA/133
[    1.719646] ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 300)   ata12.00: ATA-8: ST3500418AS, CC38, max UDMA/133

At one point I had the SSD (ata10.00: ATA-9) connected to the B350 and did a Linux install to it. I had issues with it also. I still have the messages from that too. But these occurred only once.
Then never again until a reboot and another kernel build started. With the other drives, the messages come
as long as I'm building a kernel.

   36.040607] ata2.00: exception Emask 0x11 SAct 0x1c00 SErr 0x680100 action 0x6 frozen
[   36.047214] ata2.00: irq_stat 0x48000008, interface fatal error
[   36.053772] ata2: SError: { UnrecovData 10B8B BadCRC Handshk }
[   36.060263] ata2.00: failed command: READ FPDMA QUEUED
[   36.060265] ata2.00: cmd 60/00:50:a7:07:a9/01:00:02:00:00/40 tag 10 ncq dma 131072 in
                        res 40/00:60:a7:08:a9/00:00:02:00:00/40 Emask 0x10 (ATA bus error)
[   36.060266] ata2.00: status: { DRDY }
[   36.060267] ata2.00: failed command: READ FPDMA QUEUED
[   36.060269] ata2.00: cmd 60/00:58:4f:d8:a8/01:00:02:00:00/40 tag 11 ncq dma 131072 in
                        res 40/00:60:a7:08:a9/00:00:02:00:00/40 Emask 0x10 (ATA bus error)
[   36.060269] ata2.00: status: { DRDY }
[   36.060270] ata2.00: failed command: READ FPDMA QUEUED
[   36.060272] ata2.00: cmd 60/00:60:a7:08:a9/01:00:02:00:00/40 tag 12 ncq dma 131072 in
                        res 40/00:60:a7:08:a9/00:00:02:00:00/40 Emask 0x10 (ATA bus error)
[   36.060274] ata2.00: status: { DRDY }
[   36.060277] ata2: hard resetting link
[   36.529587] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   36.537694] ata2.00: supports DRM functions and may not be fully accessible
[   36.544905] ata2.00: disabling queued TRIM support
[   36.545526] ata2.00: supports DRM functions and may not be fully accessible
[   36.552601] ata2.00: disabling queued TRIM support
[   36.552973] ata2.00: configured for UDMA/133
[   36.559496] ata2: EH complete[   36.040607] ata2.00: exception Emask 0x11 SAct 0x1c00 SErr 0x680100 action 0x6 frozen
[   36.047214] ata2.00: irq_stat 0x48000008, interface fatal error
[   36.053772] ata2: SError: { UnrecovData 10B8B BadCRC Handshk }
[   36.060263] ata2.00: failed command: READ FPDMA QUEUED
[   36.060265] ata2.00: cmd 60/00:50:a7:07:a9/01:00:02:00:00/40 tag 10 ncq dma 131072 in
                        res 40/00:60:a7:08:a9/00:00:02:00:00/40 Emask 0x10 (ATA bus error)
[   36.060266] ata2.00: status: { DRDY }
[   36.060267] ata2.00: failed command: READ FPDMA QUEUED
[   36.060269] ata2.00: cmd 60/00:58:4f:d8:a8/01:00:02:00:00/40 tag 11 ncq dma 131072 in
                        res 40/00:60:a7:08:a9/00:00:02:00:00/40 Emask 0x10 (ATA bus error)
[   36.060269] ata2.00: status: { DRDY }
[   36.060270] ata2.00: failed command: READ FPDMA QUEUED
[   36.060272] ata2.00: cmd 60/00:60:a7:08:a9/01:00:02:00:00/40 tag 12 ncq dma 131072 in
                        res 40/00:60:a7:08:a9/00:00:02:00:00/40 Emask 0x10 (ATA bus error)
[   36.060274] ata2.00: status: { DRDY }
[   36.060277] ata2: hard resetting link
[   36.529587] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   36.537694] ata2.00: supports DRM functions and may not be fully accessible
[   36.544905] ata2.00: disabling queued TRIM support
[   36.545526] ata2.00: supports DRM functions and may not be fully accessible
[   36.552601] ata2.00: disabling queued TRIM support
[   36.552973] ata2.00: configured for UDMA/133
[   36.559496] ata2: EH complete

After the above, no more messages appear.

> Maybe all 7200.10 with 3.* must have NCQ disabled on AMD SATA controllers. It can be done but that would only do the trick for some affected disks not for all.
> OEMs like HP have different firmware with different versions. A blacklist for 3.* would not detect an HP ST3160815AS with HPF0 firmware.
> The same applies to DELL disks and so on...
> 
> 
>> [    1.680035] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    2.248065] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    2.872065] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Clearly you are stuck with SATA I speeds. This can be done using two or three ways. I will not say a thing on that.
> My brother read the information you uploaded and reminded me that those disks have a small jumper which can limit the maximum SATA interface speed.
> That was needed to make them work on VT8237 series chipsets.
> I suppose you have used that jumper configuration on all three disks but forgot it since you must have done it around 8 or more years ago...
> 

Actually when these 3 disks were on my AM3 Sata-2 MB that jumper was removed. I recently installed
it on the 3 connected to the B350 to see if it would help. It didn't seem to make any difference. If I remember correctly the drives did come with the jumper installed and I removed them somewhere
along the line. The jumpers are in now though.

> 
>>   5 Reallocated_Sector_Ct   PO--CK   100   100   036    -    0
>>  10 Spin_Retry_Count        PO--C-   100   100   097    -    0
>> 187 Reported_Uncorrect      -O--CK   100   100   000    -    0
>> 189 High_Fly_Writes         -O-RCK   100   100   000    -    0
>> 198 Offline_Uncorrectable   ----C-   100   100   000    -    0
> Your disk is in great condition despite its 75675 hours.
> As I said before: "Those disks are very reliable".
> 
> I would suggest running all self tests(with NCQ disabled) as the last one occured at 9725 hours. That was 65950 hours ago. It is a very long time.
> I have not seen any disk reaching 50000 operating hours!
> 
> 
> Can you please measure the speed of all three disks on the Ryzen board with AHCI with queue depth 31, 2 and 1?
> 

This is done without NCQ disabled?

#echo 31 > /sys/block/sda/device/queue_depth
#hdparm -tT /dev/sda
/dev/sda:
 Timing cached reads:   16758 MB in  2.00 seconds = 8386.77 MB/sec                                                                                                                                    Timing buffered disk reads: 220 MB in  3.01 seconds =  73.05 MB/sec

#echo 2 > /sys/block/sda/device/queue_depth
# hdparm -tT /dev/sda                                                                                                                                                             
/dev/sda:                                                                                                                                                                                             
Timing cached reads:   16604 MB in  2.00 seconds = 8309.90 MB/sec                                                                                                                                    Timing buffered disk reads: 220 MB in  3.01 seconds =  73.03 MB/sec

# echo 1 > /sys/block/sda/device/queue_depth                                                                                                                                     
# hdparm -tT /dev/sda                                                                                                                                      
/dev/sda:                                                                                                                                                                                             
Timing cached reads:   17000 MB in  2.00 seconds = 8508.61 MB/sec                                                                                                                                    Timing buffered disk reads: 220 MB in  3.01 seconds =  73.12 MB/sec


# echo 31 > /sys/block/sdb/device/queue_depth                                                                                                                                    # hdparm -tT /dev/sdb
/dev/sdb:                                                                                                                                                                                             
Timing cached reads:   17010 MB in  2.00 seconds = 8512.90 MB/sec                                                                                                                                    Timing buffered disk reads: 224 MB in  3.00 seconds =  74.57 MB/sec

# echo 2  > /sys/block/sdb/device/queue_depth                                                                                                                                    
# hdparm -tT /dev/sdb                                                                                                                                     
/dev/sdb:                                                                                                                                                                                             
Timing cached reads:   16686 MB in  2.00 seconds = 8352.24 MB/sec                                                                                                                                    Timing buffered disk reads: 224 MB in  3.01 seconds =  74.43 MB/sec

# echo 1 > /sys/block/sdb/device/queue_depth                                                                                                                                    
# hdparm -tT /dev/sdb                                                                                                                                      
/dev/sdb:                                                                                                                                                                                             
Timing cached reads:   16958 MB in  2.00 seconds = 8486.99 MB/sec                                                                                                                                    Timing buffered disk reads: 224 MB in  3.01 seconds =  74.45 MB/sec


# echo 31 > /sys/block/sdc/device/queue_depth
# hdparm -tT /dev/sdc
/dev/sdc:
 Timing cached reads:   16664 MB in  2.00 seconds = 8339.87 MB/sec
 Timing buffered disk reads: 178 MB in  3.04 seconds =  58.55 MB/sec

# echo 2 > /sys/block/sdc/device/queue_depth
# hdparm -tT /dev/sdc
/dev/sdc:
 Timing cached reads:   16944 MB in  2.00 seconds = 8480.25 MB/sec
 Timing buffered disk reads: 180 MB in  3.02 seconds =  59.68 MB/sec

# echo 1 > /sys/block/sdc/device/queue_depth
# hdparm -tT /dev/sdc
/dev/sdc:
 Timing cached reads:   17028 MB in  2.00 seconds = 8522.74 MB/sec
 Timing buffered disk reads: 162 MB in  3.01 seconds =  53.85 MB/sec

Thanks
Mark
