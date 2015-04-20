From: Adrian Palmer <adrian.palmer@seagate.com>
Subject: Re: Sporadic timeouts accessing shingled drives with 3.19.
Date: Mon, 20 Apr 2015 15:36:40 -0600
Message-ID: <CAKdFiL5wOg9Ab4nuJuty0GSNGRMbKu9VgePDSHFe6kPzMfyyqQ@mail.gmail.com>
References: <ufabnii4k31.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:29504 "EHLO
	mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751024AbbDTVgq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Apr 2015 17:36:46 -0400
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
	by mx0a-00003501.pphosted.com (8.14.5/8.14.5) with SMTP id t3KLZnKY031136
	for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2015 17:36:45 -0400
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com [209.85.213.181])
	by mx0a-00003501.pphosted.com with ESMTP id 1tw9gkr03j-6
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2015 17:36:41 -0400
Received: by mail-ig0-f181.google.com with SMTP id lo3so60634igb.0
        for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2015 14:36:40 -0700 (PDT)
In-Reply-To: <ufabnii4k31.fsf@epithumia.math.uh.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: linux-ide@vger.kernel.org

Jason;

I'm glad you reposted this here, or I might not have seen it.


I'm the Seagate engineer leading SMR/ZAC/ZBC support in the kernel.  I
would be very interested in learning about your setup and workload.


There are 3 types of SMR drives: Drive Managed (DM), Host Managed
(HM), and Host Aware (HA).  I suspect that you have DM drives.  They
are what's out on the market now, and we've seen similar timeouts with
heavy workloads.  With more information about your workload, I would
engage firmware with another tuning case.  We've seen slowdowns and
timeouts when presented with non-stop workloads, preventing the drive
from having time to clean.

With DM, there is both nothing done, and nothing to be done in the
kernel.  The mechanics of SMR are implemented in the drive, completely
abstracted from the system.  The use case is not targeted toward RAID
applications -- as of yet, I've seen poor performance from around the
web from those that have attempted it.


HM & HA, on the other hand, have much to be done in the kernel
(IDE,SCSI, IO Scheduler, mdraid, lvm. ext4).  Seagate is releasing an
HA 8TB soon that will take advantage of these changes.  We expect
moving the SMR management up into the kernel will have drastically
superior performance results.  We have it on our schedule to look at
mdraid solutions that work with HA drives.  This is in conjunction
with our SMR Friendly File Systems (SMRFFS) update to EXT4.  We hope
to have something upstreamed later this summer.


Our repo is here (https://github.com/Seagate/SMR_FS-EXT4), either for
education or contribution.


Adrian Palmer
=46irmware Engineer II
R&D Firmware
Seagate, Longmont Colorado
720-684-1307
adrian.palmer@seagate.com


On Mon, Apr 20, 2015 at 2:32 PM, Jason L Tibbitts III <tibbs@math.uh.ed=
u> wrote:
> I filed a ticket with my distro
> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1213090) but was asked=
 to
> pass this on here.
>
> Running kernel-3.19.4-200.fc21.x86_64 on a machine with four 8TB Seag=
ate
> archive drives (which are the new shingled ones) I find that I have
> occasional drive timeouts which cause disks to fail out of the
> configured arrays.  Last night I found that all four disks in the
> machine failed out essentially at the same time.  The arrays were fin=
e
> on a reboot.  Under kernel-3.18.9-200.fc21.x86_64 the machine survive=
s
> what is basically three continuous days of array resyncing concurrent
> heavy writes (though performance for anything other than streaming
> writes is poor as expected for these drives).
>
> I found a similar report of this on
> http://serverfault.com/questions/682061/very-irregular-disk-write-per=
formance-and-repeated-sata-timeouts
>
> Looking in git I see there have been some changes in libata for shing=
led
> drives, but as far as I can tell this is just reporting their existen=
ce
> up in the stack.  There doesn't appear to be any significant change i=
n
> the driver for the disk interface (icsi).
>
> lspci has:
> 06:00.0 Serial Attached SCSI controller: Intel Corporation C602 chips=
et 4-Port SATA Storage Control Unit (rev 06)
>
> dmesg shows:
> [    2.004485] isci: Intel(R) C600 SAS Controller Driver - version 1.=
2.0
> [    2.005093] isci 0000:06:00.0: driver configured for rev: 6 silico=
n
> [    2.005691] isci 0000:06:00.0: OEM parameter table found in OROM
> [    2.006386] isci 0000:06:00.0: OEM SAS parameters (version: 1.0) l=
oaded (platform)
> [    2.007691] isci 0000:06:00.0: SCU controller 0: phy 3-0 cables: {=
short, short, short, short}
> [    2.011167] scsi host6: isci
> [    2.011835] isci 0000:06:00.0: irq 29 for MSI/MSI-X
> [    2.011842] isci 0000:06:00.0: irq 30 for MSI/MSI-X
>
> The drives themselves are SATA:
> [    4.559464] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [    4.559484] sas: ata7: end_device-6:0: dev error handler
> [    5.499472] ata7.00: ATA-9: ST8000AS0002-1NA17Z, AR13, max UDMA/13=
3
> [    5.500054] ata7.00: 15628053168 sectors, multi 0: LBA48 NCQ (dept=
h 31/32)
> [    5.502113] ata7.00: configured for UDMA/133
> [    5.502726] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0=
 tries: 1
> [    5.513315] scsi 6:0:0:0: Direct-Access     ATA      ST8000AS0002-=
1NA AR13 PQ: 0 ANSI: 5
>
> I've attached journalctl output for a boot with 3.19.4.  There are a
> couple of sets of timeouts, none of which actually kicked a disk out =
of
> the array (fortunately).  The last timeout actually happened while I =
was
> installing the 3.18 kernel to try and get the machine stable again.  =
I
> can provide a much larger journal from the boot where the disks all
> disappeared, but of course that journal isn't complete.
>
> Note that I'm not able to run any 3.19 kernel earlier than .4 because=
 of
> the issue where gssproxy won't start.  Note also that I'm not certain
> that 3.18 avoids this problem, only that so far I've not seen it crop=
 up
