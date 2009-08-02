From: "Benjamin S." <sbenni@gmx.de>
Subject: Re: ahci sometimes fails to suspend controller
Date: Sun, 2 Aug 2009 19:08:38 +0200
Message-ID: <20090802190838.4a8bd3b8@pluto-lenny.milky.way>
References: <20090719220423.54e8c75d@uranus>
	<4A683755.60909@kernel.org>
	<20090727140612.27d176ca@pluto-lenny.milky.way>
	<4A6E6774.6030909@kernel.org>
	<C8E4BD7D001E44499280E0884BD9DB30D7CFD4@sshaexmb1.amd.com>
	<20090728061033.56394c6e@pluto-lenny.milky.way>
	<C8E4BD7D001E44499280E0884BD9DB30D7D051@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753129AbZHBRFw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Aug 2009 13:05:52 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30D7D051@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>


Hello Shane,

On Tue, 28 Jul 2009 13:04:53 +0800
"Huang, Shane" <Shane.Huang@amd.com> wrote:
> 
> > -----Original Message-----
> > From: Benjamin S. [mailto:sbenni@gmx.de] 
> > 
> > On Tue, 28 Jul 2009 11:06:01 +0800
> > "Huang, Shane" <Shane.Huang@amd.com> wrote:
> > 
> > > Can you send me the whole output of lspci?
> > 
> > Sure.
> 
> OK, I see. Your revision do need the SATA MSI quirk.

Tejun wanted me to boot with pci=nomsi about 1.5 weeks ago. The system
was running till yesterday with many suspends and resumes in between. 
Yesterday the system showed the first error:


[260353.116321] rtc rtc0: legacy class resume
[260353.116362] usb usb1: type resume
[260353.132043] r8169: eth0: link up
[260353.196041] usb usb2: type resume
[260353.220057] ata2: SATA link down (SStatus 0 SControl 300)
[260353.220123] ata4: SATA link down (SStatus 0 SControl 300)
[260353.220183] ata1: SATA link down (SStatus 0 SControl 300)
[260353.248034] sd 2:0:0:0: legacy resume
[260353.248038] sd 2:0:0:0: [sda] Starting disk
[260358.264018] ata3: link is slow to respond, please be patient (ready=0)
[260360.056034] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[260360.064939] ata3.00: configured for UDMA/133
[260360.083650] usb 1-3: type resume
[260360.086304] ide-cdrom 0.1: legacy resume
[260360.089322] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[260360.090134] hdb: UDMA/33 mode selected
...............
[260360.247321] PM: Finishing wakeup.
[260360.247323] Restarting tasks ... <3>ata3.00: exception Emask 0x50 SAct 0xff SErr 0x400800 action 0x6 frozen
[260360.267694] ata3.00: irq_stat 0x08000000, interface fatal error
[260360.267734] ata3: SError: { HostInt Handshk }
[260360.267776] ata3.00: cmd 61/08:00:03:b0:6c/00:00:03:00:00/40 tag 0 ncq 4096 out
[260360.267777]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.267859] ata3.00: status: { DRDY }
[260360.267899] ata3.00: cmd 61/08:08:4b:27:6c/00:00:03:00:00/40 tag 1 ncq 4096 out
[260360.267901]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.267982] ata3.00: status: { DRDY }
[260360.268054] ata3.00: cmd 61/10:10:2b:28:6c/00:00:03:00:00/40 tag 2 ncq 8192 out
[260360.268055]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.268137] ata3.00: status: { DRDY }
[260360.268176] ata3.00: cmd 61/08:18:83:29:6c/00:00:03:00:00/40 tag 3 ncq 4096 out
[260360.268178]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.268259] ata3.00: status: { DRDY }
[260360.268299] ata3.00: cmd 61/08:20:bb:39:6c/00:00:03:00:00/40 tag 4 ncq 4096 out
[260360.268301]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.268430] ata3.00: status: { DRDY }
[260360.268471] ata3.00: cmd 61/08:28:eb:3a:6c/00:00:03:00:00/40 tag 5 ncq 4096 out
[260360.268472]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.268556] ata3.00: status: { DRDY }
[260360.268597] ata3.00: cmd 61/10:30:b3:ae:6c/00:00:03:00:00/40 tag 6 ncq 8192 out
[260360.268598]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.268678] ata3.00: status: { DRDY }
[260360.268718] ata3.00: cmd 61/08:38:d3:af:6c/00:00:03:00:00/40 tag 7 ncq 4096 out
[260360.268720]          res 40/00:3c:d3:af:6c/00:00:03:00:00/40 Emask 0x50 (ATA bus error)
[260360.268800] ata3.00: status: { DRDY }
[260360.268839] ata3: hard resetting link
[260360.356302] done.
[260360.584137] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[260360.587431] ata3.00: configured for UDMA/133
[260360.587498] ata3: EH complete






