From: Randy Broman <rbroman@bayarea.net>
Subject: Re: Software RAID Problem
Date: Wed, 29 Jul 2009 08:40:40 -0700
Message-ID: <4A706D78.7000107@bayarea.net>
References: <1248798289.4a6f26510c218@myaccount.bayarea.net> <4A6FAF54.1060902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shell4.bayarea.net ([209.128.82.1]:44470 "EHLO
	shell4.bayarea.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbZG2Pkn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 11:40:43 -0400
In-Reply-To: <4A6FAF54.1060902@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Per your instructions .... I tail -f'd /var/log/dmesg and /var/l0g/messages,
and then executed the four mdadm commands below, for the faulty array.
After removing and re-adding the faulty disk partition to the array, the 
array
returns to faulty state almost immediately. During the process, dmesg 
didn't
show anything, but the information written to /var/log/messages is at the
bottom hereto.

I suppose one answer is that there's a hardware issue with the array, or
one of the disks. But that would be surprising to me - both the hardware
array and the disks are new, and the setup (hardware/software/RAID) worked
fine until I tried to upgrade my kernel. Possibly RAID-related formats are
different between kernel 2.6.28 and 2.6.31????

Anyway, would appreciate diagnosis/recommendations ...

# mdadm --detail /dev/md_d2
/dev/md_d2:                                         
        Version : 00.90                             
  Creation Time : Tue Jul 28 17:07:34 2009          
     Raid Level : raid1                             
     Array Size : 366281856 (349.31 GiB 375.07 GB)  
  Used Dev Size : 366281856 (349.31 GiB 375.07 GB)  
   Raid Devices : 2                                 
  Total Devices : 2                                 
Preferred Minor : 2                                 
    Persistence : Superblock is persistent          

    Update Time : Wed Jul 29 08:20:16 2009
          State : clean, degraded        
 Active Devices : 1                      
Working Devices : 1                      
 Failed Devices : 1                      
  Spare Devices : 0                      

           UUID : f87c4d2a:f5ee571c:8ccdfa7d:0ed26058 (local to host 
jboat17)
         Events : 
0.38                                                      

    Number   Major   Minor   RaidDevice State
       0       8       33        0      active sync   /dev/sdc1
       1       0        0        1      removed               

       2       8       49        -      faulty spare   /dev/sdd1
---------------------------------------------
# mdadm --remove /dev/md_d2 /dev/sdd1
mdadm: hot removed /dev/sdd1 
---------------------------------------------                          
# mdadm --add /dev/md_d2 /dev/sdd1
mdadm: re-added /dev/sdd1                                  
---------------------------------------------
# mdadm --detail /dev/md_d2
/dev/md_d2:                                         
        Version : 00.90                             
  Creation Time : Tue Jul 28 17:07:34 2009          
     Raid Level : raid1                             
     Array Size : 366281856 (349.31 GiB 375.07 GB)  
  Used Dev Size : 366281856 (349.31 GiB 375.07 GB)  
   Raid Devices : 2                                 
  Total Devices : 2
Preferred Minor : 2
    Persistence : Superblock is persistent

    Update Time : Wed Jul 29 08:26:16 2009
          State : clean, degraded
 Active Devices : 1
Working Devices : 1
 Failed Devices : 1
  Spare Devices : 0

           UUID : f87c4d2a:f5ee571c:8ccdfa7d:0ed26058 (local to host 
jboat17)
         Events : 0.50

    Number   Major   Minor   RaidDevice State
       0       8       33        0      active sync   /dev/sdc1
       1       0        0        1      removed

       2       8       49        -      faulty spare   /dev/sdd1
---------------------------------------------

Jul 29 08:26:02 jboat17 kernel: [  380.719458] md: 
unbind<sdd1>                              
Jul 29 08:26:02 jboat17 kernel: [  380.724548] md: 
export_rdev(sdd1)                         
Jul 29 08:26:11 jboat17 kernel: [  389.428547] md: 
bind<sdd1>                                
Jul 29 08:26:11 jboat17 kernel: [  389.478408] RAID1 conf 
printout:                          
Jul 29 08:26:11 jboat17 kernel: [  389.478414]  --- wd:1 
rd:2                                
Jul 29 08:26:11 jboat17 kernel: [  389.478420]  disk 0, wo:0, o:1, 
dev:sdc1                  
Jul 29 08:26:11 jboat17 kernel: [  389.478425]  disk 1, wo:1, o:1, 
dev:sdd1                  
Jul 29 08:26:11 jboat17 kernel: [  389.478552] md: recovery of RAID 
array md_d2              
Jul 29 08:26:11 jboat17 kernel: [  389.478559] md: minimum _guaranteed_  
speed: 1000 
KB/sec/disk.                                                                                           

Jul 29 08:26:11 jboat17 kernel: [  389.478566] md: using maximum 
available idle IO bandwidth (but not more than 200000 KB/sec) for 
recovery.                                               
Jul 29 08:26:11 jboat17 kernel: [  389.478574] md: using 128k window, 
over a total of 366281856 
blocks.                                                                                     

Jul 29 08:26:11 jboat17 kernel: [  389.606622] ata7.02: hard resetting 
link                  
Jul 29 08:26:11 jboat17 kernel: [  389.924462] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:11 jboat17 kernel: [  389.926142] ata7.02: configured for 
UDMA/66               
Jul 29 08:26:11 jboat17 kernel: [  389.926269] ata7: EH 
complete                             
Jul 29 08:26:11 jboat17 kernel: [  389.926411] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:11 jboat17 kernel: [  389.926441] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:11 jboat17 kernel: [  389.926488] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:11 jboat17 kernel: [  389.926538] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:11 jboat17 kernel: [  389.926562] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:11 jboat17 kernel: [  389.926606] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:11 jboat17 kernel: [  390.031511] ata7.02: hard resetting 
link                  
Jul 29 08:26:12 jboat17 kernel: [  390.348451] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:12 jboat17 kernel: [  390.352154] ata7.02: configured for 
UDMA/66               
Jul 29 08:26:12 jboat17 kernel: [  390.352293] ata7: EH 
complete                             
Jul 29 08:26:12 jboat17 kernel: [  390.352440] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:12 jboat17 kernel: [  390.352470] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:12 jboat17 kernel: [  390.352538] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:12 jboat17 kernel: [  390.352596] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:12 jboat17 kernel: [  390.352621] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:12 jboat17 kernel: [  390.352667] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:12 jboat17 kernel: [  390.452099] ata7.02: hard resetting 
link                  
Jul 29 08:26:12 jboat17 kernel: [  390.768448] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:12 jboat17 kernel: [  390.770609] ata7.02: configured for 
UDMA/66               
Jul 29 08:26:12 jboat17 kernel: [  390.770746] ata7: EH 
complete                             
Jul 29 08:26:12 jboat17 kernel: [  390.770881] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:12 jboat17 kernel: [  390.770910] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:12 jboat17 kernel: [  390.770958] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:12 jboat17 kernel: [  390.771011] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:12 jboat17 kernel: [  390.771035] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:12 jboat17 kernel: [  390.771081] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:12 jboat17 kernel: [  390.892611] ata7.02: limiting speed 
to UDMA/33:PIO4       
Jul 29 08:26:12 jboat17 kernel: [  390.893217] ata7.02: hard resetting 
link                  
Jul 29 08:26:12 jboat17 kernel: [  391.212448] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:12 jboat17 kernel: [  391.214825] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:12 jboat17 kernel: [  391.214954] ata7: EH 
complete                             
Jul 29 08:26:12 jboat17 kernel: [  391.215098] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:12 jboat17 kernel: [  391.215126] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:12 jboat17 kernel: [  391.215170] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:12 jboat17 kernel: [  391.215218] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:12 jboat17 kernel: [  391.215242] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:12 jboat17 kernel: [  391.215284] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:13 jboat17 kernel: [  391.308638] ata7.02: hard resetting 
link                  
Jul 29 08:26:13 jboat17 kernel: [  391.628447] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:13 jboat17 kernel: [  391.630108] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:13 jboat17 kernel: [  391.630239] ata7: EH 
complete                             
Jul 29 08:26:13 jboat17 kernel: [  391.630380] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:13 jboat17 kernel: [  391.630412] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:13 jboat17 kernel: [  391.630458] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:13 jboat17 kernel: [  391.630506] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:13 jboat17 kernel: [  391.630530] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:13 jboat17 kernel: [  391.630575] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:13 jboat17 kernel: [  391.745362] ata7.02: hard resetting 
link                  
Jul 29 08:26:13 jboat17 kernel: [  392.064448] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:13 jboat17 kernel: [  392.066119] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:13 jboat17 kernel: [  392.066237] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066245] sd 6:2:0:0: [sdd] Sense 
Key : Aborted Command [current] 
[descriptor]                                                                         

