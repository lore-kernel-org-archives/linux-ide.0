From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Wed, 31 Jan 2007 09:29:35 +0100
Message-ID: <45C0536F.5020005@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de>	 <20070130164401.295f9913@localhost.localdomain>	 <45BF7658.1090204@imc-berlin.de>	 <20070130172629.70ad628d@localhost.localdomain>	 <45BF7E21.7010605@imc-berlin.de>	 <20070130180727.594b35d0@localhost.localdomain>	 <45BF88B9.3050802@imc-berlin.de> <45BF8F33.3070008@ru.mvista.com> <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2357 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbXAaI3i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 03:29:38 -0500
In-Reply-To: <311601c90701301156nb135de6g996eaff8b2f95a6c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-ide@vger.kernel.org

Eric,

> Maybe the FPGA is discarding the taskfile writes once the HOB bit is
> set?  It wouldn't affect the READ NATIVE MAX ADDRESS EXT command being
> issued since the only the command register matters for that, but it
> would affect SET MAX ADDRESS EXT working properly.
> 
> Without a device > 137GB to test with, and without errors on the
> device, you might not see any odd behavior in normal usage.
> 
> It's *really* unlikely the drive doesn't have a working taskfile.

I am sorry. But I don't understand what a "working taskfile" means.
I don't have CONFIG_IDE_TASK_IOCTL enabled if that means anything.

The FPGA does nothing except decoding adresseses from the ARM cpu,
controlling the A[2..0], CS[1..0], IOR, IOW lines of the HDD.

In linux all I do is setting up some hw_regs_t struct (with hw.io_ports[])
according to my memory map and call ide_register_hw() ...

So looks like I need to find out more about that taskfile stuff.

The reason I started the this thread is that after working with Hitatchi and
Toshiba HDDs in the same mannor we suddenly have problems with new Seagate
drives.

After the kernel reported problems when writing to the disk I used
smartctl to look at the attributes:

Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   253   006         0
  3 Spin_Up_Time            0x0003   096   096   000         0
  4 Start_Stop_Count        0x0032   100   100   020        21
  5 Reallocated_Sector_Ct   0x0033   100   100   036         0
  7 Seek_Error_Rate         0x000f   061   060   030   1368871
  9 Power_On_Hours          0x0032   100   100   000        76
 10 Spin_Retry_Count        0x0013   100   100   034         0
 12 Power_Cycle_Count       0x0032   100   100   020        27
187 Unknown_Attribute       0x0032   100   100   000         0
189 Unknown_Attribute       0x003a   100   100   000         0
190 Temperature_Celsius     0x0022   069   025   045 538705951
192 Power-Off_Retract_Count 0x0032   100   100   000        25
193 Load_Cycle_Count        0x0032   100   100   000       363
194 Temperature_Celsius     0x0022   031   075   000        31
195 Hardware_ECC_Recovered  0x001a   078   066   000  23105720
197 Current_Pending_Sector  0x0012   100   100   000         0
198 Offline_Uncorrectable   0x0010   100   100   000         0
199 UDMA_CRC_Error_Count    0x003e   200   200   000         0
200 Multi_Zone_Error_Rate   0x0000   100   253   000         0
202 TA_Increase_Count       0x0032   100   253   000         0

And I am kind of concerned about Seek_Error_Rate, Temperature_Celsius and
Hardware_ECC_Recovered ...

So now I wonder if all the Seagate drives we have are broken or if this
might be a problem with our hardware ...

Thanks a million!

Steven

