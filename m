From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Re: Unexpected _GTF length (8)
Date: Sun, 22 Sep 2013 17:06:58 +0200
Message-ID: <CAMeQTsa1B7Tdy5O=jZ2_mzayjeEhX6TaKQ_qHxWR04R=PCZrXA@mail.gmail.com>
References: <CAMeQTsby_CoGq1xAKUEVg_yWyqSSMjfSf6gWWzFRR+-znpPVbw@mail.gmail.com>
	<523E8D47.8040909@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34871 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab3IVPHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 11:07:01 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so1745174lab.16
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 08:06:59 -0700 (PDT)
In-Reply-To: <523E8D47.8040909@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: levex@linux.com
Cc: linux-ide@vger.kernel.org

On Sun, Sep 22, 2013 at 8:25 AM, Levente Kurusa <levex@linux.com> wrote=
:
> 2013-09-22 03:56 keltez=E9ssel, Patrik Jakobsson =EDrta:
>>
>> Hi,
>>
>> I've just got myself a MacBook Air 2013 and started looking at the d=
mesg
>> output
>> for 3.12-rc1 where I found this:
>>
>> ata1.00: unexpected _GTF length (8)
>>
>> The condition in libata-acpi.c that triggers this is:
>>
>> if (out_obj->buffer.length % REGS_PER_GTF)
>>
>> Where REGS_PER_GTF is defined as 7 which is correct according to ACP=
I
>> specs.
>> Since I'm getting a length of 8 I started digging in the ACPI code a=
nd
>> found
>> that the length is rounded up to acpi_size (u32 or u64 depending on =
arch).
>> I
>> cannot find any commits that recently touched this though I didn't r=
eally
>> dig
>> through it all.
>>
>> I've disassembled the SSDT for the "SataAhci" and everything looks o=
k.
>> That
>> code returns a 56 bit buffer. I also tried calling the _GTF method
>> manually
>> which returned the following (padded to 8 bytes by the ACPI code ofc=
).
>>
>> {0x10, 0x03, 0x00, 0x00, 0x00, 0xa0, 0xef, 0x00}
>>
>> Doing a quick google search gives me a few of these _GTF length erro=
rs
>> dating
>> back to at least 2011. What's going on here? Is this a known error?
>>
>> Thanks
>> Patrik Jakobsson
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> Hi,
>
> Can you please post the outputs of dmesg and smartctl?
> Maybe hdparm -I as well.
> These information would greatly help us, in addition to those you
> have supplied.

I tried allowing a GTF length of 8 and returning 1 from ata_dev_get_GTF=
() which
works fine so far. Enabling GTF doesn't really change anything on my sy=
stem and
to be honest I don't really know what it's supposed to do. I'm just cur=
ious
about why the code is written in such a whay that it always fails on my=
 system.

I do have sata issues after suspend/resume but that is probably a diffe=
rent
issue. I'll report this seperately if I cannot fix it myself. The chip =
is a:
04:00.0 SATA controller: Marvell Technology Group Ltd. Device 9183 (rev=
 14)

Here's the relevant ASL code, dmesg, smartctl and hdparm output:

---- SSDT1.dsl ----
/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20100528
 *
 * Disassembly of SSDT1.dat, Sat Sep 21 23:59:00 2013
 *
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000010B (267)
 *     Revision         0x01
 *     Checksum         0x6B
 *     OEM ID           "APPLE "
 *     OEM Table ID     "SataAhci"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20100915 (537921813)
 */
DefinitionBlock ("SSDT1.aml", "SSDT", 1, "APPLE ", "SataAhci", 0x000010=
00)
{
    External (GTF0, IntObj)
    External (\_SB_.PCI0.RP06.SSD0, DeviceObj)

    Scope (\_SB.PCI0.RP06.SSD0)
    {
        Device (PRT0)
        {
            Name (_ADR, 0xFFFF)
            Method (_SDD, 1, NotSerialized)
            {
                Name (GBU0, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x00
                })
                CreateByteField (GBU0, 0x00, GB00)
                CreateByteField (GBU0, 0x01, GB01)
                CreateByteField (GBU0, 0x02, GB02)
                CreateByteField (GBU0, 0x03, GB03)
                CreateByteField (GBU0, 0x04, GB04)
                CreateByteField (GBU0, 0x05, GB05)
                CreateByteField (GBU0, 0x06, GB06)
                If (LEqual (SizeOf (Arg0), 0x0200))
                {
                    CreateWordField (Arg0, 0x9C, W780)
                    If (And (W780, 0x08))
                    {
                        Store (0x10, GB00)
                        Store (0x03, GB01)
                        Store (0xEF, GB06)
                    }
                    Else
                    {
                        Store (0x90, GB00)
                        Store (0x03, GB01)
                        Store (0xEF, GB06)
                    }
                }

                Store (GBU0, GTF0)
            }

            Method (_GTF, 0, NotSerialized)
            {
                Return (GTF0)
            }
        }
    }
}

---- Cut out from DSDT.dsl (See GTF0 definition) ----

    ---- snip ----
    OperationRegion (GNVS, SystemMemory, 0x82D3EA90, 0x026D)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        ---- snip ----
        LPPR,   8,
        GTF0,   56,
        GTF2,   56,
        IDEM,   8,
        GTF1,   56,
        ---- snip ----
    }


