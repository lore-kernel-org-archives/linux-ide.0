From: Marc MERLIN <marc@merlins.org>
Subject: Re: help with PMP failures
Date: Tue, 17 Nov 2009 09:39:55 -0800
Message-ID: <20091117173955.GA19029@merlins.org>
References: <20091116184242.GA22250@merlins.org> <20091116184853.GA23126@merlins.org> <4B0238EC.6060803@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:56888 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbZKQSBK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 13:01:10 -0500
Content-Disposition: inline
In-Reply-To: <4B0238EC.6060803@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Tue, Nov 17, 2009 at 02:47:24PM +0900, Tejun Heo wrote:
> Hello,
> 
> Can you please cc linux-ide@vger.kernel.org?

Absolutely, didn't know it was good for PMP too. Done.

> > Nov  2 17:03:17 gargamel kernel: ata6.15: exception Emask 0x100 SAct 0x0 SErr 0x200000 action 0x6 frozen
> > Nov  2 17:03:17 gargamel kernel: ata6.15: irq_stat 0x02060002, PMP DMA CS errata
> 
> Command execution error reported.
> 
> Sil3124/32 has an errata which worsens PMP error handling quite a bit.
> It's DMA context gets corrupt if a failure occurs when commands are in
> flight to 3 or more commands, so the driver has to abort all commands
> immediately.

gotcha

> This is the actual failure.  Your 6.02 drive reported media error
> which combined with the controller errata caused port wide failure.
 
Ah, I see, so it should be the one for me to focus on.
If it hadn't had an error, everything wouldn't have gone down the toilet,
next, right?

scsi 6:2:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
sd 6:2:0:0: [sdj] 1953525168 512-byte hardware sectors: (1.00 TB/931 GiB)

If it's a media error, shouldn't it show up in the smart counters?
=== START OF INFORMATION SECTION ===
Model Family:     Hitachi Deskstar 7K1000
Device Model:     Hitachi HDS721010KLA330
Serial Number:    GTJ000PAG2JLKC
Firmware Version: GKAOA70F
User Capacity:    1,000,204,886,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 1
Local Time is:    Tue Nov 17 09:32:47 2009 PST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail  Always       -       0
  2 Throughput_Performance  0x0005   130   130   054    Pre-fail  Offline      -       150
  3 Spin_Up_Time            0x0007   105   105   024    Pre-fail  Always       -       662 (Average 662)
  4 Start_Stop_Count        0x0012   100   100   000    Old_age   Always       -       179
  5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always       -       1
  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail  Always       -       0
  8 Seek_Time_Performance   0x0005   132   132   020    Pre-fail  Offline      -       33
  9 Power_On_Hours          0x0012   098   098   000    Old_age   Always       -       18566
 10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       92
192 Power-Off_Retract_Count 0x0032   061   061   000    Old_age   Always       -       47436
193 Load_Cycle_Count        0x0012   061   061   000    Old_age   Always       -       47436
194 Temperature_Celsius     0x0002   125   125   000    Old_age   Always       -       48 (Lifetime Min/Max 20/63)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       1
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always       -       359

> The device gets kicked out of the system so the errors follow.  I have
> no idea why ata6.00 decided to stop responding.  It might be a
> firmware bug or the PMP is malfunctioning.  If this happens again, you
> can verify that by detaching the offending drive from the PMP without
> disconnecting power (the drive stays powered up) and then connect it
> in a different port and see whether it works.  If it doesn't, it means
> the firmware on the drive is firmly hung and will require power cycle
> to get working again.  Earlier SATA drives and few of recent ones
> sometimes do this after certain failures.
 
I can't really move it to another PMP port but I have indeed had failures
that required not just a reboot of my server but an actual power cycle
of the drive.

> Anyways, if my guess is right, the sequence of the event is first the
> drive with bad sector led to EH kicking in abruptly due to controller
> errata, which in turn caused another drive to lock up due to its
> firmware problem.

Ok, so this all sounds like it's a bit fragile due to hardware issues :)

I now have to figure out if /dev/sdj has a bad sector or not.

Last time I had this happen, though I did run 
dd if=/dev/drive of=/dev/null bs=1M
for my 5 drives, and it ran clean.

If I had a bad sector, shouldn't it show up in Current_Pending_Sector
and shouldn't reading the entire drive with dd fail?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
