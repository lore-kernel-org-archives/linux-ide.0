From: Yan Seiner <yan@seiner.com>
Subject: Re: Port multiplier resets
Date: Sat, 22 Nov 2008 08:48:32 -0800
Message-ID: <492837E0.3080906@seiner.com>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org> <4924D733.6070005@seiner.com> <4924D86C.8010107@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010607060108070100020903"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:53808 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758613AbYKVQse (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 11:48:34 -0500
In-Reply-To: <4924D86C.8010107@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607060108070100020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Yan Seiner wrote:
>   
>> Tejun Heo wrote:
>>     
>>> 2. Specify libata.force=8.15:1.5Gbps
>>>   
>>>       
>> dumb question:
>>
>> Does this go on the kernel parameter line or can I change it without
>> rebooting the system?
>>
>> I don't see it in /sys/module/libata/parameters so I'm guessing it needs
>> a reboot?
>>     
>
> Yeah, you will need to reboot or reload libata module.  Note that if
> libata.ko is being loaded from initrd, different distros use different
> methods to pass parameters to them.
>
>   
Thanks for all your help.   Unfortunately I'm still dead in the water 
with the jmicron controller....  :-(

If anything, things have gotten worse.  I suspect that the hardware is 
broken, but I'm hoping there's still something I can do.

The jmicron controller is ata3 and ata4.  Here's my kernel line from grub:

title           Debian GNU/Linux, kernel 2.6.27.4
root            (hd0,1)
kernel          /vmlinuz-2.6.27.4 root=/dev/md0 ro quiet 
libata.force=3.15:1.5Gbps,4.15:1.5Gbps
initrd          /initrd.img-2.6.27.4

I'm trying to limit the link from the controller to the PMP to 1.5 
Gbps.  That doesn't seem to be happening.  Worse, now the drives 
connected to that controller aren't being recognized.

I get "link online but device misclassified, retrying" errors.  It's not 
the drive or the caddy; I've swapped drives, slots, and cables and the 
errors remain with the jmicron ports.

I'm attaching a log which takes you from boot, to powerup of the 
diskpack, and then a power cycle of the diskpack.  Unfortunately I 
cannot boot with the external drives powered up; the jmicron controller 
hangs (it has a conflict with the scsi controller if any drives are 
attached at boot.)

I'd appreciate any help at this point.  My only alternative is to 
disable the onboard jmicron and get a PCI-based esata controller.

--Yan



--------------010607060108070100020903
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"


Nov 22 06:53:20 selene kernel: [    8.076344] ata3: SATA max UDMA/133 abar m8192@0xfdbfe000 port 0xfdbfe100 irq 16
Nov 22 06:53:20 selene kernel: [    8.076347] ata4: SATA max UDMA/133 abar m8192@0xfdbfe000 port 0xfdbfe180 irq 16
Nov 22 06:53:20 selene kernel: [    8.396027] ata3: SATA link down (SStatus 0 SControl 300)
Nov 22 06:53:20 selene kernel: [    8.732025] ata4: SATA link down (SStatus 0 SControl 300)
Nov 22 06:53:43 selene kernel: [  103.726812] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 06:53:43 selene kernel: [  103.726821] ata3: irq_stat 0x00400040, connection status changed
Nov 22 06:53:43 selene kernel: [  103.726824] ata3: SError: { PHYRdyChg CommWake DevExch }
Nov 22 06:53:43 selene kernel: [  103.726832] ata3: hard resetting link
Nov 22 06:53:43 selene kernel: [  103.730085] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 06:53:43 selene kernel: [  103.730091] ata4: irq_stat 0x00400040, connection status changed
Nov 22 06:53:43 selene kernel: [  103.730094] ata4: SError: { PHYRdyChg CommWake DevExch }
Nov 22 06:53:43 selene kernel: [  103.730097] ata4: hard resetting link
Nov 22 06:53:45 selene kernel: [  105.620028] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:53:45 selene kernel: [  105.620296] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Nov 22 06:53:45 selene kernel: [  105.620577] ata3.00: hard resetting link
Nov 22 06:53:45 selene kernel: [  105.624020] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:53:45 selene kernel: [  105.624027] ata4: link online but device misclassified, retrying
Nov 22 06:53:45 selene kernel: [  105.624030] ata4: reset failed (errno=-11), retrying in 9 secs
Nov 22 06:53:45 selene kernel: [  105.936981] ata3.00: SATA link down (SStatus 0 SControl 310)
Nov 22 06:53:45 selene kernel: [  105.937081] ata3.01: hard resetting link
Nov 22 06:53:45 selene kernel: [  106.257020] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 06:53:45 selene kernel: [  106.257026] ata3.02: hard resetting link
Nov 22 06:53:45 selene kernel: [  106.577025] ata3.02: SATA link down (SStatus 0 SControl 320)
Nov 22 06:53:45 selene kernel: [  106.577124] ata3.03: hard resetting link
Nov 22 06:53:46 selene kernel: [  106.897024] ata3.03: SATA link down (SStatus 0 SControl 320)
Nov 22 06:53:46 selene kernel: [  106.897122] ata3.04: hard resetting link
Nov 22 06:53:46 selene kernel: [  107.217022] ata3.04: SATA link down (SStatus 0 SControl 320)
Nov 22 06:53:46 selene kernel: [  107.217120] ata3.05: hard resetting link
Nov 22 06:53:46 selene kernel: [  107.536976] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 06:53:51 selene kernel: [  112.536522] ata3.01: qc timeout (cmd 0xec)
Nov 22 06:53:51 selene kernel: [  112.536534] ata3.01: failed to IDENTIFY (I/O error, err_mask=0x4)
Nov 22 06:53:51 selene kernel: [  112.536539] ata3.15: hard resetting link
Nov 22 06:53:53 selene kernel: [  113.728023] ata4: hard resetting link
Nov 22 06:53:53 selene kernel: [  114.028522] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:53:53 selene kernel: [  114.029004] ata3.00: hard resetting link
Nov 22 06:53:53 selene kernel: [  114.348497] ata3.00: SATA link down (SStatus 0 SControl 310)
Nov 22 06:53:53 selene kernel: [  114.348676] ata3.01: hard resetting link
Nov 22 06:53:54 selene kernel: [  114.668526] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 06:53:54 selene kernel: [  114.668534] ata3.05: hard resetting link
Nov 22 06:53:54 selene kernel: [  114.997984] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 06:53:55 selene kernel: [  115.624029] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:53:55 selene kernel: [  115.624037] ata4: link online but device misclassified, retrying
Nov 22 06:53:55 selene kernel: [  115.624040] ata4: reset failed (errno=-11), retrying in 9 secs
Nov 22 06:53:57 selene kernel: [  118.123857] ata3.01: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
Nov 22 06:53:57 selene kernel: [  118.124935] ata3.01: hard resetting link
Nov 22 06:54:00 selene kernel: [  121.124529] ata3.15: qc timeout (cmd 0xe4)
Nov 22 06:54:00 selene kernel: [  121.124541] ata3.01: failed to read SCR 2 (Emask=0x4)
Nov 22 06:54:00 selene kernel: [  121.124544] ata3.01: failed to read SCR 2 (Emask=0x40)
Nov 22 06:54:00 selene kernel: [  121.124546] ata3.01: COMRESET failed (errno=-5)
Nov 22 06:54:00 selene kernel: [  121.124549] ata3.01: failed to read SCR 0 (Emask=0x40)
Nov 22 06:54:00 selene kernel: [  121.124551] ata3.01: reset failed, giving up
Nov 22 06:54:00 selene kernel: [  121.124555] ata3.15: hard resetting link
Nov 22 06:54:01 selene kernel: [  122.337060] sd 0:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:54:01 selene kernel: [  122.337083] sd 0:1:0:0: [sdj] Write Protect is off
Nov 22 06:54:01 selene kernel: [  122.337086] sd 0:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 06:54:01 selene kernel: [  122.337123] sd 0:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:54:01 selene kernel: [  122.337210] sd 0:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:54:01 selene kernel: [  122.337231] sd 0:1:0:0: [sdj] Write Protect is off
Nov 22 06:54:01 selene kernel: [  122.337233] sd 0:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 06:54:01 selene kernel: [  122.337268] sd 0:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:54:01 selene kernel: [  122.337272]  sdj: sdj1
Nov 22 06:54:01 selene kernel: [  122.364839] sd 0:1:0:0: [sdj] Attached SCSI disk
Nov 22 06:54:02 selene kernel: [  122.628030] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:54:02 selene kernel: [  122.628303] ata3.00: hard resetting link
Nov 22 06:54:02 selene kernel: [  122.948958] ata3.00: SATA link down (SStatus 0 SControl 310)
Nov 22 06:54:02 selene kernel: [  123.124525] ata3.01: hard resetting link
Nov 22 06:54:02 selene kernel: [  123.444997] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 06:54:02 selene kernel: [  123.445006] ata3.02: hard resetting link
Nov 22 06:54:03 selene kernel: [  123.732027] ata4: hard resetting link
Nov 22 06:54:03 selene kernel: [  123.760975] ata3.02: SATA link down (SStatus 0 SControl 320)
Nov 22 06:54:03 selene kernel: [  123.761146] ata3.03: hard resetting link
Nov 22 06:54:03 selene kernel: [  124.081013] ata3.03: SATA link down (SStatus 0 SControl 320)
Nov 22 06:54:03 selene kernel: [  124.081180] ata3.04: hard resetting link
Nov 22 06:54:03 selene kernel: [  124.401013] ata3.04: SATA link down (SStatus 0 SControl 320)
Nov 22 06:54:03 selene kernel: [  124.401187] ata3.05: hard resetting link
Nov 22 06:54:04 selene kernel: [  124.725187] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 06:54:04 selene kernel: [  124.726676] ata3.01: ATA-8: ST31000340AS, SD15, max UDMA/133
Nov 22 06:54:04 selene kernel: [  124.726681] ata3.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
Nov 22 06:54:04 selene kernel: [  124.728615] ata3.01: configured for UDMA/133
Nov 22 06:54:04 selene kernel: [  124.731287] ata3: EH complete
Nov 22 06:54:04 selene kernel: [  124.731696] sd 4:1:0:0: [sdk] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:54:04 selene kernel: [  124.731721] sd 4:1:0:0: [sdk] Write Protect is off
Nov 22 06:54:04 selene kernel: [  124.731724] sd 4:1:0:0: [sdk] Mode Sense: 00 3a 00 00
Nov 22 06:54:04 selene kernel: [  124.731761] sd 4:1:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:54:04 selene kernel: [  124.731844] sd 4:1:0:0: [sdk] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:54:04 selene kernel: [  124.731869] sd 4:1:0:0: [sdk] Write Protect is off
Nov 22 06:54:04 selene kernel: [  124.731871] sd 4:1:0:0: [sdk] Mode Sense: 00 3a 00 00
Nov 22 06:54:04 selene kernel: [  124.731908] sd 4:1:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:54:04 selene kernel: [  124.731915]  sdk: sdk1
Nov 22 06:54:04 selene kernel: [  124.761321] sd 4:1:0:0: [sdk] Attached SCSI disk
Nov 22 06:54:04 selene kernel: [  124.813130] sd 1:1:0:0: [sdl] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:54:04 selene kernel: [  124.813153] sd 1:1:0:0: [sdl] Write Protect is off
Nov 22 06:54:04 selene kernel: [  124.813155] sd 1:1:0:0: [sdl] Mode Sense: 00 3a 00 00
Nov 22 06:54:04 selene kernel: [  124.813190] sd 1:1:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:54:04 selene kernel: [  124.813266] sd 1:1:0:0: [sdl] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:54:04 selene kernel: [  124.813286] sd 1:1:0:0: [sdl] Write Protect is off
Nov 22 06:54:04 selene kernel: [  124.813288] sd 1:1:0:0: [sdl] Mode Sense: 00 3a 00 00
Nov 22 06:54:04 selene kernel: [  124.813322] sd 1:1:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:54:04 selene kernel: [  124.813325]  sdl: sdl1
Nov 22 06:54:04 selene kernel: [  124.838253] sd 1:1:0:0: [sdl] Attached SCSI disk
Nov 22 06:54:05 selene kernel: [  125.624028] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:54:05 selene kernel: [  125.624037] ata4: link online but device misclassified, retrying
Nov 22 06:54:05 selene kernel: [  125.624039] ata4: reset failed (errno=-11), retrying in 34 secs
Nov 22 06:54:38 selene kernel: [  158.728020] ata4: limiting SATA link speed to 1.5 Gbps
Nov 22 06:54:38 selene kernel: [  158.728026] ata4: hard resetting link
Nov 22 06:54:40 selene kernel: [  160.624025] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:54:40 selene kernel: [  160.624035] ata4: link online but device misclassified, device detection might fail
Nov 22 06:54:40 selene kernel: [  160.624041] ata4: EH complete
Nov 22 06:57:09 selene kernel: [  309.921890] ata3.01: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Nov 22 06:57:09 selene kernel: [  309.921898] ata3.01: SError: { PHYRdyChg DevExch }
Nov 22 06:57:09 selene kernel: [  309.923261] ata3.01: hard resetting link
Nov 22 06:57:09 selene kernel: [  309.930585] ata4: exception Emask 0x10 SAct 0x0 SErr 0x1990001 action 0xe frozen
Nov 22 06:57:09 selene kernel: [  309.930593] ata4: irq_stat 0x04400000, PHY RDY changed
Nov 22 06:57:09 selene kernel: [  309.930596] ata4: SError: { RecovData PHYRdyChg 10B8B Dispar LinkSeq TrStaTrns }
Nov 22 06:57:09 selene kernel: [  309.930603] ata4: hard resetting link
Nov 22 06:57:09 selene kernel: [  309.940560] ata3.01: failed to read SCR 2 (Emask=0x40)
Nov 22 06:57:09 selene kernel: [  309.940566] ata3.01: COMRESET failed (errno=-5)
Nov 22 06:57:09 selene kernel: [  309.940569] ata3.01: failed to read SCR 0 (Emask=0x40)
Nov 22 06:57:09 selene kernel: [  309.940573] ata3.01: reset failed, giving up
Nov 22 06:57:09 selene kernel: [  309.940578] ata3.15: hard resetting link
Nov 22 06:57:09 selene kernel: [  310.260528] ata3.15: SATA link down (SStatus 0 SControl 300)
Nov 22 06:57:10 selene kernel: [  310.656032] ata4: SATA link down (SStatus 0 SControl 300)
Nov 22 06:57:10 selene kernel: [  310.656044] ata4: EH complete
Nov 22 06:57:12 selene kernel: [  313.260520] ata3.15: qc timeout (cmd 0xe4)
Nov 22 06:57:12 selene kernel: [  313.260536] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 06:57:12 selene kernel: [  313.260539] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 06:57:14 selene kernel: [  315.260518] ata3.15: hard resetting link
Nov 22 06:57:14 selene kernel: [  315.580460] ata3.15: SATA link down (SStatus 0 SControl 300)
Nov 22 06:57:17 selene kernel: [  318.580021] ata3.15: qc timeout (cmd 0xe4)
Nov 22 06:57:17 selene kernel: [  318.580034] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 06:57:17 selene kernel: [  318.580038] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 06:57:17 selene kernel: [  318.580041] ata3.15: limiting SATA link speed to 1.5 Gbps
Nov 22 06:57:19 selene kernel: [  320.580020] ata3.15: hard resetting link
Nov 22 06:57:20 selene kernel: [  320.904034] ata3.15: SATA link down (SStatus 0 SControl 310)
Nov 22 06:57:23 selene kernel: [  323.904061] ata3.15: qc timeout (cmd 0xe4)
Nov 22 06:57:23 selene kernel: [  323.904075] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 06:57:23 selene kernel: [  323.904078] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 06:57:25 selene kernel: [  325.908015] ata3.15: hard resetting link
Nov 22 06:57:25 selene kernel: [  326.224027] ata3.15: SATA link down (SStatus 0 SControl 310)
Nov 22 06:57:28 selene kernel: [  329.224022] ata3.15: qc timeout (cmd 0xe4)
Nov 22 06:57:28 selene kernel: [  329.224037] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 06:57:28 selene kernel: [  329.224040] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 06:57:30 selene kernel: [  331.224018] ata3.15: hard resetting link
Nov 22 06:57:30 selene kernel: [  331.331974] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 06:57:30 selene kernel: [  331.331980] ata4: irq_stat 0x00400040, connection status changed
Nov 22 06:57:30 selene kernel: [  331.331983] ata4: SError: { PHYRdyChg CommWake DevExch }
Nov 22 06:57:30 selene kernel: [  331.331990] ata4: hard resetting link
Nov 22 06:57:32 selene kernel: [  332.724037] ata3.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:57:32 selene kernel: [  332.724398] ata3.00: hard resetting link
Nov 22 06:57:32 selene kernel: [  333.045051] ata3.00: SATA link down (SStatus 0 SControl 10)
Nov 22 06:57:32 selene kernel: [  333.045100] ata3.01: hard resetting link
Nov 22 06:57:32 selene kernel: [  333.224524] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:57:32 selene kernel: [  333.224532] ata4: link online but device misclassified, retrying
Nov 22 06:57:32 selene kernel: [  333.224535] ata4: reset failed (errno=-11), retrying in 9 secs
Nov 22 06:57:32 selene kernel: [  333.364520] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:57:32 selene kernel: [  333.364527] ata3.02: hard resetting link
Nov 22 06:57:33 selene kernel: [  333.684462] ata3.02: SATA link down (SStatus 0 SControl 310)
Nov 22 06:57:33 selene kernel: [  333.684516] ata3.03: hard resetting link
Nov 22 06:57:33 selene kernel: [  334.004998] ata3.03: SATA link down (SStatus 0 SControl 310)
Nov 22 06:57:33 selene kernel: [  334.005047] ata3.04: hard resetting link
Nov 22 06:57:33 selene kernel: [  334.324966] ata3.04: SATA link down (SStatus 0 SControl 310)
Nov 22 06:57:33 selene kernel: [  334.325017] ata3.05: hard resetting link
Nov 22 06:57:34 selene kernel: [  334.645009] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:57:39 selene kernel: [  339.644023] ata3.01: qc timeout (cmd 0xec)
Nov 22 06:57:39 selene kernel: [  339.644038] ata3.01: failed to IDENTIFY (I/O error, err_mask=0x4)
Nov 22 06:57:39 selene kernel: [  339.644042] ata3.01: revalidation failed (errno=-5)
Nov 22 06:57:39 selene kernel: [  339.644049] ata3.15: hard resetting link
Nov 22 06:57:40 selene kernel: [  341.140530] ata3.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:57:40 selene kernel: [  341.145868] ata3.00: hard resetting link
Nov 22 06:57:40 selene kernel: [  341.328513] ata4: hard resetting link
Nov 22 06:57:40 selene kernel: [  341.464990] ata3.00: SATA link down (SStatus 0 SControl 310)
Nov 22 06:57:40 selene kernel: [  341.465039] ata3.01: hard resetting link
Nov 22 06:57:41 selene kernel: [  341.784962] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:57:41 selene kernel: [  341.784968] ata3.05: hard resetting link
Nov 22 06:57:41 selene kernel: [  342.104964] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:57:42 selene kernel: [  343.228525] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:57:42 selene kernel: [  343.228534] ata4: link online but device misclassified, retrying
Nov 22 06:57:42 selene kernel: [  343.228536] ata4: reset failed (errno=-11), retrying in 9 secs
Nov 22 06:57:44 selene kernel: [  345.260263] ata3.01: failed to read native max address (err_mask=0x1)
Nov 22 06:57:44 selene kernel: [  345.260269] ata3.01: HPA support seems broken, skipping HPA handling
Nov 22 06:57:44 selene kernel: [  345.261783] ata3.01: configured for UDMA/133
Nov 22 06:57:44 selene kernel: [  345.262129] ata3.15: exception Emask 0x10 SAct 0x0 SErr 0x400001 action 0x9 t4
Nov 22 06:57:44 selene kernel: [  345.262134] ata3.15: irq_stat 0x48000000
Nov 22 06:57:44 selene kernel: [  345.262136] ata3.15: SError: { RecovData Handshk }
Nov 22 06:57:44 selene kernel: [  345.262597] ata3: EH complete
Nov 22 06:57:44 selene kernel: [  345.262701] sd 4:1:0:0: [sdk] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:57:44 selene kernel: [  345.262725] sd 4:1:0:0: [sdk] Write Protect is off
Nov 22 06:57:44 selene kernel: [  345.262727] sd 4:1:0:0: [sdk] Mode Sense: 00 3a 00 00
Nov 22 06:57:44 selene kernel: [  345.262764] sd 4:1:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:57:44 selene kernel: [  345.581894] sd 1:1:0:0: [sdl] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 06:57:44 selene kernel: [  345.581918] sd 1:1:0:0: [sdl] Write Protect is off
Nov 22 06:57:44 selene kernel: [  345.581920] sd 1:1:0:0: [sdl] Mode Sense: 00 3a 00 00
Nov 22 06:57:44 selene kernel: [  345.581958] sd 1:1:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 06:57:49 selene kernel: [  350.289017] Buffer I/O error on device sdj1, logical block 976759936
Nov 22 06:57:49 selene kernel: [  350.289021] Buffer I/O error on device sdj1, logical block 976759937
Nov 22 06:57:49 selene kernel: [  350.289024] Buffer I/O error on device sdj1, logical block 976759938
Nov 22 06:57:49 selene kernel: [  350.289026] Buffer I/O error on device sdj1, logical block 976759939
Nov 22 06:57:49 selene kernel: [  350.289038] Buffer I/O error on device sdj1, logical block 976759936
Nov 22 06:57:49 selene kernel: [  350.289046] Buffer I/O error on device sdj1, logical block 976759937
Nov 22 06:57:49 selene kernel: [  350.289052] Buffer I/O error on device sdj1, logical block 976759938
Nov 22 06:57:49 selene kernel: [  350.289059] Buffer I/O error on device sdj1, logical block 976759939
Nov 22 06:57:49 selene kernel: [  350.289115] Buffer I/O error on device sdj, logical block 244190624
Nov 22 06:57:49 selene kernel: [  350.289122] Buffer I/O error on device sdj, logical block 244190624
Nov 22 06:57:49 selene kernel: [  350.289322] sd 0:1:0:0: [sdj] Synchronizing SCSI cache
Nov 22 06:57:49 selene kernel: [  350.289383] sd 0:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 06:57:49 selene kernel: [  350.289386] sd 0:1:0:0: [sdj] Stopping disk
Nov 22 06:57:49 selene kernel: [  350.289402] sd 0:1:0:0: [sdj] START_STOP FAILED
Nov 22 06:57:49 selene kernel: [  350.289404] sd 0:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 06:57:49 selene kernel: [  350.304884] md: bind<sdk1>
Nov 22 06:57:49 selene kernel: [  350.305427] md: bind<sdl1>
Nov 22 06:57:49 selene kernel: [  350.367343] raid5: device sdl1 operational as raid disk 1
Nov 22 06:57:49 selene kernel: [  350.367349] raid5: device sdk1 operational as raid disk 2
Nov 22 06:57:49 selene kernel: [  350.367901]  disk 1, o:1, dev:sdl1
Nov 22 06:57:49 selene kernel: [  350.367903]  disk 2, o:1, dev:sdk1
Nov 22 06:57:50 selene kernel: [  351.328525] ata4: hard resetting link
Nov 22 06:57:52 selene kernel: [  353.224540] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 06:57:52 selene kernel: [  353.224549] ata4: link online but device misclassified, retrying
Nov 22 06:57:52 selene kernel: [  353.224551] ata4: reset failed (errno=-11), retrying in 34 secs
Nov 22 06:58:25 selene kernel: [  386.328516] ata4: limiting SATA link speed to 1.5 Gbps
Nov 22 06:58:25 selene kernel: [  386.328522] ata4: hard resetting link
Nov 22 06:58:27 selene kernel: [  388.224025] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 06:58:27 selene kernel: [  388.224034] ata4: link online but device misclassified, device detection might fail
Nov 22 06:58:27 selene kernel: [  388.224039] ata4: EH complete
Nov 22 07:03:37 selene kernel: [  698.104956] ata3.01: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Nov 22 07:03:37 selene kernel: [  698.104962] ata3.01: SError: { PHYRdyChg DevExch }
Nov 22 07:03:37 selene kernel: [  698.105257] ata3.01: hard resetting link
Nov 22 07:03:37 selene kernel: [  698.115302] ata4: exception Emask 0x10 SAct 0x0 SErr 0x1990001 action 0xe frozen
Nov 22 07:03:37 selene kernel: [  698.115308] ata4: irq_stat 0x04400000, PHY RDY changed
Nov 22 07:03:37 selene kernel: [  698.115311] ata4: SError: { RecovData PHYRdyChg 10B8B Dispar LinkSeq TrStaTrns }
Nov 22 07:03:37 selene kernel: [  698.115320] ata4: hard resetting link
Nov 22 07:03:37 selene kernel: [  698.316431] ata3.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:03:37 selene kernel: [  698.316437] ata3.01: COMRESET failed (errno=-5)
Nov 22 07:03:37 selene kernel: [  698.316440] ata3.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:03:37 selene kernel: [  698.316442] ata3.01: reset failed, giving up
Nov 22 07:03:37 selene kernel: [  698.316446] ata3.15: hard resetting link
Nov 22 07:03:38 selene kernel: [  698.636530] ata3.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:03:38 selene kernel: [  698.844031] ata4: SATA link down (SStatus 0 SControl 300)
Nov 22 07:03:38 selene kernel: [  698.844046] ata4: EH complete
Nov 22 07:03:41 selene kernel: [  701.636517] ata3.15: qc timeout (cmd 0xe4)
Nov 22 07:03:41 selene kernel: [  701.636532] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:03:41 selene kernel: [  701.636534] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 07:03:43 selene kernel: [  703.636514] ata3.15: hard resetting link
Nov 22 07:03:43 selene kernel: [  703.956030] ata3.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:03:46 selene kernel: [  706.956033] ata3.15: qc timeout (cmd 0xe4)
Nov 22 07:03:46 selene kernel: [  706.956048] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:03:46 selene kernel: [  706.956050] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 07:03:48 selene kernel: [  708.956519] ata3.15: hard resetting link
Nov 22 07:03:48 selene kernel: [  709.283160] ata3.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:03:51 selene kernel: [  712.280517] ata3.15: qc timeout (cmd 0xe4)
Nov 22 07:03:51 selene kernel: [  712.280532] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:03:51 selene kernel: [  712.280535] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 07:03:53 selene kernel: [  714.280551] ata3.15: hard resetting link
Nov 22 07:03:54 selene kernel: [  714.600527] ata3.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:03:57 selene kernel: [  717.600514] ata3.15: qc timeout (cmd 0xe4)
Nov 22 07:03:57 selene kernel: [  717.600527] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:03:57 selene kernel: [  717.600528] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 07:03:59 selene kernel: [  719.600513] ata3.15: hard resetting link
Nov 22 07:03:59 selene kernel: [  719.920527] ata3.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:04:02 selene kernel: [  722.920521] ata3.15: qc timeout (cmd 0xe4)
Nov 22 07:04:02 selene kernel: [  722.920536] ata3.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:04:02 selene kernel: [  722.920539] ata3.15: PMP revalidation failed (errno=-5)
Nov 22 07:04:02 selene kernel: [  722.920541] ata3.15: failed to recover PMP after 5 tries, giving up
Nov 22 07:04:02 selene kernel: [  722.920543] ata3.15: Port Multiplier detaching
Nov 22 07:04:02 selene kernel: [  722.920547] ata3.01: disabled
Nov 22 07:04:02 selene kernel: [  722.920551] ata3.00: disabled
Nov 22 07:04:02 selene kernel: [  722.920560] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen t4
Nov 22 07:04:02 selene kernel: [  722.920562] ata3: irq_stat 0x00400000, PHY RDY changed
Nov 22 07:04:02 selene kernel: [  722.920567] ata3: hard resetting link
Nov 22 07:04:03 selene kernel: [  723.644527] ata3: SATA link down (SStatus 0 SControl 300)
Nov 22 07:04:03 selene kernel: [  723.644542] ata3: EH complete
Nov 22 07:04:03 selene kernel: [  723.644556] ata3.01: detaching (SCSI 4:1:0:0)
Nov 22 07:04:03 selene kernel: [  723.644934] sd 4:1:0:0: [sdk] Synchronizing SCSI cache
Nov 22 07:04:03 selene kernel: [  723.645001] sd 4:1:0:0: [sdk] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:04:03 selene kernel: [  723.645008] sd 4:1:0:0: [sdk] Stopping disk
Nov 22 07:04:03 selene kernel: [  723.645025] sd 4:1:0:0: [sdk] START_STOP FAILED
Nov 22 07:04:03 selene kernel: [  723.645027] sd 4:1:0:0: [sdk] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:04:13 selene kernel: [  733.799297] sd 1:1:0:0: [sdl] Synchronizing SCSI cache
Nov 22 07:04:13 selene kernel: [  733.799370] sd 1:1:0:0: [sdl] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:04:13 selene kernel: [  733.799374] sd 1:1:0:0: [sdl] Stopping disk
Nov 22 07:04:13 selene kernel: [  733.799390] sd 1:1:0:0: [sdl] START_STOP FAILED
Nov 22 07:04:13 selene kernel: [  733.799392] sd 1:1:0:0: [sdl] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:04:33 selene kernel: [  754.464361] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 07:04:33 selene kernel: [  754.464370] ata4: irq_stat 0x00400040, connection status changed
Nov 22 07:04:33 selene kernel: [  754.464373] ata4: SError: { PHYRdyChg CommWake DevExch }
Nov 22 07:04:33 selene kernel: [  754.464382] ata4: hard resetting link
Nov 22 07:04:33 selene kernel: [  754.468066] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 07:04:33 selene kernel: [  754.468068] ata3: irq_stat 0x00000040, connection status changed
Nov 22 07:04:33 selene kernel: [  754.468071] ata3: SError: { PHYRdyChg CommWake DevExch }
Nov 22 07:04:33 selene kernel: [  754.468075] ata3: hard resetting link
Nov 22 07:04:35 selene kernel: [  756.360026] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:04:35 selene kernel: [  756.360468] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Nov 22 07:04:35 selene kernel: [  756.360836] ata4.00: hard resetting link
Nov 22 07:04:35 selene kernel: [  756.364526] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:04:35 selene kernel: [  756.364533] ata3: link online but device misclassified, retrying
Nov 22 07:04:35 selene kernel: [  756.364535] ata3: reset failed (errno=-11), retrying in 9 secs
Nov 22 07:04:36 selene kernel: [  756.680967] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:04:36 selene kernel: [  756.681016] ata4.01: hard resetting link
Nov 22 07:04:36 selene kernel: [  757.000950] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:04:36 selene kernel: [  757.000955] ata4.02: hard resetting link
Nov 22 07:04:36 selene kernel: [  757.328368] ata4.02: SATA link down (SStatus 0 SControl 320)
Nov 22 07:04:36 selene kernel: [  757.328443] ata4.03: hard resetting link
Nov 22 07:04:37 selene kernel: [  757.648994] ata4.03: SATA link down (SStatus 0 SControl 320)
Nov 22 07:04:37 selene kernel: [  757.649047] ata4.04: hard resetting link
Nov 22 07:04:37 selene kernel: [  757.968984] ata4.04: SATA link down (SStatus 0 SControl 320)
Nov 22 07:04:37 selene kernel: [  757.969036] ata4.05: hard resetting link
Nov 22 07:04:37 selene kernel: [  758.289096] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:04:42 selene kernel: [  763.288112] ata4.01: qc timeout (cmd 0xec)
Nov 22 07:04:42 selene kernel: [  763.288127] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x4)
Nov 22 07:04:42 selene kernel: [  763.288132] ata4.15: hard resetting link
Nov 22 07:04:43 selene kernel: [  764.468518] ata3: hard resetting link
Nov 22 07:04:44 selene kernel: [  764.780523] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:04:44 selene kernel: [  764.780858] ata4.00: hard resetting link
Nov 22 07:04:44 selene kernel: [  765.101008] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:04:44 selene kernel: [  765.101061] ata4.01: hard resetting link
Nov 22 07:04:44 selene kernel: [  765.420999] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:04:44 selene kernel: [  765.421008] ata4.05: hard resetting link
Nov 22 07:04:45 selene kernel: [  765.745006] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:04:45 selene kernel: [  766.364526] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:04:45 selene kernel: [  766.364534] ata3: link online but device misclassified, retrying
Nov 22 07:04:45 selene kernel: [  766.364537] ata3: reset failed (errno=-11), retrying in 9 secs
Nov 22 07:04:48 selene kernel: [  768.836668] ata4.01: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
Nov 22 07:04:48 selene kernel: [  768.837766] ata4.01: hard resetting link
Nov 22 07:04:51 selene kernel: [  771.836600] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:04:51 selene kernel: [  771.836615] ata4.01: failed to read SCR 2 (Emask=0x4)
Nov 22 07:04:51 selene kernel: [  771.836619] ata4.01: failed to read SCR 2 (Emask=0x40)
Nov 22 07:04:51 selene kernel: [  771.836622] ata4.01: COMRESET failed (errno=-5)
Nov 22 07:04:51 selene kernel: [  771.836626] ata4.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:04:51 selene kernel: [  771.836629] ata4.01: reset failed, giving up
Nov 22 07:04:51 selene kernel: [  771.836634] ata4.15: hard resetting link
Nov 22 07:04:52 selene kernel: [  773.073029] sd 0:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:04:52 selene kernel: [  773.073051] sd 0:1:0:0: [sdj] Write Protect is off
Nov 22 07:04:52 selene kernel: [  773.073054] sd 0:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 07:04:52 selene kernel: [  773.073091] sd 0:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:04:52 selene kernel: [  773.073171] sd 0:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:04:52 selene kernel: [  773.073191] sd 0:1:0:0: [sdj] Write Protect is off
Nov 22 07:04:52 selene kernel: [  773.073193] sd 0:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 07:04:52 selene kernel: [  773.073230] sd 0:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:04:52 selene kernel: [  773.073233]  sdj: sdj1
Nov 22 07:04:52 selene kernel: [  773.102273] sd 0:1:0:0: [sdj] Attached SCSI disk
Nov 22 07:04:52 selene kernel: [  773.328357] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:04:52 selene kernel: [  773.328751] ata4.00: hard resetting link
Nov 22 07:04:53 selene kernel: [  773.649004] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:04:53 selene kernel: [  773.836516] ata4.01: hard resetting link
Nov 22 07:04:53 selene kernel: [  774.157012] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:04:53 selene kernel: [  774.157021] ata4.02: hard resetting link
Nov 22 07:04:53 selene kernel: [  774.468515] ata3: hard resetting link
Nov 22 07:04:53 selene kernel: [  774.477006] ata4.02: SATA link down (SStatus 0 SControl 320)
Nov 22 07:04:53 selene kernel: [  774.477058] ata4.03: hard resetting link
Nov 22 07:04:54 selene kernel: [  774.797002] ata4.03: SATA link down (SStatus 0 SControl 320)
Nov 22 07:04:54 selene kernel: [  774.797052] ata4.04: hard resetting link
Nov 22 07:04:54 selene kernel: [  775.116995] ata4.04: SATA link down (SStatus 0 SControl 320)
Nov 22 07:04:54 selene kernel: [  775.117043] ata4.05: hard resetting link
Nov 22 07:04:54 selene kernel: [  775.436960] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:04:54 selene kernel: [  775.438449] ata4.01: ATA-8: ST31000340AS, SD15, max UDMA/133
Nov 22 07:04:54 selene kernel: [  775.438454] ata4.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
Nov 22 07:04:54 selene kernel: [  775.440398] ata4.01: configured for UDMA/133
Nov 22 07:04:54 selene kernel: [  775.441019] ata4: EH complete
Nov 22 07:04:54 selene kernel: [  775.441251] sd 5:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:04:54 selene kernel: [  775.441273] sd 5:1:0:0: [sdm] Write Protect is off
Nov 22 07:04:54 selene kernel: [  775.441276] sd 5:1:0:0: [sdm] Mode Sense: 00 3a 00 00
Nov 22 07:04:54 selene kernel: [  775.441313] sd 5:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:04:54 selene kernel: [  775.441392] sd 5:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:04:54 selene kernel: [  775.441412] sd 5:1:0:0: [sdm] Write Protect is off
Nov 22 07:04:54 selene kernel: [  775.441415] sd 5:1:0:0: [sdm] Mode Sense: 00 3a 00 00
Nov 22 07:04:54 selene kernel: [  775.441451] sd 5:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:04:54 selene kernel: [  775.441454]  sdm: sdm1
Nov 22 07:04:54 selene kernel: [  775.469127] sd 5:1:0:0: [sdm] Attached SCSI disk
Nov 22 07:04:55 selene kernel: [  775.816885] sd 1:1:0:0: [sdn] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:04:55 selene kernel: [  775.816902] sd 1:1:0:0: [sdn] Write Protect is off
Nov 22 07:04:55 selene kernel: [  775.816905] sd 1:1:0:0: [sdn] Mode Sense: 00 3a 00 00
Nov 22 07:04:55 selene kernel: [  775.816932] sd 1:1:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:04:55 selene kernel: [  775.817045] sd 1:1:0:0: [sdn] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:04:55 selene kernel: [  775.817061] sd 1:1:0:0: [sdn] Write Protect is off
Nov 22 07:04:55 selene kernel: [  775.817063] sd 1:1:0:0: [sdn] Mode Sense: 00 3a 00 00
Nov 22 07:04:55 selene kernel: [  775.817089] sd 1:1:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:04:55 selene kernel: [  775.817092]  sdn: sdn1
Nov 22 07:04:55 selene kernel: [  775.845659] sd 1:1:0:0: [sdn] Attached SCSI disk
Nov 22 07:04:55 selene kernel: [  776.364526] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:04:55 selene kernel: [  776.364535] ata3: link online but device misclassified, retrying
Nov 22 07:04:55 selene kernel: [  776.364538] ata3: reset failed (errno=-11), retrying in 34 secs
Nov 22 07:05:28 selene kernel: [  809.468157] ata3: limiting SATA link speed to 1.5 Gbps
Nov 22 07:05:28 selene kernel: [  809.468164] ata3: hard resetting link
Nov 22 07:05:30 selene kernel: [  811.364522] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:05:30 selene kernel: [  811.364531] ata3: link online but device misclassified, device detection might fail
Nov 22 07:05:30 selene kernel: [  811.364538] ata3: EH complete
Nov 22 07:08:08 selene kernel: [  968.627099] ata4.01: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Nov 22 07:08:08 selene kernel: [  968.627144] ata4.01: SError: { PHYRdyChg DevExch }
Nov 22 07:08:08 selene kernel: [  968.627313] ata4.01: hard resetting link
Nov 22 07:08:08 selene kernel: [  968.637576] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1990001 action 0xe frozen
Nov 22 07:08:08 selene kernel: [  968.637585] ata3: irq_stat 0x04400000, PHY RDY changed
Nov 22 07:08:08 selene kernel: [  968.637588] ata3: SError: { RecovData PHYRdyChg 10B8B Dispar LinkSeq TrStaTrns }
Nov 22 07:08:08 selene kernel: [  968.637596] ata3: hard resetting link
Nov 22 07:08:08 selene kernel: [  968.836453] ata4.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:08:08 selene kernel: [  968.836455] ata4.01: COMRESET failed (errno=-5)
Nov 22 07:08:08 selene kernel: [  968.836457] ata4.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:08:08 selene kernel: [  968.836458] ata4.01: reset failed, giving up
Nov 22 07:08:08 selene kernel: [  968.836461] ata4.15: hard resetting link
Nov 22 07:08:08 selene kernel: [  969.156541] ata4.15: SATA link down (SStatus 0 SControl 300)
Nov 22 07:08:08 selene kernel: [  969.360528] ata3: SATA link down (SStatus 0 SControl 300)
Nov 22 07:08:08 selene kernel: [  969.360541] ata3: EH complete
Nov 22 07:08:11 selene kernel: [  972.156133] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:08:11 selene kernel: [  972.156149] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:08:11 selene kernel: [  972.156152] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:08:13 selene kernel: [  974.156233] ata4.15: hard resetting link
Nov 22 07:08:13 selene kernel: [  974.476527] ata4.15: SATA link down (SStatus 0 SControl 300)
Nov 22 07:08:16 selene kernel: [  977.476523] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:08:16 selene kernel: [  977.476542] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:08:16 selene kernel: [  977.476546] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:08:16 selene kernel: [  977.476551] ata4.15: limiting SATA link speed to 1.5 Gbps
Nov 22 07:08:18 selene kernel: [  979.476515] ata4.15: hard resetting link
Nov 22 07:08:19 selene kernel: [  979.796528] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:22 selene kernel: [  982.796518] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:08:22 selene kernel: [  982.796536] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:08:22 selene kernel: [  982.796540] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:08:24 selene kernel: [  984.796517] ata4.15: hard resetting link
Nov 22 07:08:24 selene kernel: [  985.116525] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:27 selene kernel: [  988.116016] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:08:27 selene kernel: [  988.116032] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:08:27 selene kernel: [  988.116034] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:08:29 selene kernel: [  990.116015] ata4.15: hard resetting link
Nov 22 07:08:29 selene kernel: [  990.436527] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:32 selene kernel: [  993.436526] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:08:32 selene kernel: [  993.436543] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:08:32 selene kernel: [  993.436546] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:08:32 selene kernel: [  993.436549] ata4.15: failed to recover PMP after 5 tries, giving up
Nov 22 07:08:32 selene kernel: [  993.436551] ata4.15: Port Multiplier detaching
Nov 22 07:08:32 selene kernel: [  993.436555] ata4.01: disabled
Nov 22 07:08:32 selene kernel: [  993.436560] ata4.00: disabled
Nov 22 07:08:32 selene kernel: [  993.436572] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen t4
Nov 22 07:08:32 selene kernel: [  993.436574] ata4: irq_stat 0x00400000, PHY RDY changed
Nov 22 07:08:32 selene kernel: [  993.436580] ata4: hard resetting link
Nov 22 07:08:33 selene kernel: [  994.160164] ata4: SATA link down (SStatus 0 SControl 300)
Nov 22 07:08:33 selene kernel: [  994.160181] ata4: EH complete
Nov 22 07:08:33 selene kernel: [  994.160196] ata4.01: detaching (SCSI 5:1:0:0)
Nov 22 07:08:33 selene kernel: [  994.160579] sd 5:1:0:0: [sdm] Synchronizing SCSI cache
Nov 22 07:08:33 selene kernel: [  994.164349] sd 5:1:0:0: [sdm] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:08:33 selene kernel: [  994.164360] sd 5:1:0:0: [sdm] Stopping disk
Nov 22 07:08:33 selene kernel: [  994.164374] sd 5:1:0:0: [sdm] START_STOP FAILED
Nov 22 07:08:33 selene kernel: [  994.164376] sd 5:1:0:0: [sdm] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:08:39 selene kernel: [ 1000.442715] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 07:08:39 selene kernel: [ 1000.442721] ata4: irq_stat 0x00000040, connection status changed
Nov 22 07:08:39 selene kernel: [ 1000.442724] ata4: SError: { PHYRdyChg CommWake DevExch }
Nov 22 07:08:39 selene kernel: [ 1000.442732] ata4: hard resetting link
Nov 22 07:08:39 selene kernel: [ 1000.446407] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 07:08:39 selene kernel: [ 1000.446412] ata3: irq_stat 0x00400040, connection status changed
Nov 22 07:08:39 selene kernel: [ 1000.446414] ata3: SError: { PHYRdyChg CommWake DevExch }
Nov 22 07:08:39 selene kernel: [ 1000.446418] ata3: hard resetting link
Nov 22 07:08:41 selene kernel: [ 1002.340528] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 22 07:08:41 selene kernel: [ 1002.340585] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:08:41 selene kernel: [ 1002.340590] ata3: link online but device misclassified, retrying
Nov 22 07:08:41 selene kernel: [ 1002.340592] ata3: reset failed (errno=-11), retrying in 9 secs
Nov 22 07:08:41 selene kernel: [ 1002.340891] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Nov 22 07:08:41 selene kernel: [ 1002.341193] ata4.00: hard resetting link
Nov 22 07:08:42 selene kernel: [ 1002.660957] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:42 selene kernel: [ 1002.661004] ata4.01: hard resetting link
Nov 22 07:08:42 selene kernel: [ 1002.981069] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:08:42 selene kernel: [ 1002.981075] ata4.02: hard resetting link
Nov 22 07:08:42 selene kernel: [ 1003.301010] ata4.02: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:42 selene kernel: [ 1003.301060] ata4.03: hard resetting link
Nov 22 07:08:43 selene kernel: [ 1003.620966] ata4.03: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:43 selene kernel: [ 1003.621013] ata4.04: hard resetting link
Nov 22 07:08:43 selene kernel: [ 1003.941012] ata4.04: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:43 selene kernel: [ 1003.941065] ata4.05: hard resetting link
Nov 22 07:08:43 selene kernel: [ 1004.261017] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:08:43 selene kernel: [ 1004.565590] sd 0:1:0:0: [sdj] Synchronizing SCSI cache
Nov 22 07:08:43 selene kernel: [ 1004.568808] sd 0:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:08:43 selene kernel: [ 1004.568817] sd 0:1:0:0: [sdj] Stopping disk
Nov 22 07:08:43 selene kernel: [ 1004.568832] sd 0:1:0:0: [sdj] START_STOP FAILED
Nov 22 07:08:43 selene kernel: [ 1004.568834] sd 0:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:08:48 selene kernel: [ 1009.260518] ata4.01: qc timeout (cmd 0xec)
Nov 22 07:08:48 selene kernel: [ 1009.260534] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x4)
Nov 22 07:08:48 selene kernel: [ 1009.260540] ata4.15: hard resetting link
Nov 22 07:08:49 selene kernel: [ 1010.444524] ata3: hard resetting link
Nov 22 07:08:50 selene kernel: [ 1010.752528] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:08:50 selene kernel: [ 1010.752884] ata4.00: hard resetting link
Nov 22 07:08:50 selene kernel: [ 1011.073022] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:50 selene kernel: [ 1011.073071] ata4.01: hard resetting link
Nov 22 07:08:50 selene kernel: [ 1011.392956] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:08:50 selene kernel: [ 1011.392965] ata4.05: hard resetting link
Nov 22 07:08:51 selene kernel: [ 1011.712955] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Nov 22 07:08:51 selene kernel: [ 1012.348525] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:08:51 selene kernel: [ 1012.348534] ata3: link online but device misclassified, retrying
Nov 22 07:08:51 selene kernel: [ 1012.348537] ata3: reset failed (errno=-11), retrying in 9 secs
Nov 22 07:08:54 selene kernel: [ 1014.829116] ata4.01: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
Nov 22 07:08:54 selene kernel: [ 1014.830187] ata4.01: hard resetting link
Nov 22 07:08:57 selene kernel: [ 1017.828519] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:08:57 selene kernel: [ 1017.828534] ata4.01: failed to read SCR 2 (Emask=0x4)
Nov 22 07:08:57 selene kernel: [ 1017.828538] ata4.01: failed to read SCR 2 (Emask=0x40)
Nov 22 07:08:57 selene kernel: [ 1017.828541] ata4.01: COMRESET failed (errno=-5)
Nov 22 07:08:57 selene kernel: [ 1017.828545] ata4.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:08:57 selene kernel: [ 1017.828548] ata4.01: reset failed, giving up
Nov 22 07:08:57 selene kernel: [ 1017.828553] ata4.15: hard resetting link
Nov 22 07:08:58 selene kernel: [ 1019.320523] ata4.15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 22 07:08:58 selene kernel: [ 1019.320894] ata4.00: hard resetting link
Nov 22 07:08:59 selene kernel: [ 1019.641025] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:59 selene kernel: [ 1019.828514] ata4.01: hard resetting link
Nov 22 07:08:59 selene kernel: [ 1020.148964] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:08:59 selene kernel: [ 1020.148972] ata4.02: hard resetting link
Nov 22 07:08:59 selene kernel: [ 1020.444529] ata3: hard resetting link
Nov 22 07:08:59 selene kernel: [ 1020.468964] ata4.02: SATA link down (SStatus 0 SControl 310)
Nov 22 07:08:59 selene kernel: [ 1020.469013] ata4.03: hard resetting link
Nov 22 07:09:00 selene kernel: [ 1020.788998] ata4.03: SATA link down (SStatus 0 SControl 310)
Nov 22 07:09:00 selene kernel: [ 1020.789050] ata4.04: hard resetting link
Nov 22 07:09:00 selene kernel: [ 1021.108595] ata4.04: SATA link down (SStatus 0 SControl 310)
Nov 22 07:09:00 selene kernel: [ 1021.108646] ata4.05: hard resetting link
Nov 22 07:09:00 selene kernel: [ 1021.429010] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:09:00 selene kernel: [ 1021.430499] ata4.01: ATA-8: ST31000340AS, SD15, max UDMA/133
Nov 22 07:09:00 selene kernel: [ 1021.430504] ata4.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
Nov 22 07:09:00 selene kernel: [ 1021.432445] ata4.01: configured for UDMA/133
Nov 22 07:09:00 selene kernel: [ 1021.432988] ata4: EH complete
Nov 22 07:09:00 selene kernel: [ 1021.434110] sd 5:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:09:00 selene kernel: [ 1021.434137] sd 5:1:0:0: [sdj] Write Protect is off
Nov 22 07:09:00 selene kernel: [ 1021.434139] sd 5:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 07:09:00 selene kernel: [ 1021.434172] sd 5:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:09:00 selene kernel: [ 1021.434260] sd 5:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:09:00 selene kernel: [ 1021.434279] sd 5:1:0:0: [sdj] Write Protect is off
Nov 22 07:09:00 selene kernel: [ 1021.434281] sd 5:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 07:09:00 selene kernel: [ 1021.434313] sd 5:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:09:00 selene kernel: [ 1021.434316]  sdj: sdj1
Nov 22 07:09:00 selene kernel: [ 1021.461616] sd 5:1:0:0: [sdj] Attached SCSI disk
Nov 22 07:09:00 selene kernel: [ 1021.549438] sd 1:1:0:0: [sdn] Synchronizing SCSI cache
Nov 22 07:09:00 selene kernel: [ 1021.551432] sd 1:1:0:0: [sdn] Stopping disk
Nov 22 07:09:00 selene kernel: [ 1021.552344] sd 1:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:09:00 selene kernel: [ 1021.552371] sd 1:1:0:0: [sdm] Write Protect is off
Nov 22 07:09:00 selene kernel: [ 1021.552374] sd 1:1:0:0: [sdm] Mode Sense: 00 3a 00 00
Nov 22 07:09:00 selene kernel: [ 1021.552413] sd 1:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:09:00 selene kernel: [ 1021.552493] sd 1:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:09:00 selene kernel: [ 1021.552536] sd 1:1:0:0: [sdm] Write Protect is off
Nov 22 07:09:00 selene kernel: [ 1021.552539] sd 1:1:0:0: [sdm] Mode Sense: 00 3a 00 00
Nov 22 07:09:00 selene kernel: [ 1021.552577] sd 1:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:09:01 selene kernel: [ 1021.552581]  sdm:<6>ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:09:01 selene kernel: [ 1022.340533] ata3: link online but device misclassified, retrying
Nov 22 07:09:01 selene kernel: [ 1022.340536] ata3: reset failed (errno=-11), retrying in 34 secs
Nov 22 07:09:02 selene kernel: [ 1023.384882]  sdm1
Nov 22 07:09:02 selene kernel: [ 1023.385014] sd 1:1:0:0: [sdm] Attached SCSI disk
Nov 22 07:09:34 selene kernel: [ 1055.444515] ata3: limiting SATA link speed to 1.5 Gbps
Nov 22 07:09:34 selene kernel: [ 1055.444522] ata3: hard resetting link
Nov 22 07:09:36 selene kernel: [ 1057.340525] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:09:36 selene kernel: [ 1057.340533] ata3: link online but device misclassified, device detection might fail
Nov 22 07:09:36 selene kernel: [ 1057.340539] ata3: EH complete
Nov 22 07:10:26 selene kernel: [ 1107.565495] ata4.01: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Nov 22 07:10:26 selene kernel: [ 1107.565505] ata4.01: SError: { PHYRdyChg DevExch }
Nov 22 07:10:26 selene kernel: [ 1107.565688] ata4.01: hard resetting link
Nov 22 07:10:26 selene kernel: [ 1107.573114] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1990001 action 0xe frozen
Nov 22 07:10:26 selene kernel: [ 1107.573124] ata3: irq_stat 0x04400000, PHY RDY changed
Nov 22 07:10:26 selene kernel: [ 1107.573127] ata3: SError: { RecovData PHYRdyChg 10B8B Dispar LinkSeq TrStaTrns }
Nov 22 07:10:26 selene kernel: [ 1107.573134] ata3: hard resetting link
Nov 22 07:10:27 selene kernel: [ 1107.780520] ata4.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:10:27 selene kernel: [ 1107.780524] ata4.01: COMRESET failed (errno=-5)
Nov 22 07:10:27 selene kernel: [ 1107.780526] ata4.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:10:27 selene kernel: [ 1107.780529] ata4.01: reset failed, giving up
Nov 22 07:10:27 selene kernel: [ 1107.780533] ata4.15: hard resetting link
Nov 22 07:10:27 selene kernel: [ 1108.100528] ata4.15: SATA link down (SStatus 0 SControl 300)
Nov 22 07:10:27 selene kernel: [ 1108.300538] ata3: SATA link down (SStatus 0 SControl 300)
Nov 22 07:10:27 selene kernel: [ 1108.300551] ata3: EH complete
Nov 22 07:10:30 selene kernel: [ 1111.100523] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:10:30 selene kernel: [ 1111.100542] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:10:30 selene kernel: [ 1111.100545] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:10:32 selene kernel: [ 1113.100548] ata4.15: hard resetting link
Nov 22 07:10:32 selene kernel: [ 1113.420531] ata4.15: SATA link down (SStatus 0 SControl 300)
Nov 22 07:10:35 selene kernel: [ 1116.420033] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:10:35 selene kernel: [ 1116.420051] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:10:35 selene kernel: [ 1116.420054] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:10:35 selene kernel: [ 1116.420058] ata4.15: limiting SATA link speed to 1.5 Gbps
Nov 22 07:10:37 selene kernel: [ 1118.420516] ata4.15: hard resetting link
Nov 22 07:10:38 selene kernel: [ 1118.740030] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:10:41 selene kernel: [ 1121.740515] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:10:41 selene kernel: [ 1121.740532] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:10:41 selene kernel: [ 1121.740535] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:10:43 selene kernel: [ 1123.740516] ata4.15: hard resetting link
Nov 22 07:10:43 selene kernel: [ 1124.060526] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:10:46 selene kernel: [ 1127.060515] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:10:46 selene kernel: [ 1127.060531] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:10:46 selene kernel: [ 1127.060534] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:10:48 selene kernel: [ 1129.060514] ata4.15: hard resetting link
Nov 22 07:10:48 selene kernel: [ 1129.380566] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:10:51 selene kernel: [ 1132.380556] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:10:51 selene kernel: [ 1132.380571] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:10:51 selene kernel: [ 1132.380574] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:10:51 selene kernel: [ 1132.380576] ata4.15: failed to recover PMP after 5 tries, giving up
Nov 22 07:10:51 selene kernel: [ 1132.380578] ata4.15: Port Multiplier detaching
Nov 22 07:10:51 selene kernel: [ 1132.380582] ata4.01: disabled
Nov 22 07:10:51 selene kernel: [ 1132.380586] ata4.00: disabled
Nov 22 07:10:51 selene kernel: [ 1132.380594] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen t4
Nov 22 07:10:51 selene kernel: [ 1132.380596] ata4: irq_stat 0x00400000, PHY RDY changed
Nov 22 07:10:51 selene kernel: [ 1132.380601] ata4: hard resetting link
Nov 22 07:10:52 selene kernel: [ 1133.104527] ata4: SATA link down (SStatus 0 SControl 300)
Nov 22 07:10:52 selene kernel: [ 1133.104543] ata4: EH complete
Nov 22 07:10:52 selene kernel: [ 1133.104557] ata4.01: detaching (SCSI 5:1:0:0)
Nov 22 07:10:52 selene kernel: [ 1133.104910] sd 5:1:0:0: [sdj] Synchronizing SCSI cache
Nov 22 07:10:52 selene kernel: [ 1133.108553] sd 5:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:10:52 selene kernel: [ 1133.108559] sd 5:1:0:0: [sdj] Stopping disk
Nov 22 07:10:52 selene kernel: [ 1133.110747] sd 5:1:0:0: [sdj] START_STOP FAILED
Nov 22 07:10:52 selene kernel: [ 1133.110753] sd 5:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:11:02 selene kernel: [ 1143.260916] sd 1:1:0:0: [sdm] Synchronizing SCSI cache
Nov 22 07:11:02 selene kernel: [ 1143.261213] sd 1:1:0:0: [sdm] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:11:02 selene kernel: [ 1143.261220] sd 1:1:0:0: [sdm] Stopping disk
Nov 22 07:11:02 selene kernel: [ 1143.261330] sd 1:1:0:0: [sdm] START_STOP FAILED
Nov 22 07:11:02 selene kernel: [ 1143.261335] sd 1:1:0:0: [sdm] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:11:16 selene kernel: [ 1157.059760] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 07:11:16 selene kernel: [ 1157.059766] ata4: irq_stat 0x00400040, connection status changed
Nov 22 07:11:16 selene kernel: [ 1157.059770] ata4: SError: { PHYRdyChg CommWake DevExch }
Nov 22 07:11:16 selene kernel: [ 1157.059776] ata4: hard resetting link
Nov 22 07:11:16 selene kernel: [ 1157.063394] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
Nov 22 07:11:16 selene kernel: [ 1157.063398] ata3: irq_stat 0x00400040, connection status changed
Nov 22 07:11:16 selene kernel: [ 1157.063401] ata3: SError: { PHYRdyChg CommWake DevExch }
Nov 22 07:11:16 selene kernel: [ 1157.063405] ata3: hard resetting link
Nov 22 07:11:18 selene kernel: [ 1158.956528] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:11:18 selene kernel: [ 1158.956538] ata3: link online but device misclassified, retrying
Nov 22 07:11:18 selene kernel: [ 1158.956540] ata3: reset failed (errno=-11), retrying in 9 secs
Nov 22 07:11:18 selene kernel: [ 1158.956758] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 22 07:11:18 selene kernel: [ 1158.957209] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Nov 22 07:11:18 selene kernel: [ 1158.957620] ata4.00: hard resetting link
Nov 22 07:11:18 selene kernel: [ 1159.276967] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:11:18 selene kernel: [ 1159.277120] ata4.01: hard resetting link
Nov 22 07:11:19 selene kernel: [ 1159.596515] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:11:19 selene kernel: [ 1159.596522] ata4.02: hard resetting link
Nov 22 07:11:19 selene kernel: [ 1159.917018] ata4.02: SATA link down (SStatus 0 SControl 310)
Nov 22 07:11:19 selene kernel: [ 1159.917123] ata4.03: hard resetting link
Nov 22 07:11:19 selene kernel: [ 1160.236569] ata4.03: SATA link down (SStatus 0 SControl 310)
Nov 22 07:11:19 selene kernel: [ 1160.236672] ata4.04: hard resetting link
Nov 22 07:11:19 selene kernel: [ 1160.557020] ata4.04: SATA link down (SStatus 0 SControl 310)
Nov 22 07:11:19 selene kernel: [ 1160.557187] ata4.05: hard resetting link
Nov 22 07:11:20 selene kernel: [ 1160.877006] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:11:25 selene kernel: [ 1165.876519] ata4.01: qc timeout (cmd 0xec)
Nov 22 07:11:25 selene kernel: [ 1165.876533] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x4)
Nov 22 07:11:25 selene kernel: [ 1165.876538] ata4.15: hard resetting link
Nov 22 07:11:26 selene kernel: [ 1167.060514] ata3: hard resetting link
Nov 22 07:11:26 selene kernel: [ 1167.368530] ata4.15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 22 07:11:26 selene kernel: [ 1167.369080] ata4.00: hard resetting link
Nov 22 07:11:27 selene kernel: [ 1167.689003] ata4.00: SATA link down (SStatus 0 SControl 310)
Nov 22 07:11:27 selene kernel: [ 1167.689167] ata4.01: hard resetting link
Nov 22 07:11:27 selene kernel: [ 1168.009002] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:11:27 selene kernel: [ 1168.009012] ata4.05: hard resetting link
Nov 22 07:11:27 selene kernel: [ 1168.328971] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:11:28 selene kernel: [ 1168.956524] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:11:28 selene kernel: [ 1168.956533] ata3: link online but device misclassified, retrying
Nov 22 07:11:28 selene kernel: [ 1168.956536] ata3: reset failed (errno=-11), retrying in 9 secs
Nov 22 07:11:30 selene kernel: [ 1171.453122] ata4.01: ATA-8: ST31000340AS, SD15, max UDMA/133
Nov 22 07:11:30 selene kernel: [ 1171.453129] ata4.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
Nov 22 07:11:30 selene kernel: [ 1171.455030] ata4.01: configured for UDMA/133
Nov 22 07:11:30 selene kernel: [ 1171.455651] ata4: EH complete
Nov 22 07:11:30 selene kernel: [ 1171.456002] sd 5:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:11:30 selene kernel: [ 1171.456085] sd 5:1:0:0: [sdj] Write Protect is off
Nov 22 07:11:30 selene kernel: [ 1171.456090] sd 5:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 07:11:30 selene kernel: [ 1171.456224] sd 5:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:11:30 selene kernel: [ 1171.456401] sd 5:1:0:0: [sdj] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:11:30 selene kernel: [ 1171.456481] sd 5:1:0:0: [sdj] Write Protect is off
Nov 22 07:11:30 selene kernel: [ 1171.456487] sd 5:1:0:0: [sdj] Mode Sense: 00 3a 00 00
Nov 22 07:11:30 selene kernel: [ 1171.456628] sd 5:1:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:11:30 selene kernel: [ 1171.456636]  sdj: sdj1
Nov 22 07:11:30 selene kernel: [ 1171.525631] sd 5:1:0:0: [sdj] Attached SCSI disk
Nov 22 07:11:36 selene kernel: [ 1177.060514] ata3: hard resetting link
Nov 22 07:11:37 selene kernel: [ 1177.836866] sd 1:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:11:37 selene kernel: [ 1177.836953] sd 1:1:0:0: [sdm] Write Protect is off
Nov 22 07:11:37 selene kernel: [ 1177.836958] sd 1:1:0:0: [sdm] Mode Sense: 00 3a 00 00
Nov 22 07:11:37 selene kernel: [ 1177.837128] sd 1:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:11:37 selene kernel: [ 1177.837277] sd 1:1:0:0: [sdm] 1953525168 512-byte hardware sectors (1000205 MB)
Nov 22 07:11:37 selene kernel: [ 1177.837364] sd 1:1:0:0: [sdm] Write Protect is off
Nov 22 07:11:37 selene kernel: [ 1177.837369] sd 1:1:0:0: [sdm] Mode Sense: 00 3a 00 00
Nov 22 07:11:37 selene kernel: [ 1177.837501] sd 1:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 22 07:11:37 selene kernel: [ 1177.837510]  sdm: sdm1
Nov 22 07:11:37 selene kernel: [ 1177.860144] sd 1:1:0:0: [sdm] Attached SCSI disk
Nov 22 07:11:38 selene kernel: [ 1178.956528] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 22 07:11:38 selene kernel: [ 1178.956537] ata3: link online but device misclassified, retrying
Nov 22 07:11:38 selene kernel: [ 1178.956540] ata3: reset failed (errno=-11), retrying in 34 secs
Nov 22 07:12:11 selene kernel: [ 1212.060516] ata3: limiting SATA link speed to 1.5 Gbps
Nov 22 07:12:11 selene kernel: [ 1212.060524] ata3: hard resetting link
Nov 22 07:12:13 selene kernel: [ 1213.956524] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov 22 07:12:13 selene kernel: [ 1213.956534] ata3: link online but device misclassified, device detection might fail
Nov 22 07:12:13 selene kernel: [ 1213.956540] ata3: EH complete
Nov 22 07:14:58 selene kernel: [ 1379.388365] ata4.01: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Nov 22 07:14:58 selene kernel: [ 1379.388371] ata4.01: SError: { PHYRdyChg DevExch }
Nov 22 07:14:58 selene kernel: [ 1379.388637] ata4.01: hard resetting link
Nov 22 07:14:58 selene kernel: [ 1379.399867] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1990001 action 0xe frozen
Nov 22 07:14:58 selene kernel: [ 1379.399869] ata3: irq_stat 0x04400000, PHY RDY changed
Nov 22 07:14:58 selene kernel: [ 1379.399872] ata3: SError: { RecovData PHYRdyChg 10B8B Dispar LinkSeq TrStaTrns }
Nov 22 07:14:58 selene kernel: [ 1379.399878] ata3: hard resetting link
Nov 22 07:14:58 selene kernel: [ 1379.403579] ata4.01: failed to read SCR 2 (Emask=0x40)
Nov 22 07:14:58 selene kernel: [ 1379.403584] ata4.01: COMRESET failed (errno=-5)
Nov 22 07:14:58 selene kernel: [ 1379.403586] ata4.01: failed to read SCR 0 (Emask=0x40)
Nov 22 07:14:58 selene kernel: [ 1379.403589] ata4.01: reset failed, giving up
Nov 22 07:14:58 selene kernel: [ 1379.403593] ata4.15: hard resetting link
Nov 22 07:14:59 selene kernel: [ 1379.720527] ata4.15: SATA link down (SStatus 0 SControl 300)
Nov 22 07:14:59 selene kernel: [ 1380.120033] ata3: SATA link down (SStatus 0 SControl 300)
Nov 22 07:14:59 selene kernel: [ 1380.120045] ata3: EH complete
Nov 22 07:15:02 selene kernel: [ 1382.720358] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:15:02 selene kernel: [ 1382.720374] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:15:02 selene kernel: [ 1382.720377] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:15:04 selene kernel: [ 1384.720515] ata4.15: hard resetting link
Nov 22 07:15:04 selene kernel: [ 1385.040528] ata4.15: SATA link down (SStatus 0 SControl 300)
Nov 22 07:15:07 selene kernel: [ 1388.040049] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:15:07 selene kernel: [ 1388.040066] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:15:07 selene kernel: [ 1388.040069] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:15:07 selene kernel: [ 1388.040073] ata4.15: limiting SATA link speed to 1.5 Gbps
Nov 22 07:15:09 selene kernel: [ 1390.040517] ata4.15: hard resetting link
Nov 22 07:15:09 selene kernel: [ 1390.360527] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:15:12 selene kernel: [ 1393.360517] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:15:12 selene kernel: [ 1393.360534] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:15:12 selene kernel: [ 1393.360537] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:15:14 selene kernel: [ 1395.360516] ata4.15: hard resetting link
Nov 22 07:15:15 selene kernel: [ 1395.684572] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:15:18 selene kernel: [ 1398.684521] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:15:18 selene kernel: [ 1398.684537] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:15:18 selene kernel: [ 1398.684540] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:15:20 selene kernel: [ 1400.684520] ata4.15: hard resetting link
Nov 22 07:15:20 selene kernel: [ 1401.004527] ata4.15: SATA link down (SStatus 0 SControl 310)
Nov 22 07:15:23 selene kernel: [ 1404.004518] ata4.15: qc timeout (cmd 0xe4)
Nov 22 07:15:23 selene kernel: [ 1404.004535] ata4.15: failed to read PMP GSCR[0] (Emask=0x4)
Nov 22 07:15:23 selene kernel: [ 1404.004537] ata4.15: PMP revalidation failed (errno=-5)
Nov 22 07:15:23 selene kernel: [ 1404.004540] ata4.15: failed to recover PMP after 5 tries, giving up
Nov 22 07:15:23 selene kernel: [ 1404.004542] ata4.15: Port Multiplier detaching
Nov 22 07:15:23 selene kernel: [ 1404.004546] ata4.01: disabled
Nov 22 07:15:23 selene kernel: [ 1404.004550] ata4.00: disabled
Nov 22 07:15:23 selene kernel: [ 1404.004560] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen t4
Nov 22 07:15:23 selene kernel: [ 1404.004563] ata4: irq_stat 0x00400000, PHY RDY changed
Nov 22 07:15:23 selene kernel: [ 1404.004568] ata4: hard resetting link
Nov 22 07:15:24 selene kernel: [ 1404.728532] ata4: SATA link down (SStatus 0 SControl 300)
Nov 22 07:15:24 selene kernel: [ 1404.728549] ata4: EH complete
Nov 22 07:15:24 selene kernel: [ 1404.728568] ata4.01: detaching (SCSI 5:1:0:0)
Nov 22 07:15:24 selene kernel: [ 1404.731605] sd 5:1:0:0: [sdj] Synchronizing SCSI cache
Nov 22 07:15:24 selene kernel: [ 1404.733338] sd 5:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:15:24 selene kernel: [ 1404.733350] sd 5:1:0:0: [sdj] Stopping disk
Nov 22 07:15:24 selene kernel: [ 1404.733519] sd 5:1:0:0: [sdj] START_STOP FAILED
Nov 22 07:15:24 selene kernel: [ 1404.733526] sd 5:1:0:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:15:34 selene kernel: [ 1415.086522] sd 1:1:0:0: [sdm] Synchronizing SCSI cache
Nov 22 07:15:34 selene kernel: [ 1415.086586] sd 1:1:0:0: [sdm] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Nov 22 07:15:34 selene kernel: [ 1415.086590] sd 1:1:0:0: [sdm] Stopping disk
Nov 22 07:15:34 selene kernel: [ 1415.086603] sd 1:1:0:0: [sdm] START_STOP FAILED
Nov 22 07:15:34 selene kernel: [ 1415.086605] sd 1:1:0:0: [sdm] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

--------------010607060108070100020903--