---- dmesg ----

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.12.0-rc1+ (patrik@patrik-air) (gcc
version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu3) ) #4 SMP Sun Sep 22
04:26:59 CEST 2013
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-3.12.0-rc1+
root=3DUUID=3D2f748f67-3ddf-4581-9647-964c58a253d0 ro quiet splash
i915.i915_enable_rc6=3D7 debug acpi.debug_level=3D0x2
acpi.debug_layer=3D0xFFFFFFFF vt.handoff=3D7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008efff] u=
sable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] u=
sable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000bffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000082d13fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000082d14000-0x0000000082d52fff] A=
CPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000082d53000-0x0000000082d63fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000082d64000-0x0000000082d8efff] A=
CPI data
[    0.000000] BIOS-e820: [mem 0x0000000082d8f000-0x0000000082e38fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000082e39000-0x0000000082e8efff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000082e8f000-0x0000000082ed0fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000082ed1000-0x0000000082efefff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000082eff000-0x0000000082f86fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000082f87000-0x0000000082feffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000082ff0000-0x0000000082ffffff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000083000000-0x000000008f9fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe10000-0x00000000ffe3ffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000016f5fffff] u=
sable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi:  ACPI=3D0x82d8e000  ACPI 2.0=3D0x82d8e014  SMBIOS=3D=
0x82d15000
[    0.000000] efi: mem00: type=3D7, attr=3D0x80000000000000f,
range=3D[0x0000000000000000-0x0000000000058000) (0MB)
[    0.000000] efi: mem01: type=3D0, attr=3D0x80000000000000f,
range=3D[0x0000000000058000-0x0000000000059000) (0MB)
[    0.000000] efi: mem02: type=3D7, attr=3D0x80000000000000f,
range=3D[0x0000000000059000-0x000000000008f000) (0MB)
[    0.000000] efi: mem03: type=3D0, attr=3D0x80000000000000f,
range=3D[0x000000000008f000-0x0000000000090000) (0MB)
[    0.000000] efi: mem04: type=3D7, attr=3D0x80000000000000f,
range=3D[0x0000000000090000-0x00000000000a0000) (0MB)
[    0.000000] efi: mem05: type=3D2, attr=3D0xf,
range=3D[0x0000000000100000-0x0000000001359000) (18MB)
[    0.000000] efi: mem06: type=3D7, attr=3D0xf,
range=3D[0x0000000001359000-0x0000000002000000) (12MB)
[    0.000000] efi: mem07: type=3D2, attr=3D0xf,
range=3D[0x0000000002000000-0x0000000003259000) (18MB)
[    0.000000] efi: mem08: type=3D7, attr=3D0xf,
range=3D[0x0000000003259000-0x000000002738a000) (577MB)
[    0.000000] efi: mem09: type=3D2, attr=3D0xf,
range=3D[0x000000002738a000-0x000000002f9bd000) (134MB)
[    0.000000] efi: mem10: type=3D7, attr=3D0xf,
range=3D[0x000000002f9bd000-0x0000000054d31000) (595MB)
[    0.000000] efi: mem11: type=3D2, attr=3D0xf,
range=3D[0x0000000054d31000-0x0000000071a5e000) (461MB)
[    0.000000] efi: mem12: type=3D4, attr=3D0xf,
range=3D[0x0000000071a5e000-0x0000000073092000) (22MB)
[    0.000000] efi: mem13: type=3D7, attr=3D0xf,
range=3D[0x0000000073092000-0x0000000073e5f000) (13MB)
[    0.000000] efi: mem14: type=3D4, attr=3D0xf,
range=3D[0x0000000073e5f000-0x0000000074c2c000) (13MB)
[    0.000000] efi: mem15: type=3D7, attr=3D0xf,
range=3D[0x0000000074c2c000-0x00000000752b6000) (6MB)
[    0.000000] efi: mem16: type=3D4, attr=3D0xf,
range=3D[0x00000000752b6000-0x00000000752e3000) (0MB)
[    0.000000] efi: mem17: type=3D7, attr=3D0xf,
range=3D[0x00000000752e3000-0x00000000752e4000) (0MB)
[    0.000000] efi: mem18: type=3D4, attr=3D0xf,
range=3D[0x00000000752e4000-0x00000000752e6000) (0MB)
[    0.000000] efi: mem19: type=3D7, attr=3D0xf,
range=3D[0x00000000752e6000-0x00000000752e9000) (0MB)
[    0.000000] efi: mem20: type=3D4, attr=3D0xf,
range=3D[0x00000000752e9000-0x00000000752ed000) (0MB)
[    0.000000] efi: mem21: type=3D7, attr=3D0xf,
range=3D[0x00000000752ed000-0x00000000752f6000) (0MB)
[    0.000000] efi: mem22: type=3D4, attr=3D0xf,
range=3D[0x00000000752f6000-0x0000000075321000) (0MB)
[    0.000000] efi: mem23: type=3D7, attr=3D0xf,
range=3D[0x0000000075321000-0x0000000075324000) (0MB)
[    0.000000] efi: mem24: type=3D4, attr=3D0xf,
range=3D[0x0000000075324000-0x0000000075341000) (0MB)
[    0.000000] efi: mem25: type=3D7, attr=3D0xf,
range=3D[0x0000000075341000-0x0000000075346000) (0MB)
[    0.000000] efi: mem26: type=3D4, attr=3D0xf,
range=3D[0x0000000075346000-0x0000000075348000) (0MB)
[    0.000000] efi: mem27: type=3D7, attr=3D0xf,
range=3D[0x0000000075348000-0x000000007535a000) (0MB)
[    0.000000] efi: mem28: type=3D4, attr=3D0xf,
range=3D[0x000000007535a000-0x000000007535e000) (0MB)
[    0.000000] efi: mem29: type=3D7, attr=3D0xf,
range=3D[0x000000007535e000-0x000000007536e000) (0MB)
[    0.000000] efi: mem30: type=3D4, attr=3D0xf,
range=3D[0x000000007536e000-0x0000000075371000) (0MB)
[    0.000000] efi: mem31: type=3D7, attr=3D0xf,
range=3D[0x0000000075371000-0x0000000075377000) (0MB)
[    0.000000] efi: mem32: type=3D4, attr=3D0xf,
range=3D[0x0000000075377000-0x0000000075390000) (0MB)
[    0.000000] efi: mem33: type=3D7, attr=3D0xf,
range=3D[0x0000000075390000-0x0000000075391000) (0MB)
[    0.000000] efi: mem34: type=3D4, attr=3D0xf,
range=3D[0x0000000075391000-0x0000000075396000) (0MB)
[    0.000000] efi: mem35: type=3D7, attr=3D0xf,
range=3D[0x0000000075396000-0x0000000075397000) (0MB)
[    0.000000] efi: mem36: type=3D4, attr=3D0xf,
range=3D[0x0000000075397000-0x000000007539e000) (0MB)
[    0.000000] efi: mem37: type=3D7, attr=3D0xf,
range=3D[0x000000007539e000-0x000000007539f000) (0MB)
[    0.000000] efi: mem38: type=3D4, attr=3D0xf,
range=3D[0x000000007539f000-0x00000000753a4000) (0MB)
[    0.000000] efi: mem39: type=3D7, attr=3D0xf,
range=3D[0x00000000753a4000-0x00000000753a5000) (0MB)
[    0.000000] efi: mem40: type=3D4, attr=3D0xf,
range=3D[0x00000000753a5000-0x00000000753ab000) (0MB)
[    0.000000] efi: mem41: type=3D7, attr=3D0xf,
range=3D[0x00000000753ab000-0x00000000753ac000) (0MB)
[    0.000000] efi: mem42: type=3D4, attr=3D0xf,
range=3D[0x00000000753ac000-0x00000000753b2000) (0MB)
[    0.000000] efi: mem43: type=3D7, attr=3D0xf,
range=3D[0x00000000753b2000-0x00000000753b3000) (0MB)
[    0.000000] efi: mem44: type=3D4, attr=3D0xf,
range=3D[0x00000000753b3000-0x00000000753b6000) (0MB)
[    0.000000] efi: mem45: type=3D7, attr=3D0xf,
range=3D[0x00000000753b6000-0x00000000753b7000) (0MB)
[    0.000000] efi: mem46: type=3D4, attr=3D0xf,
range=3D[0x00000000753b7000-0x00000000753bf000) (0MB)
[    0.000000] efi: mem47: type=3D7, attr=3D0xf,
range=3D[0x00000000753bf000-0x00000000753c0000) (0MB)
[    0.000000] efi: mem48: type=3D4, attr=3D0xf,
range=3D[0x00000000753c0000-0x00000000753c2000) (0MB)
[    0.000000] efi: mem49: type=3D7, attr=3D0xf,
range=3D[0x00000000753c2000-0x00000000753c3000) (0MB)
[    0.000000] efi: mem50: type=3D4, attr=3D0xf,
range=3D[0x00000000753c3000-0x00000000753c6000) (0MB)
[    0.000000] efi: mem51: type=3D7, attr=3D0xf,
range=3D[0x00000000753c6000-0x00000000753c7000) (0MB)
[    0.000000] efi: mem52: type=3D4, attr=3D0xf,
range=3D[0x00000000753c7000-0x00000000753c8000) (0MB)
[    0.000000] efi: mem53: type=3D7, attr=3D0xf,
range=3D[0x00000000753c8000-0x00000000753da000) (0MB)
[    0.000000] efi: mem54: type=3D4, attr=3D0xf,
range=3D[0x00000000753da000-0x00000000753dc000) (0MB)
[    0.000000] efi: mem55: type=3D7, attr=3D0xf,
range=3D[0x00000000753dc000-0x00000000753dd000) (0MB)
[    0.000000] efi: mem56: type=3D4, attr=3D0xf,
range=3D[0x00000000753dd000-0x00000000753e9000) (0MB)
[    0.000000] efi: mem57: type=3D7, attr=3D0xf,
range=3D[0x00000000753e9000-0x00000000753ec000) (0MB)
[    0.000000] efi: mem58: type=3D4, attr=3D0xf,
range=3D[0x00000000753ec000-0x00000000753f3000) (0MB)
[    0.000000] efi: mem59: type=3D7, attr=3D0xf,
range=3D[0x00000000753f3000-0x0000000075408000) (0MB)
[    0.000000] efi: mem60: type=3D4, attr=3D0xf,
range=3D[0x0000000075408000-0x0000000075409000) (0MB)
[    0.000000] efi: mem61: type=3D7, attr=3D0xf,
range=3D[0x0000000075409000-0x000000007540a000) (0MB)
[    0.000000] efi: mem62: type=3D4, attr=3D0xf,
range=3D[0x000000007540a000-0x0000000075416000) (0MB)
[    0.000000] efi: mem63: type=3D7, attr=3D0xf,
range=3D[0x0000000075416000-0x0000000075417000) (0MB)
[    0.000000] efi: mem64: type=3D4, attr=3D0xf,
range=3D[0x0000000075417000-0x0000000075425000) (0MB)
[    0.000000] efi: mem65: type=3D7, attr=3D0xf,
range=3D[0x0000000075425000-0x0000000075427000) (0MB)
[    0.000000] efi: mem66: type=3D4, attr=3D0xf,
range=3D[0x0000000075427000-0x0000000075434000) (0MB)
[    0.000000] efi: mem67: type=3D7, attr=3D0xf,
range=3D[0x0000000075434000-0x0000000075436000) (0MB)
[    0.000000] efi: mem68: type=3D4, attr=3D0xf,
range=3D[0x0000000075436000-0x000000007544b000) (0MB)
[    0.000000] efi: mem69: type=3D7, attr=3D0xf,
range=3D[0x000000007544b000-0x000000007591e000) (4MB)
[    0.000000] efi: mem70: type=3D1, attr=3D0xf,
range=3D[0x000000007591e000-0x000000007593c000) (0MB)
[    0.000000] efi: mem71: type=3D4, attr=3D0xf,
range=3D[0x000000007593c000-0x0000000075c6b000) (3MB)
[    0.000000] efi: mem72: type=3D7, attr=3D0xf,
range=3D[0x0000000075c6b000-0x0000000075c92000) (0MB)
[    0.000000] efi: mem73: type=3D2, attr=3D0xf,
range=3D[0x0000000075c92000-0x0000000075c94000) (0MB)
[    0.000000] efi: mem74: type=3D4, attr=3D0xf,
range=3D[0x0000000075c94000-0x000000007824d000) (37MB)
[    0.000000] efi: mem75: type=3D3, attr=3D0xf,
range=3D[0x000000007824d000-0x0000000078374000) (1MB)
[    0.000000] efi: mem76: type=3D4, attr=3D0xf,
range=3D[0x0000000078374000-0x0000000078500000) (1MB)
[    0.000000] efi: mem77: type=3D3, attr=3D0xf,
range=3D[0x0000000078500000-0x0000000078527000) (0MB)
[    0.000000] efi: mem78: type=3D4, attr=3D0xf,
range=3D[0x0000000078527000-0x0000000078548000) (0MB)
[    0.000000] efi: mem79: type=3D3, attr=3D0xf,
range=3D[0x0000000078548000-0x000000007854e000) (0MB)
[    0.000000] efi: mem80: type=3D4, attr=3D0xf,
range=3D[0x000000007854e000-0x0000000078558000) (0MB)
[    0.000000] efi: mem81: type=3D3, attr=3D0xf,
range=3D[0x0000000078558000-0x000000007855b000) (0MB)
[    0.000000] efi: mem82: type=3D4, attr=3D0xf,
range=3D[0x000000007855b000-0x0000000078561000) (0MB)
[    0.000000] efi: mem83: type=3D3, attr=3D0xf,
range=3D[0x0000000078561000-0x0000000078575000) (0MB)
[    0.000000] efi: mem84: type=3D4, attr=3D0xf,
range=3D[0x0000000078575000-0x000000007d618000) (80MB)
[    0.000000] efi: mem85: type=3D3, attr=3D0xf,
range=3D[0x000000007d618000-0x000000007d63f000) (0MB)
[    0.000000] efi: mem86: type=3D4, attr=3D0xf,
range=3D[0x000000007d63f000-0x000000007d642000) (0MB)
[    0.000000] efi: mem87: type=3D3, attr=3D0xf,
range=3D[0x000000007d642000-0x000000007d653000) (0MB)
[    0.000000] efi: mem88: type=3D4, attr=3D0xf,
range=3D[0x000000007d653000-0x000000007d655000) (0MB)
[    0.000000] efi: mem89: type=3D3, attr=3D0xf,
range=3D[0x000000007d655000-0x000000007d659000) (0MB)
[    0.000000] efi: mem90: type=3D4, attr=3D0xf,
range=3D[0x000000007d659000-0x000000007d65d000) (0MB)
[    0.000000] efi: mem91: type=3D3, attr=3D0xf,
range=3D[0x000000007d65d000-0x000000007d665000) (0MB)
[    0.000000] efi: mem92: type=3D4, attr=3D0xf,
range=3D[0x000000007d665000-0x000000007d669000) (0MB)
[    0.000000] efi: mem93: type=3D3, attr=3D0xf,
range=3D[0x000000007d669000-0x000000007d680000) (0MB)
[    0.000000] efi: mem94: type=3D4, attr=3D0xf,
range=3D[0x000000007d680000-0x000000007d685000) (0MB)
[    0.000000] efi: mem95: type=3D3, attr=3D0xf,
range=3D[0x000000007d685000-0x000000007d68c000) (0MB)
[    0.000000] efi: mem96: type=3D4, attr=3D0xf,
range=3D[0x000000007d68c000-0x000000007d692000) (0MB)
[    0.000000] efi: mem97: type=3D3, attr=3D0xf,
range=3D[0x000000007d692000-0x000000007d6ae000) (0MB)
[    0.000000] efi: mem98: type=3D4, attr=3D0xf,
range=3D[0x000000007d6ae000-0x00000000809ac000) (50MB)
[    0.000000] efi: mem99: type=3D3, attr=3D0xf,
range=3D[0x00000000809ac000-0x00000000809b1000) (0MB)
[    0.000000] efi: mem100: type=3D4, attr=3D0xf,
range=3D[0x00000000809b1000-0x00000000809b2000) (0MB)
[    0.000000] efi: mem101: type=3D3, attr=3D0xf,
range=3D[0x00000000809b2000-0x00000000809bb000) (0MB)
[    0.000000] efi: mem102: type=3D4, attr=3D0xf,
range=3D[0x00000000809bb000-0x00000000809bf000) (0MB)
[    0.000000] efi: mem103: type=3D3, attr=3D0xf,
range=3D[0x00000000809bf000-0x00000000809c0000) (0MB)
[    0.000000] efi: mem104: type=3D4, attr=3D0xf,
range=3D[0x00000000809c0000-0x0000000080e38000) (4MB)
[    0.000000] efi: mem105: type=3D3, attr=3D0xf,
range=3D[0x0000000080e38000-0x0000000080e3d000) (0MB)
[    0.000000] efi: mem106: type=3D4, attr=3D0xf,
range=3D[0x0000000080e3d000-0x0000000081912000) (10MB)
[    0.000000] efi: mem107: type=3D3, attr=3D0xf,
range=3D[0x0000000081912000-0x000000008191c000) (0MB)
[    0.000000] efi: mem108: type=3D4, attr=3D0xf,
range=3D[0x000000008191c000-0x000000008192a000) (0MB)
[    0.000000] efi: mem109: type=3D3, attr=3D0xf,
range=3D[0x000000008192a000-0x000000008192c000) (0MB)
[    0.000000] efi: mem110: type=3D4, attr=3D0xf,
range=3D[0x000000008192c000-0x000000008192f000) (0MB)
[    0.000000] efi: mem111: type=3D3, attr=3D0xf,
range=3D[0x000000008192f000-0x0000000081930000) (0MB)
[    0.000000] efi: mem112: type=3D4, attr=3D0xf,
range=3D[0x0000000081930000-0x0000000081933000) (0MB)
[    0.000000] efi: mem113: type=3D3, attr=3D0xf,
range=3D[0x0000000081933000-0x0000000081934000) (0MB)
[    0.000000] efi: mem114: type=3D4, attr=3D0xf,
range=3D[0x0000000081934000-0x0000000081937000) (0MB)
[    0.000000] efi: mem115: type=3D3, attr=3D0xf,
range=3D[0x0000000081937000-0x0000000081938000) (0MB)
[    0.000000] efi: mem116: type=3D4, attr=3D0xf,
range=3D[0x0000000081938000-0x0000000081939000) (0MB)
[    0.000000] efi: mem117: type=3D3, attr=3D0xf,
range=3D[0x0000000081939000-0x000000008193a000) (0MB)
[    0.000000] efi: mem118: type=3D4, attr=3D0xf,
range=3D[0x000000008193a000-0x0000000081946000) (0MB)
[    0.000000] efi: mem119: type=3D3, attr=3D0xf,
range=3D[0x0000000081946000-0x0000000081959000) (0MB)
[    0.000000] efi: mem120: type=3D4, attr=3D0xf,
range=3D[0x0000000081959000-0x0000000081962000) (0MB)
[    0.000000] efi: mem121: type=3D3, attr=3D0xf,
range=3D[0x0000000081962000-0x0000000081963000) (0MB)
[    0.000000] efi: mem122: type=3D4, attr=3D0xf,
range=3D[0x0000000081963000-0x0000000081971000) (0MB)
[    0.000000] efi: mem123: type=3D3, attr=3D0xf,
range=3D[0x0000000081971000-0x0000000081975000) (0MB)
[    0.000000] efi: mem124: type=3D4, attr=3D0xf,
range=3D[0x0000000081975000-0x0000000081979000) (0MB)
[    0.000000] efi: mem125: type=3D3, attr=3D0xf,
range=3D[0x0000000081979000-0x0000000081984000) (0MB)
[    0.000000] efi: mem126: type=3D4, attr=3D0xf,
range=3D[0x0000000081984000-0x0000000081987000) (0MB)
[    0.000000] efi: mem127: type=3D3, attr=3D0xf,
range=3D[0x0000000081987000-0x0000000081988000) (0MB)
[    0.000000] efi: mem128: type=3D4, attr=3D0xf,
range=3D[0x0000000081988000-0x0000000081989000) (0MB)
[    0.000000] efi: mem129: type=3D3, attr=3D0xf,
range=3D[0x0000000081989000-0x000000008198a000) (0MB)
[    0.000000] efi: mem130: type=3D4, attr=3D0xf,
range=3D[0x000000008198a000-0x000000008198f000) (0MB)
[    0.000000] efi: mem131: type=3D3, attr=3D0xf,
range=3D[0x000000008198f000-0x0000000081991000) (0MB)
[    0.000000] efi: mem132: type=3D4, attr=3D0xf,
range=3D[0x0000000081991000-0x00000000819d4000) (0MB)
[    0.000000] efi: mem133: type=3D3, attr=3D0xf,
range=3D[0x00000000819d4000-0x00000000819dd000) (0MB)
[    0.000000] efi: mem134: type=3D4, attr=3D0xf,
range=3D[0x00000000819dd000-0x00000000819e2000) (0MB)
[    0.000000] efi: mem135: type=3D3, attr=3D0xf,
range=3D[0x00000000819e2000-0x00000000819e5000) (0MB)
[    0.000000] efi: mem136: type=3D4, attr=3D0xf,
range=3D[0x00000000819e5000-0x0000000081a40000) (0MB)
[    0.000000] efi: mem137: type=3D3, attr=3D0xf,
range=3D[0x0000000081a40000-0x0000000081a54000) (0MB)
[    0.000000] efi: mem138: type=3D4, attr=3D0xf,
range=3D[0x0000000081a54000-0x0000000081a5a000) (0MB)
[    0.000000] efi: mem139: type=3D3, attr=3D0xf,
range=3D[0x0000000081a5a000-0x0000000081a6d000) (0MB)
[    0.000000] efi: mem140: type=3D4, attr=3D0xf,
range=3D[0x0000000081a6d000-0x0000000081a70000) (0MB)
[    0.000000] efi: mem141: type=3D3, attr=3D0xf,
range=3D[0x0000000081a70000-0x0000000081a80000) (0MB)
[    0.000000] efi: mem142: type=3D4, attr=3D0xf,
range=3D[0x0000000081a80000-0x0000000081a81000) (0MB)
[    0.000000] efi: mem143: type=3D3, attr=3D0xf,
range=3D[0x0000000081a81000-0x0000000081a90000) (0MB)
[    0.000000] efi: mem144: type=3D4, attr=3D0xf,
range=3D[0x0000000081a90000-0x0000000081a92000) (0MB)
[    0.000000] efi: mem145: type=3D3, attr=3D0xf,
range=3D[0x0000000081a92000-0x0000000081a93000) (0MB)
[    0.000000] efi: mem146: type=3D4, attr=3D0xf,
range=3D[0x0000000081a93000-0x0000000081a95000) (0MB)
[    0.000000] efi: mem147: type=3D3, attr=3D0xf,
range=3D[0x0000000081a95000-0x0000000081a9f000) (0MB)
[    0.000000] efi: mem148: type=3D4, attr=3D0xf,
range=3D[0x0000000081a9f000-0x0000000081aa3000) (0MB)
[    0.000000] efi: mem149: type=3D3, attr=3D0xf,
range=3D[0x0000000081aa3000-0x0000000081aa4000) (0MB)
[    0.000000] efi: mem150: type=3D4, attr=3D0xf,
range=3D[0x0000000081aa4000-0x0000000081aa5000) (0MB)
[    0.000000] efi: mem151: type=3D3, attr=3D0xf,
range=3D[0x0000000081aa5000-0x0000000081aa6000) (0MB)
[    0.000000] efi: mem152: type=3D4, attr=3D0xf,
range=3D[0x0000000081aa6000-0x0000000081aa7000) (0MB)
[    0.000000] efi: mem153: type=3D3, attr=3D0xf,
range=3D[0x0000000081aa7000-0x0000000081aa8000) (0MB)
[    0.000000] efi: mem154: type=3D4, attr=3D0xf,
range=3D[0x0000000081aa8000-0x0000000081aac000) (0MB)
[    0.000000] efi: mem155: type=3D3, attr=3D0xf,
range=3D[0x0000000081aac000-0x0000000081aaf000) (0MB)
[    0.000000] efi: mem156: type=3D4, attr=3D0xf,
range=3D[0x0000000081aaf000-0x0000000081ab2000) (0MB)
[    0.000000] efi: mem157: type=3D3, attr=3D0xf,
range=3D[0x0000000081ab2000-0x0000000081ab3000) (0MB)
[    0.000000] efi: mem158: type=3D4, attr=3D0xf,
range=3D[0x0000000081ab3000-0x0000000081ab5000) (0MB)
[    0.000000] efi: mem159: type=3D3, attr=3D0xf,
range=3D[0x0000000081ab5000-0x0000000081ac2000) (0MB)
[    0.000000] efi: mem160: type=3D4, attr=3D0xf,
range=3D[0x0000000081ac2000-0x0000000081ac4000) (0MB)
[    0.000000] efi: mem161: type=3D3, attr=3D0xf,
range=3D[0x0000000081ac4000-0x0000000081acc000) (0MB)
[    0.000000] efi: mem162: type=3D4, attr=3D0xf,
range=3D[0x0000000081acc000-0x0000000081acf000) (0MB)
[    0.000000] efi: mem163: type=3D3, attr=3D0xf,
range=3D[0x0000000081acf000-0x0000000081ad5000) (0MB)
[    0.000000] efi: mem164: type=3D4, attr=3D0xf,
range=3D[0x0000000081ad5000-0x0000000081adf000) (0MB)
[    0.000000] efi: mem165: type=3D3, attr=3D0xf,
range=3D[0x0000000081adf000-0x0000000081af9000) (0MB)
[    0.000000] efi: mem166: type=3D4, attr=3D0xf,
range=3D[0x0000000081af9000-0x0000000081afb000) (0MB)
[    0.000000] efi: mem167: type=3D3, attr=3D0xf,
range=3D[0x0000000081afb000-0x0000000081b00000) (0MB)
[    0.000000] efi: mem168: type=3D4, attr=3D0xf,
range=3D[0x0000000081b00000-0x0000000081b09000) (0MB)
[    0.000000] efi: mem169: type=3D3, attr=3D0xf,
range=3D[0x0000000081b09000-0x0000000081b1a000) (0MB)
[    0.000000] efi: mem170: type=3D4, attr=3D0xf,
range=3D[0x0000000081b1a000-0x0000000081b1c000) (0MB)
[    0.000000] efi: mem171: type=3D3, attr=3D0xf,
range=3D[0x0000000081b1c000-0x0000000081b2d000) (0MB)
[    0.000000] efi: mem172: type=3D4, attr=3D0xf,
range=3D[0x0000000081b2d000-0x0000000081b2f000) (0MB)
[    0.000000] efi: mem173: type=3D3, attr=3D0xf,
range=3D[0x0000000081b2f000-0x0000000081b33000) (0MB)
[    0.000000] efi: mem174: type=3D4, attr=3D0xf,
range=3D[0x0000000081b33000-0x0000000081b37000) (0MB)
[    0.000000] efi: mem175: type=3D3, attr=3D0xf,
range=3D[0x0000000081b37000-0x0000000081b3b000) (0MB)
[    0.000000] efi: mem176: type=3D4, attr=3D0xf,
range=3D[0x0000000081b3b000-0x0000000081b43000) (0MB)
[    0.000000] efi: mem177: type=3D3, attr=3D0xf,
range=3D[0x0000000081b43000-0x0000000081b45000) (0MB)
[    0.000000] efi: mem178: type=3D4, attr=3D0xf,
range=3D[0x0000000081b45000-0x0000000081b46000) (0MB)
[    0.000000] efi: mem179: type=3D3, attr=3D0xf,
range=3D[0x0000000081b46000-0x0000000081b52000) (0MB)
[    0.000000] efi: mem180: type=3D4, attr=3D0xf,
range=3D[0x0000000081b52000-0x0000000081b53000) (0MB)
[    0.000000] efi: mem181: type=3D3, attr=3D0xf,
range=3D[0x0000000081b53000-0x0000000081b78000) (0MB)
[    0.000000] efi: mem182: type=3D4, attr=3D0xf,
range=3D[0x0000000081b78000-0x0000000081b7b000) (0MB)
[    0.000000] efi: mem183: type=3D3, attr=3D0xf,
range=3D[0x0000000081b7b000-0x0000000081b93000) (0MB)
[    0.000000] efi: mem184: type=3D4, attr=3D0xf,
range=3D[0x0000000081b93000-0x0000000081b9a000) (0MB)
[    0.000000] efi: mem185: type=3D3, attr=3D0xf,
range=3D[0x0000000081b9a000-0x0000000081b9b000) (0MB)
[    0.000000] efi: mem186: type=3D4, attr=3D0xf,
range=3D[0x0000000081b9b000-0x0000000081ba0000) (0MB)
[    0.000000] efi: mem187: type=3D3, attr=3D0xf,
range=3D[0x0000000081ba0000-0x0000000081ba3000) (0MB)
[    0.000000] efi: mem188: type=3D4, attr=3D0xf,
range=3D[0x0000000081ba3000-0x0000000081ba5000) (0MB)
[    0.000000] efi: mem189: type=3D3, attr=3D0xf,
range=3D[0x0000000081ba5000-0x0000000081bae000) (0MB)
[    0.000000] efi: mem190: type=3D4, attr=3D0xf,
range=3D[0x0000000081bae000-0x0000000081bb1000) (0MB)
[    0.000000] efi: mem191: type=3D3, attr=3D0xf,
range=3D[0x0000000081bb1000-0x0000000081bb2000) (0MB)
[    0.000000] efi: mem192: type=3D4, attr=3D0xf,
range=3D[0x0000000081bb2000-0x0000000081bb4000) (0MB)
[    0.000000] efi: mem193: type=3D3, attr=3D0xf,
range=3D[0x0000000081bb4000-0x0000000081bb5000) (0MB)
[    0.000000] efi: mem194: type=3D4, attr=3D0xf,
range=3D[0x0000000081bb5000-0x0000000081bbb000) (0MB)
[    0.000000] efi: mem195: type=3D3, attr=3D0xf,
range=3D[0x0000000081bbb000-0x0000000081bbd000) (0MB)
[    0.000000] efi: mem196: type=3D4, attr=3D0xf,
range=3D[0x0000000081bbd000-0x0000000081bbf000) (0MB)
[    0.000000] efi: mem197: type=3D3, attr=3D0xf,
range=3D[0x0000000081bbf000-0x0000000081bc0000) (0MB)
[    0.000000] efi: mem198: type=3D4, attr=3D0xf,
range=3D[0x0000000081bc0000-0x0000000081bc3000) (0MB)
[    0.000000] efi: mem199: type=3D3, attr=3D0xf,
range=3D[0x0000000081bc3000-0x0000000081bc6000) (0MB)
[    0.000000] efi: mem200: type=3D4, attr=3D0xf,
range=3D[0x0000000081bc6000-0x0000000081bc7000) (0MB)
[    0.000000] efi: mem201: type=3D3, attr=3D0xf,
range=3D[0x0000000081bc7000-0x0000000081bc9000) (0MB)
[    0.000000] efi: mem202: type=3D4, attr=3D0xf,
range=3D[0x0000000081bc9000-0x0000000081bd0000) (0MB)
[    0.000000] efi: mem203: type=3D3, attr=3D0xf,
range=3D[0x0000000081bd0000-0x0000000081bd2000) (0MB)
[    0.000000] efi: mem204: type=3D4, attr=3D0xf,
range=3D[0x0000000081bd2000-0x0000000081bd6000) (0MB)
[    0.000000] efi: mem205: type=3D3, attr=3D0xf,
range=3D[0x0000000081bd6000-0x0000000081bda000) (0MB)
[    0.000000] efi: mem206: type=3D4, attr=3D0xf,
range=3D[0x0000000081bda000-0x0000000081bdf000) (0MB)
[    0.000000] efi: mem207: type=3D3, attr=3D0xf,
range=3D[0x0000000081bdf000-0x0000000081be0000) (0MB)
[    0.000000] efi: mem208: type=3D4, attr=3D0xf,
range=3D[0x0000000081be0000-0x0000000081be5000) (0MB)
[    0.000000] efi: mem209: type=3D3, attr=3D0xf,
range=3D[0x0000000081be5000-0x0000000081be7000) (0MB)
[    0.000000] efi: mem210: type=3D4, attr=3D0xf,
range=3D[0x0000000081be7000-0x0000000081beb000) (0MB)
[    0.000000] efi: mem211: type=3D3, attr=3D0xf,
range=3D[0x0000000081beb000-0x0000000081bec000) (0MB)
[    0.000000] efi: mem212: type=3D4, attr=3D0xf,
range=3D[0x0000000081bec000-0x0000000081bf0000) (0MB)
[    0.000000] efi: mem213: type=3D3, attr=3D0xf,
range=3D[0x0000000081bf0000-0x0000000081bf1000) (0MB)
[    0.000000] efi: mem214: type=3D4, attr=3D0xf,
range=3D[0x0000000081bf1000-0x0000000081bf2000) (0MB)
[    0.000000] efi: mem215: type=3D3, attr=3D0xf,
range=3D[0x0000000081bf2000-0x0000000081bf3000) (0MB)
[    0.000000] efi: mem216: type=3D4, attr=3D0xf,
range=3D[0x0000000081bf3000-0x0000000081c04000) (0MB)
[    0.000000] efi: mem217: type=3D3, attr=3D0xf,
range=3D[0x0000000081c04000-0x0000000081c12000) (0MB)
[    0.000000] efi: mem218: type=3D4, attr=3D0xf,
range=3D[0x0000000081c12000-0x0000000081c26000) (0MB)
[    0.000000] efi: mem219: type=3D3, attr=3D0xf,
range=3D[0x0000000081c26000-0x0000000081c29000) (0MB)
[    0.000000] efi: mem220: type=3D4, attr=3D0xf,
range=3D[0x0000000081c29000-0x0000000081c5c000) (0MB)
[    0.000000] efi: mem221: type=3D3, attr=3D0xf,
range=3D[0x0000000081c5c000-0x0000000081c6e000) (0MB)
[    0.000000] efi: mem222: type=3D4, attr=3D0xf,
range=3D[0x0000000081c6e000-0x0000000081c6f000) (0MB)
[    0.000000] efi: mem223: type=3D3, attr=3D0xf,
range=3D[0x0000000081c6f000-0x0000000081c73000) (0MB)
[    0.000000] efi: mem224: type=3D4, attr=3D0xf,
range=3D[0x0000000081c73000-0x0000000081c80000) (0MB)
[    0.000000] efi: mem225: type=3D3, attr=3D0xf,
range=3D[0x0000000081c80000-0x0000000081c86000) (0MB)
[    0.000000] efi: mem226: type=3D4, attr=3D0xf,
range=3D[0x0000000081c86000-0x0000000081c98000) (0MB)
[    0.000000] efi: mem227: type=3D3, attr=3D0xf,
range=3D[0x0000000081c98000-0x0000000081c9a000) (0MB)
[    0.000000] efi: mem228: type=3D4, attr=3D0xf,
range=3D[0x0000000081c9a000-0x0000000081c9e000) (0MB)
[    0.000000] efi: mem229: type=3D3, attr=3D0xf,
range=3D[0x0000000081c9e000-0x0000000081ca5000) (0MB)
[    0.000000] efi: mem230: type=3D4, attr=3D0xf,
range=3D[0x0000000081ca5000-0x0000000081cb3000) (0MB)
[    0.000000] efi: mem231: type=3D3, attr=3D0xf,
range=3D[0x0000000081cb3000-0x0000000081cb5000) (0MB)
[    0.000000] efi: mem232: type=3D4, attr=3D0xf,
range=3D[0x0000000081cb5000-0x0000000081cb7000) (0MB)
[    0.000000] efi: mem233: type=3D3, attr=3D0xf,
range=3D[0x0000000081cb7000-0x0000000081cb8000) (0MB)
[    0.000000] efi: mem234: type=3D4, attr=3D0xf,
range=3D[0x0000000081cb8000-0x0000000081cb9000) (0MB)
[    0.000000] efi: mem235: type=3D3, attr=3D0xf,
range=3D[0x0000000081cb9000-0x0000000081cba000) (0MB)
[    0.000000] efi: mem236: type=3D4, attr=3D0xf,
range=3D[0x0000000081cba000-0x0000000081cd1000) (0MB)
[    0.000000] efi: mem237: type=3D3, attr=3D0xf,
range=3D[0x0000000081cd1000-0x0000000081cd9000) (0MB)
[    0.000000] efi: mem238: type=3D4, attr=3D0xf,
range=3D[0x0000000081cd9000-0x0000000081cda000) (0MB)
[    0.000000] efi: mem239: type=3D3, attr=3D0xf,
range=3D[0x0000000081cda000-0x0000000081cdb000) (0MB)
[    0.000000] efi: mem240: type=3D4, attr=3D0xf,
range=3D[0x0000000081cdb000-0x0000000081cde000) (0MB)
[    0.000000] efi: mem241: type=3D3, attr=3D0xf,
range=3D[0x0000000081cde000-0x0000000081cef000) (0MB)
[    0.000000] efi: mem242: type=3D4, attr=3D0xf,
range=3D[0x0000000081cef000-0x0000000081cfd000) (0MB)
[    0.000000] efi: mem243: type=3D3, attr=3D0xf,
range=3D[0x0000000081cfd000-0x0000000081cfe000) (0MB)
[    0.000000] efi: mem244: type=3D4, attr=3D0xf,
range=3D[0x0000000081cfe000-0x0000000081cff000) (0MB)
[    0.000000] efi: mem245: type=3D3, attr=3D0xf,
range=3D[0x0000000081cff000-0x0000000081d00000) (0MB)
[    0.000000] efi: mem246: type=3D4, attr=3D0xf,
range=3D[0x0000000081d00000-0x0000000081d03000) (0MB)
[    0.000000] efi: mem247: type=3D3, attr=3D0xf,
range=3D[0x0000000081d03000-0x0000000081d04000) (0MB)
[    0.000000] efi: mem248: type=3D4, attr=3D0xf,
range=3D[0x0000000081d04000-0x0000000081d08000) (0MB)
[    0.000000] efi: mem249: type=3D3, attr=3D0xf,
range=3D[0x0000000081d08000-0x0000000081d0a000) (0MB)
[    0.000000] efi: mem250: type=3D4, attr=3D0xf,
range=3D[0x0000000081d0a000-0x0000000081d0b000) (0MB)
[    0.000000] efi: mem251: type=3D3, attr=3D0xf,
range=3D[0x0000000081d0b000-0x0000000081d0d000) (0MB)
[    0.000000] efi: mem252: type=3D4, attr=3D0xf,
range=3D[0x0000000081d0d000-0x0000000082132000) (4MB)
[    0.000000] efi: mem253: type=3D3, attr=3D0xf,
range=3D[0x0000000082132000-0x000000008213c000) (0MB)
[    0.000000] efi: mem254: type=3D4, attr=3D0xf,
range=3D[0x000000008213c000-0x000000008213f000) (0MB)
[    0.000000] efi: mem255: type=3D3, attr=3D0xf,
range=3D[0x000000008213f000-0x0000000082141000) (0MB)
[    0.000000] efi: mem256: type=3D4, attr=3D0xf,
range=3D[0x0000000082141000-0x0000000082148000) (0MB)
[    0.000000] efi: mem257: type=3D3, attr=3D0xf,
range=3D[0x0000000082148000-0x0000000082149000) (0MB)
[    0.000000] efi: mem258: type=3D4, attr=3D0xf,
range=3D[0x0000000082149000-0x0000000082150000) (0MB)
[    0.000000] efi: mem259: type=3D3, attr=3D0xf,
range=3D[0x0000000082150000-0x0000000082151000) (0MB)
[    0.000000] efi: mem260: type=3D4, attr=3D0xf,
range=3D[0x0000000082151000-0x0000000082154000) (0MB)
[    0.000000] efi: mem261: type=3D3, attr=3D0xf,
range=3D[0x0000000082154000-0x0000000082159000) (0MB)
[    0.000000] efi: mem262: type=3D4, attr=3D0xf,
range=3D[0x0000000082159000-0x000000008215b000) (0MB)
[    0.000000] efi: mem263: type=3D3, attr=3D0xf,
range=3D[0x000000008215b000-0x000000008215c000) (0MB)
[    0.000000] efi: mem264: type=3D4, attr=3D0xf,
range=3D[0x000000008215c000-0x0000000082190000) (0MB)
[    0.000000] efi: mem265: type=3D3, attr=3D0xf,
range=3D[0x0000000082190000-0x0000000082191000) (0MB)
[    0.000000] efi: mem266: type=3D4, attr=3D0xf,
range=3D[0x0000000082191000-0x0000000082d03000) (11MB)
[    0.000000] efi: mem267: type=3D7, attr=3D0xf,
range=3D[0x0000000082d03000-0x0000000082d14000) (0MB)
[    0.000000] efi: mem268: type=3D10, attr=3D0xf,
range=3D[0x0000000082d14000-0x0000000082d53000) (0MB)
[    0.000000] efi: mem269: type=3D7, attr=3D0xf,
range=3D[0x0000000082d53000-0x0000000082d64000) (0MB)
[    0.000000] efi: mem270: type=3D9, attr=3D0xf,
range=3D[0x0000000082d64000-0x0000000082d8f000) (0MB)
[    0.000000] efi: mem271: type=3D7, attr=3D0xf,
range=3D[0x0000000082d8f000-0x0000000082e39000) (0MB)
[    0.000000] efi: mem272: type=3D6, attr=3D0x800000000000000f,
range=3D[0x0000000082e39000-0x0000000082e8f000) (0MB)
[    0.000000] efi: mem273: type=3D7, attr=3D0xf,
range=3D[0x0000000082e8f000-0x0000000082ed1000) (0MB)
[    0.000000] efi: mem274: type=3D5, attr=3D0x800000000000000f,
range=3D[0x0000000082ed1000-0x0000000082eff000) (0MB)
[    0.000000] efi: mem275: type=3D7, attr=3D0xf,
range=3D[0x0000000082eff000-0x0000000082f7a000) (0MB)
[    0.000000] efi: mem276: type=3D2, attr=3D0xf,
range=3D[0x0000000082f7a000-0x0000000082f87000) (0MB)
[    0.000000] efi: mem277: type=3D0, attr=3D0xf,
range=3D[0x0000000082f87000-0x0000000082ff0000) (0MB)
[    0.000000] efi: mem278: type=3D4, attr=3D0xf,
range=3D[0x0000000082ff0000-0x0000000083000000) (0MB)
[    0.000000] efi: mem279: type=3D7, attr=3D0xf,
range=3D[0x0000000100000000-0x000000016f600000) (1782MB)
[    0.000000] efi: mem280: type=3D0, attr=3D0x8000000000000000,
range=3D[0x00000000000a0000-0x00000000000c0000) (0MB)
[    0.000000] efi: mem281: type=3D0, attr=3D0x8000000000000000,
range=3D[0x0000000083000000-0x000000008fa00000) (202MB)
[    0.000000] efi: mem282: type=3D11, attr=3D0x8000000000000001,
range=3D[0x00000000e00f8000-0x00000000e00f9000) (0MB)
[    0.000000] efi: mem283: type=3D11, attr=3D0x8000000000000001,
range=3D[0x00000000fed1c000-0x00000000fed20000) (0MB)
[    0.000000] efi: mem284: type=3D11, attr=3D0x8000000000000001,
range=3D[0x00000000ffe10000-0x00000000ffe40000) (0MB)
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. MacBookAir6,2/Mac-7DF21CB3ED6977E5,
BIOS MBA61.88Z.0099.B00.1305241529 05/24/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> =
reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x16f600 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.000000]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.000000]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.000000]   3 base 0088000000 mask 7FF8000000 uncachable
[    0.000000]   4 base 0084000000 mask 7FFC000000 uncachable
[    0.000000]   5 base 0083800000 mask 7FFF800000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x70106=
00070106
[    0.000000] e820: last_pfn =3D 0x83000 max_arch_pfn =3D 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size =
24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02f68000, 0x02f68fff] PGTABLE
[    0.000000] BRK [0x02f69000, 0x02f69fff] PGTABLE
[    0.000000] BRK [0x02f6a000, 0x02f6afff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x16f400000-0x16f5fffff]
[    0.000000]  [mem 0x16f400000-0x16f5fffff] page 2M
[    0.000000] BRK [0x02f6b000, 0x02f6bfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x16c000000-0x16f3fffff]
[    0.000000]  [mem 0x16c000000-0x16f3fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x100000000-0x16bffffff]
[    0.000000]  [mem 0x100000000-0x13fffffff] page 1G
[    0.000000]  [mem 0x140000000-0x16bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x82d13fff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0x7fffffff] page 1G
[    0.000000]  [mem 0x80000000-0x82bfffff] page 2M
[    0.000000]  [mem 0x82c00000-0x82d13fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x82d53000-0x82d63fff]
[    0.000000]  [mem 0x82d53000-0x82d63fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x82d8f000-0x82e38fff]
[    0.000000]  [mem 0x82d8f000-0x82e38fff] page 4k
[    0.000000] BRK [0x02f6c000, 0x02f6cfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x82e8f000-0x82ed0fff]
[    0.000000]  [mem 0x82e8f000-0x82ed0fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x82eff000-0x82f86fff]
[    0.000000]  [mem 0x82eff000-0x82f86fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x82ff0000-0x82ffffff]
[    0.000000]  [mem 0x82ff0000-0x82ffffff] page 4k
[    0.000000] RAMDISK: [mem 0x2738a000-0x2f9bcfff]
[    0.000000] ACPI: RSDP 0000000082d8e014 00024 (v02 APPLE )
[    0.000000] ACPI: XSDT 0000000082d8e1c0 0009C (v01 APPLE   Apple00
00000000      01000013)
[    0.000000] ACPI: FACP 0000000082d8c000 000F4 (v05 APPLE   Apple00
00000000 Loki 0000005F)
[    0.000000] ACPI Error: Gpe0Block - 32-bit FADT register is too
long (32 bytes, 256 bits) to convert to GAS struct - 255 bits max,
truncating (20130725/tbfadt-202)
[    0.000000] ACPI: DSDT 0000000082d7f000 07B3E (v03 APPLE  MacBookA
00060001 INTL 20100915)
[    0.000000] ACPI: FACS 0000000082d1c000 00040
[    0.000000] ACPI: HPET 0000000082d8b000 00038 (v01 APPLE   Apple00
00000001 Loki 0000005F)
[    0.000000] ACPI: APIC 0000000082d8a000 000BC (v02 APPLE   Apple00
00000001 Loki 0000005F)
[    0.000000] ACPI: SBST 0000000082d88000 00030 (v01 APPLE   Apple00
00000001 Loki 0000005F)
[    0.000000] ACPI: ECDT 0000000082d87000 00053 (v01 APPLE   Apple00
00000001 Loki 0000005F)
[    0.000000] ACPI: SSDT 0000000082d7e000 0010B (v01 APPLE  SataAhci
00001000 INTL 20100915)
[    0.000000] ACPI: SSDT 0000000082d7d000 00024 (v01 APPLE   SmcDppt
00001000 INTL 20100915)
[    0.000000] ACPI: SSDT 0000000082d7a000 00F26 (v01 APPLE  SDUsbLpt
00001000 INTL 20100915)
[    0.000000] ACPI: SSDT 0000000082d76000 00032 (v01 APPLE    SsdtS3
00001000 INTL 20100915)
[    0.000000] ACPI: SSDT 0000000082d74000 01EB7 (v01 APPLE   PcieTbt
00001000 INTL 20100915)
[    0.000000] ACPI: SSDT 0000000082d67000 000B8 (v01 APPLE      Sdxc
00001000 INTL 20100915)
[    0.000000] ACPI: SSDT 0000000082d66000 00563 (v01  PmRef  Cpu0Ist
00003000 INTL 20100915)
[    0.000000] ACPI: SSDT 0000000082d65000 00B83 (v01  PmRef    CpuPm
00003000 INTL 20100915)
[    0.000000] ACPI: MCFG 0000000082d89000 0003C (v01 APPLE   Apple00
00000001 Loki 0000005F)
[    0.000000] ACPI: DMAR 0000000082d64000 00088 (v01 APPLE      HSW
00000001 AAPL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000016f5ff=
fff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x16f5fffff]
[    0.000000]   NODE_DATA [mem 0x16f5f9000-0x16f5fdfff]
[    0.000000]  [ffffea0000000000-ffffea0005bfffff] PMD ->
[ffff88016ae00000-ffff88016ebfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x16f5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x00057fff]
[    0.000000]   node   0: [mem 0x00059000-0x0008efff]
[    0.000000]   node   0: [mem 0x00090000-0x0009ffff]
[    0.000000]   node   0: [mem 0x00100000-0x82d13fff]
[    0.000000]   node   0: [mem 0x82d53000-0x82d63fff]
[    0.000000]   node   0: [mem 0x82d8f000-0x82e38fff]
[    0.000000]   node   0: [mem 0x82e8f000-0x82ed0fff]
[    0.000000]   node   0: [mem 0x82eff000-0x82f86fff]
[    0.000000]   node   0: [mem 0x82ff0000-0x82ffffff]
[    0.000000]   node   0: [mem 0x100000000-0x16f5fffff]
[    0.000000] On node 0 totalpages: 992326
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 26 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 8315 pages used for memmap
[    0.000000]   DMA32 zone: 532137 pages, LIFO batch:31
[    0.000000]   Normal zone: 7128 pages used for memmap
[    0.000000]   Normal zone: 456192 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0xff] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0xff] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0xff] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0xff] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GS=
I 0-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] nr_irqs_gsi: 56
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000bffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x000c0000-0x000fffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x82d14000-0x82d52fff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x82d64000-0x82d8efff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x82e39000-0x82e8efff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x82ed1000-0x82efefff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x82f87000-0x82feffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x83000000-0x8f9fffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0x8fa00000-0xe00f7fff=
]
[    0.000000] PM: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff=
]
[    0.000000] PM: Registered nosave memory: [mem 0xe00f9000-0xfed1bfff=
]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xffe0ffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0xffe10000-0xffe3ffff=
]
[    0.000000] PM: Registered nosave memory: [mem 0xffe40000-0xffffffff=
]
[    0.000000] e820: [mem 0x8fa00000-0xe00f7fff] available for PCI devi=
ces
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88016f200000 s81536
r8192 d20864 u262144
[    0.000000] pcpu-alloc: s81536 r8192 d20864 u262144 alloc=3D1*209715=
2
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 976793
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=3D/boot/vmlinuz-3.12.0-rc1+
root=3DUUID=3D2f748f67-3ddf-4581-9647-964c58a253d0 ro quiet splash
i915.i915_enable_rc6=3D7 debug acpi.debug_level=3D0x2
acpi.debug_layer=3D0xFFFFFFFF vt.handoff=3D7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bai=
ling!
[    0.000000] Memory: 3430528K/3969304K available (6865K kernel code,
994K rwdata, 3144K rodata, 1192K init, 1260K bss, 538776K reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
8, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]     RCU dyntick-idle grace-period acceleration is enable=
d.
[    0.000000]     RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_id=
s=3D8.
[    0.000000] NR_IRQS:16640 nr_irqs:1016 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 16252928 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't
want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 1899.973 MHz processor
[    0.000003] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3799.94 BogoMIPS (lpj=3D7599892)
[    0.000012] pid_max: default: 32768 minimum: 301
[    0.000058] init_memory_mapping: [mem 0x82e39000-0x82e8efff]
[    0.000062]  [mem 0x82e39000-0x82e8efff] page 4k
[    0.000080] init_memory_mapping: [mem 0x82ed1000-0x82efefff]
[    0.000084]  [mem 0x82ed1000-0x82efefff] page 4k
[    0.000158] init_memory_mapping: [mem 0x83000000-0x8f9fffff]
[    0.000162]  [mem 0x83000000-0x8f9fffff] page 2M
[    0.150456] Security Framework initialized
[    0.150469] AppArmor: AppArmor initialized
[    0.150472] Yama: becoming mindful.
[    0.150958] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.152378] Inode-cache hash table entries: 262144 (order: 9, 209715=
2 bytes)
[    0.153002] Mount-cache hash table entries: 256
[    0.153280] Initializing cgroup subsys memory
[    0.153295] Initializing cgroup subsys devices
[    0.153299] Initializing cgroup subsys freezer
[    0.153303] Initializing cgroup subsys blkio
[    0.153307] Initializing cgroup subsys perf_event
[    0.153312] Initializing cgroup subsys hugetlb
[    0.153346] CPU: Physical Processor ID: 0
[    0.153349] CPU: Processor Core ID: 0
[    0.153358] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.153358] ENERGY_PERF_BIAS: View and update with x86_energy_perf_p=
olicy(8)
[    0.154860] mce: CPU supports 7 MCE banks
[    0.154882] CPU0: Thermal monitoring enabled (TM1)
[    0.154901] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.154901] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0
[    0.154901] tlb_flushall_shift: 6
[    0.155081] Freeing SMP alternatives memory: 28K (ffffffff81e24000
- ffffffff81e2b000)
[    0.155087] ACPI: Core revision 20130725
[    0.170115] ACPI: All ACPI Tables successfully acquired
[    0.185994] ftrace: allocating 26817 entries in 105 pages
[    0.205667] dmar: Host address width 39
[    0.205673] dmar: DRHD base: 0x000000fed90000 flags: 0x0
[    0.205686] dmar: IOMMU 0: reg_base_addr fed90000 ver 1:0 cap
c0000020660462 ecap f0101a
[    0.205690] dmar: DRHD base: 0x000000fed91000 flags: 0x1
[    0.205703] dmar: IOMMU 1: reg_base_addr fed91000 ver 1:0 cap
d2008020660462 ecap f010da
[    0.205707] dmar: RMRR base: 0x0000008d800000 end: 0x0000008f9fffff
[    0.205840] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.205843] HPET id 0 under DRHD base 0xfed91000
[    0.206119] Enabled IRQ remapping in x2apic mode
[    0.206123] Enabling x2apic
[    0.206125] Enabled x2apic
[    0.206133] Switched APIC routing to cluster x2apic.
[    0.206813] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
[    0.246505] smpboot: CPU0: Intel(R) Core(TM) i5-4250U CPU @ 1.30GHz
(fam: 06, model: 45, stepping: 01)
[    0.246519] TSC deadline timer enabled
[    0.246534] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell
events, full-width counters, Intel PMU driver.
[    0.246548] ... version:                3
[    0.246550] ... bit width:              48
[    0.246553] ... generic registers:      4
[    0.246556] ... value mask:             0000ffffffffffff
[    0.246558] ... max period:             0000ffffffffffff
[    0.246561] ... fixed-purpose events:   3
[    0.246563] ... event mask:             000000070000000f
[    0.263189] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.248420] smpboot: Booting Node   0, Processors  #   1 #   2 #   3=
 OK