Jul 29 08:26:13 jboat17 kernel: [  392.066255] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066260]         72 0b 47 00 00 00 
00 0c 00 0a 80 00 00 00 00 
00                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066276]         00 00 08 
bf                           
Jul 29 08:26:13 jboat17 kernel: [  392.066283] sd 6:2:0:0: [sdd] Add. 
Sense: Scsi parity error
Jul 29 08:26:13 jboat17 kernel: [  392.066366] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066373] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066382] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066386]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
60                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066402]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066408] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066448] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066455] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066462] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066467]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
70                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066482]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066488] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066527] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066533] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066541] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066545]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
80                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066560]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066566] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066606] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066612] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066620] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066624]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
90                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066640]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066646] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066689] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066695] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066703] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066707]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
a0                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066722]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066728] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066765] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066772] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066779] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066784]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
b0                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066799]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066805] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066830] md: md_d2: recovery 
done.                     
Jul 29 08:26:13 jboat17 kernel: [  392.066845] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066851] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066859] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066863]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
c0                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066878]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066884] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066927] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:13 jboat17 kernel: [  392.066933] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:13 jboat17 kernel: [  392.066941] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:13 jboat17 kernel: [  392.066945]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
d0                                                                                      

Jul 29 08:26:13 jboat17 kernel: [  392.066960]         00 00 00 
00                           
Jul 29 08:26:13 jboat17 kernel: [  392.066966] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:13 jboat17 kernel: [  392.066998] ata7: EH 
complete                             
Jul 29 08:26:13 jboat17 kernel: [  392.068198] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:13 jboat17 kernel: [  392.068231] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:13 jboat17 kernel: [  392.068276] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:13 jboat17 kernel: [  392.068326] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:13 jboat17 kernel: [  392.068354] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:13 jboat17 kernel: [  392.068399] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:13 jboat17 kernel: [  392.158170] ata7.00: hard resetting 
link                  
Jul 29 08:26:14 jboat17 kernel: [  392.476448] ata7.00: SATA link up 3.0 
Gbps (SStatus 123 SControl 
320)                                                                                    