> and I stressed the drives pretty hard.  (I swapped out four existing =
4TB
> drives and grew the array, and then had to replace a drive which went
> bad, which meant five complete full-write resyncs which took about fo=
ur
> continuous days to complete.  Plus the weekly full array check.)
>
> Please let me know if there's any other information I can provide.
>
> -- Logs begin at Thu 2015-03-12 20:46:10 CDT, end at Sat 2015-04-18 1=
3:52:56 CDT. --
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd-journal[205]: Runtime =
journal is using 8.0M (max allowed 4.0G, trying to leave 4.0G free of 1=
25.9G available =E2=86=92 current limit 4.0G).
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd-journal[205]: Runtime =
journal is using 8.0M (max allowed 4.0G, trying to leave 4.0G free of 1=
25.9G available =E2=86=92 current limit 4.0G).
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys cpuset
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys cpu
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys cpuacct
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Linux version 3.19.4-2=
00.fc21.x86_64 (mockbuild@bkernel01.phx2.fedoraproject.org) (gcc versio=
n 4.9.2 20150212 (Red Hat 4.9.2-6) (GCC) ) #1 SMP Mon Apr 13 21:43:26 U=
TC 2015
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Command line: BOOT_IMA=
GE=3D/vmlinuz-3.19.4-200.fc21.x86_64 root=3D/dev/mapper/os-root ro rd.l=
vm.lv=3Dos/root rd.md.uuid=3Dcb616dc5:1cc90d6f:e55e66e2:bd0a70f9 rd.md.=
uuid=3Dbb10b94e:68bbadb4:5255b6ff:9533ce07 rd.md.uuid=3De0107f30:581504=
8c:005fef1e:7e036c8a rd.shell=3D0 consoleblank=3D0 nomodeset LANG=3Den_=
US.UTF-8
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: BIOS-provided ph=
ysical RAM map:
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
000000000000-0x000000000008efff] usable
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
00000008f000-0x000000000009ffff] reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
0000000e0000-0x00000000000fffff] reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
000000100000-0x000000007de32fff] usable
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
00007de33000-0x000000007dec1fff] reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
00007dec2000-0x000000007dfcafff] ACPI data
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
00007dfcb000-0x000000007e1e4fff] ACPI NVS
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
00007e1e5000-0x000000007f36cfff] reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
00007f36d000-0x000000007f7fffff] ACPI NVS
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
000080000000-0x000000008fffffff] reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
0000fed1c000-0x00000000fed3ffff] reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
0000ff000000-0x00000000ffffffff] reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BIOS-e820: [mem 0x0000=
000100000000-0x000000407fffffff] usable
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NX (Execute Disable) p=
rotection: active
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SMBIOS 2.7 present.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: DMI: Supermicro X9DRW/=
X9DRW, BIOS 3.0c 03/24/2014
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: update [mem 0x00=
000000-0x00000fff] usable =3D=3D> reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: remove [mem 0x00=
0a0000-0x000fffff] usable
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: last_pfn =3D 0x4=
080000 max_arch_pfn =3D 0x400000000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: MTRR default type: unc=
achable
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: MTRR fixed ranges enab=
led:
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   00000-9FFFF write-ba=
ck
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   A0000-BFFFF uncachab=
le
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   C0000-FFFFF write-pr=
otect
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: MTRR variable ranges e=
nabled:
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   0 base 000000000000 =
mask 3FC000000000 write-back
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   1 base 004000000000 =
mask 3FFF80000000 write-back
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   2 base 000080000000 =
mask 3FFF80000000 uncachable
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   3 disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   4 disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   5 disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   6 disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   7 disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   8 disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   9 disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PAT configuration [0-7=
]: WB  WC  UC- UC  WB  WC  UC- UC
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: update [mem 0x80=
000000-0xffffffff] usable =3D=3D> reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: last_pfn =3D 0x7=
de33 max_arch_pfn =3D 0x400000000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: found SMP MP-table at =
[mem 0x000fdb10-0x000fdb1f] mapped at [ffff8800000fdb10]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Base memory trampoline=
 at [ffff880000089000] 89000 size 24576
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Using GB pages for dir=
ect mapping
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: init_memory_mapping: [=
mem 0x00000000-0x000fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x00000000-0x000=
fffff] page 4k
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BRK [0x02038000, 0x020=
38fff] PGTABLE
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BRK [0x02039000, 0x020=
39fff] PGTABLE
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: BRK [0x0203a000, 0x020=
3afff] PGTABLE
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: init_memory_mapping: [=
mem 0x407fe00000-0x407fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x407fe00000-0x4=
07fffffff] page 1G
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: init_memory_mapping: [=
mem 0x4060000000-0x407fdfffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x4060000000-0x4=
07fdfffff] page 1G
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: init_memory_mapping: [=
mem 0x4000000000-0x405fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x4000000000-0x4=
05fffffff] page 1G
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: init_memory_mapping: [=
mem 0x2000000000-0x3fffffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x2000000000-0x3=
fffffffff] page 1G
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: init_memory_mapping: [=
mem 0x00100000-0x7de32fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x00100000-0x001=
fffff] page 4k
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x00200000-0x7dd=
fffff] page 2M
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x7de00000-0x7de=
32fff] page 4k
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: init_memory_mapping: [=
mem 0x100000000-0x1fffffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [mem 0x100000000-0x1f=
ffffffff] page 1G
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: RAMDISK: [mem 0x366b40=
00-0x37351fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Early table chec=
ksum verification disabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: RSDP 0x000000000=
00F04A0 000024 (v02 SUPERM)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: XSDT 0x000000007=
DEF7090 00009C (v01 SUPERM SMCI--MB 00000001 AMI  00010013)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: FACP 0x000000007=
DF02110 0000F4 (v04 SUPERM SMCI--MB 00000001 AMI  00010013)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: DSDT 0x000000007=
DEF71B8 00AF53 (v02 SUPERM SMCI--MB 00000000 INTL 20091112)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: FACS 0x000000007=
E1DC080 000040
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: APIC 0x000000007=
DF02208 0000D4 (v03                 00000001 AMI  00010013)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: FPDT 0x000000007=
DF022E0 000044 (v01                 00000001 AMI  00010013)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: SRAT 0x000000007=
DF02328 000330 (v01 A M I  AMI SRAT 00000001 AMI. 00000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: SLIT 0x000000007=
DF02658 000030 (v01 A M I  AMI SLIT 00000000 AMI. 00000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: HPET 0x000000007=
DF02688 000038 (v01 SUPERM SMCI--MB 00000001 AMI. 00000005)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PRAD 0x000000007=
DF026C0 0000BE (v02 PRADID PRADTID  00000001 MSFT 04000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: SPMI 0x000000007=
DF02780 000040 (v05 A M I  OEMSPMI  00000000 AMI. 00000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: SSDT 0x000000007=
DF027C0 0C7AE8 (v02 INTEL  CpuPm    00004000 INTL 20091112)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: EINJ 0x000000007=
DFCA2A8 000130 (v01 AMI    AMI EINJ 00000000      00000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: ERST 0x000000007=
DFCA3D8 000230 (v01 AMIER  AMI ERST 00000000      00000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: HEST 0x000000007=
DFCA608 0000A8 (v01 AMI    AMI HEST 00000000      00000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: BERT 0x000000007=
DFCA6B0 000030 (v01 AMI    AMI BERT 00000000      00000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: DMAR 0x000000007=
DFCA6E0 000138 (v01 A M I  OEMDMAR  00000001 INTL 00000001)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: MCFG 0x000000007=
DFCA818 00003C (v01 SUPERM SMCI--MB 00000001 MSFT 00000097)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Local APIC addre=
ss 0xfee00000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 0 -> APIC 0x=
00 -> Node 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 0 -> APIC 0x=
02 -> Node 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 0 -> APIC 0x=
04 -> Node 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 0 -> APIC 0x=
06 -> Node 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 1 -> APIC 0x=
20 -> Node 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 1 -> APIC 0x=
22 -> Node 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 1 -> APIC 0x=
24 -> Node 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: PXM 1 -> APIC 0x=
26 -> Node 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: Node 0 PXM 0 [me=
m 0x00000000-0x7fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: Node 0 PXM 0 [me=
m 0x100000000-0x207fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SRAT: Node 1 PXM 1 [me=
m 0x2080000000-0x407fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NUMA: Initialized dist=
ance table, cnt=3D2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NUMA: Node 0 [mem 0x00=
000000-0x7fffffff] + [mem 0x100000000-0x207fffffff] -> [mem 0x00000000-=
0x207fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NODE_DATA(0) allocated=
 [mem 0x207ffec000-0x207fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NODE_DATA(1) allocated=
 [mem 0x407ffe9000-0x407fffcfff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [ffffea0000000000-fff=
fea0081ffffff] PMD -> [ffff881fffe00000-ffff88207fdfffff] on node 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  [ffffea0082000000-fff=
fea0101ffffff] PMD -> [ffff883fff600000-ffff88407f5fffff] on node 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Zone ranges:
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   DMA      [mem 0x0000=
1000-0x00ffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   DMA32    [mem 0x0100=
0000-0xffffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   Normal   [mem 0x1000=
00000-0x407fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Movable zone start for=
 each node
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Early memory node rang=
es
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   node   0: [mem 0x000=
01000-0x0008efff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   node   0: [mem 0x001=
00000-0x7de32fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   node   0: [mem 0x100=
000000-0x207fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   node   1: [mem 0x208=
0000000-0x407fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initmem setup node 0 [=
mem 0x00001000-0x207fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: On node 0 totalpages: =
33545665
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   DMA zone: 64 pages u=
sed for memmap
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   DMA zone: 21 pages r=
eserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   DMA zone: 3982 pages=
, LIFO batch:0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   DMA32 zone: 7993 pag=
es used for memmap
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   DMA32 zone: 511539 p=
ages, LIFO batch:31
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   Normal zone: 516096 =
pages used for memmap
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   Normal zone: 3303014=
4 pages, LIFO batch:31
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initmem setup node 1 [=
mem 0x2080000000-0x407fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: On node 1 totalpages: =
33554432
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   Normal zone: 524288 =
pages used for memmap
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   Normal zone: 3355443=
2 pages, LIFO batch:31
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PM-Timer IO Port=
: 0x408
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Local APIC addre=
ss 0xfee00000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x00] lapic_id[0x00] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x01] lapic_id[0x02] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x02] lapic_id[0x04] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x03] lapic_id[0x06] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x04] lapic_id[0x20] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x05] lapic_id[0x22] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x06] lapic_id[0x24] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC (acpi_id[0=
x07] lapic_id[0x26] enabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x00] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x01] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x02] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x03] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x04] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x05] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x06] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: LAPIC_NMI (acpi_=
id[0x07] high edge lint[0x1])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: IOAPIC (id[0x00]=
 address[0xfec00000] gsi_base[0])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: IOAPIC[0]: apic_id 0, =
version 32, address 0xfec00000, GSI 0-23
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: IOAPIC (id[0x02]=
 address[0xfec01000] gsi_base[24])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: IOAPIC[1]: apic_id 2, =
version 32, address 0xfec01000, GSI 24-47
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: IOAPIC (id[0x03]=
 address[0xfec40000] gsi_base[48])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: IOAPIC[2]: apic_id 3, =
version 32, address 0xfec40000, GSI 48-71
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: INT_SRC_OVR (bus=
 0 bus_irq 0 global_irq 2 dfl dfl)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: INT_SRC_OVR (bus=
 0 bus_irq 9 global_irq 9 high level)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: IRQ0 used by ove=
rride.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: IRQ9 used by ove=
rride.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Using ACPI (MADT) for =
SMP configuration information
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: HPET id: 0x8086a=
701 base: 0xfed00000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: smpboot: Allowing 8 CP=
Us, 0 hotplug CPUs
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x00000000-0x00000fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x0008f000-0x0009ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x000a0000-0x000dffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x000e0000-0x000fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x7de33000-0x7dec1fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x7dec2000-0x7dfcafff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x7dfcb000-0x7e1e4fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x7e1e5000-0x7f36cfff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x7f36d000-0x7f7fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x7f800000-0x7fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x80000000-0x8fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0x90000000-0xfed1bfff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0xfed1c000-0xfed3ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0xfed40000-0xfeffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registered nosave =
memory: [mem 0xff000000-0xffffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: [mem 0x90000000-=
0xfed1bfff] available for PCI devices
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Booting paravirtualize=
d kernel on bare hardware
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: setup_percpu: NR_CPUS:=
1024 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PERCPU: Embedded 31 pa=
ges/cpu @ffff881fffc00000 s87936 r8192 d30848 u524288
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pcpu-alloc: s87936 r81=
92 d30848 u524288 alloc=3D1*2097152
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pcpu-alloc: [0] 0 1 2 =
3 [1] 4 5 6 7
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Built 2 zonelists in N=
ode order, mobility grouping on.  Total pages: 66051635
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Policy zone: Normal
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Kernel command line: B=
OOT_IMAGE=3D/vmlinuz-3.19.4-200.fc21.x86_64 root=3D/dev/mapper/os-root =
ro rd.lvm.lv=3Dos/root rd.md.uuid=3Dcb616dc5:1cc90d6f:e55e66e2:bd0a70f9=
 rd.md.uuid=3Dbb10b94e:68bbadb4:5255b6ff:9533ce07 rd.md.uuid=3De0107f30=
:5815048c:005fef1e:7e036c8a rd.shell=3D0 consoleblank=3D0 nomodeset LAN=
G=3Den_US.UTF-8
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PID hash table entries=
: 4096 (order: 3, 32768 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: xsave: enabled xstate_=
bv 0x7, cntxt size 0x340 using standard form
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Memory: 264108780K/268=
400388K available (7656K kernel code, 1243K rwdata, 3304K rodata, 1504K=
 init, 1532K bss, 4291608K reserved, 0K cma-reserved)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SLUB: HWalign=3D64, Or=
der=3D0-3, MinObjects=3D0, CPUs=3D8, Nodes=3D2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Hierarchical RCU imple=
mentation.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:         RCU dyntick-id=
le grace-period acceleration is enabled.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:         RCU restrictin=
g CPUs from NR_CPUS=3D1024 to nr_cpu_ids=3D8.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: RCU: Adjusting geometr=
y for rcu_fanout_leaf=3D16, nr_cpu_ids=3D8
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NR_IRQS:65792 nr_irqs:=
1304 16
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:         Offload RCU ca=
llbacks from all CPUs
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:         Offload RCU ca=
llbacks from CPUs: 0-7.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Console: colour VGA+ 8=
0x25
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: console [tty0] enabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: mempolicy: Enabling au=
tomatic NUMA balancing. Configure with numa_balancing=3D or the kernel.=
numa_balancing sysctl
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hpet clockevent regist=
ered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: tsc: Fast TSC calibrat=
ion using PIT
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: tsc: Detected 2500.075=
 MHz processor
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Calibrating delay loop=
 (skipped), value calculated using timer frequency.. 5000.15 BogoMIPS (=
lpj=3D2500075)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pid_max: default: 3276=
8 minimum: 301
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Core revision 20=
141107
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: All ACPI Tables =
successfully acquired
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Security Framework ini=
tialized
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SELinux:  Initializing=
=2E
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SELinux:  Starting in =
permissive mode
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Dentry cache hash tabl=
e entries: 33554432 (order: 16, 268435456 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Inode-cache hash table=
 entries: 16777216 (order: 15, 134217728 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Mount-cache hash table=
 entries: 524288 (order: 10, 4194304 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Mountpoint-cache hash =
table entries: 524288 (order: 10, 4194304 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys memory
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys devices
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys freezer
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys net_cls
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys blkio
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys perf_event
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys net_prio
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing cgroup su=
bsys hugetlb
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: CPU: Physical Processo=
r ID: 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: CPU: Processor Core ID=
: 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: mce: CPU supports 21 M=
CE banks
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: CPU0: Thermal monitori=
ng enabled (TM1)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Last level iTLB entrie=
s: 4KB 512, 2MB 8, 4MB 8
>                                                Last level dTLB entrie=
s: 4KB 512, 2MB 0, 4MB 0, 1GB 4
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Freeing SMP alternativ=
es memory: 28K (ffffffff81eb0000 - ffffffff81eb7000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ftrace: allocating 277=
00 entries in 109 pages
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: Host address wid=
th 46
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: DRHD base: 0x000=
000fbffe000 flags: 0x0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: IOMMU 0: reg_bas=
e_addr fbffe000 ver 1:0 cap d2078c106f0466 ecap f020de
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: DRHD base: 0x000=
000dfffc000 flags: 0x1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: IOMMU 1: reg_bas=
e_addr dfffc000 ver 1:0 cap d2078c106f0466 ecap f020de
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: RMRR base: 0x000=
0007de98000 end: 0x0000007dea4fff
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: ATSR flags: 0x0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: RHSA base: 0x000=
000fbffe000 proximity domain: 0x1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: dmar: RHSA base: 0x000=
000dfffc000 proximity domain: 0x0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: IOAPIC id 3 under DRHD=
 base  0xfbffe000 IOMMU 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: IOAPIC id 0 under DRHD=
 base  0xdfffc000 IOMMU 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: IOAPIC id 2 under DRHD=
 base  0xdfffc000 IOMMU 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: HPET id 0 under DRHD b=
ase 0xdfffc000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Queued invalidation wi=
ll be enabled to support x2apic and Intr-remapping.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Enabled IRQ remapping =
in x2apic mode
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Enabling x2apic
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Enabled x2apic
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Switched APIC routing =
to cluster x2apic.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ..TIMER: vector=3D0x30=
 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: smpboot: CPU0: Intel(R=
) Xeon(R) CPU E5-2609 v2 @ 2.50GHz (fam: 06, model: 3e, stepping: 04)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: TSC deadline timer ena=
bled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Performance Events: PE=
BS fmt1+, 16-deep LBR, IvyBridge events, full-width counters, Intel PMU=
 driver.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ... version:          =
      3
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ... bit width:        =
      48
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ... generic registers:=
      8
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ... value mask:       =
      0000ffffffffffff
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ... max period:       =
      0000ffffffffffff
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ... fixed-purpose even=
ts:   3
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ... event mask:       =
      00000007000000ff
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: x86: Booting SMP confi=
guration:
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: .... node  #0, CPUs:  =
    #1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NMI watchdog: enabled =
on all CPUs, permanently consumes one hw-PMU counter.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:  #2 #3
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: .... node  #1, CPUs:  =
 #4 #5 #6 #7
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: x86: Booted up 2 nodes=
, 8 CPUs
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: smpboot: Total of 8 pr=
ocessors activated (40024.31 BogoMIPS)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: devtmpfs: initialized
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Using 2GB memory block=
 size for large-memory system
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registering ACPI N=
VS region [mem 0x7dfcb000-0x7e1e4fff] (2203648 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Registering ACPI N=
VS region [mem 0x7f36d000-0x7f7fffff] (4796416 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: atomic64_test: passed =
for x86-64 platform with CX8 and with SSE
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pinctrl core: initiali=
zed pinctrl subsystem
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: RTC time: 15:52:10, da=
te: 04/18/15
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NET: Registered protoc=
ol family 16
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: cpuidle: using governo=
r menu
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI FADT declares the=
 system doesn't support PCIe ASPM, so disable it
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: bus type PCI reg=
istered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpiphp: ACPI Hot Plug=
 PCI Controller Driver version: 0.5
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI: MMCONFIG for doma=
in 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI: MMCONFIG at [mem =
0x80000000-0x8fffffff] reserved in E820
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI: Using configurati=
on type 1 for base access
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Added _OSI(Modul=
e Device)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Added _OSI(Proce=
ssor Device)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Added _OSI(3.0 _=
SCP Extensions)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Added _OSI(Proce=
ssor Aggregator Device)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Executed 1 block=
s of module-level executable AML code
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: \_SB_:_OSC invalid UUI=
D
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: _OSC request data:1 1f
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Interpreter enab=
led
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI Exception: AE_NOT=
_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI Exception: AE_NOT=
_FOUND, While evaluating Sleep State [\_S3_] (20141107/hwxface-580)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: (supports S0 S1 =
S4 S5)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Using IOAPIC for=
 interrupt routing
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: HEST: Table parsing ha=
s been initialized.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI: Using host bridge=
 windows from ACPI; if necessary, use "pci=3Dnocrs" and report a bug
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Root Bridge =
[PCI0] (domain 0000 [bus 00-7e])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:00: _OSC:=
 OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:00: _OSC:=
 platform does not support [PME AER]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:00: _OSC:=
 OS now controls [PCIeHotplug PCIeCapability]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI host bridge to bus=
 0000:00
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [bus 00-7e]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [io  0x0000-0x03af]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [io  0x03e0-0x0cf7]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [io  0x03b0-0x03df]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [io  0x0d00-0x9fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [mem 0x000a0000-0x000bffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [mem 0x000c0000-0x000dffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [mem 0xfed08000-0xfed08fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [mem 0xfed0e000-0xfed0ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: root =
bus resource [mem 0x80000000-0xdfffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:00.0: [808=
6:0e00] type 00 class 0x060000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:00.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.0: [808=
6:0e02] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1: [808=
6:0e03] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:02.0: [808=
6:0e04] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:02.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:02.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:03.0: [808=
6:0e08] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:03.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:03.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.0: [808=
6:0e20] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.0: reg =
0x10: [mem 0xdfa1c000-0xdfa1ffff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.1: [808=
6:0e21] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.1: reg =
0x10: [mem 0xdfa18000-0xdfa1bfff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.2: [808=
6:0e22] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.2: reg =
0x10: [mem 0xdfa14000-0xdfa17fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.3: [808=
6:0e23] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.3: reg =
0x10: [mem 0xdfa10000-0xdfa13fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.4: [808=
6:0e24] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.4: reg =
0x10: [mem 0xdfa0c000-0xdfa0ffff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.5: [808=
6:0e25] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.5: reg =
0x10: [mem 0xdfa08000-0xdfa0bfff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.6: [808=
6:0e26] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.6: reg =
0x10: [mem 0xdfa04000-0xdfa07fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.7: [808=
6:0e27] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:04.7: reg =
0x10: [mem 0xdfa00000-0xdfa03fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:05.0: [808=
6:0e28] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:05.2: [808=
6:0e2a] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:05.4: [808=
6:0e2c] type 00 class 0x080020
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:05.4: reg =
0x10: [mem 0xdfa25000-0xdfa25fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0: [808=
6:1d3e] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:16.0: [808=
6:1d3a] type 00 class 0x078000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:16.0: reg =
0x10: [mem 0xfed0e000-0xfed0e00f 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:16.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:16.1: [808=
6:1d3b] type 00 class 0x078000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:16.1: reg =
0x10: [mem 0xfed0f000-0xfed0f00f 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:16.1: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1a.0: [808=
6:1d2d] type 00 class 0x0c0320
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1a.0: reg =
0x10: [mem 0xdfa23000-0xdfa233ff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1a.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1a.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.0: [808=
6:1d10] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7: [808=
6:1d1e] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1d.0: [808=
6:1d26] type 00 class 0x0c0320
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1d.0: reg =
0x10: [mem 0xdfa22000-0xdfa223ff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1d.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1d.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0: [808=
6:244e] type 01 class 0x060401
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.0: [808=
6:1d41] type 00 class 0x060100
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: [808=
6:1d02] type 00 class 0x010601
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: reg =
0x10: [io  0x9050-0x9057]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: reg =
0x14: [io  0x9040-0x9043]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: reg =
0x18: [io  0x9030-0x9037]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: reg =
0x1c: [io  0x9020-0x9023]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: reg =
0x20: [io  0x9000-0x901f]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: reg =
0x24: [mem 0xdfa21000-0xdfa217ff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.2: PME#=
 supported from D3hot
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.3: [808=
6:1d22] type 00 class 0x0c0500
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.3: reg =
0x10: [mem 0xdfa20000-0xdfa200ff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.3: reg =
0x20: [io  0x1180-0x119f]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.6: [808=
6:1d24] type 00 class 0x118000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1f.6: reg =
0x10: [mem 0xfed08000-0xfed08fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.0: PCI =
bridge to [bus 01]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.0: [808=
6:1521] type 00 class 0x020000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.0: reg =
0x10: [mem 0xdf920000-0xdf93ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.0: reg =
0x18: [io  0x8020-0x803f]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.0: reg =
0x1c: [mem 0xdf944000-0xdf947fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.0: reg =
0x184: [mem 0xde660000-0xde663fff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.0: reg =
0x190: [mem 0xde640000-0xde643fff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.1: [808=
6:1521] type 00 class 0x020000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.1: reg =
0x10: [mem 0xdf900000-0xdf91ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.1: reg =
0x18: [io  0x8000-0x801f]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.1: reg =
0x1c: [mem 0xdf940000-0xdf943fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.1: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.1: reg =
0x184: [mem 0xde620000-0xde623fff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:02:00.1: reg =
0x190: [mem 0xde600000-0xde603fff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1: PCI =
bridge to [bus 02-03]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1:   br=
idge window [io  0x8000-0x8fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1:   br=
idge window [mem 0xdf900000-0xdf9fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1:   br=
idge window [mem 0xde600000-0xde6fffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:02.0: PCI =
bridge to [bus 04]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:03.0: PCI =
bridge to [bus 05]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:06:00.0: [808=
6:1d6b] type 00 class 0x010700
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:06:00.0: reg =
0x10: [mem 0xde47c000-0xde47ffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:06:00.0: reg =
0x18: [mem 0xde000000-0xde3fffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:06:00.0: reg =
0x20: [io  0x7000-0x70ff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:06:00.0: reg =
0x164: [mem 0xde400000-0xde403fff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0: PCI =
bridge to [bus 06]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0:   br=
idge window [io  0x7000-0x7fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0:   br=
idge window [mem 0xde000000-0xde4fffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.0: PCI =
bridge to [bus 07]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0: [191=
2:0013] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7: PCI =
bridge to [bus 08-0c]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0: [191=
2:0013] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:01.0: [191=
2:0013] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:01.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0: PCI =
bridge to [bus 09-0c]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0a:00.0: [191=
2:0012] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0: PCI =
bridge to [bus 0a-0b]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0b:00.0: [102=
b:0534] type 00 class 0x030000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0b:00.0: reg =
0x10: [mem 0xdd000000-0xddffffff pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0b:00.0: reg =
0x14: [mem 0xdf800000-0xdf803fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0b:00.0: reg =
0x18: [mem 0xdf000000-0xdf7fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0a:00.0: PCI =
bridge to [bus 0b]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0a:00.0:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0a:00.0:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:01.0: PCI =
bridge to [bus 0c]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0: PCI =
bridge to [bus 0d] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [io  0x0000-0x03af] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [io  0x03e0-0x0cf7] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [io  0x03b0-0x03df] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [io  0x0d00-0x9fff] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [mem 0x000a0000-0x000bffff] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [mem 0x000c0000-0x000dffff] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [mem 0xfed08000-0xfed08fff] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [mem 0xfed0e000-0xfed0ffff] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0:   br=
idge window [mem 0x80000000-0xdfffffff] (subtractive decode)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: on NU=
MA node 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:00: Disab=
ling ASPM (FADT indicates it is unsupported)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Root Bridge =
[UNC0] (domain 0000 [bus 7f])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A03:00: _OSC:=
 OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A03:00: _OSC:=
 OS now controls [PCIeHotplug PME AER PCIeCapability]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI host bridge to bus=
 0000:7f
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:7f: root =
bus resource [bus 7f]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:08.0: [808=
6:0e80] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:09.0: [808=
6:0e90] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0a.0: [808=
6:0ec0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0a.1: [808=
6:0ec1] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0a.2: [808=
6:0ec2] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0a.3: [808=
6:0ec3] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0b.0: [808=
6:0e1e] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0b.3: [808=
6:0e1f] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0c.0: [808=
6:0ee0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0c.1: [808=
6:0ee2] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0d.0: [808=
6:0ee1] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0d.1: [808=
6:0ee3] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0e.0: [808=
6:0ea0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0e.1: [808=
6:0e30] type 00 class 0x110100
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0f.0: [808=
6:0ea8] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0f.1: [808=
6:0e71] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0f.2: [808=
6:0eaa] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0f.3: [808=
6:0eab] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0f.4: [808=
6:0eac] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:0f.5: [808=
6:0ead] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.0: [808=
6:0eb0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.1: [808=
6:0eb1] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.2: [808=
6:0eb2] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.3: [808=
6:0eb3] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.4: [808=
6:0eb4] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.5: [808=
6:0eb5] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.6: [808=
6:0eb6] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:10.7: [808=
6:0eb7] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:13.0: [808=
6:0e1d] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:13.1: [808=
6:0e34] type 00 class 0x110100
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:13.4: [808=
6:0e81] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:13.5: [808=
6:0e36] type 00 class 0x110100
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:16.0: [808=
6:0ec8] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:16.1: [808=
6:0ec9] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:7f:16.2: [808=
6:0eca] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:7f: on NU=
MA node 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A03:00: Disab=
ling ASPM (FADT indicates it is unsupported)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Root Bridge =
[PCI1] (domain 0000 [bus 80-fe])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:01: _OSC:=
 OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:01: _OSC:=
 platform does not support [PME AER]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:01: _OSC:=
 OS now controls [PCIeHotplug PCIeCapability]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI host bridge to bus=
 0000:80
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:80: root =
bus resource [bus 80-fe]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:80: root =
bus resource [io  0xa000-0xffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:80: root =
bus resource [mem 0xe0000000-0xfbffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:02.0: [808=
6:0e04] type 01 class 0x060400
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:02.0: PME#=
 supported from D0 D3hot D3cold
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:02.0: Syst=
em wakeup disabled by ACPI
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.0: [808=
6:0e20] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.0: reg =
0x10: [mem 0xfbf1c000-0xfbf1ffff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.1: [808=
6:0e21] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.1: reg =
0x10: [mem 0xfbf18000-0xfbf1bfff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.2: [808=
6:0e22] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.2: reg =
0x10: [mem 0xfbf14000-0xfbf17fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.3: [808=
6:0e23] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.3: reg =
0x10: [mem 0xfbf10000-0xfbf13fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.4: [808=
6:0e24] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.4: reg =
0x10: [mem 0xfbf0c000-0xfbf0ffff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.5: [808=
6:0e25] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.5: reg =
0x10: [mem 0xfbf08000-0xfbf0bfff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.6: [808=
6:0e26] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.6: reg =
0x10: [mem 0xfbf04000-0xfbf07fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.7: [808=
6:0e27] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:04.7: reg =
0x10: [mem 0xfbf00000-0xfbf03fff 64bit]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:05.0: [808=
6:0e28] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:05.2: [808=
6:0e2a] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:05.4: [808=
6:0e2c] type 00 class 0x080020
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:05.4: reg =
0x10: [mem 0xfbf20000-0xfbf20fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:02.0: PCI =
bridge to [bus 81]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:80: on NU=
MA node 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A08:01: Disab=
ling ASPM (FADT indicates it is unsupported)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Root Bridge =
[UNC1] (domain 0000 [bus ff])
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A03:01: _OSC:=
 OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A03:01: _OSC:=
 OS now controls [PCIeHotplug PME AER PCIeCapability]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI host bridge to bus=
 0000:ff
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:ff: root =
bus resource [bus ff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:08.0: [808=
6:0e80] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:09.0: [808=
6:0e90] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0a.0: [808=
6:0ec0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0a.1: [808=
6:0ec1] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0a.2: [808=
6:0ec2] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0a.3: [808=
6:0ec3] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0b.0: [808=
6:0e1e] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0b.3: [808=
6:0e1f] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0c.0: [808=
6:0ee0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0c.1: [808=
6:0ee2] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0d.0: [808=
6:0ee1] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0d.1: [808=
6:0ee3] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0e.0: [808=
6:0ea0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0e.1: [808=
6:0e30] type 00 class 0x110100
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0f.0: [808=
6:0ea8] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0f.1: [808=
6:0e71] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0f.2: [808=
6:0eaa] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0f.3: [808=
6:0eab] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0f.4: [808=
6:0eac] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:0f.5: [808=
6:0ead] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.0: [808=
6:0eb0] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.1: [808=
6:0eb1] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.2: [808=
6:0eb2] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.3: [808=
6:0eb3] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.4: [808=
6:0eb4] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.5: [808=
6:0eb5] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.6: [808=
6:0eb6] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:10.7: [808=
6:0eb7] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:13.0: [808=
6:0e1d] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:13.1: [808=
6:0e34] type 00 class 0x110100
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:13.4: [808=
6:0e81] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:13.5: [808=
6:0e36] type 00 class 0x110100
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:16.0: [808=
6:0ec8] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:16.1: [808=
6:0ec9] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:ff:16.2: [808=
6:0eca] type 00 class 0x088000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:ff: on NU=
MA node 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: acpi PNP0A03:01: Disab=
ling ASPM (FADT indicates it is unsupported)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKC] (IRQs 3 4 *5 6 10 11 12 14 15)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: PCI Interrupt Li=
nk [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Enabled 1 GPEs i=
n block 00 to 3F
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI Error: [\_SB_.PRA=
D] Namespace lookup failure, AE_NOT_FOUND (20141107/psargs-359)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI Error: Method par=
se/execution failed [\_GPE._L24] (Node ffff881fff8bee60), AE_NOT_FOUND =
(20141107/psparse-536)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI Exception: AE_NOT=
_FOUND, while evaluating GPE method [_L24] (20141107/evgpe-581)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: vgaarb: setting as boo=
t device: PCI:0000:0b:00.0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: vgaarb: device added: =
PCI:0000:0b:00.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: vgaarb: loaded
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: vgaarb: bridge control=
 possible 0000:0b:00.0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SCSI subsystem initial=
ized
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: libata version 3.00 lo=
aded.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: bus type USB reg=
istered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbcore: registered ne=
w interface driver usbfs
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbcore: registered ne=
w interface driver hub
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbcore: registered ne=
w device driver usb
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI: Using ACPI for IR=
Q routing
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI: pci_cache_line_si=
ze set to 64 bytes
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: reserve RAM buff=
er [mem 0x0008f000-0x0008ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: e820: reserve RAM buff=
er [mem 0x7de33000-0x7fffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NetLabel: Initializing
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NetLabel:  domain hash=
 size =3D 128
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NetLabel:  protocols =3D=
 UNLABELED CIPSOv4
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NetLabel:  unlabeled t=
raffic allowed by default
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hpet0: at MMIO 0xfed00=
000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hpet0: 8 comparators, =
64-bit 14.318180 MHz counter
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Switched to clocksourc=
e hpet
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp: PnP ACPI init
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:00: [mem 0xf=
c000000-0xfcffffff] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:00: [mem 0xf=
d000000-0xfdffffff] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:00: [mem 0xf=
e000000-0xfeafffff] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:00: [mem 0xf=
eb00000-0xfebfffff] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:00: Plug and=
 Play ACPI device, IDs PNP0c01 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:01: [mem 0xd=
fffc000-0xdfffdfff] could not be reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:01: Plug and=
 Play ACPI device, IDs PNP0c02 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp 00:02: Plug and Pl=
ay ACPI device, IDs PNP0b00 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:03: [io  0x0=
4d0-0x04d1] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:03: [mem 0x0=
0000400-0x000004ff] could not be reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:03: Plug and=
 Play ACPI device, IDs PNP0c02 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:04: [io  0x0=
a00-0x0a07] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:04: Plug and=
 Play ACPI device, IDs PNP0c02 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp 00:05: Plug and Pl=
ay ACPI device, IDs PNP0f03 PNP0f13 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:06: [io  0x0=
370-0x0371] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:06: [io  0x0=
a00-0x0a07] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:06: [io  0x0=
a10-0x0a3f] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:06: Plug and=
 Play ACPI device, IDs PNP0c02 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp 00:07: [dma 0 disa=
bled]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp 00:07: Plug and Pl=
ay ACPI device, IDs PNP0501 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp 00:08: [dma 0 disa=
bled]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp 00:08: Plug and Pl=
ay ACPI device, IDs PNP0501 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp 00:09: Plug and Pl=
ay ACPI device, IDs IPI0001 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: [io  0x0=
400-0x0453] could not be reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: [io  0x0=
458-0x047f] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: [io  0x1=
180-0x119f] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: [io  0x0=
500-0x057f] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: [mem 0xf=
ed1c000-0xfed1ffff] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: [mem 0xf=
ec00000-0xfecfffff] could not be reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: [mem 0xf=
f000000-0xffffffff] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0a: Plug and=
 Play ACPI device, IDs PNP0c01 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0b: [io  0x0=
454-0x0457] has been reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0b: Plug and=
 Play ACPI device, IDs INT3f0d PNP0c02 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0c: Plug and=
 Play ACPI device, IDs PNP0c01 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0d: [mem 0xf=
bffe000-0xfbffffff] could not be reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0d: Plug and=
 Play ACPI device, IDs PNP0c02 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0e: [mem 0x0=
0000000-0x0009ffff] could not be reserved
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: system 00:0e: Plug and=
 Play ACPI device, IDs PNP0c01 (active)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pnp: PnP ACPI: found 1=
5 devices
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.0: PCI =
bridge to [bus 01]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1: PCI =
bridge to [bus 02-03]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1:   br=
idge window [io  0x8000-0x8fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1:   br=
idge window [mem 0xdf900000-0xdf9fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:01.1:   br=
idge window [mem 0xde600000-0xde6fffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:02.0: PCI =
bridge to [bus 04]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:03.0: PCI =
bridge to [bus 05]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0: PCI =
bridge to [bus 06]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0:   br=
idge window [io  0x7000-0x7fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:11.0:   br=
idge window [mem 0xde000000-0xde4fffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.0: PCI =
bridge to [bus 07]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0a:00.0: PCI =
bridge to [bus 0b]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0a:00.0:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0a:00.0:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0: PCI =
bridge to [bus 0a-0b]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:00.0:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:09:01.0: PCI =
bridge to [bus 0c]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0: PCI =
bridge to [bus 09-0c]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:08:00.0:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7: PCI =
bridge to [bus 08-0c]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7:   br=
idge window [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1c.7:   br=
idge window [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:00:1e.0: PCI =
bridge to [bus 0d]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 4 [io  0x0000-0x03af]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 5 [io  0x03e0-0x0cf7]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 6 [io  0x03b0-0x03df]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 7 [io  0x0d00-0x9fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 8 [mem 0x000a0000-0x000bffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 9 [mem 0x000c0000-0x000dffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 10 [mem 0xfed08000-0xfed08fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 11 [mem 0xfed0e000-0xfed0ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:00: resou=
rce 12 [mem 0x80000000-0xdfffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:02: resou=
rce 0 [io  0x8000-0x8fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:02: resou=
rce 1 [mem 0xdf900000-0xdf9fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:02: resou=
rce 2 [mem 0xde600000-0xde6fffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:06: resou=
rce 0 [io  0x7000-0x7fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:06: resou=
rce 2 [mem 0xde000000-0xde4fffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:08: resou=
rce 1 [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:08: resou=
rce 2 [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:09: resou=
rce 1 [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:09: resou=
rce 2 [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0a: resou=
rce 1 [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0a: resou=
rce 2 [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0b: resou=
rce 1 [mem 0xdf000000-0xdf8fffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0b: resou=
rce 2 [mem 0xdd000000-0xddffffff 64bit pref]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 4 [io  0x0000-0x03af]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 5 [io  0x03e0-0x0cf7]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 6 [io  0x03b0-0x03df]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 7 [io  0x0d00-0x9fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 8 [mem 0x000a0000-0x000bffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 9 [mem 0x000c0000-0x000dffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 10 [mem 0xfed08000-0xfed08fff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 11 [mem 0xfed0e000-0xfed0ffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:0d: resou=
rce 12 [mem 0x80000000-0xdfffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:80:02.0: PCI =
bridge to [bus 81]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:80: resou=
rce 4 [io  0xa000-0xffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_bus 0000:80: resou=
rce 5 [mem 0xe0000000-0xfbffffff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NET: Registered protoc=
ol family 2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: TCP established hash t=
able entries: 524288 (order: 10, 4194304 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: TCP bind hash table en=
tries: 65536 (order: 8, 1048576 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: TCP: Hash tables confi=
gured (established 524288 bind 65536)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: TCP: reno registered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: UDP hash table entries=
: 65536 (order: 9, 2097152 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: UDP-Lite hash table en=
tries: 65536 (order: 9, 2097152 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NET: Registered protoc=
ol family 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci 0000:0b:00.0: Vide=
o device with shadowed ROM
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI: CLS 64 bytes, def=
ault 64
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Unpacking initramfs...
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Freeing initrd memory:=
 12920K (ffff8800366b4000 - ffff880037352000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PCI-DMA: Using softwar=
e bounce buffering for IO (SWIOTLB)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: software IO TLB [mem 0=
x79e33000-0x7de33000] (64MB) mapped at [ffff880079e33000-ffff88007de32f=
ff]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: RAPL PMU detected, hw =
unit 2^-16 Joules, API unit is 2^-32 Joules, 3 fixed counters 163840 ms=
 ovfl timer
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU0 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU1 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU2 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU3 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU4 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU5 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU6 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: CPU7 sig=3D=
0x306e4, pf=3D0x1, revision=3D0x416
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: microcode: Microcode U=
pdate Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: AVX version of gcm_enc=
/dec engaged.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: AES CTR mode by8 optim=
ization enabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: alg: No test for __gcm=
-aes-aesni (__driver-gcm-aes-aesni)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: futex hash table entri=
es: 2048 (order: 5, 131072 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initialise system trus=
ted keyring
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: audit: initializing ne=
tlink subsys (disabled)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: audit: type=3D2000 aud=
it(1429372330.951:1): initialized
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: HugeTLB registered 2 M=
B page size, pre-allocated 0 pages
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: zpool: loaded
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: zbud: loaded
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: VFS: Disk quotas dquot=
_6.5.2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: VFS: Dquot-cache hash =
table entries: 512 (order 0, 4096 bytes)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Key type big_key regis=
tered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: SELinux:  Registering =
netfilter hooks
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: alg: No test for stdrn=
g (krng)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NET: Registered protoc=
ol family 38
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Key type asymmetric re=
gistered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Asymmetric key parser =
'x509' registered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Block layer SCSI gener=
ic (bsg) driver version 0.4 loaded (major 252)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: io scheduler noop regi=
stered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: io scheduler deadline =
registered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: io scheduler cfq regis=
tered (default)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pci_hotplug: PCI Hot P=
lug PCI Core version: 0.5
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pciehp: PCI Express Ho=
t Plug Controller Driver version: 0.4
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: intel_idle: MWAIT subs=
tates: 0x1120
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: intel_idle: v0.4 model=
 0x3E
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: intel_idle: lapic_time=
r_reliable_states 0xffffffff
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: input: Power Button as=
 /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Power Button [PW=
RB]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: input: Power Button as=
 /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ACPI: Power Button [PW=
RF]
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ERST: Error Record Ser=
ialization Table (ERST) support is initialized.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: pstore: Registered ers=
t as persistent store backend
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: GHES: APEI firmware fi=
rst mode is enabled by WHEA _OSC.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Serial: 8250/16550 dri=
ver, 4 ports, IRQ sharing enabled
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: 00:07: ttyS0 at I/O 0x=
3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: 00:08: ttyS1 at I/O 0x=
2f8 (irq =3D 3, base_baud =3D 115200) is a 16550A
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Non-volatile memory dr=
iver v1.3
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Linux agpgart interfac=
e v0.103
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ahci 0000:00:1f.2: ver=
sion 3.0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ahci 0000:00:1f.2: AHC=
I 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ahci 0000:00:1f.2: fla=
gs: 64bit ncq sntf pm led clo pio slum part ems apst
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: scsi host0: ahci
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: scsi host1: ahci
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: scsi host2: ahci
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: scsi host3: ahci
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: scsi host4: ahci
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: scsi host5: ahci
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata1: SATA max UDMA/13=
3 abar m2048@0xdfa21000 port 0xdfa21100 irq 28
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata2: SATA max UDMA/13=
3 abar m2048@0xdfa21000 port 0xdfa21180 irq 28
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata3: SATA max UDMA/13=
3 abar m2048@0xdfa21000 port 0xdfa21200 irq 28
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata4: SATA max UDMA/13=
3 abar m2048@0xdfa21000 port 0xdfa21280 irq 28
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata5: SATA max UDMA/13=
3 abar m2048@0xdfa21000 port 0xdfa21300 irq 28
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata6: SATA max UDMA/13=
3 abar m2048@0xdfa21000 port 0xdfa21380 irq 28
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: libphy: Fixed MDIO Bus=
: probed
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci_hcd: USB 2.0 'Enh=
anced' Host Controller (EHCI) Driver
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci: EHCI PCI pla=
tform driver
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1a.0:=
 EHCI Host Controller
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1a.0:=
 new USB bus registered, assigned bus number 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1a.0:=
 debug port 2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1a.0:=
 cache line size of 64 is not supported
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1a.0:=
 irq 16, io mem 0xdfa23000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1a.0:=
 USB 2.0 started, EHCI 1.00
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb1: New USB devi=
ce found, idVendor=3D1d6b, idProduct=3D0002
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb1: New USB devi=
ce strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb1: Product: EHC=
I Host Controller
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb1: Manufacturer=
: Linux 3.19.4-200.fc21.x86_64 ehci_hcd
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb1: SerialNumber=
: 0000:00:1a.0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 1-0:1.0: USB hub f=
ound
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 1-0:1.0: 2 ports d=
etected
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1d.0:=
 EHCI Host Controller
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1d.0:=
 new USB bus registered, assigned bus number 2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1d.0:=
 debug port 2
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1d.0:=
 cache line size of 64 is not supported
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1d.0:=
 irq 23, io mem 0xdfa22000
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ehci-pci 0000:00:1d.0:=
 USB 2.0 started, EHCI 1.00
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb2: New USB devi=
ce found, idVendor=3D1d6b, idProduct=3D0002
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb2: New USB devi=
ce strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb2: Product: EHC=
I Host Controller
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb2: Manufacturer=
: Linux 3.19.4-200.fc21.x86_64 ehci_hcd
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb usb2: SerialNumber=
: 0000:00:1d.0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 2-0:1.0: USB hub f=
ound
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 2-0:1.0: 2 ports d=
etected
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ohci_hcd: USB 1.1 'Ope=
n' Host Controller (OHCI) Driver
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ohci-pci: OHCI PCI pla=
tform driver
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: uhci_hcd: USB Universa=
l Host Controller Interface driver
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbcore: registered ne=
w interface driver usbserial
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbcore: registered ne=
w interface driver usbserial_generic
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbserial: USB Serial =
support registered for generic
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: i8042: PNP: PS/2 Contr=
oller [PNP0f03:PS2M] at 0x60,0x64 irq 12
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: i8042: PNP: PS/2 contr=
oller doesn't have KBD irq; using default 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: serio: i8042 KBD port =
at 0x60,0x64 irq 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: serio: i8042 AUX port =
at 0x60,0x64 irq 12
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: mousedev: PS/2 mouse d=
evice common for all mice
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: rtc_cmos 00:02: RTC ca=
n wake from S4
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: rtc_cmos 00:02: rtc co=
re: registered rtc_cmos as rtc0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: rtc_cmos 00:02: alarms=
 up to one month, y3k, 114 bytes nvram, hpet irqs
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: device-mapper: uevent:=
 version 1.0.3
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: device-mapper: ioctl: =
4.29.0-ioctl (2014-10-28) initialised: dm-devel@redhat.com
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Intel P-state driver i=
nitializing.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hidraw: raw HID events=
 driver (C) Jiri Kosina
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbcore: registered ne=
w interface driver usbhid
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usbhid: USB HID core d=
river
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: drop_monitor: Initiali=
zing network drop monitor service
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ip_tables: (C) 2000-20=
06 Netfilter Core Team
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: TCP: cubic registered
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Initializing XFRM netl=
ink socket
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NET: Registered protoc=
ol family 10
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: mip6: Mobile IPv6
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: NET: Registered protoc=
ol family 17
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Loading compiled-in X.=
509 certificates
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Loaded X.509 cert 'Fed=
ora kernel signing key: 7c71d2c04076cfd26f37da63b0e89703f90162b6'
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: registered taskstats v=
ersion 1
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel:   Magic number: 11:270=
:892
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: bdi default: hash matc=
hes
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: rtc_cmos 00:02: settin=
g system clock to 2015-04-18 15:52:11 UTC (1429372331)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: PM: Hibernation image =
not present or could not be loaded.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata2: SATA link down (=
SStatus 0 SControl 300)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata3: SATA link down (=
SStatus 0 SControl 300)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata1: SATA link down (=
SStatus 0 SControl 300)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata6: SATA link down (=
SStatus 0 SControl 300)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata4: SATA link down (=
SStatus 0 SControl 300)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: ata5: SATA link down (=
SStatus 0 SControl 300)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Freeing unused kernel =
memory: 1504K (ffffffff81d38000 - ffffffff81eb0000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Write protecting the k=
ernel read-only data: 12288k
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Freeing unused kernel =
memory: 524K (ffff88000177d000 - ffff880001800000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: Freeing unused kernel =
memory: 792K (ffff880001b3a000 - ffff880001c00000)
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: random: systemd urando=
m read with 4 bits of entropy available
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: systemd 216 runnin=
g in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT=
 +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +EL=
=46UTILS +KMOD +IDN)
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Detected architect=
ure 'x86-64'.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Running in initial=
 RAM disk.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb 1-1: new high-spee=
d USB device number 2 using ehci-pci
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Set hostname to <o=
verwatch1.math.uh.edu>.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb 2-1: new high-spee=
d USB device number 2 using ehci-pci
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Expecting device d=
ev-disk-by\x2duuid-da90bc36\x2d4600\x2d4fbb\x2d9002\x2d35a8d47ba4eb.dev=
ice...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Expecting device d=
ev-disk-by\x2duuid-d39d0f1f\x2db532\x2d44a9\x2dbf8e\x2d434f34b3dac0.dev=
ice...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Expecting device d=
ev-mapper-os\x2droot.device...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Timers.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Reached target Tim=
ers.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting -.slice.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Created slice -.sl=
ice.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting udev Cont=
rol Socket.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Listening on udev =
Control Socket.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting udev Kern=
el Socket.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Listening on udev =
Kernel Socket.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Journal S=
ocket.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Listening on Journ=
al Socket.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting System Sl=
ice.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Created slice Syst=
em Slice.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started dracut ask=
 for additional cmdline parameters.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting dracut cm=
dline hook...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting system-sy=
stemd\x2dfsck.slice.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Created slice syst=
em-systemd\x2dfsck.slice.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Create li=
st of required static device nodes for the current kernel...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started Load Kerne=
l Modules.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Journal S=
ocket (/dev/log).
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Slices.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Reached target Sli=
ces.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Setup Vir=
tual Console...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Apply Ker=
nel Variables...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Swap.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Reached target Swa=
p.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Local Fil=
e Systems.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Reached target Loc=
al File Systems.
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb 1-1: New USB devic=
e found, idVendor=3D8087, idProduct=3D0024
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb 1-1: New USB devic=
e strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 1-1:1.0: USB hub f=
ound
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 1-1:1.0: 6 ports d=
etected
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started Create lis=
t of required static device nodes for the current kernel.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Listening on Journ=
al Socket (/dev/log).
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started Apply Kern=
el Variables.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Sockets.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Reached target Soc=
kets.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Journal S=
ervice...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting Create St=
atic Device Nodes in /dev...
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb 2-1: New USB devic=
e found, idVendor=3D8087, idProduct=3D0024
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: usb 2-1: New USB devic=
e strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 2-1:1.0: USB hub f=
ound
> Apr 18 10:52:11 overwatch1.math.uh.edu kernel: hub 2-1:1.0: 8 ports d=
etected
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started Create Sta=
tic Device Nodes in /dev.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started dracut cmd=
line hook.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting dracut pr=
e-udev hook...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd-journal[205]: Journal =
started
> Apr 18 10:52:11 overwatch1.math.uh.edu dracut-cmdline[169]: dracut-21=
 (Twenty One) dracut-038-33.git20141216.fc21
> Apr 18 10:52:11 overwatch1.math.uh.edu dracut-cmdline[169]: Using ker=
nel command line parameters:
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started Journal Se=
rvice.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started Setup Virt=
ual Console.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started dracut pre=
-udev hook.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting udev Kern=
el Device Manager...
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd-udevd[277]: starting v=
ersion 216
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Started udev Kerne=
l Device Manager.
> Apr 18 10:52:11 overwatch1.math.uh.edu systemd[1]: Starting dracut pr=
e-trigger hook...
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Started dracut pre=
-trigger hook.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Starting udev Cold=
plug all Devices...
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Started udev Coldp=
lug all Devices.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Starting dracut in=
itqueue hook...
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Starting Show Plym=
outh Boot Screen...
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Starting System In=
itialization.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Reached target Sys=
tem Initialization.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Mounting Configura=
tion File System...
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Mounted Configurat=
ion File System.
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: usb 1-1.3: new full-sp=
eed USB device number 3 using ehci-pci
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: isci: Intel(R) C600 SA=
S Controller Driver - version 1.2.0
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: dri=
ver configured for rev: 6 silicon
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: OEM=
 parameter table found in OROM
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: [drm] Initialized drm =
1.1.0 20060810
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: OEM=
 SAS parameters (version: 1.0) loaded (platform)
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: SCU=
 controller 0: phy 3-0 cables: {short, short, short, short}
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: scsi host6: isci
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: usb 1-1.3: New USB dev=
ice found, idVendor=3D046b, idProduct=3Dff10
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: usb 1-1.3: New USB dev=
ice strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: usb 1-1.3: Product: Vi=
rtual Keyboard and Mouse
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: usb 1-1.3: Manufacture=
r: American Megatrends Inc.
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: input: American Megatr=
ends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1a.=
0/usb1/1-1/1-1.3/1-1.3:1.0/0003:046B:FF10.0001/input/input5
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: hid-generic 0003:046B:=
=46F10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends=
 Inc. Virtual Keyboard and Mouse] on usb-0000:00:1a.0-1.3/input0
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: input: American Megatr=
ends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1a.=
0/usb1/1-1/1-1.3/1-1.3:1.1/0003:046B:FF10.0002/input/input6
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: hid-generic 0003:046B:=
=46F10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends In=
c. Virtual Keyboard and Mouse] on usb-0000:00:1a.0-1.3/input1
> Apr 18 10:52:12 overwatch1.math.uh.edu kernel: tsc: Refined TSC clock=
source calibration: 2499.998 MHz
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Received SIGRTMIN+=
20 from PID 336 (plymouthd).
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Started Show Plymo=
uth Boot Screen.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Starting Forward P=
assword Requests to Plymouth Directory Watch.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Started Forward Pa=
ssword Requests to Plymouth Directory Watch.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Started Dispatch P=
assword Requests to Console Directory Watch.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Starting Paths.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Reached target Pat=
hs.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Starting Basic Sys=
tem.
> Apr 18 10:52:12 overwatch1.math.uh.edu systemd[1]: Reached target Bas=
ic System.
> Apr 18 10:52:13 overwatch1.math.uh.edu kernel: Switched to clocksourc=
e tsc
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: phy-6:0 added to =
port-6:0, phy_mask:0x1 (500304800704ac00)
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: phy-6:1 added to =
port-6:1, phy_mask:0x2 (500304800704ac01)
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: phy-6:2 added to =
port-6:2, phy_mask:0x4 (500304800704ac02)
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: phy-6:3 added to =
port-6:3, phy_mask:0x8 (500304800704ac03)
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DOING DISCOVERY o=
n port 0, pid:6
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DONE DISCOVERY on=
 port 0, pid:6, result:0
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DOING DISCOVERY o=
n port 1, pid:6
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DONE DISCOVERY on=
 port 1, pid:6, result:0
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DOING DISCOVERY o=
n port 2, pid:6
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DONE DISCOVERY on=
 port 2, pid:6, result:0
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DOING DISCOVERY o=
n port 3, pid:6
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: DONE DISCOVERY on=
 port 3, pid:6, result:0
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: Enter sas_scsi_re=
cover_host busy: 0 failed: 0
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: dev error handler
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: ata7.00: ATA-9: ST8000=
AS0002-1NA17Z, AR13, max UDMA/133
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: ata7.00: 15628053168 s=
ectors, multi 0: LBA48 NCQ (depth 31/32)
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: ata7.00: configured fo=
r UDMA/133
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: --- Exit sas_scsi=
_recover_host: busy: 0 failed: 0 tries: 1
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: scsi 6:0:0:0: Direct-A=
ccess     ATA      ST8000AS0002-1NA AR13 PQ: 0 ANSI: 5
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: Enter sas_scsi_re=
cover_host busy: 0 failed: 0
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: dev error handler
> Apr 18 10:52:14 overwatch1.math.uh.edu kernel: sas: ata8: end_device-=
6:1: dev error handler
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: ata8.00: ATA-9: ST8000=
AS0002-1NA17Z, AR13, max UDMA/133
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: ata8.00: 15628053168 s=
ectors, multi 0: LBA48 NCQ (depth 31/32)
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: ata8.00: configured fo=
r UDMA/133
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: --- Exit sas_scsi=
_recover_host: busy: 0 failed: 0 tries: 1
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: scsi 6:0:1:0: Direct-A=
ccess     ATA      ST8000AS0002-1NA AR13 PQ: 0 ANSI: 5
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: Enter sas_scsi_re=
cover_host busy: 0 failed: 0
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: dev error handler
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: ata8: end_device-=
6:1: dev error handler
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: ata9: end_device-=
6:2: dev error handler
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: ata9.00: ATA-9: ST8000=
AS0002-1NA17Z, AR13, max UDMA/133
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: ata9.00: 15628053168 s=
ectors, multi 0: LBA48 NCQ (depth 31/32)
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: ata9.00: configured fo=
r UDMA/133
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: --- Exit sas_scsi=
_recover_host: busy: 0 failed: 0 tries: 1
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: scsi 6:0:2:0: Direct-A=
ccess     ATA      ST8000AS0002-1NA AR13 PQ: 0 ANSI: 5
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: Enter sas_scsi_re=
cover_host busy: 0 failed: 0
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: dev error handler
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: ata8: end_device-=
6:1: dev error handler
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: ata9: end_device-=
6:2: dev error handler
> Apr 18 10:52:15 overwatch1.math.uh.edu kernel: sas: ata10: end_device=
-6:3: dev error handler
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: ata10.00: ATA-9: ST800=
0AS0002-1NA17Z, AR13, max UDMA/133
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: ata10.00: 15628053168 =
sectors, multi 0: LBA48 NCQ (depth 31/32)
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: ata10.00: configured f=
or UDMA/133
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sas: --- Exit sas_scsi=
_recover_host: busy: 0 failed: 0 tries: 1
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: scsi 6:0:3:0: Direct-A=
ccess     ATA      ST8000AS0002-1NA AR13 PQ: 0 ANSI: 5
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:0:0: [sda] 1562=
8053168 512-byte logical blocks: (8.00 TB/7.27 TiB)
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:0:0: Attached s=
csi generic sg0 type 0
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:1:0: Attached s=
csi generic sg1 type 0
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:1:0: [sdb] 1562=
8053168 512-byte logical blocks: (8.00 TB/7.27 TiB)
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:1:0: [sdb] 4096=
-byte physical blocks
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:2:0: Attached s=
csi generic sg2 type 0
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:1:0: [sdb] Writ=
e Protect is off
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:1:0: [sdb] Mode=
 Sense: 00 3a 00 00
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:1:0: [sdb] Writ=
e cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:2:0: [sdc] 1562=
8053168 512-byte logical blocks: (8.00 TB/7.27 TiB)
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:2:0: [sdc] 4096=
-byte physical blocks
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:3:0: Attached s=
csi generic sg3 type 0
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:3:0: [sdd] 1562=
8053168 512-byte logical blocks: (8.00 TB/7.27 TiB)
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:3:0: [sdd] 4096=
-byte physical blocks
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:3:0: [sdd] Writ=
e Protect is off
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:3:0: [sdd] Mode=
 Sense: 00 3a 00 00
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:3:0: [sdd] Writ=
e cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:2:0: [sdc] Writ=
e Protect is off
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:2:0: [sdc] Mode=
 Sense: 00 3a 00 00
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:2:0: [sdc] Writ=
e cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:0:0: [sda] 4096=
-byte physical blocks
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:0:0: [sda] Writ=
e Protect is off
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:0:0: [sda] Mode=
 Sense: 00 3a 00 00
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:0:0: [sda] Writ=
e cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel:  sda: sda1 sda2 sda3 s=
da4 sda5
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:0:0: [sda] Atta=
ched SCSI disk
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel:  sdb: sdb1 sdb2 sdb3 s=
db4 sdb5
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:1:0: [sdb] Atta=
ched SCSI disk
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel:  sdc: sdc1 sdc2 sdc3 s=
dc4 sdc5
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:2:0: [sdc] Atta=
ched SCSI disk
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel:  sdd: sdd1 sdd2 sdd3 s=
dd4 sdd5
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: sd 6:0:3:0: [sdd] Atta=
ched SCSI disk
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: random: nonblocking po=
ol is initialized
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdc4>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sda3>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sda2>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sda4>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdb4>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdc3>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdb2>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdd4>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: raid1 personality =
registered for level 1
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md/raid1:md1: active w=
ith 4 out of 4 mirrors
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md1: detected capacity=
 change from 0 to 17163091968
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel:  md1: unknown partitio=
n table
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdd3>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdd2>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdc2>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md/raid1:md0: active w=
ith 4 out of 4 mirrors
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: created bitmap (1 page=
s) for device md0
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md0: bitmap initialize=
d from disk: read 1 pages, set 0 of 16 bits
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md0: detected capacity=
 change from 0 to 1073676288
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel:  md0: unknown partitio=
n table
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md: bind<sdb3>
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md/raid1:md2: active w=
ith 4 out of 4 mirrors
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: created bitmap (1 page=
s) for device md2
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md2: bitmap initialize=
d from disk: read 1 pages, set 0 of 1562 bits
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel: md2: detected capacity=
 change from 0 to 104790491136
> Apr 18 10:52:16 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
disk/by-uuid/d39d0f1f-b532-44a9-bf8e-434f34b3dac0.
> Apr 18 10:52:16 overwatch1.math.uh.edu kernel:  md2: unknown partitio=
n table
> Apr 18 10:52:16 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
disk/by-uuid/da90bc36-4600-4fbb-9002-35a8d47ba4eb.
> Apr 18 10:52:17 overwatch1.math.uh.edu dracut-initqueue[334]: Scannin=
g devices md2  for LVM logical volumes os/root os/root
> Apr 18 10:52:18 overwatch1.math.uh.edu dracut-initqueue[334]: inactiv=
e '/dev/os/var' [8.00 GiB] inherit
> Apr 18 10:52:18 overwatch1.math.uh.edu dracut-initqueue[334]: inactiv=
e '/dev/os/root' [10.00 GiB] inherit
> Apr 18 10:52:18 overwatch1.math.uh.edu dracut-initqueue[334]: inactiv=
e '/dev/os/scratch' [1.00 GiB] inherit
> Apr 18 10:52:18 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
mapper/os-root.
> Apr 18 10:52:18 overwatch1.math.uh.edu systemd[1]: Starting File Syst=
em Check on /dev/mapper/os-root...
> Apr 18 10:52:18 overwatch1.math.uh.edu systemd-fsck[684]: /dev/mapper=
/os-root: recovering journal
> Apr 18 10:52:19 overwatch1.math.uh.edu systemd[1]: Started dracut ini=
tqueue hook.
> Apr 18 10:52:19 overwatch1.math.uh.edu systemd[1]: Starting dracut pr=
e-mount hook...
> Apr 18 10:52:19 overwatch1.math.uh.edu systemd[1]: Starting Remote Fi=
le Systems (Pre).
> Apr 18 10:52:19 overwatch1.math.uh.edu systemd[1]: Reached target Rem=
ote File Systems (Pre).
> Apr 18 10:52:19 overwatch1.math.uh.edu systemd[1]: Starting Remote Fi=
le Systems.
> Apr 18 10:52:19 overwatch1.math.uh.edu systemd[1]: Reached target Rem=
ote File Systems.
> Apr 18 10:52:19 overwatch1.math.uh.edu systemd[1]: Started dracut pre=
-mount hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd-fsck[684]: /dev/mapper=
/os-root: clean, 45234/655360 files, 369312/2621440 blocks
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Started File Syste=
m Check on /dev/mapper/os-root.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Mounting /sysroot.=
=2E.
> Apr 18 10:52:20 overwatch1.math.uh.edu kernel: EXT4-fs (dm-0): mounte=
d filesystem with ordered data mode. Opts: (null)
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Mounted /sysroot.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Initrd Ro=
ot File System.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Reached target Ini=
trd Root File System.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Reload Co=
nfiguration from the Real Root...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Reloading.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Started Reload Con=
figuration from the Real Root.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Initrd Fi=
le Systems.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Reached target Ini=
trd File Systems.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Started dracut mou=
nt hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Initrd De=
fault Target.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Reached target Ini=
trd Default Target.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting dracut pr=
e-pivot and cleanup hook...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Started dracut pre=
-pivot and cleanup hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Cleaning =
Up and Shutting Down Daemons...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Cleaning =
Up and Shutting Down Daemons...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Timers.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Tim=
ers.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Plymouth =
switch root service...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped Cleaning U=
p and Shutting Down Daemons.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping dracut pr=
e-pivot and cleanup hook...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped dracut pre=
-pivot and cleanup hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Remote Fi=
le Systems.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Rem=
ote File Systems.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Remote Fi=
le Systems (Pre).
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Rem=
ote File Systems (Pre).
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping dracut pr=
e-mount hook...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped dracut pre=
-mount hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping dracut in=
itqueue hook...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped dracut ini=
tqueue hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Initrd De=
fault Target.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Ini=
trd Default Target.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Basic Sys=
tem.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Bas=
ic System.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Slices.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Sli=
ces.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Paths.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Pat=
hs.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Sockets.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Soc=
kets.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping System In=
itialization.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Sys=
tem Initialization.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Apply Ker=
nel Variables...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped Apply Kern=
el Variables.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping udev Cold=
plug all Devices...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped udev Coldp=
lug all Devices.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping dracut pr=
e-trigger hook...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped dracut pre=
-trigger hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Swap.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Swa=
p.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Local Fil=
e Systems.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped target Loc=
al File Systems.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping udev Kern=
el Device Manager...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Started Plymouth s=
witch root service.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped udev Kerne=
l Device Manager.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping dracut pr=
e-udev hook...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped dracut pre=
-udev hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping dracut cm=
dline hook...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped dracut cmd=
line hook.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Create St=
atic Device Nodes in /dev...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped Create Sta=
tic Device Nodes in /dev.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping Create li=
st of required static device nodes for the current kernel...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopped Create lis=
t of required static device nodes for the current kernel.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping udev Cont=
rol Socket.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Closed udev Contro=
l Socket.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Stopping udev Kern=
el Socket.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Closed udev Kernel=
 Socket.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Cleanup u=
devd DB...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Started Cleanup ud=
evd DB.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Switch Ro=
ot.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Reached target Swi=
tch Root.
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Starting Switch Ro=
ot...
> Apr 18 10:52:20 overwatch1.math.uh.edu systemd[1]: Switching root.
> Apr 18 10:52:20 overwatch1.math.uh.edu [205]: Journal stopped
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd-journal[771]: Runtime =
journal is using 8.0M (max allowed 4.0G, trying to leave 4.0G free of 1=
25.9G available =E2=86=92 current limit 4.0G).
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd-journal[771]: Runtime =
journal is using 8.0M (max allowed 4.0G, trying to leave 4.0G free of 1=
25.9G available =E2=86=92 current limit 4.0G).
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd-journald[205]: Receive=
d SIGTERM from PID 1 (n/a).
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: audit: type=3D1404 aud=
it(1429372341.259:2): enforcing=3D1 old_enforcing=3D0 auid=3D4294967295=
 ses=3D4294967295
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: 2048 avtab ha=
sh slots, 105095 rules.
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: 2048 avtab ha=
sh slots, 105095 rules.
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux:  8 users, 103=
 roles, 4991 types, 294 bools, 1 sens, 1024 cats
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux:  83 classes, =
105095 rules
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux:  Permission a=
udit_read in class capability2 not defined in policy.
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: the above unk=
nown classes and permissions will be allowed
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux:  Completing i=
nitialization.
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux:  Setting up e=
xisting superblocks.
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev rootfs, type rootfs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev bdev, type bdev), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev nsfs, type nsfs), not configured for labeling
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev proc, type proc), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev tmpfs, type tmpfs), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev devtmpfs, type devtmpfs), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev debugfs, type debugfs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev sockfs, type sockfs), uses task SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev pipefs, type pipefs), uses task SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev anon_inodefs, type anon_inodefs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev aio, type aio), not configured for labeling
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev devpts, type devpts), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev hugetlbfs, type hugetlbfs), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev mqueue, type mqueue), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev selinuxfs, type selinuxfs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev sysfs, type sysfs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev securityfs, type securityfs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev tmpfs, type tmpfs), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev tmpfs, type tmpfs), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev tmpfs, type tmpfs), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev pstore, type pstore), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev cgroup, type cgroup), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev configfs, type configfs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev dm-0, type ext4), uses xattr
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: audit: type=3D1403 aud=
it(1429372341.451:3): policy loaded auid=3D4294967295 ses=3D4294967295
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Successfully loade=
d SELinux policy in 363.311ms.
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Relabelled /dev an=
d /run in 36.147ms.
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev autofs, type autofs), uses genfs_contexts
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd-journal[771]: Journal =
started
> Apr 18 10:52:21 overwatch1.math.uh.edu systemd[1]: systemd 216 runnin=
g in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT=
 +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +EL=
=46UTILS +KMOD +IDN)
> Apr 18 10:52:21 overwatch1.math.uh.edu systemd[1]: Detected architect=
ure 'x86-64'.
> Apr 18 10:52:21 overwatch1.math.uh.edu systemd[1]: Set hostname to <o=
verwatch1.math.uh.edu>.
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Configuration file=
 /usr/lib/systemd/system/auditd.service is marked world-inaccessible. T=
his has no effect as configuration data is accessible via APIs without =
restrictions. Proceeding anyway.
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Cannot add depende=
ncy job for unit display-manager.service, ignoring: Unit display-manage=
r.service failed to load: No such file or directory.
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Started Replay Rea=
d-Ahead Data.
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Started Create lis=
t of required static device nodes for the current kernel.
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Starting LVM2 meta=
data daemon...
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Started LVM2 metad=
ata daemon.
> Apr 18 10:52:23 overwatch1.math.uh.edu systemd[1]: Starting File Syst=
em Check on Root Device...
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev tmpfs, type tmpfs), uses transition SIDs
> Apr 18 10:52:23 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev hugetlbfs, type hugetlbfs), uses transition SIDs
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Set Up Add=
itional Binary Formats.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd-fsck[778]: /dev/mapper=
/os-root: clean, 45234/655360 files, 369312/2621440 blocks
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Load legac=
y module configuration.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Load Kerne=
l Modules.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Starting Apply Ker=
nel Variables...
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Mounted FUSE Contr=
ol File System.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Mounted POSIX Mess=
age Queue File System.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Mounted Debug File=
 System.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Mounted Huge Pages=
 File System.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Mounted Temporary =
Directory.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started udev Coldp=
lug all Devices.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Apply Kern=
el Variables.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started File Syste=
m Check on Root Device.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Starting Remount R=
oot and Kernel File Systems...
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: EXT4-fs (dm-0): re-mou=
nted. Opts: (null)
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Remount Ro=
ot and Kernel File Systems.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Import net=
work configuration from initramfs.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Rebuild Dy=
namic Linker Cache.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started First Boot=
 Wizard.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Rebuild Ha=
rdware Database.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Create Sys=
tem Users.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Starting Create St=
atic Device Nodes in /dev...
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Starting Configure=
 read-only root support...
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Create Sta=
tic Device Nodes in /dev.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Starting udev Kern=
el Device Manager...
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Starting Local Fil=
e Systems (Pre).
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Reached target Loc=
al File Systems (Pre).
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Mounting NFSD conf=
iguration filesystem...
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Configure =
read-only root support.
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: RPC: Registered named =
UNIX socket transport module.
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: RPC: Registered udp tr=
ansport module.
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: RPC: Registered tcp tr=
ansport module.
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: RPC: Registered tcp NF=
Sv4.1 backchannel transport module.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd-udevd[797]: starting v=
ersion 216
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: Installing knfsd (copy=
right (C) 1996 okir@monad.swb.de).
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev nfsd, type nfsd), uses genfs_contexts
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Mounted NFSD confi=
guration filesystem.
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started udev Kerne=
l Device Manager.
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: shpchp: Standard Hot P=
lug PCI Controller Driver version: 0.4
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: dca service started, v=
ersion 1.12.1
> Apr 18 10:52:24 overwatch1.math.uh.edu kernel: ioatdma: Intel(R) Quic=
kData Technology Driver 4.00
> Apr 18 10:52:24 overwatch1.math.uh.edu lvm[772]: 1 logical volume(s) =
in volume group "os" monitored
> Apr 18 10:52:24 overwatch1.math.uh.edu systemd[1]: Started Monitoring=
 of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: mei_me 0000:00:16.0: D=
evice doesn't have valid ME Interface
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi message handler v=
ersion 39.2
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: IPMI System Interface =
driver.
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: probing via A=
CPI
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si 00:09: [io  0x=
0ca2] regsize 1 spacing 1 irq 0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: Adding ACPI-s=
pecified kcs state machine
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: probing via S=
MBIOS
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: SMBIOS: io 0x=
ca2 regsize 1 spacing 1 irq 0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: Adding SMBIOS=
-specified kcs state machine duplicate interface
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: probing via S=
PMI
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: SPMI: io 0xca=
2 regsize 1 spacing 1 irq 0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: Adding SPMI-s=
pecified kcs state machine duplicate interface
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si: Trying ACPI-s=
pecified kcs state machine at i/o address 0xca2, slave address 0x0, irq=
 0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: pps_core: LinuxPPS API=
 ver. 1 registered
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: pps_core: Software ver=
=2E 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: i801_smbus 0000:00:1f.=
3: SMBus using PCI interrupt
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC MC: Ver: 3.0.0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: wmi: Mapper loaded
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md: bind<sdb5>
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: alg: No test for crc32=
 (crc32-pclmul)
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: PTP clock support regi=
stered
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb: Intel(R) Gigabit =
Ethernet Network Driver - version 5.2.15-k
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb: Copyright (c) 200=
7-2014 Intel Corporation.
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md: bind<sdd5>
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si 00:09: Found n=
ew BMC (man_id: 0x002a7c, prod_id: 0xaabb, dev_id: 0x20)
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: ipmi_si 00:09: IPMI kc=
s interface initialized
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: IPMI SSIF Interface dr=
iver
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ea0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ea0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ea0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ea8
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ea8
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ea8
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0e71
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0e71
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0e71
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eaa
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eaa
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eaa
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eab
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eab
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eab
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eac
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eac
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eac
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ead
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ead
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ead
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ec8
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ec8
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ec8
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ec9
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ec9
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ec9
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eca
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eca
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eca
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0e60
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0e6a
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0e6b
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0eb8
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge: Seeking =
for: PCI ID 8086:0ebc
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC MC0: Giving out d=
evice to module sbridge_edac.c controller Ivy Bridge Socket#0: DEV 0000=
:7f:0e.0 (POLLED)
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC MC1: Giving out d=
evice to module sbridge_edac.c controller Ivy Bridge Socket#1: DEV 0000=
:ff:0e.0 (POLLED)
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: EDAC sbridge:  Ver: 1.=
1.0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.0: DCA =
enabled
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.0: adde=
d PHC on eth0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.0: Inte=
l(R) Gigabit Ethernet Network Connection
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.0: eth0=
: (PCIe:5.0Gb/s:Width x4) 00:25:90:e7:2f:c6
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.0: eth0=
: PBA No: 106100-000
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.0: Usin=
g MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md: bind<sda5>
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: iTCO_vendor_support: v=
endor-support=3D0
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: iTCO_wdt: Intel TCO Wa=
tchDog Timer Driver v1.11
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: iTCO_wdt: unable to re=
set NO_REBOOT flag, device disabled by hardware/BIOS
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.1: DCA =
enabled
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.1: adde=
d PHC on eth1
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.1: Inte=
l(R) Gigabit Ethernet Network Connection
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.1: eth1=
: (PCIe:5.0Gb/s:Width x4) 00:25:90:e7:2f:c7
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.1: eth1=
: PBA No: 106100-000
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.1: Usin=
g MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.0 eno1:=
 renamed from eth0
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Starting system-lv=
m2\x2dpvscan.slice.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Created slice syst=
em-lvm2\x2dpvscan.slice.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Starting LVM2 PV s=
can on device 9:2...
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md: bind<sdc5>
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md: raid10 personality=
 registered for level 10
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md/raid10:md3: active =
with 3 out of 4 devices
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: igb 0000:02:00.1 eno2:=
 renamed from eth1
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
mapper/os-var.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Starting File Syst=
em Check on /dev/mapper/os-var...
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: created bitmap (115 pa=
ges) for device md3
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
disk/by-uuid/d39d0f1f-b532-44a9-bf8e-434f34b3dac0.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Load legac=
y module configuration.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Load Kerne=
l Modules.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Dispatch P=
assword Requests to Console Directory Watch.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Set Up Add=
itional Binary Formats.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Rebuild Ha=
rdware Database.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Mounted FUSE Contr=
ol File System.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started First Boot=
 Wizard.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Create Sys=
tem Users.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Rebuild Dy=
namic Linker Cache.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Import net=
work configuration from initramfs.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Starting File Syst=
em Check on /dev/disk/by-uuid/d39d0f1f-b532-44a9-bf8e-434f34b3dac0...
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md3: bitmap initialize=
d from disk: read 8 pages, set 4482 of 234793 bits
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd-fsck[893]: /dev/mapper=
/os-var: recovering journal
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: md3: detected capacity=
 change from 0 to 15756628590592
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: RAID10 conf printout:
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  --- wd:3 rd:4
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 0, wo:1, o:1, de=
v:sda5
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 1, wo:0, o:1, de=
v:sdb5
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 2, wo:0, o:1, de=
v:sdc5
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 3, wo:0, o:1, de=
v:sdd5
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: RAID10 conf printout:
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  --- wd:3 rd:4
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 0, wo:1, o:1, de=
v:sda5
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 1, wo:0, o:1, de=
v:sdb5
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 2, wo:0, o:1, de=
v:sdc5
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel:  disk 3, wo:0, o:1, de=
v:sdd5
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
disk/by-uuid/da90bc36-4600-4fbb-9002-35a8d47ba4eb.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Load legac=
y module configuration.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Load Kerne=
l Modules.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Dispatch P=
assword Requests to Console Directory Watch.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Set Up Add=
itional Binary Formats.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Rebuild Ha=
rdware Database.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Mounted FUSE Contr=
ol File System.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started First Boot=
 Wizard.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Create Sys=
tem Users.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Rebuild Dy=
namic Linker Cache.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started Import net=
work configuration from initramfs.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Activating swap /d=
ev/disk/by-uuid/da90bc36-4600-4fbb-9002-35a8d47ba4eb...
> Apr 18 10:52:25 overwatch1.math.uh.edu lvm[874]: 3 logical volume(s) =
in volume group "os" now active
> Apr 18 10:52:25 overwatch1.math.uh.edu kernel: Adding 16760828k swap =
on /dev/md1.  Priority:-1 extents:1 across:16760828k FS
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
mapper/os-scratch.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Activated swap /de=
v/disk/by-uuid/da90bc36-4600-4fbb-9002-35a8d47ba4eb.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Started LVM2 PV sc=
an on device 9:2.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Starting Swap.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Reached target Swa=
p.
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd[1]: Starting File Syst=
em Check on /dev/mapper/os-scratch...
> Apr 18 10:52:25 overwatch1.math.uh.edu systemd-fsck[906]: /dev/mapper=
/os-scratch: recovering journal
> Apr 18 10:52:26 overwatch1.math.uh.edu kernel: md: recovery of RAID a=
rray md3
> Apr 18 10:52:26 overwatch1.math.uh.edu kernel: md: minimum _guarantee=
d_  speed: 1000 KB/sec/disk.
> Apr 18 10:52:26 overwatch1.math.uh.edu kernel:  md3: unknown partitio=
n table
> Apr 18 10:52:26 overwatch1.math.uh.edu kernel: md: using maximum avai=
lable idle IO bandwidth (but not more than 200000 KB/sec) for recovery.
> Apr 18 10:52:26 overwatch1.math.uh.edu kernel: md: using 128k window,=
 over a total of 7693666304k.
> Apr 18 10:52:26 overwatch1.math.uh.edu kernel: md: resuming recovery =
of md3 from checkpoint.
> Apr 18 10:52:26 overwatch1.math.uh.edu systemd-fsck[895]: /dev/md0: r=
ecovering journal
> Apr 18 10:52:26 overwatch1.math.uh.edu systemd-fsck[906]: /dev/mapper=
/os-scratch: clean, 11/65536 files, 12635/262144 blocks
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Started File Syste=
m Check on /dev/mapper/os-scratch.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounting /scratch.=
=2E.
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel:  md0: unknown partitio=
n table
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel: EXT4-fs (dm-2): mounte=
d filesystem with ordered data mode. Opts: (null)
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev dm-2, type ext4), uses xattr
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounted /scratch.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Starting LVM2 PV s=
can on device 9:3...
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd-fsck[895]: /dev/md0: c=
lean, 348/65536 files, 50002/262128 blocks
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd-fsck[893]: /dev/mapper=
/os-var: Clearing orphaned inode 393408 (uid=3D0, gid=3D0, mode=3D01006=
44, size=3D6406312)
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd-fsck[893]: /dev/mapper=
/os-var: Clearing orphaned inode 393396 (uid=3D0, gid=3D0, mode=3D01006=
44, size=3D8406312)
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd-fsck[893]: /dev/mapper=
/os-var: clean, 2313/524288 files, 171644/2097152 blocks
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Started File Syste=
m Check on /dev/disk/by-uuid/d39d0f1f-b532-44a9-bf8e-434f34b3dac0.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounting /boot...
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel: EXT4-fs (md0): mounted=
 filesystem with ordered data mode. Opts: (null)
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev md0, type ext4), uses xattr
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounted /boot.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Started File Syste=
m Check on /dev/mapper/os-var.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounting /var...
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel: EXT4-fs (dm-1): mounte=
d filesystem with ordered data mode. Opts: (null)
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev dm-1, type ext4), uses xattr
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounted /var.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Starting Flush Jou=
rnal to Persistent Storage...
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Starting Load/Save=
 Random Seed...
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounting RPC Pipe =
=46ile System...
> Apr 18 10:52:27 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
> Apr 18 10:52:28 overwatch1.math.uh.edu systemd-journal[771]: Permanen=
t journal is using 80.0M (max allowed 793.5M, trying to leave 1.1G free=
 of 6.9G available =E2=86=92 current limit 793.5M).
> Apr 18 10:52:28 overwatch1.math.uh.edu systemd-journal[771]: Time spe=
nt on flushing to /var is 55.766ms for 1425 entries.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Mounted RPC Pipe F=
ile System.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Started Load/Save =
Random Seed.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Found device /dev/=
recordings/cam.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Started LVM2 PV sc=
an on device 9:3.
> Apr 18 10:52:27 overwatch1.math.uh.edu systemd[1]: Starting File Syst=
em Check on /dev/recordings/cam...
> Apr 18 10:52:28 overwatch1.math.uh.edu systemd[1]: Started Flush Jour=
nal to Persistent Storage.
> Apr 18 10:52:28 overwatch1.math.uh.edu lvm[921]: 1 logical volume(s) =
in volume group "recordings" now active
> Apr 18 10:52:28 overwatch1.math.uh.edu systemd-fsck[946]: /dev/mapper=
/recordings-cam: recovering journal
> Apr 18 10:52:28 overwatch1.math.uh.edu systemd-fsck[946]: /dev/mapper=
/recordings-cam: clean, 147490/480854016 files, 578398208/3846832128 bl=
ocks
> Apr 18 10:52:28 overwatch1.math.uh.edu systemd[1]: Started File Syste=
m Check on /dev/recordings/cam.
> Apr 18 10:52:28 overwatch1.math.uh.edu systemd[1]: Mounting /srv/cam.=
=2E.
> Apr 18 10:52:29 overwatch1.math.uh.edu kernel: EXT4-fs (dm-3): mounte=
d filesystem with ordered data mode. Opts: acl,user_xattr
> Apr 18 10:52:29 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev dm-3, type ext4), uses xattr
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Mounted /srv/cam.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Local Fil=
e Systems.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Reached target Loc=
al File Systems.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Create Vo=
latile Files and Directories...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Rebuild Jo=
urnal Catalog.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Update is =
Completed.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Tell Plym=
outh To Write Out Runtime Data...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Mark the n=
eed to relabel after reboot.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Relabel al=
l filesystems, if necessary.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Tell Plymo=
uth To Write Out Runtime Data.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Create Vol=
atile Files and Directories.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Security =
Auditing Service...
> Apr 18 10:52:29 overwatch1.math.uh.edu auditctl[963]: No rules
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Security A=
uditing Service.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Update UT=
MP about System Boot/Shutdown...
> Apr 18 10:52:29 overwatch1.math.uh.edu auditd[962]: Started dispatche=
r: /sbin/audispd pid: 970
> Apr 18 10:52:29 overwatch1.math.uh.edu audispd[970]: priority_boost_p=
arser called with: 4
> Apr 18 10:52:29 overwatch1.math.uh.edu audispd[970]: max_restarts_par=
ser called with: 10
> Apr 18 10:52:29 overwatch1.math.uh.edu audispd[970]: No plugins found=
, exiting
> Apr 18 10:52:29 overwatch1.math.uh.edu kernel: audit: type=3D1305 aud=
it(1429372349.486:4): audit_pid=3D962 old=3D0 auid=3D4294967295 ses=3D4=
294967295 subj=3Dsystem_u:system_r:auditd_t:s0 res=3D1
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Update UTM=
P about System Boot/Shutdown.
> Apr 18 10:52:29 overwatch1.math.uh.edu auditd[962]: Init complete, au=
ditd 2.4.1 listening for events (startup state enable)
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting System In=
itialization.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Reached target Sys=
tem Initialization.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting RPCbind S=
erver Activation Socket.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Listening on RPCbi=
nd Server Activation Socket.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting ACPID Lis=
ten Socket.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Listening on ACPID=
 Listen Socket.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Daily Cle=
anup of Temporary Directories.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Daily Clea=
nup of Temporary Directories.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Timers.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Reached target Tim=
ers.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting D-Bus Sys=
tem Message Bus Socket.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Listening on D-Bus=
 System Message Bus Socket.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Sockets.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Reached target Soc=
kets.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Basic Sys=
tem.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Reached target Bas=
ic System.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting NTP clien=
t/server...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Run autom=
atic yum updates as a cron job...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Self Moni=
toring and Reporting Technology (SMART) Daemon...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Self Monit=
oring and Reporting Technology (SMART) Daemon.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting IPv4 fire=
wall with iptables...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Network M=
anager...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting System Se=
curity Services Daemon...
> Apr 18 10:52:29 overwatch1.math.uh.edu chronyd[978]: chronyd version =
1.31 starting
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Kernel Mo=
dule supporting RPCSEC_GSS...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Preproces=
s NFS configuration...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started OpenSSH Se=
rver Key Generation.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Software =
RAID monitoring and management...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting D-Bus Sys=
tem Message Bus...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started D-Bus Syst=
em Message Bus.
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: smartd 6.2 2014-0=
7-16 r3952 [x86_64-linux-3.19.4-200.fc21.x86_64] (local build)
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Copyright (C) 200=
2-13, Bruce Allen, Christian Franke, www.smartmontools.org
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Opened configurat=
ion file /etc/smartmontools/smartd.conf
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Configuration fil=
e /etc/smartmontools/smartd.conf was parsed, found DEVICESCAN, scanning=
 devices
> Apr 18 10:52:29 overwatch1.math.uh.edu chronyd[978]: Frequency 12.865=
 +/- 0.006 ppm read from /var/lib/chrony/drift
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sda,=
 type changed from 'scsi' to 'sat'
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sda =
[SAT], opened
> Apr 18 10:52:29 overwatch1.math.uh.edu sssd[1006]: Starting up
> Apr 18 10:52:29 overwatch1.math.uh.edu kernel: nf_conntrack version 0=
=2E5.0 (16384 buckets, 65536 max)
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  N=
etworkManager (version 0.9.10.2-2.fc21) is starting...
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  R=
ead config: /etc/NetworkManager/NetworkManager.conf
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  W=
EXT support is enabled
> Apr 18 10:52:29 overwatch1.math.uh.edu iptables.init[977]: iptables: =
Applying firewall rules: [  OK  ]
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sda =
[SAT], ST8000AS0002-1NA17Z, S/N:Z8402YZM, WWN:5-000c50-07b026fbb, FW:AR=
13, 8.00 TB
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sda =
[SAT], not found in smartd database.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Run automa=
tic yum updates as a cron job.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started IPv4 firew=
all with iptables.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Kernel Mod=
ule supporting RPCSEC_GSS.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Preprocess=
 NFS configuration.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Software R=
AID monitoring and management.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting NFSv4 ID-=
name mapping service...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting GSSAPI Pr=
oxy Daemon...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started NTP client=
/server.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started NFSv4 ID-n=
ame mapping service.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started GSSAPI Pro=
xy Daemon.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting RPC secur=
ity service for NFS client and server...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started RPC securi=
ty service for NFS server.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started RPC securi=
ty service for NFS client and server.
> Apr 18 10:52:29 overwatch1.math.uh.edu sssd[be[default]][1029]: Start=
ing up
> Apr 18 10:52:29 overwatch1.math.uh.edu sssd[autofs][1032]: Starting u=
p
> Apr 18 10:52:29 overwatch1.math.uh.edu sssd[nss][1030]: Starting up
> Apr 18 10:52:29 overwatch1.math.uh.edu sssd[pam][1031]: Starting up
> Apr 18 10:52:29 overwatch1.math.uh.edu dbus[985]: [system] Activating=
 via systemd: service name=3D'org.freedesktop.PolicyKit1' unit=3D'polki=
t.service'
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Authoriza=
tion Manager...
> Apr 18 10:52:29 overwatch1.math.uh.edu polkitd[1034]: Started polkitd=
 version 0.112
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started System Sec=
urity Services Daemon.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting User and =
Group Name Lookups.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Reached target Use=
r and Group Name Lookups.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Starting Login Ser=
vice...
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Login Serv=
ice.
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd-logind[1036]: Watching=
 system buttons on /dev/input/event1 (Power Button)
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd-logind[1036]: Watching=
 system buttons on /dev/input/event0 (Power Button)
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd-logind[1036]: New seat=
 seat0.
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sda =
[SAT], is SMART capable. Adding to "monitor" list.
> Apr 18 10:52:29 overwatch1.math.uh.edu polkitd[1034]: Loading rules f=
rom directory /etc/polkit-1/rules.d
> Apr 18 10:52:29 overwatch1.math.uh.edu polkitd[1034]: Loading rules f=
rom directory /usr/share/polkit-1/rules.d
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdb,=
 type changed from 'scsi' to 'sat'
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdb =
[SAT], opened
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdb =
[SAT], ST8000AS0002-1NA17Z, S/N:Z8402KCQ, WWN:5-000c50-07ad140bf, FW:AR=
13, 8.00 TB
> Apr 18 10:52:29 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdb =
[SAT], not found in smartd database.
> Apr 18 10:52:29 overwatch1.math.uh.edu polkitd[1034]: Finished loadin=
g, compiling and executing 3 rules
> Apr 18 10:52:29 overwatch1.math.uh.edu dbus[985]: [system] Successful=
ly activated service 'org.freedesktop.PolicyKit1'
> Apr 18 10:52:29 overwatch1.math.uh.edu polkitd[1034]: Acquired the na=
me org.freedesktop.PolicyKit1 on the system bus
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
cquired D-Bus service com.redhat.ifcfgrh1
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  L=
oaded plugin ifcfg-rh: (c) 2007 - 2013 Red Hat, Inc.  To report bugs pl=
ease use the NetworkManager mailing list.
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  L=
oaded plugin keyfile: (c) 2007 - 2013 Red Hat, Inc.  To report bugs ple=
ase use the NetworkManager mailing list.
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  p=
arsing /etc/sysconfig/network-scripts/ifcfg-eno1 ...
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>   =
   read connection 'eno1'
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  p=
arsing /etc/sysconfig/network-scripts/ifcfg-lo ...
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>  p=
arsing /etc/sysconfig/network-scripts/ifcfg-eno2 ...
> Apr 18 10:52:29 overwatch1.math.uh.edu NetworkManager[979]: <info>   =
   read connection 'eno2'
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  m=
onitoring kernel firmware directory '/lib/firmware'.
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  W=
iFi enabled by radio killswitch; enabled by state file
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  W=
WAN enabled by radio killswitch; enabled by state file
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  W=
iMAX enabled by radio killswitch; enabled by state file
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  N=
etworking is enabled by state file
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
lo): link connected
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
lo): carrier is ON
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
lo): new Generic device (driver: 'unknown' ifindex: 1)
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
lo): exported as /org/freedesktop/NetworkManager/Devices/0
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): carrier is OFF
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): new Ethernet device (driver: 'igb' ifindex: 2)
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): exported as /org/freedesktop/NetworkManager/Devices/1
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: unmanaged -> unavailable (reason 'managed')=
 [10 20 2]
> Apr 18 10:52:29 overwatch1.math.uh.edu systemd[1]: Started Authorizat=
ion Manager.
> Apr 18 10:52:30 overwatch1.math.uh.edu systemd[1]: Started Network Ma=
nager.
> Apr 18 10:52:30 overwatch1.math.uh.edu systemd[1]: Starting Network M=
anager Wait Online...
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdb =
[SAT], is SMART capable. Adding to "monitor" list.
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdc,=
 type changed from 'scsi' to 'sat'
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdc =
[SAT], opened
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdc =
[SAT], ST8000AS0002-1NA17Z, S/N:Z8402EZ1, WWN:5-000c50-07acf481b, FW:AR=
13, 8.00 TB
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdc =
[SAT], not found in smartd database.
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): preparing device
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno2): carrier is OFF
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno2): new Ethernet device (driver: 'igb' ifindex: 3)
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno2): exported as /org/freedesktop/NetworkManager/Devices/2
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno2): device state change: unmanaged -> unavailable (reason 'managed')=
 [10 20 2]
> Apr 18 10:52:30 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno2): preparing device
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdc =
[SAT], is SMART capable. Adding to "monitor" list.
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdd,=
 type changed from 'scsi' to 'sat'
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdd =
[SAT], opened
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdd =
[SAT], ST8000AS0002-1NA17Z, S/N:Z8402FNN, WWN:5-000c50-07acecaad, FW:AR=
13, 8.00 TB
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdd =
[SAT], not found in smartd database.
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Device: /dev/sdd =
[SAT], is SMART capable. Adding to "monitor" list.
> Apr 18 10:52:30 overwatch1.math.uh.edu smartd[975]: Monitoring 4 ATA =
and 0 SCSI devices
> Apr 18 10:52:34 overwatch1.math.uh.edu kernel: igb 0000:02:00.0 eno1:=
 igb: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): link connected
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: unavailable -> disconnected (reason 'carrie=
r-changed') [20 30 40]
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
uto-activating connection 'eno1'.
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) starting connection 'eno1'
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 1 of 5 (Device Prepare) scheduled...
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 1 of 5 (Device Prepare) started...
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: disconnected -> prepare (reason 'none') [30=
 40 0]
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  N=
etworkManager state is now CONNECTING
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 2 of 5 (Device Configure) scheduled...
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 1 of 5 (Device Prepare) complete.
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 2 of 5 (Device Configure) starting...
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: prepare -> config (reason 'none') [40 50 0]
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 2 of 5 (Device Configure) successful.
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 3 of 5 (IP Configure Start) scheduled.
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 2 of 5 (Device Configure) complete.
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 3 of 5 (IP Configure Start) started...
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: config -> ip-config (reason 'none') [50 70 =
0]
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 5 of 5 (IPv4 Configure Commit) scheduled...
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 3 of 5 (IP Configure Start) complete.
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 5 of 5 (IPv4 Commit) started...
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: ip-config -> ip-check (reason 'none') [70 8=
0 0]
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) Stage 5 of 5 (IPv4 Commit) complete.
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: ip-check -> secondaries (reason 'none') [80=
 90 0]
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  (=
eno1): device state change: secondaries -> activated (reason 'none') [9=
0 100 0]
> Apr 18 10:52:34 overwatch1.math.uh.edu NetworkManager[979]: <info>  N=
etworkManager state is now CONNECTED_LOCAL
> Apr 18 10:52:35 overwatch1.math.uh.edu NetworkManager[979]: <info>  N=
etworkManager state is now CONNECTED_GLOBAL
> Apr 18 10:52:35 overwatch1.math.uh.edu NetworkManager[979]: <info>  P=
olicy set 'eno1' (eno1) as default for IPv4 routing and DNS.
> Apr 18 10:52:35 overwatch1.math.uh.edu NetworkManager[979]: <info>  A=
ctivation (eno1) successful, device activated.
> Apr 18 10:52:35 overwatch1.math.uh.edu dbus[985]: [system] Activating=
 via systemd: service name=3D'org.freedesktop.nm_dispatcher' unit=3D'db=
us-org.freedesktop.nm-dispatcher.service'
> Apr 18 10:52:35 overwatch1.math.uh.edu systemd[1]: Starting Network M=
anager Script Dispatcher Service...
> Apr 18 10:52:35 overwatch1.math.uh.edu dbus[985]: [system] Successful=
ly activated service 'org.freedesktop.nm_dispatcher'
> Apr 18 10:52:35 overwatch1.math.uh.edu systemd[1]: Started Network Ma=
nager Script Dispatcher Service.
> Apr 18 10:52:35 overwatch1.math.uh.edu nm-dispatcher[1048]: Dispatchi=
ng action 'up' for eno1
> Apr 18 10:52:39 overwatch1.math.uh.edu NetworkManager[979]: <info>  s=
tartup complete
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Started Network Ma=
nager Wait Online.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting Network.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Reached target Net=
work.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting Postfix M=
ail Transport Agent...
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting NFS Mount=
 Daemon...
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting NFS statu=
s monitor for NFSv2/3 locking....
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting OpenSSH s=
erver daemon...
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Started OpenSSH se=
rver daemon.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting Network i=
s Online.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Reached target Net=
work is Online.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting Automount=
s filesystems on demand...
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting /etc/rc.d=
/rc.local Compatibility...
> Apr 18 10:52:39 overwatch1.math.uh.edu rpc.statd[1085]: Version 1.3.1=
 starting
> Apr 18 10:52:39 overwatch1.math.uh.edu rpc.statd[1085]: Flags: TI-RPC
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Starting RPC bind =
service...
> Apr 18 10:52:39 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev autofs, type autofs), uses genfs_contexts
> Apr 18 10:52:39 overwatch1.math.uh.edu sshd[1082]: Server listening o=
n 0.0.0.0 port 22.
> Apr 18 10:52:39 overwatch1.math.uh.edu sshd[1082]: Server listening o=
n :: port 22.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Started RPC bind s=
ervice.
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Started /etc/rc.d/=
rc.local Compatibility.
> Apr 18 10:52:39 overwatch1.math.uh.edu rpc.mountd[1109]: Version 1.3.=
1 starting
> Apr 18 10:52:39 overwatch1.math.uh.edu systemd[1]: Started NFS Mount =
Daemon.
> Apr 18 10:52:41 overwatch1.math.uh.edu postfix/postfix-script[1177]: =
starting the Postfix mail system
> Apr 18 10:52:41 overwatch1.math.uh.edu postfix/master[1179]: daemon s=
tarted -- version 2.11.3, configuration /etc/postfix
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started NFS status=
 monitor for NFSv2/3 locking..
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Postfix Ma=
il Transport Agent.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting NFS serve=
r and services...
> Apr 18 10:52:41 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev autofs, type autofs), uses genfs_contexts
> Apr 18 10:52:41 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev autofs, type autofs), uses genfs_contexts
> Apr 18 10:52:41 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev autofs, type autofs), uses genfs_contexts
> Apr 18 10:52:41 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev autofs, type autofs), uses genfs_contexts
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Automounts=
 filesystems on demand.
> Apr 18 10:52:41 overwatch1.math.uh.edu kernel: NFSD: starting 90-seco=
nd grace period (net ffffffff81ce9680)
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started NFS server=
 and services.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Notify NF=
S peers of a restart...
> Apr 18 10:52:41 overwatch1.math.uh.edu sm-notify[1209]: Version 1.3.1=
 starting
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Notify NFS=
 peers of a restart.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting NFS clien=
t services.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Reached target NFS=
 client services.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Remote Fi=
le Systems (Pre).
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Reached target Rem=
ote File Systems (Pre).
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Remote Fi=
le Systems.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Reached target Rem=
ote File Systems.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting The Apach=
e HTTP Server...
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Permit Us=
er Sessions...
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Permit Use=
r Sessions.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Command S=
cheduler...
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Command Sc=
heduler.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Terminate=
 Plymouth Boot Screen...
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Wait for =
Plymouth Boot Screen to Quit...
> Apr 18 10:52:41 overwatch1.math.uh.edu crond[1214]: (CRON) INFO (RAND=
OM_DELAY will be scaled with factor 96% if used.)
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Received SIGRTMIN+=
21 from PID 336 (plymouthd).
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Terminate =
Plymouth Boot Screen.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Wait for P=
lymouth Boot Screen to Quit.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Getty on =
tty1...
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Started Getty on t=
ty1.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Starting Login Pro=
mpts.
> Apr 18 10:52:41 overwatch1.math.uh.edu systemd[1]: Reached target Log=
in Prompts.
> Apr 18 10:52:41 overwatch1.math.uh.edu chronyd[978]: Selected source =
97.107.128.58
> Apr 18 10:52:41 overwatch1.math.uh.edu kernel: Adjusting tsc more tha=
n 11% (7759381 vs 7449090)
> Apr 18 10:52:41 overwatch1.math.uh.edu crond[1214]: (CRON) INFO (runn=
ing with inotify support)
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Started The Apache=
 HTTP Server.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Starting Multi-Use=
r System.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Reached target Mul=
ti-User System.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Starting Graphical=
 Interface.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Reached target Gra=
phical Interface.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Starting Stop Read=
-Ahead Data Collection 10s After Completed Startup.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Started Stop Read-=
Ahead Data Collection 10s After Completed Startup.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Starting Update UT=
MP about System Runlevel Changes...
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Started Update UTM=
P about System Runlevel Changes.
> Apr 18 10:52:42 overwatch1.math.uh.edu systemd[1]: Startup finished i=
n 1.381s (kernel) + 9.358s (initrd) + 21.170s (userspace) =3D 31.910s.
> Apr 18 10:53:02 overwatch1.math.uh.edu kernel: FS-Cache: Loaded
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: FS-Cache: Netfs 'nfs' =
registered for caching
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: Key type dns_resolver =
registered
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: NFS: Registering the i=
d_resolver key type
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: Key type id_resolver r=
egistered
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: Key type id_legacy reg=
istered
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev 0:42, type nfs4), uses genfs_contexts
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev 0:43, type nfs4), uses genfs_contexts
> Apr 18 10:53:03 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev 0:44, type nfs4), uses genfs_contexts
> Apr 18 10:53:07 overwatch1.math.uh.edu kernel: SELinux: initialized (=
dev tmpfs, type tmpfs), uses transition SIDs
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: Enter sas_scsi_re=
cover_host busy: 11 failed: 11
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff114e500
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff114e500
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff114e500, old_request =3D=3D ffff881ff0037000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
4e500 , old_request =3D=3D ffff881ff0037000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff114e500 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff114e500 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1176a00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1176a00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1176a00, old_request =3D=3D ffff881ff0bcc000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
76a00 , old_request =3D=3D ffff881ff0bcc000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1176a00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1176a00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1177d00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1177d00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1177d00, old_request =3D=3D ffff881ff003c000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
77d00 , old_request =3D=3D ffff881ff003c000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1177d00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1177d00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1177200
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1177200
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1177200, old_request =3D=3D ffff881ff08dc000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
77200 , old_request =3D=3D ffff881ff08dc000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1177200 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1177200 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1176600
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1176600
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1176600, old_request =3D=3D ffff881ff0bca000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
76600 , old_request =3D=3D ffff881ff0bca000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1176600 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1176600 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1177e00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1177e00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1177e00, old_request =3D=3D ffff881ff000b000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
77e00 , old_request =3D=3D ffff881ff000b000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1177e00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1177e00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1176200
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1176200
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1176200, old_request =3D=3D ffff881ff0a2e000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
76200 , old_request =3D=3D ffff881ff0a2e000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1176200 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1176200 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1176f00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1176f00
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1176f00, old_request =3D=3D ffff881ff0065000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
76f00 , old_request =3D=3D ffff881ff0065000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1176f00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1176f00 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1177400
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1177400
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1177400, old_request =3D=3D ffff881ff0024000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
77400 , old_request =3D=3D ffff881ff0024000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1177400 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1177400 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1176500
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1176500
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1176500, old_request =3D=3D ffff881ff0ab9000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
76500 , old_request =3D=3D ffff881ff0ab9000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1176500 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1176500 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff1177800
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff1177800
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff1177800, old_request =3D=3D ffff881ff006b000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff11=
77800 , old_request =3D=3D ffff881ff006b000
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff1177800 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff1177800 is done
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: cmd error handler
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: dev error handler
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: exception Ema=
sk 0x0 SAct 0x7ff SErr 0x0 action 0x6 frozen
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: ata8: end_device-=
6:1: dev error handler
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: ata9: end_device-=
6:2: dev error handler
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: ata10: end_device=
-6:3: dev error handler
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:58:2b/29:00:5e:01:00/40 tag 0 ncq 5373952 out
>                                                         res 40/00:01:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
80:81:2b/05:00:5e:01:00/40 tag 1 ncq 720896 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
00:87:2b/01:00:5e:01:00/40 tag 2 ncq 196608 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:88:2b/04:00:5e:01:00/40 tag 3 ncq 524288 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:8c:2b/04:00:5e:01:00/40 tag 4 ncq 524288 out
>                                                         res 40/00:01:=
01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:90:2b/04:00:5e:01:00/40 tag 5 ncq 524288 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:94:2b/03:00:5e:01:00/40 tag 6 ncq 393216 out
>                                                         res 40/00:01:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:97:2b/04:00:5e:01:00/40 tag 7 ncq 524288 out
>                                                         res 40/00:ff:=
00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:9b:2b/04:00:5e:01:00/40 tag 8 ncq 524288 out
>                                                         res 40/00:00:=
00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:9f:2b/04:00:5e:01:00/40 tag 9 ncq 524288 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:a3:2b/08:00:5e:01:00/40 tag 10 ncq 1048576 out
>                                                         res 40/00:ff:=
00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7: hard resetting l=
ink
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: configured fo=
r UDMA/133
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: ata7: EH complete
> Apr 18 11:20:46 overwatch1.math.uh.edu kernel: sas: --- Exit sas_scsi=
_recover_host: busy: 0 failed: 0 tries: 1
> Apr 18 11:46:42 overwatch1.math.uh.edu kernel: sas: Enter sas_scsi_re=
cover_host busy: 14 failed: 14
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff1dd0300
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff1dd0300
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff1dd0300, old_request =3D=3D ffff881ff005f000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff1d=
d0300 , old_request =3D=3D ffff881ff005f000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff1dd0300 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff1dd0300 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff1dd1900
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff1dd1900
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff1dd1900, old_request =3D=3D ffff881ff003a000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff1d=
d1900 , old_request =3D=3D ffff881ff003a000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff1dd1900 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff1dd1900 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff0ac5900
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff0ac5900
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff0ac5900, old_request =3D=3D ffff881ff08f8000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff0a=
c5900 , old_request =3D=3D ffff881ff08f8000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff0ac5900 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff0ac5900 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff0ac5e00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff0ac5e00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff0ac5e00, old_request =3D=3D ffff881ff0abb000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff0a=
c5e00 , old_request =3D=3D ffff881ff0abb000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff0ac5e00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff0ac5e00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff0ac4d00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff0ac4d00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff0ac4d00, old_request =3D=3D ffff881ff0bc1000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff0a=
c4d00 , old_request =3D=3D ffff881ff0bc1000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff0ac4d00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff0ac4d00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff1dd0f00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff1dd0f00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff1dd0f00, old_request =3D=3D ffff881ff0bfd000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff1d=
d0f00 , old_request =3D=3D ffff881ff0bfd000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff1dd0f00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff1dd0f00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff10fca00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff10fca00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff10fca00, old_request =3D=3D ffff881ff0008000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff10=
fca00 , old_request =3D=3D ffff881ff0008000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff10fca00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff10fca00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff10fc600
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff10fc600
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff10fc600, old_request =3D=3D ffff881ff001f000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff10=
fc600 , old_request =3D=3D ffff881ff001f000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff10fc600 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff10fc600 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff10fd700
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff10fd700
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff10fd700, old_request =3D=3D ffff881ff0bca000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff10=
fd700 , old_request =3D=3D ffff881ff0bca000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff10fd700 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff10fd700 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff10fda00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff10fda00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff10fda00, old_request =3D=3D ffff881ff0bce000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff10=
fda00 , old_request =3D=3D ffff881ff0bce000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff10fda00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff10fda00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff10fd100
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff10fd100
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff10fd100, old_request =3D=3D ffff881ff004e000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff10=
fd100 , old_request =3D=3D ffff881ff004e000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff10fd100 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff10fd100 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff881ff10fdb00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff881ff10fdb00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
1ff10fdb00, old_request =3D=3D ffff881ff0b7d000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff881ff10=
fdb00 , old_request =3D=3D ffff881ff0b7d000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff881ff10fdb00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff881ff10fdb00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff0ac5b00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff0ac5b00
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff0ac5b00, old_request =3D=3D ffff881ff0bfb000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff0a=
c5b00 , old_request =3D=3D ffff881ff0bfb000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff0ac5b00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff0ac5b00 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: trying to find ta=
sk 0xffff883ff0ac4200
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: aborting task 0xffff883ff0ac4200
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: dev =3D ffff881ff0b44208 (STP/SATA), task =3D ffff88=
3ff0ac4200, old_request =3D=3D ffff881ff0029000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: SATA/STP request or complete_in_target (1), or IDEV_=
GONE (0), thus no TMF
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: isci 0000:06:00.0: isc=
i_task_abort_task: Done; dev =3D ffff881ff0b44208, task =3D ffff883ff0a=
c4200 , old_request =3D=3D ffff881ff0029000
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_scsi_find_tas=
k: task 0xffff883ff0ac4200 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: sas_eh_handle_sas=
_errors: task 0xffff883ff0ac4200 is done
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: cmd error handler
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: ata7: end_device-=
6:0: dev error handler
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: exception Ema=
sk 0x0 SAct 0x7ffe00 SErr 0x0 action 0x6 frozen
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: ata8: end_device-=
6:1: dev error handler
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: ata9: end_device-=
6:2: dev error handler
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: ata10: end_device=
-6:3: dev error handler
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:65:41/28:00:74:01:00/40 tag 9 ncq 5242880 out
>                                                         res 40/00:00:=
00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
80:8d:41/13:00:74:01:00/40 tag 10 ncq 2555904 out
>                                                         res 40/00:ff:=
00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
00:a1:41/0b:00:74:01:00/40 tag 11 ncq 1507328 out
>                                                         res 40/00:01:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:ac:41/07:00:74:01:00/40 tag 12 ncq 917504 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:b3:41/06:00:74:01:00/40 tag 13 ncq 786432 out
>                                                         res 40/00:00:=
01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:b9:41/07:00:74:01:00/40 tag 14 ncq 917504 out
>                                                         res 40/00:01:=
00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
80:c0:41/09:00:74:01:00/40 tag 15 ncq 1245184 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
00:ca:41/0c:00:74:01:00/40 tag 16 ncq 1572864 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
00:d6:41/05:00:74:01:00/40 tag 17 ncq 720896 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:db:41/11:00:74:01:00/40 tag 18 ncq 2228224 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:ec:41/12:00:74:01:00/40 tag 19 ncq 2359296 out
>                                                         res 40/00:01:=
00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
80:fe:41/12:00:74:01:00/40 tag 20 ncq 2424832 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/80:00:=
00:11:42/1a:00:74:01:00/40 tag 21 ncq 3473408 out
>                                                         res 40/00:00:=
00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: failed comman=
d: WRITE FPDMA QUEUED
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: cmd 61/00:00:=
80:2b:42/16:00:74:01:00/40 tag 22 ncq 2883584 out
>                                                         res 40/00:00:=
00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: status: { DRD=
Y }
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7: hard resetting l=
ink
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: configured fo=
r UDMA/133
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7.00: device report=
ed invalid CHS sector 0
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: ata7: EH complete
> Apr 18 11:46:45 overwatch1.math.uh.edu kernel: sas: --- Exit sas_scsi=
_recover_host: busy: 0 failed: 0 tries: 1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