Despite this error the system resumed and was able to suspend and resume 
another three times. Then the system showed the same errors I have seen 
without pci=nomsi:



[299202.632031] ohci_hcd 0000:00:12.1: suspend
[299202.632038] ohci_hcd 0000:00:12.1: PCI INT A disabled
[299202.632099] ohci_hcd 0000:00:12.0: suspend
[299202.632106] ohci_hcd 0000:00:12.0: PCI INT A disabled
[299202.632167] ahci 0000:00:11.0: suspend
[299203.016052] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[299208.016032] ata3.00: qc timeout (cmd 0xec)
[299208.016078] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[299208.016116] ata3.00: revalidation failed (errno=-5)
[299208.336049] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[299218.336032] ata3.00: qc timeout (cmd 0xec)
[299218.336076] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[299218.336114] ata3.00: revalidation failed (errno=-5)
[299218.336153] ata3: limiting SATA link speed to 1.5 Gbps
[299218.656050] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[299248.656030] ata3.00: qc timeout (cmd 0xec)
[299248.656074] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[299248.656112] ata3.00: revalidation failed (errno=-5)
[299248.656149] ata3.00: disabled
[299248.656264] ahci 0000:00:11.0: PCI INT A disabled
[299248.656302] pcieport-driver 0000:00:0a.0: suspend
[299248.656306] pci 0000:00:01.0: suspend
[299248.656309] pci 0000:00:00.0: suspend
.....................
[299248.657045] ehci_hcd 0000:00:12.2: LATE suspend
[299248.657047] ohci_hcd 0000:00:12.1: LATE suspend
[299248.657049] ohci_hcd 0000:00:12.0: LATE suspend
[299248.657052] ahci 0000:00:11.0: LATE suspend
[299248.657054] pcieport-driver 0000:00:0a.0: LATE suspend
[299248.657080] pci 0000:00:01.0: LATE suspend
[299248.657095] pci 0000:00:00.0: LATE suspend
[299248.657226] ACPI: Preparing to enter system sleep state S3
[299248.657654] Disabling non-boot CPUs ...
[299248.660214] kvm: disabling virtualization on CPU1
[299248.660269] CPU 1 is now offline
[299248.660349] SMP alternatives: switching to UP code
[299248.665159] CPU0 attaching NULL sched-domain.
[299248.665162] CPU1 attaching NULL sched-domain.
[299248.665244] CPU0 attaching NULL sched-domain.
[299248.665463] CPU1 is down
[299248.665508] Back to C!
[299248.665508] PCI-DMA: Resuming GART IOMMU
[299248.665508] PCI-DMA: Restoring GART aperture settings
[299248.665508] Enabling non-boot CPUs ...
[299248.666667] SMP alternatives: switching to SMP code
[299248.671158] Booting processor 1 APIC 0x1 ip 0x6000
[299248.664976] Initializing CPU#1
[299248.664976] Calibrating delay using timer specific routine.. 5010.89 BogoMIPS (lpj=10021787)
[299248.664976] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[299248.664976] CPU: L2 Cache: 512K (64 bytes/line)
[299248.664976] CPU 1/0x1 -> Node 0
[299248.664976] CPU: Physical Processor ID: 0
[299248.664976] CPU: Processor Core ID: 1
[299248.760137] CPU1: AMD Athlon(tm) Dual Core Processor 4850e stepping 02
[299248.760482] kvm: enabling virtualization on CPU1
[299248.760584] CPU0 attaching NULL sched-domain.
[299248.764521] Switched to high resolution mode on CPU 1
[299248.776103] CPU0 attaching sched-domain:
[299248.776107]  domain 0: span 0-1 level CPU
[299248.776110]   groups: 0 1
[299248.776114] CPU1 attaching sched-domain:
[299248.776117]  domain 0: span 0-1 level CPU
[299248.776119]   groups: 1 0
[299248.776516] CPU1 is up
[299248.776554] ACPI: Waking up from system sleep state S3
[299248.776843] pci 0000:00:00.0: EARLY resume
[299248.776860] pci 0000:00:00.0: restoring config space at offset 0x3 (was 0x0, writing 0x2000)
[299248.776871] pci 0000:00:01.0: EARLY resume
.................................
[299249.024313] rtc rtc0: legacy class resume
[299249.024354] usb usb1: type resume
[299249.040043] r8169: eth0: link up
[299249.104043] usb usb2: type resume
[299249.128051] ata2: SATA link down (SStatus 0 SControl 300)
[299249.128117] ata4: SATA link down (SStatus 0 SControl 300)
[299249.128183] ata1: SATA link down (SStatus 0 SControl 300)
[299249.156033] sd 2:0:0:0: legacy resume
[299249.156037] sd 2:0:0:0: [sda] Starting disk
[299254.172018] ata3: link is slow to respond, please be patient (ready=0)
[299255.964034] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[299255.980044] sd 2:0:0:0: [sda] START_STOP FAILED
[299255.980081] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299255.980155] PM: Device 2:0:0:0 failed to resume: error 262144
[299255.980198] usb 1-3: type resume
[299255.983305] ide-cdrom 0.1: legacy resume
[299255.986180] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[299255.986992] hdb: UDMA/33 mode selected
[299255.987469] usb usb3: type resume
[299256.064043] usb usb4: type resume
.........................
[299256.143282] pci 0000:00:00.0: completing resume
[299256.143316] PM: Finishing wakeup.
[299256.143317] Restarting tasks ... <6>sd 2:0:0:0: [sda] Unhandled error code
[299256.150609] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.150682] end_request: I/O error, dev sda, sector 57464531
[299256.150720] Buffer I/O error on device sda7, logical block 202816
[299256.150757] lost page write due to I/O error on sda7
[299256.150795] Buffer I/O error on device sda7, logical block 202817
[299256.150832] lost page write due to I/O error on sda7
[299256.150882] sd 2:0:0:0: [sda] Unhandled error code
[299256.150918] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.150988] end_request: I/O error, dev sda, sector 57464627
[299256.151026] Buffer I/O error on device sda7, logical block 202828
[299256.151062] lost page write due to I/O error on sda7
[299256.151099] Buffer I/O error on device sda7, logical block 202829
[299256.151136] lost page write due to I/O error on sda7
[299256.151175] sd 2:0:0:0: [sda] Unhandled error code
[299256.151211] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.151281] end_request: I/O error, dev sda, sector 57529531
[299256.151318] Buffer I/O error on device sda7, logical block 210941
[299256.151354] lost page write due to I/O error on sda7
[299256.151392] Buffer I/O error on device sda7, logical block 210942
[299256.151428] lost page write due to I/O error on sda7
[299256.151467] sd 2:0:0:0: [sda] Unhandled error code
[299256.151503] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[299256.151574] end_request: I/O error, dev sda, sector 57530859
[299256.151610] Buffer I/O error on device sda7, logical block 211107
[299256.151647] lost page write due to I/O error on sda7



Does that mean the SATA MSI quirk won't solve my problem?



Regards, Benjamin