Jul 29 08:26:14 jboat17 kernel: [  392.476457] ata7.02: hard resetting 
link                  
Jul 29 08:26:14 jboat17 kernel: [  392.796449] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:14 jboat17 kernel: [  392.798166] ata7.00: configured for 
UDMA/100              
Jul 29 08:26:14 jboat17 kernel: [  392.801264] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:14 jboat17 kernel: [  392.801390] ata7: EH 
complete                             
Jul 29 08:26:14 jboat17 kernel: [  392.801531] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:14 jboat17 kernel: [  392.801562] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:14 jboat17 kernel: [  392.801610] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:14 jboat17 kernel: [  392.801665] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:14 jboat17 kernel: [  392.801689] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:14 jboat17 kernel: [  392.801731] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:14 jboat17 kernel: [  392.801774] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:14 jboat17 kernel: [  392.801797] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:14 jboat17 kernel: [  392.801840] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:14 jboat17 kernel: [  392.801878] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:14 jboat17 kernel: [  392.801900] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:14 jboat17 kernel: [  392.801941] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:14 jboat17 kernel: [  392.896983] ata7.02: hard resetting 
link                  
Jul 29 08:26:14 jboat17 kernel: [  393.212517] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:14 jboat17 kernel: [  393.214208] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:14 jboat17 kernel: [  393.214316] ata7: EH 
complete                             
Jul 29 08:26:14 jboat17 kernel: [  393.214449] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:14 jboat17 kernel: [  393.214477] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:14 jboat17 kernel: [  393.214520] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:14 jboat17 kernel: [  393.214566] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:14 jboat17 kernel: [  393.214589] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:14 jboat17 kernel: [  393.214630] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:15 jboat17 kernel: [  393.319899] ata7.02: hard resetting 
link                  
Jul 29 08:26:15 jboat17 kernel: [  393.644446] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:15 jboat17 kernel: [  393.647065] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:15 jboat17 kernel: [  393.647166] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:15 jboat17 kernel: [  393.647174] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:15 jboat17 kernel: [  393.647184] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:15 jboat17 kernel: [  393.647188]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
20                                                                                      