[    0.292696] Brought up 4 CPUs
[    0.292704] smpboot: Total of 4 processors activated (15199.78 BogoM=
IPS)
[    0.298433] devtmpfs: initialized
[    0.301585] EVM: security.selinux
[    0.301589] EVM: security.SMACK64
[    0.301591] EVM: security.capability
[    0.301699] PM: Registering ACPI NVS region [mem
0x82d14000-0x82d52fff] (258048 bytes)
[    0.302980] regulator-dummy: no parameters
[    0.303050] NET: Registered protocol family 16
[    0.303201] cpuidle: using governor ladder
[    0.303204] cpuidle: using governor menu
[    0.303291] ACPI: bus type PCI registered
[    0.303371] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem
0xe0000000-0xe9bfffff] (base 0xe0000000)
[    0.303377] PCI: not using MMCONFIG
[    0.303381] PCI: Using configuration type 1 for base access
[    0.304732] bio: create slab <bio-0> at 0
[    0.304936] ACPI: Added _OSI(Module Device)
[    0.304940] ACPI: Added _OSI(Processor Device)
[    0.304943] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.304946] ACPI: Added _OSI(Processor Aggregator Device)
[    0.307923] ACPI: EC: EC description table is found, configuring boo=
t EC
[    0.316016] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    2.336989] ACPI: SSDT 0000000082f89890 004F0 (v01  PmRef  Cpu0Cst
00003001 INTL 20100915)
[    2.337744] ACPI: Dynamic OEM Table Load:
[    2.337748] ACPI: SSDT           (null) 004F0 (v01  PmRef  Cpu0Cst
00003001 INTL 20100915)
[    2.348027] ACPI: SSDT 0000000082f8a190 0067C (v01  PmRef    ApIst
00003000 INTL 20100915)
[    2.348939] ACPI: Dynamic OEM Table Load:
[    2.348944] ACPI: SSDT           (null) 0067C (v01  PmRef    ApIst
00003000 INTL 20100915)
[    2.360962] ACPI: SSDT 0000000082f88d90 00119 (v01  PmRef    ApCst
00003000 INTL 20100915)
[    2.361707] ACPI: Dynamic OEM Table Load:
[    2.361711] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst
00003000 INTL 20100915)
[    2.372589] ACPI: Interpreter enabled
[    2.372603] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S1_] (20130725/hwxface-571)
[    2.372616] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S2_] (20130725/hwxface-571)
[    2.372641] ACPI: (supports S0 S3 S4 S5)
[    2.372645] ACPI: Using IOAPIC for interrupt routing
[    2.372677] PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem
0xe0000000-0xe9bfffff] (base 0xe0000000)
[    2.381466] PCI: MMCONFIG at [mem 0xe0000000-0xe9bfffff] reserved
in ACPI motherboard resources
[    2.419810] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    2.420096] ACPI: No dock devices found.
[    2.434796] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    2.434958] acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
[    2.435098] acpi PNP0A08:00: ACPI _OSC control (0x1d) granted
[    2.435427] acpi PNP0A08:00: fail to add MMCONFIG information,
can't access extended PCI configuration space under this bridge.
[    2.435457] PCI host bridge to bus 0000:00
[    2.435462] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.435466] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    2.435470] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    2.435475] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000=
bffff]
[    2.435478] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000=
c3fff]
[    2.435482] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000=
c7fff]
[    2.435486] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000=
cbfff]
[    2.435490] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000=
cffff]
[    2.435494] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000=
d3fff]
[    2.435498] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000=
d7fff]
[    2.435501] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000=
dbfff]
[    2.435505] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000=
dffff]
[    2.435509] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000=
e3fff]
[    2.435513] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000=
e7fff]
[    2.435517] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000=
ebfff]
[    2.435521] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000=
effff]
[    2.435524] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000=
fffff]
[    2.435528] pci_bus 0000:00: root bus resource [mem 0x8fa00000-0xfea=
fffff]
[    2.435532] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed=
44fff]
[    2.435546] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    2.435671] pci 0000:00:02.0: [8086:0a26] type 00 class 0x030000
[    2.435692] pci 0000:00:02.0: reg 0x10: [mem 0xb0000000-0xb03fffff 6=
4bit]
[    2.435714] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff
64bit pref]
[    2.435724] pci 0000:00:02.0: reg 0x20: [io  0x2000-0x203f]
[    2.435834] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    2.435849] pci 0000:00:03.0: reg 0x10: [mem 0xb0a10000-0xb0a13fff 6=
4bit]
[    2.435991] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    2.436016] pci 0000:00:14.0: reg 0x10: [mem 0xb0a00000-0xb0a0ffff 6=
4bit]
[    2.436093] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    2.436143] pci 0000:00:14.0: System wakeup disabled by ACPI
[    2.436189] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    2.436217] pci 0000:00:16.0: reg 0x10: [mem 0xb0a2a100-0xb0a2a11f 6=
4bit]
[    2.436304] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    2.436402] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    2.436421] pci 0000:00:1b.0: reg 0x10: [mem 0xb0a14000-0xb0a17fff 6=
4bit]
[    2.436503] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    2.436554] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    2.436595] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    2.436677] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.436729] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    2.436770] pci 0000:00:1c.1: [8086:9c12] type 01 class 0x060400
[    2.436862] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    2.436916] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    2.436958] pci 0000:00:1c.2: [8086:9c14] type 01 class 0x060400
[    2.437050] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    2.437107] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    2.437148] pci 0000:00:1c.4: [8086:9c18] type 01 class 0x060400
[    2.437238] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    2.437294] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    2.437333] pci 0000:00:1c.5: [8086:9c1a] type 01 class 0x060400
[    2.437418] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    2.437473] pci 0000:00:1c.5: System wakeup disabled by ACPI
[    2.437521] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    2.437721] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    2.437741] pci 0000:00:1f.3: reg 0x10: [mem 0xb0a2a000-0xb0a2a0ff 6=
4bit]
[    2.437768] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    2.437920] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    2.438014] pci 0000:02:00.0: [14e4:1570] type 00 class 0x048000
[    2.438041] pci 0000:02:00.0: reg 0x10: [mem 0xb0900000-0xb090ffff 6=
4bit]
[    2.438063] pci 0000:02:00.0: reg 0x18: [mem 0x90000000-0x9fffffff
64bit pref]
[    2.438084] pci 0000:02:00.0: reg 0x20: [mem 0xb0800000-0xb08fffff 6=
4bit]
[    2.438163] pci 0000:02:00.0: supports D1
[    2.438167] pci 0000:02:00.0: PME# supported from D0 D3hot
[    2.443731] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    2.443740] pci 0000:00:1c.1:   bridge window [mem 0xb0800000-0xb09f=
ffff]
[    2.443749] pci 0000:00:1c.1:   bridge window [mem
0x90000000-0x9fffffff 64bit pref]
[    2.443881] pci 0000:03:00.0: [14e4:43a0] type 00 class 0x028000
[    2.443917] pci 0000:03:00.0: reg 0x10: [mem 0xb0600000-0xb0607fff 6=
4bit]
[    2.443947] pci 0000:03:00.0: reg 0x18: [mem 0xb0400000-0xb05fffff 6=
4bit]
[    2.444094] pci 0000:03:00.0: supports D1 D2
[    2.444097] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    2.444185] pci 0000:03:00.0: System wakeup disabled by ACPI
[    2.451768] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    2.451776] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb06f=
ffff]
[    2.451844] pci 0000:00:1c.4: PCI bridge to [bus 05-9b]
[    2.451851] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    2.451856] pci 0000:00:1c.4:   bridge window [mem 0xb0b00000-0xbcbf=
ffff]
[    2.451865] pci 0000:00:1c.4:   bridge window [mem
0xbcc00000-0xc8bfffff 64bit pref]
[    2.451969] pci 0000:04:00.0: [1b4b:9183] type 00 class 0x010601
[    2.451987] pci 0000:04:00.0: reg 0x10: [io  0x1028-0x102f]
[    2.452000] pci 0000:04:00.0: reg 0x14: [io  0x1034-0x1037]
[    2.452014] pci 0000:04:00.0: reg 0x18: [io  0x1020-0x1027]
[    2.452027] pci 0000:04:00.0: reg 0x1c: [io  0x1030-0x1033]
[    2.452041] pci 0000:04:00.0: reg 0x20: [io  0x1000-0x101f]
[    2.452055] pci 0000:04:00.0: reg 0x24: [mem 0xb0700000-0xb07001ff]
[    2.452069] pci 0000:04:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff p=
ref]
[    2.452129] pci 0000:04:00.0: PME# supported from D3hot
[    2.463736] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    2.463742] pci 0000:00:1c.5:   bridge window [io  0x1000-0x1fff]
[    2.463748] pci 0000:00:1c.5:   bridge window [mem 0xb0700000-0xb07f=
ffff]
[    2.465198] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12
14 15) *0, disabled.
[    2.465279] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    2.465354] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12
14 15) *0, disabled.
[    2.465428] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    2.465502] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12
14 15) *0, disabled.
[    2.465575] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    2.465648] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12
14 15) *0, disabled.
[    2.465721] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    2.467370] ACPI: Enabled 2 GPEs in block 00 to 7F
[    2.467383] ACPI: \_SB_.PCI0: notify handler is installed
[    2.467484] Found 1 acpi root devices
[    2.467518] ACPI: EC: GPE =3D 0x4e, I/O: command/status =3D 0x66, da=
ta =3D 0x62
[    2.467647] vgaarb: device added:
PCI:0000:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    2.467654] vgaarb: loaded
[    2.467657] vgaarb: bridge control possible 0000:00:02.0
[    2.467892] SCSI subsystem initialized
[    2.467966] libata version 3.00 loaded.
[    2.467989] ACPI: bus type USB registered
[    2.468011] usbcore: registered new interface driver usbfs
[    2.468022] usbcore: registered new interface driver hub
[    2.468055] usbcore: registered new device driver usb
[    2.468204] PCI: Using ACPI for IRQ routing
[    2.473177] PCI: pci_cache_line_size set to 64 bytes
[    2.473306] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    2.473310] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    2.473313] e820: reserve RAM buffer [mem 0x82d14000-0x83ffffff]
[    2.473318] e820: reserve RAM buffer [mem 0x82d64000-0x83ffffff]
[    2.473323] e820: reserve RAM buffer [mem 0x82e39000-0x83ffffff]
[    2.473327] e820: reserve RAM buffer [mem 0x82ed1000-0x83ffffff]
[    2.473331] e820: reserve RAM buffer [mem 0x82f87000-0x83ffffff]
[    2.473334] e820: reserve RAM buffer [mem 0x83000000-0x83ffffff]
[    2.473338] e820: reserve RAM buffer [mem 0x16f600000-0x16fffffff]
[    2.473454] NetLabel: Initializing
[    2.473457] NetLabel:  domain hash size =3D 128
[    2.473460] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    2.473473] NetLabel:  unlabeled traffic allowed by default
[    2.473576] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.473587] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    2.475620] Switched to clocksource hpet
[    2.482301] AppArmor: AppArmor Filesystem Enabled
[    2.482331] pnp: PnP ACPI init
[    2.482346] ACPI: bus type PNP registered
[    2.482420] pnp 00:00: [dma 4]
[    2.482449] pnp 00:00: Plug and Play ACPI device, IDs PNP0200 (activ=
e)
[    2.482479] pnp 00:01: Plug and Play ACPI device, IDs INT0800 (activ=
e)
[    2.482648] system 00:02: [mem 0xfed00000-0xfed003ff] has been reser=
ved
[    2.482654] system 00:02: Plug and Play ACPI device, IDs PNP0103
PNP0c01 (active)
[    2.482698] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (activ=
e)
[    2.482741] system 00:04: [io  0xffff] has been reserved
[    2.482747] system 00:04: [io  0x0400-0x047f] could not be reserved
[    2.482751] system 00:04: [io  0x0800-0x087f] has been reserved
[    2.482756] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (ac=
tive)
[    2.482784] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (activ=
e)
[    2.482823] pnp 00:06: Plug and Play ACPI device, IDs APP0001 (activ=
e)
[    2.483539] pnp 00:07: Plug and Play ACPI device, IDs INT33c1 (activ=
e)
[    2.483763] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reser=
ved
[    2.483768] system 00:08: [mem 0xfed10000-0xfed17fff] has been reser=
ved
[    2.483773] system 00:08: [mem 0xfed18000-0xfed18fff] has been reser=
ved
[    2.483777] system 00:08: [mem 0xfed19000-0xfed19fff] has been reser=
ved
[    2.483782] system 00:08: [mem 0xe0000000-0xefffffff] could not be r=
eserved
[    2.483786] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reser=
ved
[    2.483791] system 00:08: [mem 0xfed90000-0xfed93fff] could not be r=
eserved
[    2.483795] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reser=
ved
[    2.483800] system 00:08: [mem 0xff000000-0xffffffff] could not be r=
eserved
[    2.483804] system 00:08: [mem 0xfee00000-0xfeefffff] has been reser=
ved
[    2.483809] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (ac=
tive)
[    2.483894] system 00:09: [mem 0x20000000-0x201fffff] could not be r=
eserved
[    2.483899] system 00:09: [mem 0x40000000-0x401fffff] could not be r=
eserved
[    2.483904] system 00:09: Plug and Play ACPI device, IDs PNP0c01 (ac=
tive)
[    2.486202] pnp: PnP ACPI: found 10 devices
[    2.486207] ACPI: bus type PNP unregistered
[    2.492919] pci 0000:04:00.0: no compatible bridge window for [mem
0xfffe0000-0xffffffff pref]
[    2.492978] pci 0000:00:1c.5: BAR 15: assigned [mem
0x8fa00000-0x8fafffff pref]
[    2.492984] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    2.493002] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    2.493011] pci 0000:00:1c.1:   bridge window [mem 0xb0800000-0xb09f=
ffff]
[    2.493018] pci 0000:00:1c.1:   bridge window [mem
0x90000000-0x9fffffff 64bit pref]
[    2.493028] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    2.493036] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb06f=
ffff]
[    2.493047] pci 0000:00:1c.4: PCI bridge to [bus 05-9b]
[    2.493054] pci 0000:00:1c.4:   bridge window [io  0x3000-0x5fff]
[    2.493063] pci 0000:00:1c.4:   bridge window [mem 0xb0b00000-0xbcbf=
ffff]
[    2.493071] pci 0000:00:1c.4:   bridge window [mem
0xbcc00000-0xc8bfffff 64bit pref]
[    2.493083] pci 0000:04:00.0: BAR 6: assigned [mem
0x8fa00000-0x8fa1ffff pref]
[    2.493088] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    2.493092] pci 0000:00:1c.5:   bridge window [io  0x1000-0x1fff]
[    2.493100] pci 0000:00:1c.5:   bridge window [mem 0xb0700000-0xb07f=
ffff]
[    2.493106] pci 0000:00:1c.5:   bridge window [mem
0x8fa00000-0x8fafffff pref]
[    2.493116] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    2.493120] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    2.493124] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    2.493128] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff]
[    2.493132] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff]
[    2.493136] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff]
[    2.493140] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff]
[    2.493144] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff]
[    2.493147] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff]
[    2.493151] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff]
[    2.493155] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff]
[    2.493159] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff]
[    2.493163] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff]
[    2.493167] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff]
[    2.493170] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff]
[    2.493174] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff]
[    2.493178] pci_bus 0000:00: resource 20 [mem 0x8fa00000-0xfeafffff]
[    2.493182] pci_bus 0000:00: resource 21 [mem 0xfed40000-0xfed44fff]
[    2.493186] pci_bus 0000:02: resource 1 [mem 0xb0800000-0xb09fffff]
[    2.493190] pci_bus 0000:02: resource 2 [mem 0x90000000-0x9fffffff
64bit pref]
[    2.493195] pci_bus 0000:03: resource 1 [mem 0xb0400000-0xb06fffff]
[    2.493199] pci_bus 0000:05: resource 0 [io  0x3000-0x5fff]
[    2.493203] pci_bus 0000:05: resource 1 [mem 0xb0b00000-0xbcbfffff]
[    2.493207] pci_bus 0000:05: resource 2 [mem 0xbcc00000-0xc8bfffff
64bit pref]
[    2.493211] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    2.493215] pci_bus 0000:04: resource 1 [mem 0xb0700000-0xb07fffff]
[    2.493219] pci_bus 0000:04: resource 2 [mem 0x8fa00000-0x8fafffff p=
ref]
[    2.493266] NET: Registered protocol family 2
[    2.493512] TCP established hash table entries: 32768 (order: 7,
524288 bytes)
[    2.493670] TCP bind hash table entries: 32768 (order: 7, 524288 byt=
es)
[    2.493764] TCP: Hash tables configured (established 32768 bind 3276=
8)
[    2.493790] TCP: reno registered
[    2.493802] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    2.493828] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes=
)
[    2.493915] NET: Registered protocol family 1
[    2.493932] pci 0000:00:02.0: Boot video device
[    2.494274] PCI: CLS 256 bytes, default 64
[    2.494323] Trying to unpack rootfs image as initramfs...
[    6.665432] Freeing initrd memory: 137420K (ffff88002738a000 -
ffff88002f9bd000)
[    6.665449] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
[    6.665454] software IO TLB [mem 0x6da5e000-0x71a5e000] (64MB)
mapped at [ffff88006da5e000-ffff880071a5dfff]
[    6.665719] Scanning for low memory corruption every 60 seconds
[    6.666080] Initialise module verification
[    6.666141] audit: initializing netlink socket (disabled)
[    6.666155] type=3D2000 audit(1379857947.652:1): initialized
[    6.726185] bounce pool size: 64 pages
[    6.726200] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    6.727962] VFS: Disk quotas dquot_6.5.2
[    6.728017] Dquot-cache hash table entries: 512 (order 0, 4096 bytes=
)
[    6.728638] fuse init (API version 7.22)
[    6.728745] msgmni has been set to 7466
[    6.729375] Key type asymmetric registered
[    6.729381] Asymmetric key parser 'x509' registered
[    6.729423] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[    6.729476] io scheduler noop registered
[    6.729482] io scheduler deadline registered (default)
[    6.729516] io scheduler cfq registered
[    6.729782] pcieport 0000:00:1c.0: irq 58 for MSI/MSI-X
[    6.729984] pcieport 0000:00:1c.1: irq 59 for MSI/MSI-X
[    6.730170] pcieport 0000:00:1c.2: irq 60 for MSI/MSI-X
[    6.730357] pcieport 0000:00:1c.4: irq 61 for MSI/MSI-X
[    6.730541] pcieport 0000:00:1c.5: irq 62 for MSI/MSI-X
[    6.730642] pcieport 0000:00:1c.0: Signaling PME through PCIe PME in=
terrupt
[    6.730649] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme lo=
aded
[    6.730675] pcieport 0000:00:1c.1: Signaling PME through PCIe PME in=
terrupt
[    6.730679] pci 0000:02:00.0: Signaling PME through PCIe PME interru=
pt
[    6.730687] pcie_pme 0000:00:1c.1:pcie01: service driver pcie_pme lo=
aded
[    6.730709] pcieport 0000:00:1c.2: Signaling PME through PCIe PME in=
terrupt
[    6.730713] pci 0000:03:00.0: Signaling PME through PCIe PME interru=
pt
[    6.730720] pcie_pme 0000:00:1c.2:pcie01: service driver pcie_pme lo=
aded
[    6.730744] pcieport 0000:00:1c.4: Signaling PME through PCIe PME in=
terrupt
[    6.730751] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme lo=
aded
[    6.730774] pcieport 0000:00:1c.5: Signaling PME through PCIe PME in=
terrupt
[    6.730778] pci 0000:04:00.0: Signaling PME through PCIe PME interru=
pt
[    6.730785] pcie_pme 0000:00:1c.5:pcie01: service driver pcie_pme lo=
aded
[    6.730802] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    6.730821] pciehp: PCI Express Hot Plug Controller Driver version: =
0.4
[    6.730895] efifb: probing for efifb
[    6.732357] efifb: framebuffer at 0xa0000000, mapped to
0xffffc9000a480000, using 5440k, total 5440k
[    6.732362] efifb: mode is 1440x900x32, linelength=3D6144, pages=3D1
[    6.732365] efifb: scrolling: redraw
[    6.732368] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    6.737762] Console: switching to colour frame buffer device 180x56
[    6.743095] fb0: EFI VGA frame buffer device
[    6.743131] intel_idle: MWAIT substates: 0x11142120
[    6.743164] intel_idle: v0.4 model 0x45
[    6.743190] intel_idle: lapic_timer_reliable_states 0xffffffff
[    6.743521] ACPI: AC Adapter [ADP1] (off-line)
[    6.743662] input: Lid Switch as
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
[    6.743733] ACPI: Lid Switch [LID0]
[    6.743795] input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    6.743851] ACPI: Power Button [PWRB]
[    6.743911] input: Sleep Button as
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
[    6.743965] ACPI: Sleep Button [SLPB]
[    6.744026] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    6.744086] ACPI: Power Button [PWRF]
[    6.744153] ACPI: Requesting acpi_cpufreq
[    6.745805] GHES: HEST is not enabled!
[    6.745961] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    6.748503] Linux agpgart interface v0.103
[    6.750236] brd: module loaded
[    6.751118] loop: module loaded
[    6.751576] libphy: Fixed MDIO Bus: probed
[    6.751709] tun: Universal TUN/TAP device driver, 1.6
[    6.751743] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    6.751839] PPP generic driver version 2.4.2
[    6.751918] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    6.751963] ehci-pci: EHCI PCI platform driver
[    6.752006] ehci-platform: EHCI generic platform driver
[    6.752063] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.752105] ohci-pci: OHCI PCI platform driver
[    6.752153] ohci-platform: OHCI generic platform driver
[    6.752203] uhci_hcd: USB Universal Host Controller Interface driver
[    6.752475] xhci_hcd 0000:00:14.0: setting latency timer to 64
[    6.754299] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    6.756020] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    6.757903] xhci_hcd 0000:00:14.0: cache line size of 256 is not sup=
ported
[    6.759693] xhci_hcd 0000:00:14.0: irq 63 for MSI/MSI-X
[    6.761573] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    6.763292] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    6.765038] usb usb1: Product: xHCI Host Controller
[    6.766738] usb usb1: Manufacturer: Linux 3.12.0-rc1+ xhci_hcd
[    6.768448] usb usb1: SerialNumber: 0000:00:14.0
[    6.770382] hub 1-0:1.0: USB hub found
[    6.772372] hub 1-0:1.0: 9 ports detected
[    6.774444] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    6.776155] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    6.778153] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003
[    6.779907] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    6.781863] usb usb2: Product: xHCI Host Controller
[    6.783778] usb usb2: Manufacturer: Linux 3.12.0-rc1+ xhci_hcd
[    6.785753] usb usb2: SerialNumber: 0000:00:14.0
[    6.787617] hub 2-0:1.0: USB hub found
[    6.789496] hub 2-0:1.0: 4 ports detected
[    6.808226] i8042: PNP: No PS/2 controller found. Probing ports dire=
ctly.
[    6.880192] ACPI: Battery Slot [BAT0] (battery present)
[    7.000421] usb 2-3: new SuperSpeed USB device number 2 using xhci_h=
cd
[    7.018249] usb 2-3: New USB device found, idVendor=3D05ac, idProduc=
t=3D8406
[    7.021090] usb 2-3: New USB device strings: Mfr=3D3, Product=3D4, S=
erialNumber=3D5
[    7.023873] usb 2-3: Product: Card Reader
[    7.026651] usb 2-3: Manufacturer: Apple
[    7.029420] usb 2-3: SerialNumber: 00000000AP05
[    7.592175] usb 1-3: new full-speed USB device number 2 using xhci_h=
cd
[    7.664166] tsc: Refined TSC clocksource calibration: 1899.999 MHz
[    7.669031] usb 1-3: New USB device found, idVendor=3D0a5c, idProduc=
t=3D4500
[    7.671824] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    7.674571] usb 1-3: Product: BRCM20702 Hub
[    7.677288] usb 1-3: Manufacturer: Apple Inc.
[    7.680069] usb 1-3: ep 0x81 - rounding interval to 1024
microframes, ep desc says 2040 microframes
[    7.683016] hub 1-3:1.0: USB hub found
[    7.685792] hub 1-3:1.0: 3 ports detected
[    7.876613] i8042: No controller found
[    7.878424] mousedev: PS/2 mouse device common for all mice
[    7.880686] rtc_cmos 00:05: RTC can wake from S4
[    7.882478] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    7.884045] rtc_cmos 00:05: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    7.885692] device-mapper: uevent: version 1.0.3
[    7.887354] device-mapper: ioctl: 4.26.0-ioctl (2013-08-15)
initialised: dm-devel@redhat.com
[    7.888979] ledtrig-cpu: registered to indicate activity on CPUs
[    7.890572] EFI Variables Facility v0.08 2004-May-17
[    8.040241] usb 1-5: new full-speed USB device number 3 using xhci_h=
cd
[    8.057794] usb 1-5: New USB device found, idVendor=3D05ac, idProduc=
t=3D0291
[    8.061135] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D3
[    8.064574] usb 1-5: Product: Apple Internal Keyboard / Trackpad
[    8.067992] usb 1-5: Manufacturer: Apple Inc.
[    8.071300] usb 1-5: SerialNumber: D3H33349PPAF94RASCA
[    8.142814] ashmem: initialized
[    8.144264] usb 1-3.1: new full-speed USB device number 4 using xhci=
_hcd
[    8.146245] TCP: cubic registered
[    8.147954] NET: Registered protocol family 10
[    8.149794] NET: Registered protocol family 17
[    8.151386] Key type dns_resolver registered
[    8.153315] Loading module verification certificates
[    8.156338] MODSIGN: Loaded cert 'Magrathea: Glacier signing key:
886d6836477ef49af1b2c30375667ce92650542d'
[    8.157975] registered taskstats version 1
[    8.162670] usb 1-3.1: New USB device found, idVendor=3D05ac, idProd=
uct=3D820a
[    8.163001] Key type trusted registered
[    8.165764] Key type encrypted registered
[    8.167867] usb 1-3.1: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    8.168357] AppArmor: AppArmor sha1 policy hashing enabled
[    8.173449] rtc_cmos 00:05: setting system clock to 2013-09-22
13:52:29 UTC (1379857949)
[    8.173574] usb 1-3.1: ep 0x81 - rounding interval to 64
microframes, ep desc says 80 microframes
[    8.177901] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    8.179507] EDD information not available.
[    8.182381] Freeing unused kernel memory: 1192K (ffffffff81cfa000 -
ffffffff81e24000)
[    8.184011] Write protecting the kernel read-only data: 12288k
[    8.189993] Freeing unused kernel memory: 1316K (ffff8800026b7000 -
ffff880002800000)
[    8.194525] Freeing unused kernel memory: 952K (ffff880002b12000 -
ffff880002c00000)
[    8.212532] systemd-udevd[108]: starting version 204
[    8.244255] usb 1-3.2: new full-speed USB device number 5 using xhci=
_hcd
[    8.260730] usb 1-3.2: device descriptor read/all, error 9
[    8.284474] usb-storage 2-3:1.0: USB Mass Storage device detected
[    8.288563] scsi0 : usb-storage 2-3:1.0
[    8.294227] usbcore: registered new interface driver usb-storage
[    8.297328] hidraw: raw HID events driver (C) Jiri Kosina
[    8.313087] ahci 0000:04:00.0: version 3.0
[    8.314957] ahci 0000:04:00.0: irq 64 for MSI/MSI-X
[    8.332234] ahci 0000:04:00.0: AHCI 0001.0000 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    8.334924] ahci 0000:04:00.0: flags: 64bit ncq sntf led pio slum pa=
rt
[    8.334928] usb 1-3.2: new full-speed USB device number 6 using xhci=
_hcd
[    8.337248] usbcore: registered new interface driver usbhid
[    8.337249] usbhid: USB HID core driver
[    8.345941] scsi1 : ahci
[    8.347711] ata1: SATA max UDMA/133 abar m512@0xb0700000 port
0xb0700100 irq 64
[    8.350419] usb 1-3.2: New USB device found, idVendor=3D05ac, idProd=
uct=3D820b
[    8.350422] usb 1-3.2: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    8.352220] usb 1-3.2: ep 0x81 - rounding interval to 64
microframes, ep desc says 80 microframes
[    8.357807] apple 0003:05AC:0291.0001: hiddev0,hidraw0: USB HID
v1.10 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on
usb-0000:00:14.0-5/input0
[    8.360048] input: Apple Inc. Apple Internal Keyboard / Trackpad as
/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.1/input/input4
[    8.362401] apple 0003:05AC:0291.0002: input,hiddev0,hidraw1: USB
HID v1.10 Keyboard [Apple Inc. Apple Internal Keyboard / Trackpad] on
usb-0000:00:14.0-5/input1
[    8.424381] usb 1-3.3: new full-speed USB device number 7 using xhci=
_hcd
[    8.444288] usb 1-3.3: New USB device found, idVendor=3D05ac, idProd=
uct=3D828f
[    8.446189] usb 1-3.3: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[    8.448057] usb 1-3.3: Product: Bluetooth USB Host Controller
[    8.449923] usb 1-3.3: Manufacturer: Apple Inc.
[    8.457348] input: HID 05ac:820a as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.1/1-3.1:1.0/input/input5
[    8.459503] hid-generic 0003:05AC:820A.0003: input,hidraw2: USB HID
v1.11 Keyboard [HID 05ac:820a] on usb-0000:00:14.0-3.1/input0
[    8.461640] input: HID 05ac:820b as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.2/1-3.2:1.0/input/input6
[    8.464007] hid-generic 0003:05AC:820B.0004: input,hidraw3: USB HID
v1.11 Mouse [HID 05ac:820b] on usb-0000:00:14.0-3.2/input0
[    8.664374] Switched to clocksource tsc
[    8.676336] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.678875] ata1.00: unexpected _GTF length (8)
[    8.681017] ata1.00: ATA-8: APPLE SSD SD0128F, A222821, max UDMA/133
[    8.683010] ata1.00: 236978176 sectors, multi 1: LBA48 NCQ (depth 31=
/32), AA
[    8.685736] ata1.00: unexpected _GTF length (8)
[    8.687891] ata1.00: configured for UDMA/133
[    8.690107] scsi 1:0:0:0: Direct-Access     ATA      APPLE SSD
SD0128 A222 PQ: 0 ANSI: 5
[    8.692397] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    8.692403] sd 1:0:0:0: [sda] 236978176 512-byte logical blocks:
(121 GB/113 GiB)
[    8.692405] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    8.692535] sd 1:0:0:0: [sda] Write Protect is off
[    8.692539] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    8.692574] sd 1:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    8.694281]  sda: sda1 sda2 sda3 sda4 sda5
[    8.694966] sd 1:0:0:0: [sda] Attached SCSI disk
[    8.752676] EXT4-fs (sda4): INFO: recovery required on readonly file=
system
[    8.754682] EXT4-fs (sda4): write access will be enabled during reco=
very
[    8.891412] EXT4-fs (sda4): recovery complete
[    8.894038] EXT4-fs (sda4): mounted filesystem with ordered data
mode. Opts: (null)
[    9.102544] init: ureadahead main process (170) terminated with stat=
us 5
[    9.194711] Adding 3967996k swap on /dev/sda5.  Priority:-1
extents:1 across:3967996k SSFS
[    9.217739] EXT4-fs (sda4): re-mounted. Opts: errors=3Dremount-ro
[    9.294430] scsi 0:0:0:0: Direct-Access     APPLE    SD Card Reader
  3.00 PQ: 0 ANSI: 6
