From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [usb-storage] [Merging ATA passthru] on integrating SMART/ATA-Security
 in usb-storage driver
Date: Wed, 02 Nov 2005 22:55:57 +0100
Message-ID: <436935ED.6030805@gmx.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF37@WDSCEXBECL03.sc.wdc.com>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:44439 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965284AbVKBV4E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 16:56:04 -0500
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BF37@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, usb-storage@lists.one-eyed-alien.net, linux-ide@vger.kernel.org

Timothy Thelin wrote:
>>They aren't ATA read/write commands; they are SCSI commands.  
>>If there is 
>>a version of SMART that runs over SCSI, you might be able to use it.
>>
>>
>>>and sata is short of smart support. both use scsi-emu(?).
>>>
>>>i dont think theres a hardware problem.
>>
>>Yes there is.  The USB interface on the drive won't recognize 
>>an ATA SMART
>>command and won't pass it on to the drive controller.
>>
> 
> 
> To expand on this, its really the USB device firmware which needs
> the passthru mechanism implmented, since (as stated) it expects
> to be getting scsi commands.  Now there are many vendor specific
> ways to embed ATA commands inside of scsi cdbs, and then there are
> two public methods that I'm aware of: SAT and the At2lp (cypress
> bridge board, docs on their website).
> 
> And to send these commands, user-space already has SG_IO.
> 

so sg3_utils and sdparm could be used for commands(?)

my device can do:

tom1:~# sdparm -avfl /dev/sda
    /dev/sda: IC35L030  AVVN07-0
Read write error recovery [PS=0] mode page:
  AWRE        0  [cha: n, def:  0, sav:  0]  Automatic write
reallocation enabled
  ARRE        0  [cha: n, def:  0, sav:  0]  Automatic read reallocation
enabled
  TB          0  [cha: n, def:  0, sav:  0]  Transfer block
  RC          0  [cha: n, def:  0, sav:  0]  Read continuous
  EER         0  [cha: n, def:  0, sav:  0]  Enable early recover
  PER         0  [cha: n, def:  0, sav:  0]  Post error
  DTE         0  [cha: n, def:  0, sav:  0]  Data terminate on error
  DCR         0  [cha: n, def:  0, sav:  0]  Disable correction
  RRC         0  [cha: n, def:  0, sav:  0]  Read retry count
  EMCDR       0  [cha: n, def:  0, sav:  0]  Enhanced media
certification and defect reporting
  WRC         0  [cha: n, def:  0, sav:  0]  Write retry count
  RTL         0  [cha: n, def:  0, sav:  0]  Recovery time limit (ms)
>> Format (SBC) mode page not supported
>> Rigid disk (SBC) mode page not supported
Write parameters (MMC) [PS=0] mode page:
  BUFE        1  [cha: y, def:  1, sav:  1]  Buffer underrun free
recording enable
  LS_V        1  [cha: y, def:  1, sav:  1]  Link size valid
  TST_W       1  [cha: y, def:  1, sav:  1]  Test write
  WR_T       15  [cha: y, def: 15, sav: 15]  Write type
  MULTI_S     3  [cha: y, def:  3, sav:  3]  Multi session
  FP          1  [cha: y, def:  1, sav:  1]  Fixed packet type
  COPY        1  [cha: y, def:  1, sav:  1]  Serial copy management
system (SCMS) enable
  TRACK_M    15  [cha: y, def: 15, sav: 15]  Track mode
  DBT         0  [cha: n, def:  0, sav:  0]  Data block type
  LINK_S     63  [cha: y, def: 63, sav: 63]  Link size
  IAC         0  [cha: n, def:  0, sav:  0]  Initiator application code
  SESS_F     63  [cha: y, def: 63, sav: 63]  Session format
  PACK_S      0  [cha: n, def:  0, sav:  0]  Packet size
 >> hereafter field position exceeds mode page length=12
  APL         0  [cha: n, def:  0, sav:  0]  Audio pause length (blocks)
>> RBC device parameters (RBC) mode page not supported
>> Verify error recovery (SBC) mode page not supported
Caching (SBC) [PS=0] mode page:
  IC          0  [cha: n, def:  0, sav:  0]  Initiator control
  ABPF        0  [cha: n, def:  0, sav:  0]  Abort pre-fetch
  CAP         0  [cha: n, def:  0, sav:  0]  Caching analysis permitted
  DISC        0  [cha: n, def:  0, sav:  0]  Discontinuity
  SIZE        0  [cha: n, def:  0, sav:  0]  Size (1->CSS valid, 0->NCS
valid)
  WCE         0  [cha: n, def:  0, sav:  0]  Write cache enable
  MF          0  [cha: n, def:  0, sav:  0]  Multiplication factor
  RCD         0  [cha: n, def:  0, sav:  0]  Read cache disable
  DRRP        0  [cha: n, def:  0, sav:  0]  Demand read retension priority
  WRP         0  [cha: n, def:  0, sav:  0]  Write retension priority
  DPTL        0  [cha: n, def:  0, sav:  0]  Disable pre-fetch transfer
length
  MIPF        0  [cha: n, def:  0, sav:  0]  Minimum pre-fetch
  MAPF        0  [cha: n, def:  0, sav:  0]  Maximum pre-fetch
  MAPFC       0  [cha: n, def:  0, sav:  0]  Maximum pre-fetch ceiling
 >> hereafter field position exceeds mode page length=12
  FSW         0  [cha: n, def:  0, sav:  0]  Force sequential write
  LBCSS       0  [cha: n, def:  0, sav:  0]  Logical block cache segment
size
  DRA         0  [cha: n, def:  0, sav:  0]  Disable read ahead
  NV_DIS      0  [cha: n, def:  0, sav:  0]  Non-volatile cache disable
  NCS         0  [cha: n, def:  0, sav:  0]  Number of cache segments
  CSS         0  [cha: n, def:  0, sav:  0]  Cache segment size
>> Control mode page not supported
>> Data compression (SSC) mode page not supported
>> XOR control (SBC) mode page not supported
>> Enclosure services management (SES) mode page not supported
>> Protocol specific logical unit mode page not supported
>> Protocol specific port mode page not supported
>> Power condition mode page not supported
>> Informational exceptions control mode page not supported
>> Background control (SBC) mode subpage not supported
>> Timeout and protect (MMC) mode page not supported
>> CD/DVD (MM) capabilities and mechanical status (MMC) mode page not
supported
tom1:~#


> So I'm not sure usb-storage can do much, since it can't force a usb
> device to accept passthru cdbs, and SG_IO already allows cdbs
> to be sent to usb devices.

yes, fine to me :)

> 
> Regards,
> Tim Thelin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

thx
y
tom schorpp