Jul 29 08:26:15 jboat17 kernel: [  393.647205]         00 00 00 
00                           
Jul 29 08:26:15 jboat17 kernel: [  393.647211] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:15 jboat17 kernel: [  393.647256] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:15 jboat17 kernel: [  393.647263] sd 6:2:0:0: [sdd] Sense 
Key : Hardware Error [current] 
[descriptor]                                                                          

Jul 29 08:26:15 jboat17 kernel: [  393.647271] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:15 jboat17 kernel: [  393.647275]         72 04 00 00 00 00 
00 0c 00 0a 80 00 00 00 36 
30                                                                                      

Jul 29 08:26:15 jboat17 kernel: [  393.647290]         00 00 00 
00                           
Jul 29 08:26:15 jboat17 kernel: [  393.647297] sd 6:2:0:0: [sdd] Add. 
Sense: No additional sense 
information                                                                                

Jul 29 08:26:15 jboat17 kernel: [  393.647326] ata7: EH 
complete                             
Jul 29 08:26:15 jboat17 kernel: [  393.647401] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:15 jboat17 kernel: [  393.647429] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:15 jboat17 kernel: [  393.647473] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:15 jboat17 kernel: [  393.647518] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:15 jboat17 kernel: [  393.647541] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:15 jboat17 kernel: [  393.647583] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:15 jboat17 kernel: [  393.741756] ata7.02: hard resetting 
link                  
Jul 29 08:26:15 jboat17 kernel: [  394.060880] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:15 jboat17 kernel: [  394.062618] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:15 jboat17 kernel: [  394.062720] ata7: EH 
complete                             
Jul 29 08:26:15 jboat17 kernel: [  394.062817] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:15 jboat17 kernel: [  394.062847] sd 6:0:0:0: [sdc] Write 
Protect is off        
Jul 29 08:26:15 jboat17 kernel: [  394.062892] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:15 jboat17 kernel: [  394.062936] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardware sectors: (750 GB/698 
GiB)                                                                    
Jul 29 08:26:15 jboat17 kernel: [  394.062959] sd 6:2:0:0: [sdd] Write 
Protect is off        
Jul 29 08:26:15 jboat17 kernel: [  394.063001] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or 
FUA                                                     
Jul 29 08:26:15 jboat17 kernel: [  394.168579] ata7.02: hard resetting 
link                  
Jul 29 08:26:16 jboat17 kernel: [  394.488460] ata7.02: SATA link up 1.5 
Gbps (SStatus 113 SControl 
310)                                                                                    

Jul 29 08:26:16 jboat17 kernel: [  394.490128] ata7.02: configured for 
UDMA/33               
Jul 29 08:26:16 jboat17 kernel: [  394.490231] sd 6:2:0:0: [sdd] Result: 
hostbyte=DID_OK 
driverbyte=DRIVER_SENSE,SUGGEST_OK                                                                 