[    9.294737] sd 0:0:0:0: Attached scsi generic sg1 type 0
[    9.296135] sd 0:0:0:0: [sdb] Attached SCSI removable disk
[    9.346799] systemd-udevd[352]: starting version 204
[    9.413946] lp: driver loaded but no devices found
[    9.600588] input: bcm5974 as
/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.2/input/input7
[    9.603318] usbcore: registered new interface driver bcm5974
[    9.698144] ACPI Warning: 0x0000000000000830-0x000000000000083f
SystemIO conflicts with Region \GPIO 1 (20130725/utaddress-251)
[    9.698157] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    9.698161] ACPI Warning: 0x0000000000000800-0x000000000000082f
SystemIO conflicts with Region \GPIO 1 (20130725/utaddress-251)
[    9.698168] ACPI Warning: 0x0000000000000800-0x000000000000082f
SystemIO conflicts with Region \IO_D 2 (20130725/utaddress-251)
[    9.698175] ACPI Warning: 0x0000000000000800-0x000000000000082f
SystemIO conflicts with Region \IO_T 3 (20130725/utaddress-251)
[    9.698182] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    9.698185] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    9.706351] [drm] Initialized drm 1.1.0 20060810
[    9.712386] microcode: CPU0 sig=3D0x40651, pf=3D0x40, revision=3D0x1=
1
[    9.846336] cfg80211: Calling CRDA to update world regulatory domain
[    9.889991] lib80211: common routines for IEEE802.11 drivers
[    9.889999] lib80211_crypt: registered algorithm 'NULL'
[    9.954410] Bluetooth: Core ver 2.16
[    9.954446] NET: Registered protocol family 31
[    9.954449] Bluetooth: HCI device and connection manager initialized
[    9.954461] Bluetooth: HCI socket layer initialized
[    9.954465] Bluetooth: L2CAP socket layer initialized
[    9.954475] Bluetooth: SCO socket layer initialized
[    9.979250] wl: module license 'MIXED/Proprietary' taints kernel.
[    9.979251] Disabling lock debugging due to kernel taint
[    9.985425] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.985427] Bluetooth: BNEP filters: protocol multicast
[    9.985439] Bluetooth: BNEP socket layer initialized
[   10.005592] wl: module verification failed: signature and/or
required key missing - tainting kernel
[   10.058708]  femctrl from nvram not enabled. returning from here
[   10.063427] Bluetooth: RFCOMM TTY layer initialized
[   10.063444] Bluetooth: RFCOMM socket layer initialized
[   10.063447] Bluetooth: RFCOMM ver 1.11
[   10.094281] INFO @wl_cfg80211_attach : Registered CFG80211 phy
[   10.101301] ppdev: user-space parallel port driver
[   10.117257] lib80211_crypt: registered algorithm 'TKIP'
[   10.162984] eth0: Broadcom BCM43a0 802.11 Hybrid Wireless
Controller 6.30.223.30 (r390414)
[   10.163921] usbcore: registered new interface driver btusb
[   10.194523] microcode: CPU1 sig=3D0x40651, pf=3D0x40, revision=3D0x1=
1
[   10.254909] microcode: CPU2 sig=3D0x40651, pf=3D0x40, revision=3D0x1=
1
[   10.256964] microcode: CPU3 sig=3D0x40651, pf=3D0x40, revision=3D0x1=
1
[   10.258588] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   10.285747] applesmc: key=3D518 fan=3D1 temp=3D32 index=3D32 acc=3D0=
 lux=3D2 kbd=3D1
