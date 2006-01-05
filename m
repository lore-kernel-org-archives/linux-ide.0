From: Roman Gischig <Roman@Gischig.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Thu, 5 Jan 2006 20:29:21 +0000 (UTC)
Message-ID: <loom.20060105T211008-914@post.gmane.org>
References: <20060103164319.GA402@havoc.gtf.org> <43BC3186.8060103@projecthugo.co.uk> <43BD6918.6000601@physics.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52179 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932225AbWAEVV3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jan 2006 16:21:29 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EucXi-0001sI-RJ
	for linux-ide@vger.kernel.org; Thu, 05 Jan 2006 22:21:06 +0100
Received: from 84-73-58-247.dclient.hispeed.ch ([84.73.58.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 05 Jan 2006 22:21:06 +0100
Received: from Roman by 84-73-58-247.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 05 Jan 2006 22:21:06 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I can only confirm waht you guys are taling about!

I have a dual Opteron with a HighPoint 1820 PCI-X controller.

I have 7 disks attached to the controller:
scsi7 : sata_mv
  Vendor: ATA       Model: Maxtor 6L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3300831AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: HDS725050KLA360   Rev: K2AO
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: v    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05

History...

A) copying from only one disk to an other (200GB, mostly big files) works quite 
well. When doing a 2nd copy from an other disk onto the same disk, one of the 
source disks failed.

The system still works, no crash, as the / is on a different drive :-)


Jan  5 19:29:28 twin ata5: Entering mv_eng_timeout
Jan  5 19:29:28 twin mmio_base ffffc20000080000 ap ffff810002d12488 qc 
ffff810002d129c8 scsi_cmnd ffff8100b31b72c0 &cmnd ffff8100b31b7330
Jan  5 19:29:29 twin ata5: status=0x50 { DriveReady SeekComplete }
Jan  5 19:29:29 twin ata5: error=0x01 { AddrMarkNotFound }
Jan  5 19:29:30 twin Assertion failed! qc->flags & 
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3513
Jan  5 19:29:30 twin ata5: status=0x50 { DriveReady SeekComplete }
Jan  5 19:29:30 twin ata5: error=0x01 { AddrMarkNotFound }
Jan  5 19:29:30 twin sdd: Current: sense key: No Sense
Jan  5 19:29:30 twin Additional sense: No additional sense information


B) After removing all data from the 250GB disks I've created RAID 5 with the 
four Maxtor 7Y250M0

Having 2 instances of bonnie++ running and the rebuilt in the background, it 
happened again....

the rebuilt never completet:

dude@twin /vol/twin/raid5 $ cat /proc/mdstat
Personalities : [raid1] [raid5] [multipath]
md0 : active raid5 sdg5[4] sdf5[2] sde5[1] sdd5[0]
      735334656 blocks level 5, 64k chunk, algorithm 2 [4/3] [UUU_]
      [=======>.............]  recovery = 36.3% (88984344/245111552) 
finish=54303.2min speed=47K/sec

unused devices: <none>

System:
Linux twin 2.6.15-am0-g88026842 #1 SMP Wed Jan 4 20:51:58 CET 2006 x86_64 AMD 
Opteron(tm) Processor 240 AuthenticAMD GNU/Linux

twin ~ # lspci
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
0000:01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:01:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 
07)
0000:01:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
0000:02:04.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 
8-port SATA I PCI-X Controller
0000:03:01.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]
0000:03:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 
Gigabit Ethernet (rev 03)
0000:03:02.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 
Gigabit Ethernet (rev 03)




# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y

CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_SCHED_SMT is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=8
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_ACPI_CPUFREQ is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set

# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y


#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_MV=y
CONFIG_SCSI_QLA2XXX=y


Cheers Roman