Jul 29 08:26:16 jboat17 kernel: [  394.490240] sd 6:2:0:0: [sdd] Sense 
Key : Aborted Command [current] 
[descriptor]                                                                         

Jul 29 08:26:16 jboat17 kernel: [  394.490250] Descriptor sense data 
with sense descriptors (in 
hex):                                                                                       

Jul 29 08:26:16 jboat17 kernel: [  394.490255]         72 0b 47 00 00 00 
00 0c 00 0a 80 00 00 00 00 
00                                                                                      

Jul 29 08:26:16 jboat17 kernel: [  394.490271]         00 00 17 
3f                           
Jul 29 08:26:16 jboat17 kernel: [  394.490278] sd 6:2:0:0: [sdd] Add. 
Sense: Scsi parity error
Jul 29 08:26:16 jboat17 kernel: [  394.490394] ata7: EH complete
Jul 29 08:26:16 jboat17 kernel: [  394.490748] sd 6:0:0:0: [sdc] 
1465149168 512-byte hardwaresectors: (750 GB/698 GiB)
Jul 29 08:26:16 jboat17 kernel: [  394.490777] sd 6:0:0:0: [sdc] Write 
Protect is off
Jul 29 08:26:16 jboat17 kernel: [  394.490821] sd 6:0:0:0: [sdc] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jul 29 08:26:16 jboat17 kernel: [  394.490868] sd 6:2:0:0: [sdd] 
1465149168 512-byte hardwaresectors: (750 GB/698 GiB)
Jul 29 08:26:16 jboat17 kernel: [  394.490896] sd 6:2:0:0: [sdd] Write 
Protect is off
Jul 29 08:26:16 jboat17 kernel: [  394.490941] sd 6:2:0:0: [sdd] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jul 29 08:26:16 jboat17 kernel: [  394.503674] RAID1 conf printout:
Jul 29 08:26:16 jboat17 kernel: [  394.503681]  --- wd:1 rd:2
Jul 29 08:26:16 jboat17 kernel: [  394.503686]  disk 0, wo:0, o:1, dev:sdc1
Jul 29 08:26:16 jboat17 kernel: [  394.503690]  disk 1, wo:1, o:0, dev:sdd1
Jul 29 08:26:16 jboat17 kernel: [  394.504539] RAID1 conf printout:
Jul 29 08:26:16 jboat17 kernel: [  394.504545]  --- wd:1 rd:2
Jul 29 08:26:16 jboat17 kernel: [  394.504549]  disk 0, wo:0, o:1, dev:sdc1


Tejun Heo wrote:
> Hello,
>
> When you reply further, can you please do the followings?
>
> 1. Don't drop cc list.
>
> 2. Use an email client which properly specifies References: and
>    In-Reply-To:.
>
> rbroman@bayarea.net wrote:
>   
>>> Can you attach full output of 'dmesg' after raid degradation?
>>>       
>> For context, there are four RAID devices on this system. md0 is
>> /boot, md1 is / and md2 and md3 are the problem devices. /proc/mdstat
>> is below followed by the output of dmesg.
>>
>> /proc/mdstat
>>
>> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4]
>> [raid10]
>> md_d3 : inactive sdd2[2](S)
>>       366289920 blocks
>>
>> md_d2 : inactive sdd1[2](S)
>>       366281856 blocks
>>
>> md1 : active raid0 sdb6[1] sda6[0]
>>       781256704 blocks 64k chunks
>>
>> md0 : active raid1 sda1[0] sdb1[1]
>>       48829440 blocks [2/2] [UU]
>>
>> unused devices: <none>
>>
>> dmesg .....
>>
>>     
>
> The dmesg doesn't contain ATA error messages and the actual
> degradation.  Can you please trigger that and then attach dmesg?
>
> Thanks.
>
>   