[   10.319387] init: avahi-cups-reload main process (501) terminated
with status 1
[   10.366789] usb 1-3.1: USB disconnect, device number 4
[   10.461056] [drm] Memory usable by graphics device =3D 2048M
[   10.461064] checking generic (a0000000 550000) vs hw (a0000000 10000=
000)
[   10.461068] fb: conflicting fb hw usage inteldrmfb vs EFI VGA -
removing generic driver
[   10.461118] Console: switching to colour dummy device 80x25
[   10.462082] i915 0000:00:02.0: setting latency timer to 64
[   10.553057] systemd-udevd[396]: renamed network interface eth0 to et=
h1
[   10.561558] i915 0000:00:02.0: irq 65 for MSI/MSI-X
[   10.561576] [drm] Supports vblank timestamp caching Rev 1 (10.10.201=
0).
[   10.561579] [drm] Driver supports precise vblank timestamp query.
[   10.567733] cfg80211: World regulatory domain updated:
[   10.567739] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[   10.567743] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   10.567747] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   10.567751] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   10.567754] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   10.567758] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   10.992634] usb 1-3.2: USB disconnect, device number 6
[   11.245429] type=3D1400 audit(1379857952.571:2): apparmor=3D"STATUS"
operation=3D"profile_load" name=3D"/sbin/dhclient" pid=3D598
comm=3D"apparmor_parser"
[   11.245716] type=3D1400 audit(1379857952.571:3): apparmor=3D"STATUS"
operation=3D"profile_load"
name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D598
comm=3D"apparmor_parser"
[   11.245982] type=3D1400 audit(1379857952.571:4): apparmor=3D"STATUS"
operation=3D"profile_load"
name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D598
comm=3D"apparmor_parser"
[   11.259258] [drm] GMBUS [i915 gmbus dpb] timed out, falling back to
bit banging on pin 5
[   11.310833] type=3D1400 audit(1379857952.635:5): apparmor=3D"STATUS"
operation=3D"profile_replace" name=3D"/sbin/dhclient" pid=3D621
comm=3D"apparmor_parser"
[   11.311118] type=3D1400 audit(1379857952.635:6): apparmor=3D"STATUS"
operation=3D"profile_replace"
name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D621
comm=3D"apparmor_parser"
[   11.311381] type=3D1400 audit(1379857952.635:7): apparmor=3D"STATUS"
operation=3D"profile_replace"
name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D621
comm=3D"apparmor_parser"
[   11.328511] [drm] GMBUS [i915 gmbus dpc] timed out, falling back to
bit banging on pin 4
[   11.352757] fbcon: inteldrmfb (fb0) is primary device
[   11.657990] type=3D1400 audit(1379857952.983:8): apparmor=3D"STATUS"
operation=3D"profile_load" name=3D"/usr/lib/cups/backend/cups-pdf" pid=3D=
594
comm=3D"apparmor_parser"
[   11.658378] type=3D1400 audit(1379857952.983:9): apparmor=3D"STATUS"
operation=3D"profile_load" name=3D"/usr/sbin/cupsd" pid=3D594
comm=3D"apparmor_parser"
[   12.788760] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[   13.564841] Console: switching to colour frame buffer device 180x56
[   13.574021] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   13.574024] i915 0000:00:02.0: registered panic notifier
[   13.574029] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dio:owns=3Dio
[   13.586198] [drm:intel_uncore_check_errors] *ERROR* Unclaimed
register before interrupt
[   13.587185] acpi device:03: registered as cooling_device4
[   13.587746] ACPI: Video Device [IGPU] (multi-head: yes  rom: no  pos=
t: no)
[   13.588885] input: Video Bus as
/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input8
[   13.589586] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 o=
n minor 0
[   13.590338] snd_hda_intel 0000:00:03.0: irq 66 for MSI/MSI-X
[   13.591223] snd_hda_intel 0000:00:1b.0: irq 67 for MSI/MSI-X
[   13.603136] init: failsafe main process (636) killed by TERM signal
[   13.624908] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[   13.625144] hda_codec: invalid CONNECT_LIST verb 5[1]:0
[   13.625228] hda_codec: invalid CONNECT_LIST verb 6[1]:0
[   13.625286] hda_codec: invalid CONNECT_LIST verb 7[1]:0
[   13.625627] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[   13.625734] input: HDA Intel MID HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input11
[   13.626078] input: HDA Intel MID HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input12
[   13.626294] input: HDA Intel MID HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input13
[   14.451387] type=3D1400 audit(1379857955.775:10): apparmor=3D"STATUS=
"
operation=3D"profile_load"
name=3D"/usr/lib/x86_64-linux-gnu/lightdm-remote-session-freerdp/freerd=
p-session-wrapper"
pid=3D789 comm=3D"apparmor_parser"
[   14.451995] type=3D1400 audit(1379857955.775:11): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"chromium_browser" pid=3D789
comm=3D"apparmor_parser"
[   14.489231] type=3D1400 audit(1379857955.815:12): apparmor=3D"STATUS=
"
operation=3D"profile_load"
name=3D"/usr/lib/lightdm/lightdm/lightdm-guest-session-wrapper" pid=3D7=
88
comm=3D"apparmor_parser"
[   14.489726] type=3D1400 audit(1379857955.815:13): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"chromium_browser" pid=3D788
comm=3D"apparmor_parser"
[   14.491758] type=3D1400 audit(1379857955.815:14): apparmor=3D"STATUS=
"
operation=3D"profile_replace" name=3D"/sbin/dhclient" pid=3D791
comm=3D"apparmor_parser"
[   14.492112] type=3D1400 audit(1379857955.815:15): apparmor=3D"STATUS=
"
operation=3D"profile_replace"
name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D791
comm=3D"apparmor_parser"
[   14.492409] type=3D1400 audit(1379857955.815:16): apparmor=3D"STATUS=
"
operation=3D"profile_replace"
name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D791
comm=3D"apparmor_parser"
[   14.527059] type=3D1400 audit(1379857955.851:17): apparmor=3D"STATUS=
"
operation=3D"profile_load"
name=3D"/usr/lib/x86_64-linux-gnu/lightdm-remote-session-uccsconfigure/=
uccsconfigure-session-wrapper"
pid=3D790 comm=3D"apparmor_parser"
[   14.527513] type=3D1400 audit(1379857955.851:18): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"chromium_browser" pid=3D790
comm=3D"apparmor_parser"
[   14.986323] type=3D1400 audit(1379857956.311:19): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"/usr/sbin/tcpdump" pid=3D807
comm=3D"apparmor_parser"
[   16.989152] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[   22.519867] audit_printk_skb: 21 callbacks suppressed
[   22.519872] type=3D1400 audit(1379857963.843:27): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"/usr/bin/evince" pid=3D802
comm=3D"apparmor_parser"
[   22.520653] type=3D1400 audit(1379857963.843:28): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"sanitized_helper" pid=3D802
comm=3D"apparmor_parser"
[   22.522375] type=3D1400 audit(1379857963.847:29): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"/usr/bin/evince-previewer" pid=3D802
comm=3D"apparmor_parser"
[   22.522921] type=3D1400 audit(1379857963.847:30): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"sanitized_helper" pid=3D802
comm=3D"apparmor_parser"
[   22.524102] type=3D1400 audit(1379857963.847:31): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"/usr/bin/evince-thumbnailer" pid=3D8=
02
comm=3D"apparmor_parser"
[   22.524562] type=3D1400 audit(1379857963.847:32): apparmor=3D"STATUS=
"
operation=3D"profile_load" name=3D"sanitized_helper" pid=3D802
comm=3D"apparmor_parser"
[   40.663776] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[   83.680176] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[  146.714166] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[  229.618319] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[  332.628293] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[  452.640062] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[  572.667658] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error
[  692.699249] ERROR @wl_inform_single_bss : cfg80211_inform_bss_frame =
error


---- hdparm -I /dev/sda ----
/dev/sda:

ATA device, with non-removable media
    Model Number:       APPLE SSD SD0128F
    Serial Number:      1333BT404802=14=14=14=14=14=14=14
    Firmware Revision:  A222821
    Media Serial Num:
    Media Manufacturer:
    Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II
Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
    Used: unknown (minor revision code 0x0028)
    Supported: 8 7 6 5
    Likely used: 8
Configuration:
    Logical        max    current
    cylinders    16383    16383
    heads        16    16
    sectors/track    63    63
    --
    CHS current addressable sectors:   16514064
    LBA    user addressable sectors:  236978176
    LBA48  user addressable sectors:  236978176
    Logical  Sector size:                   512 bytes
    Physical Sector size:                  4096 bytes
    Logical Sector-0 offset:                  0 bytes
    device size with M =3D 1024*1024:      115712 MBytes
    device size with M =3D 1000*1000:      121332 MBytes (121 GB)
    cache/buffer size  =3D unknown
    Nominal Media Rotation Rate: Solid State Device
Capabilities:
    LBA, IORDY(can be disabled)
    Queue depth: 32
    Standby timer values: spec'd by Standard, no device specific minimu=
m
    R/W multiple sector transfer: Max =3D 1    Current =3D 1
    Advanced power management level: 128
    Recommended acoustic management value: 32, current value: 32
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=3D120ns recommended=3D120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=3D240ns  IORDY flow control=3D120n=
s
Commands/features:
    Enabled    Supported:
       *    SMART feature set
            Security Mode feature set
       *    Power Management feature set
       *    Write cache
       *    Look-ahead
       *    WRITE_BUFFER command
       *    READ_BUFFER command
       *    NOP cmd
       *    DOWNLOAD_MICROCODE
       *    Advanced Power Management feature set
       *    48-bit Address feature set
       *    Device Configuration Overlay feature set
       *    Mandatory FLUSH_CACHE
       *    FLUSH_CACHE_EXT
       *    SMART error logging
       *    General Purpose Logging feature set
       *    WRITE_{DMA|MULTIPLE}_FUA_EXT
       *    64-bit World wide name
       *    IDLE_IMMEDIATE with UNLOAD
       *    {READ,WRITE}_DMA_EXT_GPL commands
       *    Segmented DOWNLOAD_MICROCODE
       *    Free-fall Control feature set
       *    Gen1 signaling speed (1.5Gb/s)
       *    Gen2 signaling speed (3.0Gb/s)
       *    Gen3 signaling speed (6.0Gb/s)
       *    Native Command Queueing (NCQ)
       *    Host-initiated interface power management
       *    Phy event counters
       *    Host automatic Partial to Slumber transitions
       *    Device automatic Partial to Slumber transitions
       *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
       *    DMA Setup Auto-Activate optimization
            Device-initiated interface power management
       *    Software settings preservation
       *    Data Set Management TRIM supported (limit 16 blocks)
       *    Deterministic read ZEROs after TRIM
Security:
    Master password revision code =3D 65534
        supported
    not    enabled
    not    locked
        frozen
    not    expired: security count
        supported: enhanced erase
    2min for SECURITY ERASE UNIT. 12min for ENHANCED SECURITY ERASE UNI=
T.
Logical Unit WWN Device Identifier: 5001b44a21c7a442
    NAA        : 5
    IEEE OUI    : 001b44
    Unique ID    : a21c7a442
Checksum: correct


---- smartctl -a /dev/sda ----
smartctl 6.2 2013-04-20 r3812 [x86_64-linux-3.12.0-rc1+] (local build)
Copyright (C) 2002-13, Bruce Allen, Christian Franke, www.smartmontools=
=2Eorg

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     APPLE SSD SD0128F
Serial Number:    1333BT404802
LU WWN Device Id: 5 001b44 a21c7a442
=46irmware Version: A222821
User Capacity:    121 332 826 112 bytes [121 GB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    Solid State Device
Device is:        Not in smartctl database [for details use: -P showall=
]
ATA Version is:   ATA8-ACS T13/1699-D revision 6
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Sun Sep 22 16:06:48 2013 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)    Offline data collection acti=
vity
                    was never started.
                    Auto Offline Data Collection: Disabled.
Total time to complete Offline
data collection:         (    0) seconds.
Offline data collection
capabilities:              (0x00)     Offline data collection not suppo=
rted.
SMART capabilities:            (0x0003)    Saves SMART data before ente=
ring
                    power-saving mode.
                    Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                    General Purpose Logging supported.

SMART Attributes Data Structure revision number: 40
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   100   000    Pre-fail
Always       -       0
  5 Reallocated_Sector_Ct   0x000f   100   100   000    Pre-fail
Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       19
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       96
169 Unknown_Attribute       0x0022   100   100   010    Old_age
Always       -       756088309472
173 Unknown_Attribute       0x0022   200   200   100    Old_age
Always       -       4296409091
174 Unknown_Attribute       0x0030   100   100   000    Old_age
Offline      -       844440
175 Program_Fail_Count_Chip 0x0030   100   100   000    Old_age
Offline      -       376857
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
Always       -       8
194 Temperature_Celsius     0x0022   039   039   000    Old_age
Always       -       61 (Min/Max 25/85)
197 Current_Pending_Sector  0x0032   000   000   000    Old_age
Always       -       0
199 UDMA_CRC_Error_Count    0x003e   100   100   000    Old_age
Always       -       0
244 Unknown_Attribute       0x0002   000   000   000    Old_age
Always       -       0

SMART Error Log not supported

SMART Self-test Log not supported

Selective Self-tests/Logging not supported
