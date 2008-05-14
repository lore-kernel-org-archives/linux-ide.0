From: Taisuke Yamada <tai@rakugaki.org>
Subject: Re: [PATCH] LBA28/LBA48 off-by-one bug in ata.h
Date: Thu, 15 May 2008 03:53:41 +0900
Message-ID: <482B3535.60709@rakugaki.org>
References: <481C224F.10301@rakugaki.org>	 <87f94c370805041133w1cea3c85k2eb1185be6c374d8@mail.gmail.com> <87f94c370805131206xe8081a2yade9d28e2a1edd04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020805000607020302000709"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s342.xrea.com ([59.139.29.98]:40720 "HELO s342.xrea.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752168AbYENTA7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 15:00:59 -0400
In-Reply-To: <87f94c370805131206xe8081a2yade9d28e2a1edd04@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: linux-ide@vger.kernel.org, tai@rakugaki.org

This is a multi-part message in MIME format.
--------------020805000607020302000709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg,
Thanks for responding and excuse me for the delay in reply.

# This is a re-post as I had email server configuration issue.
# Excuse me if you receive similar messages twice.

I was finally able to stop the machine, and took out 1 of 3 drives
in question. I re-tested the drive, and the issue reproduced 100%.
Here's the model/serial code of the drive:

     # output from "scsiinfo -a /dev/sda"
     Vendor:                    ATA
     Product:                   Hitachi HDP72505
     Revision level:            GM4O
     Serial Number '      GEB531RE0GEPGB'

  From the information I have gathered, this issue seems to be
either environment or usage-dependent. It seems it always reproduces,
or never happens. While I see many reports (and reports of "-1" fix
working) on various blogs/BBSs, I do also see many saying "doesn't
happen with me".

I must admit this weakens my proposal to apply the patch.
However, althrough it may not be 100% reproducible everywhere at
this time, I believe there is at least an ambiguity in the spec ("How
should ATA req on 0xfffffff be handled?") which could cause driver to
fail anytime, and so decided to submit a patch.

The fact *BSDs (and probably Intel) having similar fix also pushed
me to take action, and I'd also like to clarify that I'm not the
only one with this "-1" fix - the exact same stuff has been floating
on the net for months.

Now I have the drive at hand, I re-tested with latest 2.6.25.3
kernel (rebuilt from vanilla source, not some distribution kernel),
and here's the result:

    # uname -a
    Linux pc 2.6.25.3 #2 Thu May 15 01:05:14 JST 2008 i686 GNU/Linux
    # dd if=/dev/sda bs=512 count=1 skip=268435455
    dd: reading `/dev/sda': Input/output error
    0+0 records in
    0+0 records out
    0 bytes (0 B) copied, 0.289322 s, 0.0 kB/s
    # dmesg -c
    ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
    ata3.00: BMDMA stat 0x25
    ata3.00: cmd c8/00:08:f8:ff:ff/00:00:00:00:00/ef tag 0 dma 4096 in
             res 51/04:08:f8:ff:ff/00:00:00:00:00/ef Emask 0x1 (device 
error)
    ata3.00: status: { DRDY ERR }
    ata3.00: error: { ABRT }
    ata3.00: configured for UDMA/33
    ata3: EH complete
     ...[same messages repeating several times]...

And for block size of 1KB-8KB, I get exactly the same error:

    # dd if=/dev/sda bs=1024 count=1 skip=134217727
    dd: reading `/dev/sda': Input/output error
    # dd if=/dev/sda bs=2048 count=1 skip=67108863
    dd: reading `/dev/sda': Input/output error
    # dd if=/dev/sda bs=4096 count=1 skip=33554431
    dd: reading `/dev/sda': Input/output error
    # dd if=/dev/sda bs=8192 count=1 skip=16777215
    dd: reading `/dev/sda': Input/output error
    # dd if=/dev/sda bs=16384 count=1 skip=8388607
    dd: reading `/dev/sda': Input/output error

Now, here's more interesting behavior of the drive.
With enough "backoff" from the border, the drive responds
normally to the request:

    # dd if=/dev/sda bs=4096 count=1 skip=33554431
    dd: reading `/dev/sda': Input/output error
    0+0 records in
    0+0 records out
    0 bytes (0 B) copied, 0.288113 s, 0.0 kB/s
    # dd if=/dev/sda bs=4096 count=2 skip=33554430
    dd: reading `/dev/sda': Input/output error
    1+0 records in    <----------------------------- PARTIAL READ OK
    1+0 records out
    4096 bytes (4.1 kB) copied, 0.309428 s, 13.2 kB/s
    # dd if=/dev/sda bs=4096 count=3 skip=33554429
    3+0 records in    <----------------------------- FULL READ OK
    3+0 records out
    12288 bytes (12 kB) copied, 0.00753634 s, 1.6 MB/s
    # dd if=/dev/sda bs=4096 count=100 skip=33554429
    100+0 records in
    100+0 records out
    409600 bytes (410 kB) copied, 0.00551966 s, 74.2 MB/s

And the same test with 512-byte block request:

    # dd if=/dev/sda bs=512 count=1 skip=268435455
    dd: reading `/dev/sda': Input/output error
    0+0 records in
    0+0 records out
    0 bytes (0 B) copied, 0.289812 s, 0.0 kB/s
    # dd if=/dev/sda bs=512 count=2 skip=268435454
    dd: reading `/dev/sda': Input/output error
    0+0 records in
    0+0 records out
    0 bytes (0 B) copied, 0.28924 s, 0.0 kB/s
    ...
    ...continue backing off with larger total access size...
    ...
    # dd if=/dev/sda bs=512 count=8 skip=268435448
    dd: reading `/dev/sda': Input/output error
    0+0 records in
    0+0 records out
    0 bytes (0 B) copied, 0.286469 s, 0.0 kB/s
    # dd if=/dev/sda bs=512 count=9 skip=268435447
    dd: reading `/dev/sda': Input/output error
    1+0 records in    <----------------------------- PARTIAL READ OK
    1+0 records out
    512 bytes (512 B) copied, 0.322541 s, 1.6 kB/s
    ...
    ...continue backing off with larger total access size...
    ...
    # dd if=/dev/sda bs=512 count=16 skip=268435440
    dd: reading `/dev/sda': Input/output error
    8+0 records in    <----------------------------- MORE PARTIAL READ OK
    8+0 records out
    4096 bytes (4.1 kB) copied, 0.327491 s, 12.5 kB/s
    # dd if=/dev/sda bs=512 count=17 skip=268435439
    17+0 records in   <----------------------------- FULL READ OK
    17+0 records out
    8704 bytes (8.7 kB) copied, 0.0119018 s, 731 kB/s
    # dd if=/dev/sda bs=512 count=100 skip=268435439
    100+0 records in
    100+0 records out
    51200 bytes (51 kB) copied, 0.00237427 s, 21.6 MB/s

I'm starting to see some pattern here...

So even if request goes over LBA address of 0xfffffff, it seems
it won't break if certain amount of request (8KB>) is sent prior
to accessing the border.

I have attached full log of the test (pctest.sh, pctest.log), so
please check it out if there's anything unclear with above excerpt.
Also, as this could be some hardware and/or software combination issue,
reports generated by lshw(1) and scsiinfo(1) are also attached.

Is there any other tests I can do to track down the issue?
Maybe sending raw LBA28 request directly to the drive may help to
identify the issue?

Best Regards,
--
Taisuke Yamada

   >>  >  I recently bought 3 HGST P7K500-series 500GB SATA drives and
   >>  >  had trouble accessing the block right on the LBA28-LBA48 border.
   >>  >  Here's how it fails (same for all 3 drives):
   >>  >
   >>  >   # dd if=/dev/sdc bs=512 count=1 skip=268435455 > /dev/null
   >>  >   dd: reading `/dev/sdc': Input/output error
   >>
   >>  I'm surprised to see the above.  We do lots of dd to raw SATA drive
   >>  activity with a large variety of drives.  Both reads and writes and
   >>  we've never noticed this issue.
   >>
   >>  Does it happen if you are using 4k blocks with dd?
   >>
   >>  ie. We typically read / write the entire drive but using 4k blocks.
   >>
   >>  In fact a few months ago we specifically bought about 15 drives of
   >>  various sizes and manufacturers and verified that we could both read
   >>  and write all of the sectors of the drives.
   >>
   > Taisuke,
   >
   > I'd like to reproduce your results and keep the drive as a test drive
   > to ensure our systems work properly across the entire spectrum of
   > drives.
   >
   >>From our earlier tests we had a Hitachi 7K1000 Series Model
   > HDS721075KLA330 SATA 750GB drive, but it is not exhibiting the problem
   > you describe.
   >
   > Can you tell me a specific Model number Hitachi drive that the current
   > linux kernel is failing with.



--------------020805000607020302000709
Content-Type: text/plain;
 name="lshw.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lshw.txt"

<?xml version="1.0" standalone="yes" ?>
<!-- generated by lshw-B.02.12.01 -->
<!-- GCC 4.2.3 20080114 (prerelease) (Debian 4.2.2-7) -->
<!-- Linux 2.6.25.3 #2 Thu May 15 01:05:14 JST 2008 i686 -->
<!-- GNU libc 2 (glibc 2.7) -->
<node id="pc" claimed="true" class="system" handle="DMI:0001">
 <description>Desktop Computer</description>
 <product>PROD00000000</product>
 <vendor>OEM00000</vendor>
 <width units="bits">32</width>
 <configuration>
  <setting id="boot" value="normal" />
  <setting id="chassis" value="desktop" />
  <setting id="cpus" value="1" />
 </configuration>
 <capabilities>
  <capability id="smbios-2.2" >SMBIOS version 2.2</capability>
  <capability id="dmi-2.2" >DMI version 2.2</capability>
  <capability id="smp-1.4" >SMP specification v1.4</capability>
  <capability id="smp" >Symmetric Multi-Processing</capability>
 </capabilities>
  <node id="core" claimed="true" class="bus" handle="DMI:0002">
   <description>Motherboard</description>
   <product>MS-7025</product>
   <physid>0</physid>
    <node id="firmware" claimed="true" class="memory" handle="">
     <description>BIOS</description>
     <vendor>Phoenix Technologies, LTD</vendor>
     <physid>0</physid>
     <version>6.00 PG (12/21/2005)</version>
     <size units="bytes">131072</size>
     <capacity units="bytes">458752</capacity>
     <capabilities>
      <capability id="isa" >ISA bus</capability>
      <capability id="pci" >PCI bus</capability>
      <capability id="pnp" >Plug-and-Play</capability>
      <capability id="apm" >Advanced Power Management</capability>
      <capability id="upgrade" >BIOS EEPROM can be upgraded</capability>
      <capability id="shadowing" >BIOS shadowing</capability>
      <capability id="cdboot" >Booting from CD-ROM/DVD</capability>
      <capability id="bootselect" >Selectable boot path</capability>
      <capability id="socketedrom" >BIOS ROM is socketed</capability>
      <capability id="edd" >Enhanced Disk Drive extensions</capability>
      <capability id="int13floppy360" >5.25&quot; 360KB floppy</capability>
      <capability id="int13floppy1200" >5.25&quot; 1.2MB floppy</capability>
      <capability id="int13floppy720" >3.5&quot; 720KB floppy</capability>
      <capability id="int13floppy2880" >3.5&quot; 2.88MB floppy</capability>
      <capability id="int5printscreen" >Print Screen key</capability>
      <capability id="int9keyboard" >i8042 keyboard controller</capability>
      <capability id="int14serial" >INT14 serial line control</capability>
      <capability id="int17printer" >INT17 printer control</capability>
      <capability id="int10video" >INT10 CGA/Mono video</capability>
      <capability id="acpi" >ACPI</capability>
      <capability id="usb" >USB legacy emulation</capability>
      <capability id="agp" >AGP</capability>
      <capability id="ls120boot" >Booting from LS-120</capability>
      <capability id="zipboot" >Booting from ATAPI ZIP</capability>
     </capabilities>
    </node>
    <node id="cpu:0" claimed="true" class="processor" handle="DMI:0004">
     <description>CPU</description>
     <product>AMD Athlon(tm) 64 Processor 3200+</product>
     <vendor>Advanced Micro Devices [AMD]</vendor>
     <physid>4</physid>
     <businfo>cpu@0</businfo>
     <version>15.15.0</version>
     <slot>Socket 939</slot>
     <size units="Hz">2010000000</size>
     <capacity units="Hz">3000000000</capacity>
     <width units="bits">64</width>
     <clock units="Hz">200000000</clock>
     <capabilities>
      <capability id="boot" >boot processor</capability>
      <capability id="fpu" >mathematical co-processor</capability>
      <capability id="fpu_exception" >FPU exceptions reporting</capability>
      <capability id="wp" />
      <capability id="vme" >virtual mode extensions</capability>
      <capability id="de" >debugging extensions</capability>
      <capability id="pse" >page size extensions</capability>
      <capability id="tsc" >time stamp counter</capability>
      <capability id="msr" >model-specific registers</capability>
      <capability id="pae" >4GB+ memory addressing (Physical Address Extension)</capability>
      <capability id="mce" >machine check exceptions</capability>
      <capability id="cx8" >compare and exchange 8-byte</capability>
      <capability id="apic" >on-chip advanced programmable interrupt controller (APIC)</capability>
      <capability id="sep" >fast system calls</capability>
      <capability id="mtrr" >memory type range registers</capability>
      <capability id="pge" >page global enable</capability>
      <capability id="mca" >machine check architecture</capability>
      <capability id="cmov" >conditional move instruction</capability>
      <capability id="pat" >page attribute table</capability>
      <capability id="pse36" >36-bit page size extensions</capability>
      <capability id="clflush" />
      <capability id="mmx" >multimedia extensions (MMX)</capability>
      <capability id="fxsr" >fast floating point save/restore</capability>
      <capability id="sse" >streaming SIMD extensions (SSE)</capability>
      <capability id="sse2" >streaming SIMD extensions (SSE2)</capability>
      <capability id="syscall" >fast system calls</capability>
      <capability id="nx" >no-execute bit (NX)</capability>
      <capability id="mmxext" >multimedia extensions (MMXExt)</capability>
      <capability id="fxsr_opt" />
      <capability id="x86-64" >64bits extensions (x86-64)</capability>
      <capability id="3dnowext" >multimedia extensions (3DNow!Ext)</capability>
      <capability id="3dnow" >multimedia extensions (3DNow!)</capability>
      <capability id="lahf_lm" />
      <capability id="ts" />
      <capability id="fid" />
      <capability id="vid" />
      <capability id="ttp" />
     </capabilities>
      <node id="cache:0" claimed="true" class="memory" handle="DMI:000B">
       <description>L1 cache</description>
       <physid>b</physid>
       <slot>Internal Cache</slot>
       <size units="bytes">131072</size>
       <capacity units="bytes">131072</capacity>
       <capabilities>
        <capability id="synchronous" >Synchronous</capability>
        <capability id="internal" >Internal</capability>
        <capability id="write-back" >Write-back</capability>
       </capabilities>
      </node>
      <node id="cache:1" claimed="true" class="memory" handle="DMI:000D">
       <description>L2 cache</description>
       <physid>d</physid>
       <slot>External Cache</slot>
       <size units="bytes">524288</size>
       <capacity units="bytes">524288</capacity>
       <capabilities>
        <capability id="synchronous" >Synchronous</capability>
        <capability id="internal" >Internal</capability>
        <capability id="write-back" >Write-back</capability>
       </capabilities>
      </node>
    </node>
    <node id="cpu:1" disabled="true" claimed="true" class="processor" handle="DMI:0005">
     <description>CPU</description>
     <vendor>Unknown</vendor>
     <physid>5</physid>
     <businfo>cpu@1</businfo>
     <version>15.15.0</version>
     <slot>Socket 939</slot>
     <size units="Hz">2010000000</size>
     <capacity units="Hz">3000000000</capacity>
     <clock units="Hz">200000000</clock>
      <node id="cache:0" claimed="true" class="memory" handle="DMI:000C">
       <description>L1 cache</description>
       <physid>c</physid>
       <slot>Internal Cache</slot>
       <size units="bytes">131072</size>
       <capacity units="bytes">131072</capacity>
       <capabilities>
        <capability id="synchronous" >Synchronous</capability>
        <capability id="internal" >Internal</capability>
        <capability id="write-back" >Write-back</capability>
       </capabilities>
      </node>
      <node id="cache:1" claimed="true" class="memory" handle="DMI:000E">
       <description>L2 cache</description>
       <physid>e</physid>
       <slot>External Cache</slot>
       <size units="bytes">524288</size>
       <capacity units="bytes">524288</capacity>
       <capabilities>
        <capability id="synchronous" >Synchronous</capability>
        <capability id="internal" >Internal</capability>
        <capability id="write-back" >Write-back</capability>
       </capabilities>
      </node>
    </node>
    <node id="memory" claimed="true" class="memory" handle="DMI:001F">
     <description>System Memory</description>
     <physid>1f</physid>
     <slot>System board or motherboard</slot>
     <size units="bytes">3221225472</size>
      <node id="bank:0" claimed="true" class="memory" handle="DMI:0020">
       <description>DIMM</description>
       <physid>0</physid>
       <slot>A0</slot>
       <size units="bytes">1073741824</size>
       <width units="bits">64</width>
      </node>
      <node id="bank:1" claimed="true" class="memory" handle="DMI:0021">
       <description>DIMM</description>
       <physid>1</physid>
       <slot>A1</slot>
       <size units="bytes">1073741824</size>
       <width units="bits">64</width>
      </node>
      <node id="bank:2" claimed="true" class="memory" handle="DMI:0022">
       <description>DIMM</description>
       <physid>2</physid>
       <slot>A2</slot>
       <size units="bytes">536870912</size>
       <width units="bits">64</width>
      </node>
      <node id="bank:3" claimed="true" class="memory" handle="DMI:0023">
       <description>DIMM</description>
       <physid>3</physid>
       <slot>A3</slot>
       <size units="bytes">536870912</size>
       <width units="bits">64</width>
      </node>
    </node>
    <node id="pci:0" claimed="true" class="bridge" handle="PCIBUS:0000:00">
     <description>Host bridge</description>
     <product>nForce3 250Gb Host Bridge</product>
     <vendor>nVidia Corporation</vendor>
     <physid>100</physid>
     <businfo>pci@0000:00:00.0</businfo>
     <version>a1</version>
     <width units="bits">32</width>
     <clock units="Hz">66000000</clock>
      <node id="isa" claimed="true" class="bridge" handle="PCI:0000:00:01.0">
       <description>ISA bridge</description>
       <product>nForce3 250Gb LPC Bridge</product>
       <vendor>nVidia Corporation</vendor>
       <physid>1</physid>
       <businfo>pci@0000:00:01.0</businfo>
       <version>a2</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="latency" value="0" />
       </configuration>
       <capabilities>
        <capability id="isa" />
        <capability id="bus_master" >bus mastering</capability>
       </capabilities>
      </node>
      <node id="serial" class="bus" handle="PCI:0000:00:01.1">
       <description>SMBus</description>
       <product>nForce 250Gb PCI System Management</product>
       <vendor>nVidia Corporation</vendor>
       <physid>1.1</physid>
       <businfo>pci@0000:00:01.1</businfo>
       <version>a1</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="1" />
        <setting id="mingnt" value="3" />
       </configuration>
       <capabilities>
        <capability id="pm" >Power Management</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
      </node>
      <node id="usb:0" class="bus" handle="PCI:0000:00:02.0">
       <description>USB Controller</description>
       <product>CK8S USB Controller</product>
       <vendor>nVidia Corporation</vendor>
       <physid>2</physid>
       <businfo>pci@0000:00:02.0</businfo>
       <version>a1</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="1" />
        <setting id="mingnt" value="3" />
       </configuration>
       <capabilities>
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
      </node>
      <node id="usb:1" class="bus" handle="PCI:0000:00:02.1">
       <description>USB Controller</description>
       <product>CK8S USB Controller</product>
       <vendor>nVidia Corporation</vendor>
       <physid>2.1</physid>
       <businfo>pci@0000:00:02.1</businfo>
       <version>a1</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="1" />
        <setting id="mingnt" value="3" />
       </configuration>
       <capabilities>
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
      </node>
      <node id="usb:2" class="bus" handle="PCI:0000:00:02.2">
       <description>USB Controller</description>
       <product>nForce3 EHCI USB 2.0 Controller</product>
       <vendor>nVidia Corporation</vendor>
       <physid>2.2</physid>
       <businfo>pci@0000:00:02.2</businfo>
       <version>a2</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="1" />
        <setting id="mingnt" value="3" />
       </configuration>
       <capabilities>
        <capability id="debug" >Debug port</capability>
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
      </node>
      <node id="bridge" disabled="true" claimed="true" class="bridge" handle="PCI:0000:00:05.0">
       <description>Ethernet interface</description>
       <product>CK8S Ethernet Controller</product>
       <vendor>nVidia Corporation</vendor>
       <physid>5</physid>
       <businfo>pci@0000:00:05.0</businfo>
       <logicalname>eth0</logicalname>
       <version>a2</version>
       <serial>00:11:09:d4:92:68</serial>
       <capacity>1000000000</capacity>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="autonegotiation" value="on" />
        <setting id="broadcast" value="yes" />
        <setting id="driver" value="forcedeth" />
        <setting id="driverversion" value="0.61" />
        <setting id="latency" value="0" />
        <setting id="link" value="yes" />
        <setting id="maxlatency" value="20" />
        <setting id="mingnt" value="1" />
        <setting id="multicast" value="yes" />
        <setting id="port" value="MII" />
       </configuration>
       <capabilities>
        <capability id="bridge" />
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
        <capability id="ethernet" />
        <capability id="physical" >Physical interface</capability>
        <capability id="mii" >Media Independant Interface</capability>
        <capability id="10bt" >10MB/s</capability>
        <capability id="10bt-fd" >10MB/s (full duplex)</capability>
        <capability id="100bt" >100MB/s</capability>
        <capability id="100bt-fd" >100MB/s (full duplex)</capability>
        <capability id="1000bt-fd" >1GB/s (full duplex)</capability>
        <capability id="autonegotiation" >Auto-negotiation</capability>
       </capabilities>
      </node>
      <node id="multimedia" class="multimedia" handle="PCI:0000:00:06.0">
       <description>Multimedia audio controller</description>
       <product>nForce3 250Gb AC'97 Audio Controller</product>
       <vendor>nVidia Corporation</vendor>
       <physid>6</physid>
       <businfo>pci@0000:00:06.0</businfo>
       <version>a1</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="5" />
        <setting id="mingnt" value="2" />
       </configuration>
       <capabilities>
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
      </node>
      <node id="ide:0" claimed="true" class="storage" handle="PCI:0000:00:08.0">
       <description>IDE interface</description>
       <product>CK8S Parallel ATA Controller (v2.5)</product>
       <vendor>nVidia Corporation</vendor>
       <physid>8</physid>
       <businfo>pci@0000:00:08.0</businfo>
       <version>a2</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="driver" value="AMD_IDE" />
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="1" />
        <setting id="mingnt" value="3" />
       </configuration>
       <capabilities>
        <capability id="ide" />
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
        <node id="ide:0" claimed="true" class="bus" handle="IDE:ide0">
         <description>IDE Channel 0</description>
         <physid>0</physid>
         <businfo>ide@0</businfo>
         <logicalname>ide0</logicalname>
         <clock units="Hz">66000000</clock>
          <node id="disk" claimed="true" class="disk" handle="IDE:ide0:hda">
           <description>ATA Disk</description>
           <product>HDS722516VLAT20</product>
           <physid>0</physid>
           <businfo>ide@0.0</businfo>
           <logicalname>/dev/hda</logicalname>
           <dev>3d:0d</dev>
           <version>V34OA60A</version>
           <serial>VNR4GMC4GBKKZM</serial>
           <size units="bytes">164696555520</size>
           <configuration>
            <setting id="apm" value="off" />
            <setting id="mode" value="udma2" />
            <setting id="signature" value="000d9b70" />
            <setting id="smart" value="on" />
           </configuration>
           <capabilities>
            <capability id="ata" >ATA</capability>
            <capability id="dma" >Direct Memory Access</capability>
            <capability id="lba" >Large Block Addressing</capability>
            <capability id="iordy" >I/O ready reporting</capability>
            <capability id="smart" >S.M.A.R.T. (Self-Monitoring And Reporting Technology)</capability>
            <capability id="security" >ATA security extensions</capability>
            <capability id="pm" >Power Management</capability>
            <capability id="apm" >Advanced Power Management</capability>
            <capability id="partitioned" >Partitioned disk</capability>
            <capability id="partitioned:dos" >MS-DOS partition table</capability>
           </capabilities>
            <node id="volume:0" claimed="true" class="volume" handle="">
             <description>Windows FAT volume</description>
             <vendor>mkdosfs</vendor>
             <physid>1</physid>
             <businfo>ide@0.0,1</businfo>
             <logicalname>/dev/hda1</logicalname>
             <dev>3d:1d</dev>
             <version>FAT16</version>
             <serial>482a-42ca</serial>
             <size>254950912</size>
             <capacity>254951424</capacity>
             <configuration>
              <setting id="FATs" value="2" />
              <setting id="filesystem" value="fat" />
             </configuration>
             <capabilities>
              <capability id="primary" >Primary partition</capability>
              <capability id="fat" >Windows FAT</capability>
              <capability id="initialized" >initialized volume</capability>
             </capabilities>
            </node>
            <node id="volume:1" claimed="true" class="volume" handle="">
             <description>Windows NTFS volume</description>
             <physid>2</physid>
             <businfo>ide@0.0,2</businfo>
             <logicalname>/dev/hda2</logicalname>
             <dev>3d:2d</dev>
             <version>3.1</version>
             <serial>6a2599db-5b72-4149-9d2a-3994cc7da3e3</serial>
             <size>31976236032</size>
             <capacity>31996339200</capacity>
             <configuration>
              <setting id="clustersize" value="4096" />
              <setting id="created" value="2008-05-14 09:33:24" />
              <setting id="filesystem" value="ntfs" />
              <setting id="state" value="clean" />
             </configuration>
             <capabilities>
              <capability id="primary" >Primary partition</capability>
              <capability id="bootable" >Bootable partition (active)</capability>
              <capability id="ntfs" >Windows NTFS</capability>
              <capability id="initialized" >initialized volume</capability>
             </capabilities>
            </node>
            <node id="volume:2" claimed="true" class="volume" handle="">
             <description>EXT3 volume</description>
             <vendor>Linux</vendor>
             <physid>3</physid>
             <businfo>ide@0.0,3</businfo>
             <logicalname>/dev/hda3</logicalname>
             <dev>3d:3d</dev>
             <version>1.0</version>
             <serial>9ebcc955-b2bb-4cce-a2b6-7bca665a9779</serial>
             <size>31996338176</size>
             <capacity>31996339200</capacity>
             <configuration>
              <setting id="created" value="2008-05-14 07:53:24" />
              <setting id="filesystem" value="ext3" />
              <setting id="modified" value="2008-05-14 10:51:41" />
              <setting id="mounted" value="2008-05-14 10:46:10" />
              <setting id="state" value="clean" />
             </configuration>
             <capabilities>
              <capability id="primary" >Primary partition</capability>
              <capability id="journaled" />
              <capability id="extended_attributes" >Extended Attributes</capability>
              <capability id="large_files" >4GB+ files</capability>
              <capability id="huge_files" >16TB+ files</capability>
              <capability id="recover" >needs recovery</capability>
              <capability id="ext3" />
              <capability id="ext2" >EXT2/EXT3</capability>
              <capability id="initialized" >initialized volume</capability>
             </capabilities>
            </node>
            <node id="volume:3" claimed="true" class="volume" handle="">
             <description>Extended partition</description>
             <physid>4</physid>
             <businfo>ide@0.0,4</businfo>
             <logicalname>/dev/hda4</logicalname>
             <dev>3d:4d</dev>
             <size>8011422720</size>
             <capacity>8011422720</capacity>
             <capabilities>
              <capability id="primary" >Primary partition</capability>
              <capability id="extended" >Extended partition</capability>
              <capability id="partitioned" >Partitioned disk</capability>
              <capability id="partitioned:extended" >Extended partition</capability>
             </capabilities>
              <node id="logicalvolume:0" claimed="true" class="volume" handle="">
               <description>Linux swap / Solaris partition</description>
               <physid>5</physid>
               <logicalname>/dev/hda5</logicalname>
               <dev>3d:5d</dev>
               <capacity>3997486080</capacity>
               <capabilities>
                <capability id="nofs" >No filesystem</capability>
               </capabilities>
              </node>
              <node id="logicalvolume:1" claimed="true" class="volume" handle="">
               <description>Linux filesystem partition</description>
               <physid>6</physid>
               <logicalname>/dev/hda6</logicalname>
               <dev>3d:6d</dev>
               <capacity>3997453824</capacity>
              </node>
            </node>
          </node>
        </node>
        <node id="ide:1" claimed="true" class="bus" handle="IDE:ide1">
         <description>IDE Channel 1</description>
         <physid>1</physid>
         <businfo>ide@1</businfo>
         <logicalname>ide1</logicalname>
         <clock units="Hz">66000000</clock>
          <node id="cdrom" claimed="true" class="disk" handle="IDE:ide1:hdc">
           <description>CD-R/CD-RW writer</description>
           <product>SONY CD-RW CRX175E</product>
           <physid>0</physid>
           <businfo>ide@1.0</businfo>
           <logicalname>/dev/hdc</logicalname>
           <dev>22d:0d</dev>
           <version>1.0g</version>
           <configuration>
            <setting id="status" value="nodisc" />
           </configuration>
           <capabilities>
            <capability id="packet" >ATAPI packet device</capability>
            <capability id="atapi" >ATAPI</capability>
            <capability id="cdrom" >can read CD-ROMs</capability>
            <capability id="removable" >support is removable</capability>
            <capability id="nonmagnetic" >support is non-magnetic (optical)</capability>
            <capability id="dma" >Direct Memory Access</capability>
            <capability id="lba" >Large Block Addressing</capability>
            <capability id="iordy" >I/O ready reporting</capability>
            <capability id="audio" >Audio CD playback</capability>
            <capability id="cd-r" >CD-R burning</capability>
            <capability id="cd-rw" >CD-RW burning</capability>
           </capabilities>
          </node>
        </node>
      </node>
      <node id="ide:1" claimed="true" class="storage" handle="PCI:0000:00:09.0">
       <description>IDE interface</description>
       <product>CK8S Serial ATA Controller (v2.5)</product>
       <vendor>nVidia Corporation</vendor>
       <physid>9</physid>
       <businfo>pci@0000:00:09.0</businfo>
       <version>a2</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="driver" value="sata_nv" />
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="1" />
        <setting id="mingnt" value="3" />
       </configuration>
       <capabilities>
        <capability id="ide" />
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
      </node>
      <node id="ide:2" claimed="true" class="storage" handle="PCI:0000:00:0a.0">
       <description>IDE interface</description>
       <product>CK8S Serial ATA Controller (v2.5)</product>
       <vendor>nVidia Corporation</vendor>
       <physid>a</physid>
       <businfo>pci@0000:00:0a.0</businfo>
       <version>a2</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <configuration>
        <setting id="driver" value="sata_nv" />
        <setting id="latency" value="0" />
        <setting id="maxlatency" value="1" />
        <setting id="mingnt" value="3" />
       </configuration>
       <capabilities>
        <capability id="ide" />
        <capability id="pm" >Power Management</capability>
        <capability id="bus_master" >bus mastering</capability>
        <capability id="cap_list" >PCI capabilities listing</capability>
       </capabilities>
      </node>
      <node id="pci:0" claimed="true" class="bridge" handle="PCIBUS:0000:01">
       <description>PCI bridge</description>
       <product>nForce3 250Gb AGP Host to PCI Bridge</product>
       <vendor>nVidia Corporation</vendor>
       <physid>b</physid>
       <businfo>pci@0000:00:0b.0</businfo>
       <version>a2</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <capabilities>
        <capability id="pci" />
        <capability id="bus_master" >bus mastering</capability>
       </capabilities>
        <node id="display:0" class="display" handle="PCI:0000:01:00.0">
         <description>VGA compatible controller</description>
         <product>Radeon RV250 If [Radeon 9000]</product>
         <vendor>ATI Technologies Inc</vendor>
         <physid>0</physid>
         <businfo>pci@0000:01:00.0</businfo>
         <version>01</version>
         <width units="bits">32</width>
         <clock units="Hz">66000000</clock>
         <configuration>
          <setting id="latency" value="32" />
          <setting id="mingnt" value="8" />
         </configuration>
         <capabilities>
          <capability id="agp" >AGP</capability>
          <capability id="agp-2.0" >AGP 2.0</capability>
          <capability id="pm" >Power Management</capability>
          <capability id="bus_master" >bus mastering</capability>
          <capability id="cap_list" >PCI capabilities listing</capability>
         </capabilities>
        </node>
        <node id="display:1" class="display" handle="PCI:0000:01:00.1">
         <description>Display controller</description>
         <product>Radeon RV250 [Radeon 9000] (Secondary)</product>
         <vendor>ATI Technologies Inc</vendor>
         <physid>0.1</physid>
         <businfo>pci@0000:01:00.1</businfo>
         <version>01</version>
         <width units="bits">32</width>
         <clock units="Hz">66000000</clock>
         <configuration>
          <setting id="latency" value="32" />
          <setting id="mingnt" value="8" />
         </configuration>
         <capabilities>
          <capability id="agp" >AGP</capability>
          <capability id="agp-2.0" >AGP 2.0</capability>
          <capability id="pm" >Power Management</capability>
          <capability id="cap_list" >PCI capabilities listing</capability>
         </capabilities>
        </node>
      </node>
      <node id="pci:1" claimed="true" class="bridge" handle="PCIBUS:0000:02">
       <description>PCI bridge</description>
       <product>nForce3 250Gb PCI-to-PCI Bridge</product>
       <vendor>nVidia Corporation</vendor>
       <physid>e</physid>
       <businfo>pci@0000:00:0e.0</businfo>
       <version>a2</version>
       <width units="bits">32</width>
       <clock units="Hz">66000000</clock>
       <capabilities>
        <capability id="pci" />
        <capability id="bus_master" >bus mastering</capability>
       </capabilities>
        <node id="display" class="display" handle="PCI:0000:02:08.0">
         <description>VGA compatible controller</description>
         <product>86c325 [ViRGE]</product>
         <vendor>S3 Inc.</vendor>
         <physid>8</physid>
         <businfo>pci@0000:02:08.0</businfo>
         <version>06</version>
         <width units="bits">32</width>
         <clock units="Hz">33000000</clock>
         <configuration>
          <setting id="latency" value="32" />
          <setting id="maxlatency" value="255" />
          <setting id="mingnt" value="4" />
         </configuration>
        </node>
        <node id="generic" class="generic" handle="PCI:0000:02:09.0">
         <product>Omron Corporation</product>
         <vendor>Omron Corporation</vendor>
         <physid>9</physid>
         <businfo>pci@0000:02:09.0</businfo>
         <version>00</version>
         <width units="bits">32</width>
         <clock units="Hz">33000000</clock>
         <configuration>
          <setting id="latency" value="0" />
         </configuration>
        </node>
        <node id="usb:0" class="bus" handle="PCI:0000:02:0a.0">
         <description>USB Controller</description>
         <product>USB</product>
         <vendor>NEC Corporation</vendor>
         <physid>a</physid>
         <businfo>pci@0000:02:0a.0</businfo>
         <version>43</version>
         <width units="bits">32</width>
         <clock units="Hz">33000000</clock>
         <configuration>
          <setting id="latency" value="32" />
          <setting id="maxlatency" value="42" />
          <setting id="mingnt" value="1" />
         </configuration>
         <capabilities>
          <capability id="pm" >Power Management</capability>
          <capability id="bus_master" >bus mastering</capability>
          <capability id="cap_list" >PCI capabilities listing</capability>
         </capabilities>
        </node>
        <node id="usb:1" class="bus" handle="PCI:0000:02:0a.1">
         <description>USB Controller</description>
         <product>USB</product>
         <vendor>NEC Corporation</vendor>
         <physid>a.1</physid>
         <businfo>pci@0000:02:0a.1</businfo>
         <version>43</version>
         <width units="bits">32</width>
         <clock units="Hz">33000000</clock>
         <configuration>
          <setting id="latency" value="32" />
          <setting id="maxlatency" value="42" />
          <setting id="mingnt" value="1" />
         </configuration>
         <capabilities>
          <capability id="pm" >Power Management</capability>
          <capability id="bus_master" >bus mastering</capability>
          <capability id="cap_list" >PCI capabilities listing</capability>
         </capabilities>
        </node>
        <node id="usb:2" class="bus" handle="PCI:0000:02:0a.2">
         <description>USB Controller</description>
         <product>USB 2.0</product>
         <vendor>NEC Corporation</vendor>
         <physid>a.2</physid>
         <businfo>pci@0000:02:0a.2</businfo>
         <version>04</version>
         <width units="bits">32</width>
         <clock units="Hz">33000000</clock>
         <configuration>
          <setting id="latency" value="32" />
          <setting id="maxlatency" value="34" />
          <setting id="mingnt" value="16" />
         </configuration>
         <capabilities>
          <capability id="pm" >Power Management</capability>
          <capability id="bus_master" >bus mastering</capability>
          <capability id="cap_list" >PCI capabilities listing</capability>
         </capabilities>
        </node>
        <node id="firewire" class="bus" handle="PCI:0000:02:0c.0">
         <description>FireWire (IEEE 1394)</description>
         <product>IEEE 1394 Host Controller</product>
         <vendor>VIA Technologies, Inc.</vendor>
         <physid>c</physid>
         <businfo>pci@0000:02:0c.0</businfo>
         <version>46</version>
         <width units="bits">32</width>
         <clock units="Hz">33000000</clock>
         <configuration>
          <setting id="latency" value="32" />
         </configuration>
         <capabilities>
          <capability id="pm" >Power Management</capability>
          <capability id="bus_master" >bus mastering</capability>
          <capability id="cap_list" >PCI capabilities listing</capability>
         </capabilities>
        </node>
        <node id="network" claimed="true" class="network" handle="PCI:0000:02:0d.0">
         <description>Ethernet interface</description>
         <product>RTL-8169 Gigabit Ethernet</product>
         <vendor>Realtek Semiconductor Co., Ltd.</vendor>
         <physid>d</physid>
         <businfo>pci@0000:02:0d.0</businfo>
         <logicalname>eth1</logicalname>
         <version>10</version>
         <serial>00:11:09:d4:92:67</serial>
         <size>1000000000</size>
         <capacity>1000000000</capacity>
         <width units="bits">32</width>
         <clock units="Hz">66000000</clock>
         <configuration>
          <setting id="autonegotiation" value="on" />
          <setting id="broadcast" value="yes" />
          <setting id="driver" value="r8169" />
          <setting id="driverversion" value="2.2LK" />
          <setting id="duplex" value="full" />
          <setting id="ip" value="192.168.1.21" />
          <setting id="latency" value="64" />
          <setting id="link" value="yes" />
          <setting id="maxlatency" value="64" />
          <setting id="mingnt" value="32" />
          <setting id="multicast" value="yes" />
          <setting id="port" value="twisted pair" />
          <setting id="speed" value="1GB/s" />
         </configuration>
         <capabilities>
          <capability id="pm" >Power Management</capability>
          <capability id="bus_master" >bus mastering</capability>
          <capability id="cap_list" >PCI capabilities listing</capability>
          <capability id="ethernet" />
          <capability id="physical" >Physical interface</capability>
          <capability id="tp" >twisted pair</capability>
          <capability id="10bt" >10MB/s</capability>
          <capability id="10bt-fd" >10MB/s (full duplex)</capability>
          <capability id="100bt" >100MB/s</capability>
          <capability id="100bt-fd" >100MB/s (full duplex)</capability>
          <capability id="1000bt-fd" >1GB/s (full duplex)</capability>
          <capability id="autonegotiation" >Auto-negotiation</capability>
         </capabilities>
        </node>
      </node>
    </node>
    <node id="pci:1" claimed="true" class="bridge" handle="PCIBUS:0000:00">
     <description>Host bridge</description>
     <product>K8 [Athlon64/Opteron] HyperTransport Technology Configuration</product>
     <vendor>Advanced Micro Devices [AMD]</vendor>
     <physid>101</physid>
     <businfo>pci@0000:00:18.0</businfo>
     <version>00</version>
     <width units="bits">32</width>
     <clock units="Hz">33000000</clock>
    </node>
    <node id="pci:2" claimed="true" class="bridge" handle="PCIBUS:0000:00">
     <description>Host bridge</description>
     <product>K8 [Athlon64/Opteron] Address Map</product>
     <vendor>Advanced Micro Devices [AMD]</vendor>
     <physid>102</physid>
     <businfo>pci@0000:00:18.1</businfo>
     <version>00</version>
     <width units="bits">32</width>
     <clock units="Hz">33000000</clock>
    </node>
    <node id="pci:3" claimed="true" class="bridge" handle="PCIBUS:0000:00">
     <description>Host bridge</description>
     <product>K8 [Athlon64/Opteron] DRAM Controller</product>
     <vendor>Advanced Micro Devices [AMD]</vendor>
     <physid>103</physid>
     <businfo>pci@0000:00:18.2</businfo>
     <version>00</version>
     <width units="bits">32</width>
     <clock units="Hz">33000000</clock>
    </node>
    <node id="pci:4" claimed="true" class="bridge" handle="PCIBUS:0000:00">
     <description>Host bridge</description>
     <product>K8 [Athlon64/Opteron] Miscellaneous Control</product>
     <vendor>Advanced Micro Devices [AMD]</vendor>
     <physid>104</physid>
     <businfo>pci@0000:00:18.3</businfo>
     <version>00</version>
     <width units="bits">32</width>
     <clock units="Hz">33000000</clock>
    </node>
  </node>
</node>



--------------020805000607020302000709
Content-Type: text/plain;
 name="scsiinfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsiinfo.txt"


Inquiry command
---------------
Relative Address                   0
Wide bus 32                        0
Wide bus 16                        0
Synchronous neg.                   0
Linked Commands                    0
Command Queueing                   0
SftRe                              0
Device Type                        0
Peripheral Qualifier               0
Removable?                         0
Device Type Modifier               0
ISO Version                        0
ECMA Version                       0
ANSI Version                       5
AENC                               0
TrmIOP                             0
Response Data Format               2
Vendor:                    ATA     
Product:                   Hitachi HDP72505
Revision level:            GM4O

Serial Number '      GEB531RE0GEPGB'
Data from Caching Page
----------------------
Write Cache                        1
Read Cache                         1
Prefetch units                     0
Demand Read Retention Priority     0
Demand Write Retention Priority    0
Disable Pre-fetch Transfer Length  0
Minimum Pre-fetch                  0
Maximum Pre-fetch                  0
Maximum Pre-fetch Ceiling          0

Data from Error Recovery Page
-----------------------------
AWRE                               1
ARRE                               0
TB                                 0
RC                                 0
EER                                0
PER                                0
DTE                                0
DCR                                0
Read Retry Count                   0
Correction Span                    0
Head Offset Count                  0
Data Strobe Offset Count           0
Write Retry Count                  0
Recovery Time Limit                0

Data from Control Page
----------------------
RLEC                               0
QErr                               0
DQue                               0
EECA                               0
RAENP                              0
UUAENP                             0
EAENP                              0
Queue Algorithm Modifier           0
Ready AEN Holdoff Period           0

Data from Defect Lists
----------------------


--------------020805000607020302000709
Content-Type: text/plain;
 name="pctest.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pctest.sh"

#!/bin/sh -x

dmesg -c
uname -a

dd if=/dev/sda bs=512   count=1 skip=268435455 > /dev/null
dmesg -c
dd if=/dev/sda bs=1024  count=1 skip=134217727 > /dev/null
dmesg -c
dd if=/dev/sda bs=2048  count=1 skip=67108863  > /dev/null
dmesg -c
dd if=/dev/sda bs=4096  count=1 skip=33554431  > /dev/null
dmesg -c
dd if=/dev/sda bs=8192  count=1 skip=16777215  > /dev/null
dmesg -c
dd if=/dev/sda bs=16384 count=1 skip=8388607   > /dev/null
dmesg -c

seq 1 1 3 | while read i
do
  dd if=/dev/sda bs=4096 count=$i skip=`expr 33554432  - $i` > /dev/null
done
dd if=/dev/sda bs=4096 count=100 skip=`expr 33554432 - 3` > /dev/null

seq 1 1 17 | while read i
do
  dd if=/dev/sda bs=512  count=$i skip=`expr 268435456 - $i` > /dev/null
done
dd if=/dev/sda bs=512  count=100 skip=`expr 268435456 - 17` > /dev/null


--------------020805000607020302000709
Content-Type: text/plain;
 name="pctest.log"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pctest.log"

U2NyaXB0IHN0YXJ0ZWQgb24gVGh1IDE1IE1heSAyMDA4IDAzOjQ4OjI0IEFNIEpTVApwYzp+
IyBkbWVzZyAtYw0KcGM6fiMgY2F0IHBjdGVzdC5zaA0KIyEvYmluL3NoIC14DQoNCmRtZXNn
IC1jDQp1bmFtZSAtYQ0KDQpkZCBpZj0vZGV2L3NkYSBicz01MTIgICBjb3VudD0xIHNraXA9
MjY4NDM1NDU1ID4gL2Rldi9udWxsDQpkbWVzZyAtYw0KZGQgaWY9L2Rldi9zZGEgYnM9MTAy
NCAgY291bnQ9MSBza2lwPTEzNDIxNzcyNyA+IC9kZXYvbnVsbA0KZG1lc2cgLWMNCmRkIGlm
PS9kZXYvc2RhIGJzPTIwNDggIGNvdW50PTEgc2tpcD02NzEwODg2MyAgPiAvZGV2L251bGwN
CmRtZXNnIC1jDQpkZCBpZj0vZGV2L3NkYSBicz00MDk2ICBjb3VudD0xIHNraXA9MzM1NTQ0
MzEgID4gL2Rldi9udWxsDQpkbWVzZyAtYw0KZGQgaWY9L2Rldi9zZGEgYnM9ODE5MiAgY291
bnQ9MSBza2lwPTE2Nzc3MjE1ICA+IC9kZXYvbnVsbA0KZG1lc2cgLWMNCmRkIGlmPS9kZXYv
c2RhIGJzPTE2Mzg0IGNvdW50PTEgc2tpcD04Mzg4NjA3ICAgPiAvZGV2L251bGwNCmRtZXNn
IC1jDQoNCnNlcSAxIDEgMyB8IHdoaWxlIHJlYWQgaQ0KZG8NCiAgZGQgaWY9L2Rldi9zZGEg
YnM9NDA5NiBjb3VudD0kaSBza2lwPWBleHByIDMzNTU0NDMyICAtICRpYCA+IC9kZXYvbnVs
bA0KZG9uZQ0KZGQgaWY9L2Rldi9zZGEgYnM9NDA5NiBjb3VudD0xMDAgc2tpcD1gZXhwciAz
MzU1NDQzMiAtIDNgID4gL2Rldi9udWxsDQoNCnNlcSAxIDEgMTcgfCB3aGlsZSByZWFkIGkN
CmRvDQogIGRkIGlmPS9kZXYvc2RhIGJzPTUxMiAgY291bnQ9JGkgc2tpcD1gZXhwciAyNjg0
MzU0NTYgLSAkaWAgPiAvZGV2L251bGwNCmRvbmUNCmRkIGlmPS9kZXYvc2RhIGJzPTUxMiAg
Y291bnQ9MTAwIHNraXA9YGV4cHIgMjY4NDM1NDU2IC0gMTdgID4gL2Rldi9udWxsDQpwYzp+
IyAuL3BjdGVzdC5zaA0KKyBkbWVzZyAtYw0KKyB1bmFtZSAtYQ0KTGludXggcGMgMi42LjI1
LjMgIzIgVGh1IE1heSAxNSAwMTowNToxNCBKU1QgMjAwOCBpNjg2IEdOVS9MaW51eA0KKyBk
ZCBpZj0vZGV2L3NkYSBicz01MTIgY291bnQ9MSBza2lwPTI2ODQzNTQ1NQ0KZGQ6IHJlYWRp
bmcgYC9kZXYvc2RhJzogSW5wdXQvb3V0cHV0IGVycm9yDQowKzAgcmVjb3JkcyBpbg0KMCsw
IHJlY29yZHMgb3V0DQowIGJ5dGVzICgwIEIpIGNvcGllZCwgMC4yODgzNTIgcywgMC4wIGtC
L3MNCisgZG1lc2cgLWMNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAg
U0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAw
OiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQw
OTYgaW4NCiAgICAgICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9l
ZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVS
UiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9y
IFVETUEvMzMNCmF0YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sg
MHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQg
MHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2Vm
IHRhZyAwIGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6
MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0
dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBj
b25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhj
ZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAw
OiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDow
MDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4
OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0K
YXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQg
fQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUN
CmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9u
IDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6
Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAg
IHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRl
dmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBl
cnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6
IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNF
cnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDog
Y21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2
IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYg
RW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIg
fQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZvciBV
RE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4
MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4
MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0
YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAw
OjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVz
OiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29u
ZmlndXJlZCBmb3IgVURNQS8zMw0Kc2QgMjowOjA6MDogW3NkYV0gUmVzdWx0OiBob3N0Ynl0
ZT0weDAwIGRyaXZlcmJ5dGU9MHgwOA0Kc2QgMjowOjA6MDogW3NkYV0gU2Vuc2UgS2V5IDog
MHhiIFtjdXJyZW50XSBbZGVzY3JpcHRvcl0NCkRlc2NyaXB0b3Igc2Vuc2UgZGF0YSB3aXRo
IHNlbnNlIGRlc2NyaXB0b3JzIChpbiBoZXgpOg0KICAgICAgICA3MiAwYiAwMCAwMCAwMCAw
MCAwMCAwYyAwMCAwYSA4MCAwMCAwMCAwMCAwMCAwMCANCiAgICAgICAgMGYgZmYgZmYgZjgg
DQpzZCAyOjA6MDowOiBbc2RhXSBBU0M9MHgwIEFTQ1E9MHgwDQplbmRfcmVxdWVzdDogSS9P
IGVycm9yLCBkZXYgc2RhLCBzZWN0b3IgMjY4NDM1NDQ4DQpwcmludGs6IDExIG1lc3NhZ2Vz
IHN1cHByZXNzZWQuDQpCdWZmZXIgSS9PIGVycm9yIG9uIGRldmljZSBzZGEsIGxvZ2ljYWwg
YmxvY2sgMzM1NTQ0MzENCmF0YTM6IEVIIGNvbXBsZXRlDQpzZCAyOjA6MDowOiBbc2RhXSA5
NzY3NzMxNjggNTEyLWJ5dGUgaGFyZHdhcmUgc2VjdG9ycyAoNTAwMTA4IE1CKQ0Kc2QgMjow
OjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYNCnNkIDI6MDowOjA6IFtzZGFdIE1v
ZGUgU2Vuc2U6IDAwIDNhIDAwIDAwDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBjYWNoZTog
ZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBwb3J0IERQTyBvciBG
VUENCnNkIDI6MDowOjA6IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBoYXJkd2FyZSBzZWN0
b3JzICg1MDAxMDggTUIpDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBQcm90ZWN0IGlzIG9m
Zg0Kc2QgMjowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDANCnNkIDI6MDow
OjA6IFtzZGFdIFdyaXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBk
b2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZVQQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4
MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4
MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0
YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAw
OjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVz
OiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29u
ZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4Y2Vw
dGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDog
Qk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6
MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAgIHJlcyA1MS8wNDowODpm
ODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikNCmF0
YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJUIH0N
CmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6IEVIIGNvbXBsZXRlDQph
dGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAw
eDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4
OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2IGluDQogICAgICAgICBy
ZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZp
Y2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJy
b3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBF
SCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJy
IDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNt
ZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBp
bg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVt
YXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0N
CmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURN
QS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAg
U0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1
DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFn
IDAgZG1hIDQwOTYgaW4NCiAgICAgICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDow
MDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czog
eyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZp
Z3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRp
b24gRW1hc2sgMHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJN
RE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAw
OjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6
ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEz
LjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQph
dGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzMzDQpzZCAyOjA6MDowOiBbc2RhXSBSZXN1
bHQ6IGhvc3RieXRlPTB4MDAgZHJpdmVyYnl0ZT0weDA4DQpzZCAyOjA6MDowOiBbc2RhXSBT
ZW5zZSBLZXkgOiAweGIgW2N1cnJlbnRdIFtkZXNjcmlwdG9yXQ0KRGVzY3JpcHRvciBzZW5z
ZSBkYXRhIHdpdGggc2Vuc2UgZGVzY3JpcHRvcnMgKGluIGhleCk6DQogICAgICAgIDcyIDBi
IDAwIDAwIDAwIDAwIDAwIDBjIDAwIDBhIDgwIDAwIDAwIDAwIDAwIDAwIA0KICAgICAgICAw
ZiBmZiBmZiBmOCANCnNkIDI6MDowOjA6IFtzZGFdIEFTQz0weDAgQVNDUT0weDANCmVuZF9y
ZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBzZGEsIHNlY3RvciAyNjg0MzU0NDgNCkJ1ZmZlciBJ
L08gZXJyb3Igb24gZGV2aWNlIHNkYSwgbG9naWNhbCBibG9jayAzMzU1NDQzMQ0KYXRhMzog
RUggY29tcGxldGUNCnNkIDI6MDowOjA6IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBoYXJk
d2FyZSBzZWN0b3JzICg1MDAxMDggTUIpDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBQcm90
ZWN0IGlzIG9mZg0Kc2QgMjowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDAN
CnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBl
bmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZVQQ0Kc2QgMjowOjA6MDogW3NkYV0g
OTc2NzczMTY4IDUxMi1ieXRlIGhhcmR3YXJlIHNlY3RvcnMgKDUwMDEwOCBNQikNCnNkIDI6
MDowOjA6IFtzZGFdIFdyaXRlIFByb3RlY3QgaXMgb2ZmDQpzZCAyOjA6MDowOiBbc2RhXSBN
b2RlIFNlbnNlOiAwMCAzYSAwMCAwMA0Kc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6
IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3Ig
RlVBDQorIGRkIGlmPS9kZXYvc2RhIGJzPTEwMjQgY291bnQ9MSBza2lwPTEzNDIxNzcyNw0K
ZGQ6IHJlYWRpbmcgYC9kZXYvc2RhJzogSW5wdXQvb3V0cHV0IGVycm9yDQowKzAgcmVjb3Jk
cyBpbg0KMCswIHJlY29yZHMgb3V0DQowIGJ5dGVzICgwIEIpIGNvcGllZCwgMC4yODk2MTEg
cywgMC4wIGtCL3MNCisgZG1lc2cgLWMNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAg
U0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1
DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFn
IDAgZG1hIDQwOTYgaW4NCiAgICAgICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDow
MDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czog
eyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZp
Z3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRp
b24gRW1hc2sgMHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJN
RE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAw
OjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6
ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEz
LjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQph
dGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRh
My4wMDogZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgw
DQphdGEzLjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpm
ZjpmZi8wMDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVz
IDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNl
IGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9y
OiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUgg
Y29tcGxldGUNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAw
eDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQg
YzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4N
CiAgICAgICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFz
ayAweDEgKGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQph
dGEzLjAwOiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEv
MzMNCmF0YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNB
Y3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0K
YXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAw
IGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6
MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsg
RFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1
cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9u
IEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURN
QSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDow
MDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZm
OmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4w
MDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRh
My4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0Kc2QgMjowOjA6MDogW3NkYV0gUmVzdWx0
OiBob3N0Ynl0ZT0weDAwIGRyaXZlcmJ5dGU9MHgwOA0Kc2QgMjowOjA6MDogW3NkYV0gU2Vu
c2UgS2V5IDogMHhiIFtjdXJyZW50XSBbZGVzY3JpcHRvcl0NCkRlc2NyaXB0b3Igc2Vuc2Ug
ZGF0YSB3aXRoIHNlbnNlIGRlc2NyaXB0b3JzIChpbiBoZXgpOg0KICAgICAgICA3MiAwYiAw
MCAwMCAwMCAwMCAwMCAwYyAwMCAwYSA4MCAwMCAwMCAwMCAwMCAwMCANCiAgICAgICAgMGYg
ZmYgZmYgZjggDQpzZCAyOjA6MDowOiBbc2RhXSBBU0M9MHgwIEFTQ1E9MHgwDQplbmRfcmVx
dWVzdDogSS9PIGVycm9yLCBkZXYgc2RhLCBzZWN0b3IgMjY4NDM1NDQ4DQpCdWZmZXIgSS9P
IGVycm9yIG9uIGRldmljZSBzZGEsIGxvZ2ljYWwgYmxvY2sgMzM1NTQ0MzENCmF0YTM6IEVI
IGNvbXBsZXRlDQpzZCAyOjA6MDowOiBbc2RhXSA5NzY3NzMxNjggNTEyLWJ5dGUgaGFyZHdh
cmUgc2VjdG9ycyAoNTAwMTA4IE1CKQ0Kc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVj
dCBpcyBvZmYNCnNkIDI6MDowOjA6IFtzZGFdIE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwDQpz
ZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBjYWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5h
YmxlZCwgZG9lc24ndCBzdXBwb3J0IERQTyBvciBGVUENCnNkIDI6MDowOjA6IFtzZGFdIDk3
Njc3MzE2OCA1MTItYnl0ZSBoYXJkd2FyZSBzZWN0b3JzICg1MDAxMDggTUIpDQpzZCAyOjA6
MDowOiBbc2RhXSBXcml0ZSBQcm90ZWN0IGlzIG9mZg0Kc2QgMjowOjA6MDogW3NkYV0gTW9k
ZSBTZW5zZTogMDAgM2EgMDAgMDANCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIGNhY2hlOiBl
bmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZV
QQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rp
b24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDow
ODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAg
ICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAo
ZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6
IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRh
MzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAg
U0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAw
OiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQw
OTYgaW4NCiAgICAgICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9l
ZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVS
UiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9y
IFVETUEvMzMNCmF0YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sg
MHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQg
MHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2Vm
IHRhZyAwIGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6
MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0
dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBj
b25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhj
ZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAw
OiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDow
MDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4
OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0K
YXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQg
fQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUN
CmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9u
IDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6
Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAg
IHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRl
dmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBl
cnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6
IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNF
cnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDog
Y21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2
IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYg
RW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIg
fQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZvciBV
RE1BLzMzDQpzZCAyOjA6MDowOiBbc2RhXSBSZXN1bHQ6IGhvc3RieXRlPTB4MDAgZHJpdmVy
Ynl0ZT0weDA4DQpzZCAyOjA6MDowOiBbc2RhXSBTZW5zZSBLZXkgOiAweGIgW2N1cnJlbnRd
IFtkZXNjcmlwdG9yXQ0KRGVzY3JpcHRvciBzZW5zZSBkYXRhIHdpdGggc2Vuc2UgZGVzY3Jp
cHRvcnMgKGluIGhleCk6DQogICAgICAgIDcyIDBiIDAwIDAwIDAwIDAwIDAwIDBjIDAwIDBh
IDgwIDAwIDAwIDAwIDAwIDAwIA0KICAgICAgICAwZiBmZiBmZiBmOCANCnNkIDI6MDowOjA6
IFtzZGFdIEFTQz0weDAgQVNDUT0weDANCmVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBz
ZGEsIHNlY3RvciAyNjg0MzU0NDgNCkJ1ZmZlciBJL08gZXJyb3Igb24gZGV2aWNlIHNkYSwg
bG9naWNhbCBibG9jayAzMzU1NDQzMQ0KYXRhMzogRUggY29tcGxldGUNCnNkIDI6MDowOjA6
IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBoYXJkd2FyZSBzZWN0b3JzICg1MDAxMDggTUIp
DQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBQcm90ZWN0IGlzIG9mZg0Kc2QgMjowOjA6MDog
W3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDANCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRl
IGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQg
RFBPIG9yIEZVQQ0Kc2QgMjowOjA6MDogW3NkYV0gOTc2NzczMTY4IDUxMi1ieXRlIGhhcmR3
YXJlIHNlY3RvcnMgKDUwMDEwOCBNQikNCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIFByb3Rl
Y3QgaXMgb2ZmDQpzZCAyOjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAwMA0K
c2QgMjowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVu
YWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBDQorIGRkIGlmPS9kZXYvc2RhIGJz
PTIwNDggY291bnQ9MSBza2lwPTY3MTA4ODYzDQpkZDogcmVhZGluZyBgL2Rldi9zZGEnOiBJ
bnB1dC9vdXRwdXQgZXJyb3INCjArMCByZWNvcmRzIGluDQowKzAgcmVjb3JkcyBvdXQNCjAg
Ynl0ZXMgKDAgQikgY29waWVkLCAwLjI4OTcwNyBzLCAwLjAga0Ivcw0KKyBkbWVzZyAtYw0K
YXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24g
MHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpm
ODpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAg
cmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2
aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVy
cm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzog
RUggY29tcGxldGUNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0Vy
ciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBj
bWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYg
aW4NCiAgICAgICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBF
bWFzayAweDEgKGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9
DQphdGEzLjAwOiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVE
TUEvMzMNCmF0YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgw
IFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgy
NQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRh
ZyAwIGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6
MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6
IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25m
aWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0
aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBC
TURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDow
MDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4
OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRh
My4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0K
YXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0
YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4
MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6Zjg6
ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAgIHJl
cyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRldmlj
ZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJv
cjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6IEVI
IGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNFcnIg
MHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDogY21k
IGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2IGlu
DQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgRW1h
c2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIgfQ0K
YXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1B
LzMzDQpzZCAyOjA6MDowOiBbc2RhXSBSZXN1bHQ6IGhvc3RieXRlPTB4MDAgZHJpdmVyYnl0
ZT0weDA4DQpzZCAyOjA6MDowOiBbc2RhXSBTZW5zZSBLZXkgOiAweGIgW2N1cnJlbnRdIFtk
ZXNjcmlwdG9yXQ0KRGVzY3JpcHRvciBzZW5zZSBkYXRhIHdpdGggc2Vuc2UgZGVzY3JpcHRv
cnMgKGluIGhleCk6DQogICAgICAgIDcyIDBiIDAwIDAwIDAwIDAwIDAwIDBjIDAwIDBhIDgw
IDAwIDAwIDAwIDAwIDAwIA0KICAgICAgICAwZiBmZiBmZiBmOCANCnNkIDI6MDowOjA6IFtz
ZGFdIEFTQz0weDAgQVNDUT0weDANCmVuZF9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBzZGEs
IHNlY3RvciAyNjg0MzU0NDgNCkJ1ZmZlciBJL08gZXJyb3Igb24gZGV2aWNlIHNkYSwgbG9n
aWNhbCBibG9jayAzMzU1NDQzMQ0KYXRhMzogRUggY29tcGxldGUNCnNkIDI6MDowOjA6IFtz
ZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBoYXJkd2FyZSBzZWN0b3JzICg1MDAxMDggTUIpDQpz
ZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBQcm90ZWN0IGlzIG9mZg0Kc2QgMjowOjA6MDogW3Nk
YV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDANCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIGNh
Y2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBP
IG9yIEZVQQ0Kc2QgMjowOjA6MDogW3NkYV0gOTc2NzczMTY4IDUxMi1ieXRlIGhhcmR3YXJl
IHNlY3RvcnMgKDUwMDEwOCBNQikNCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIFByb3RlY3Qg
aXMgb2ZmDQpzZCAyOjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAwMA0Kc2Qg
MjowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJs
ZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBDQphdGEzLjAwOiBleGNlcHRpb24gRW1h
c2sgMHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0
YXQgMHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAw
L2VmIHRhZyAwIGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYv
MDA6MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBz
dGF0dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAw
OiBjb25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDog
ZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEz
LjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8w
MDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0
OjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9y
KQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFC
UlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxl
dGUNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0
aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6
MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAg
ICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEg
KGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAw
OiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0
YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgw
IFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4w
MDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA0
MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAv
ZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBF
UlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZv
ciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNr
IDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0
IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9l
ZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAw
OjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3Rh
dHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDog
Y29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4
Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4w
MDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6
MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAgIHJlcyA1MS8wNDow
ODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikN
CmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJU
IH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCnNkIDI6MDowOjA6IFtzZGFd
IFJlc3VsdDogaG9zdGJ5dGU9MHgwMCBkcml2ZXJieXRlPTB4MDgNCnNkIDI6MDowOjA6IFtz
ZGFdIFNlbnNlIEtleSA6IDB4YiBbY3VycmVudF0gW2Rlc2NyaXB0b3JdDQpEZXNjcmlwdG9y
IHNlbnNlIGRhdGEgd2l0aCBzZW5zZSBkZXNjcmlwdG9ycyAoaW4gaGV4KToNCiAgICAgICAg
NzIgMGIgMDAgMDAgMDAgMDAgMDAgMGMgMDAgMGEgODAgMDAgMDAgMDAgMDAgMDAgDQogICAg
ICAgIDBmIGZmIGZmIGY4IA0Kc2QgMjowOjA6MDogW3NkYV0gQVNDPTB4MCBBU0NRPTB4MA0K
ZW5kX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IHNkYSwgc2VjdG9yIDI2ODQzNTQ0OA0KQnVm
ZmVyIEkvTyBlcnJvciBvbiBkZXZpY2Ugc2RhLCBsb2dpY2FsIGJsb2NrIDMzNTU0NDMxDQph
dGEzOiBFSCBjb21wbGV0ZQ0Kc2QgMjowOjA6MDogW3NkYV0gOTc2NzczMTY4IDUxMi1ieXRl
IGhhcmR3YXJlIHNlY3RvcnMgKDUwMDEwOCBNQikNCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRl
IFByb3RlY3QgaXMgb2ZmDQpzZCAyOjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAwMCAzYSAw
MCAwMA0Kc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2Fj
aGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBDQpzZCAyOjA6MDowOiBb
c2RhXSA5NzY3NzMxNjggNTEyLWJ5dGUgaGFyZHdhcmUgc2VjdG9ycyAoNTAwMTA4IE1CKQ0K
c2QgMjowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYNCnNkIDI6MDowOjA6IFtz
ZGFdIE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBj
YWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBwb3J0IERQ
TyBvciBGVUENCisgZGQgaWY9L2Rldi9zZGEgYnM9NDA5NiBjb3VudD0xIHNraXA9MzM1NTQ0
MzENCmRkOiByZWFkaW5nIGAvZGV2L3NkYSc6IElucHV0L291dHB1dCBlcnJvcg0KMCswIHJl
Y29yZHMgaW4NCjArMCByZWNvcmRzIG91dA0KMCBieXRlcyAoMCBCKSBjb3BpZWQsIDAuMjg5
Njc1IHMsIDAuMCBrQi9zDQorIGRtZXNnIC1jDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sg
MHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQg
MHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2Vm
IHRhZyAwIGRtYSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6
MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0
dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBj
b25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhj
ZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAw
OiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDow
MDowMDowMDowMC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4
OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0K
YXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQg
fQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUN
CmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9u
IDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6
Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAg
IHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRl
dmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBl
cnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6
IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNF
cnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDog
Y21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2
IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYg
RW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIg
fQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZvciBV
RE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4
MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4
MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0
YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAw
OjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVz
OiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29u
ZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4Y2Vw
dGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDog
Qk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6
MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAgIHJlcyA1MS8wNDowODpm
ODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikNCmF0
YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJUIH0N
CmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCnNkIDI6MDowOjA6IFtzZGFdIFJl
c3VsdDogaG9zdGJ5dGU9MHgwMCBkcml2ZXJieXRlPTB4MDgNCnNkIDI6MDowOjA6IFtzZGFd
IFNlbnNlIEtleSA6IDB4YiBbY3VycmVudF0gW2Rlc2NyaXB0b3JdDQpEZXNjcmlwdG9yIHNl
bnNlIGRhdGEgd2l0aCBzZW5zZSBkZXNjcmlwdG9ycyAoaW4gaGV4KToNCiAgICAgICAgNzIg
MGIgMDAgMDAgMDAgMDAgMDAgMGMgMDAgMGEgODAgMDAgMDAgMDAgMDAgMDAgDQogICAgICAg
IDBmIGZmIGZmIGY4IA0Kc2QgMjowOjA6MDogW3NkYV0gQVNDPTB4MCBBU0NRPTB4MA0KZW5k
X3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IHNkYSwgc2VjdG9yIDI2ODQzNTQ0OA0KQnVmZmVy
IEkvTyBlcnJvciBvbiBkZXZpY2Ugc2RhLCBsb2dpY2FsIGJsb2NrIDMzNTU0NDMxDQphdGEz
OiBFSCBjb21wbGV0ZQ0Kc2QgMjowOjA6MDogW3NkYV0gOTc2NzczMTY4IDUxMi1ieXRlIGhh
cmR3YXJlIHNlY3RvcnMgKDUwMDEwOCBNQikNCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIFBy
b3RlY3QgaXMgb2ZmDQpzZCAyOjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAw
MA0Kc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6
IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBDQpzZCAyOjA6MDowOiBbc2Rh
XSA5NzY3NzMxNjggNTEyLWJ5dGUgaGFyZHdhcmUgc2VjdG9ycyAoNTAwMTA4IE1CKQ0Kc2Qg
MjowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYNCnNkIDI6MDowOjA6IFtzZGFd
IE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBjYWNo
ZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBwb3J0IERQTyBv
ciBGVUENCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAg
YWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgv
MDA6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAg
ICAgICAgIHJlcyA1MS8wNDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAw
eDEgKGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEz
LjAwOiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMN
CmF0YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3Qg
MHgwIFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRh
My4wMDogY21kIGM4LzAwOjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRt
YSA0MDk2IGluDQogICAgICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6
MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJE
WSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVk
IGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVt
YXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBz
dGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDowMDow
MC9lZiB0YWcgMCBkbWEgNDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZm
LzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDog
c3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4w
MDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6
IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRh
My4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MDg6Zjg6ZmY6ZmYv
MDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDQwOTYgaW4NCiAgICAgICAgIHJlcyA1MS8w
NDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJv
cikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBB
QlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6IEVIIGNvbXBs
ZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFj
dGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDogY21kIGM4LzAw
OjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA0MDk2IGluDQogICAg
ICAgICByZXMgNTEvMDQ6MDg6Zjg6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgx
IChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4w
MDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzMzDQph
dGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4
MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMu
MDA6IGNtZCBjOC8wMDowODpmODpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEg
NDA5NiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjA4OmY4OmZmOmZmLzAwOjAwOjAwOjAwOjAw
L2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkg
RVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBm
b3IgVURNQS8zMw0Kc2QgMjowOjA6MDogW3NkYV0gUmVzdWx0OiBob3N0Ynl0ZT0weDAwIGRy
aXZlcmJ5dGU9MHgwOA0Kc2QgMjowOjA6MDogW3NkYV0gU2Vuc2UgS2V5IDogMHhiIFtjdXJy
ZW50XSBbZGVzY3JpcHRvcl0NCkRlc2NyaXB0b3Igc2Vuc2UgZGF0YSB3aXRoIHNlbnNlIGRl
c2NyaXB0b3JzIChpbiBoZXgpOg0KICAgICAgICA3MiAwYiAwMCAwMCAwMCAwMCAwMCAwYyAw
MCAwYSA4MCAwMCAwMCAwMCAwMCAwMCANCiAgICAgICAgMGYgZmYgZmYgZjggDQpzZCAyOjA6
MDowOiBbc2RhXSBBU0M9MHgwIEFTQ1E9MHgwDQplbmRfcmVxdWVzdDogSS9PIGVycm9yLCBk
ZXYgc2RhLCBzZWN0b3IgMjY4NDM1NDQ4DQpCdWZmZXIgSS9PIGVycm9yIG9uIGRldmljZSBz
ZGEsIGxvZ2ljYWwgYmxvY2sgMzM1NTQ0MzENCmF0YTM6IEVIIGNvbXBsZXRlDQpzZCAyOjA6
MDowOiBbc2RhXSA5NzY3NzMxNjggNTEyLWJ5dGUgaGFyZHdhcmUgc2VjdG9ycyAoNTAwMTA4
IE1CKQ0Kc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYNCnNkIDI6MDow
OjA6IFtzZGFdIE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwDQpzZCAyOjA6MDowOiBbc2RhXSBX
cml0ZSBjYWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBw
b3J0IERQTyBvciBGVUENCnNkIDI6MDowOjA6IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBo
YXJkd2FyZSBzZWN0b3JzICg1MDAxMDggTUIpDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBQ
cm90ZWN0IGlzIG9mZg0Kc2QgMjowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAg
MDANCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hl
OiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZVQQ0KKyBkZCBpZj0vZGV2L3Nk
YSBicz04MTkyIGNvdW50PTEgc2tpcD0xNjc3NzIxNQ0KZGQ6IHJlYWRpbmcgYC9kZXYvc2Rh
JzogSW5wdXQvb3V0cHV0IGVycm9yDQowKzAgcmVjb3JkcyBpbg0KMCswIHJlY29yZHMgb3V0
DQowIGJ5dGVzICgwIEIpIGNvcGllZCwgMC4xNTQ0NjQgcywgMC4wIGtCL3MNCisgZG1lc2cg
LWMNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0
aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6
MTA6ZjA6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDgxOTIgaW4NCiAgICAg
ICAgIHJlcyA1MS8wNDoxMDpmMDpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEg
KGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAw
OiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0
YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgw
IFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4w
MDogY21kIGM4LzAwOjEwOmYwOmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA4
MTkyIGluDQogICAgICAgICByZXMgNTEvMDQ6MTA6ZjA6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAv
ZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBF
UlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZv
ciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNr
IDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0
IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDoxMDpmMDpmZjpmZi8wMDowMDowMDowMDowMC9l
ZiB0YWcgMCBkbWEgODE5MiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjEwOmYwOmZmOmZmLzAw
OjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3Rh
dHVzOiB7IERSRFkgRVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDog
Y29uZmlndXJlZCBmb3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4
Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4w
MDogQk1ETUEgc3RhdCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MTA6ZjA6ZmY6ZmYvMDA6
MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1hIDgxOTIgaW4NCiAgICAgICAgIHJlcyA1MS8wNDox
MDpmMDpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJvcikN
CmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBBQlJU
IH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6IEVIIGNvbXBsZXRl
DQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFjdGlv
biAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDogY21kIGM4LzAwOjEw
OmYwOmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSA4MTkyIGluDQogICAgICAg
ICByZXMgNTEvMDQ6MTA6ZjA6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChk
ZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDog
ZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEz
OiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBT
RXJyIDB4MCBhY3Rpb24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6
IGNtZCBjOC8wMDoxMDpmMDpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgODE5
MiBpbg0KICAgICAgICAgcmVzIDUxLzA0OjEwOmYwOmZmOmZmLzAwOjAwOjAwOjAwOjAwL2Vm
IEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJS
IH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3Ig
VURNQS8zMw0Kc2QgMjowOjA6MDogW3NkYV0gUmVzdWx0OiBob3N0Ynl0ZT0weDAwIGRyaXZl
cmJ5dGU9MHgwOA0Kc2QgMjowOjA6MDogW3NkYV0gU2Vuc2UgS2V5IDogMHhiIFtjdXJyZW50
XSBbZGVzY3JpcHRvcl0NCkRlc2NyaXB0b3Igc2Vuc2UgZGF0YSB3aXRoIHNlbnNlIGRlc2Ny
aXB0b3JzIChpbiBoZXgpOg0KICAgICAgICA3MiAwYiAwMCAwMCAwMCAwMCAwMCAwYyAwMCAw
YSA4MCAwMCAwMCAwMCAwMCAwMCANCiAgICAgICAgMGYgZmYgZmYgZjAgDQpzZCAyOjA6MDow
OiBbc2RhXSBBU0M9MHgwIEFTQ1E9MHgwDQplbmRfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYg
c2RhLCBzZWN0b3IgMjY4NDM1NDQwDQpCdWZmZXIgSS9PIGVycm9yIG9uIGRldmljZSBzZGEs
IGxvZ2ljYWwgYmxvY2sgMzM1NTQ0MzANCkJ1ZmZlciBJL08gZXJyb3Igb24gZGV2aWNlIHNk
YSwgbG9naWNhbCBibG9jayAzMzU1NDQzMQ0KYXRhMzogRUggY29tcGxldGUNCnNkIDI6MDow
OjA6IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBoYXJkd2FyZSBzZWN0b3JzICg1MDAxMDgg
TUIpDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBQcm90ZWN0IGlzIG9mZg0Kc2QgMjowOjA6
MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDANCnNkIDI6MDowOjA6IFtzZGFdIFdy
aXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1cHBv
cnQgRFBPIG9yIEZVQQ0Kc2QgMjowOjA6MDogW3NkYV0gOTc2NzczMTY4IDUxMi1ieXRlIGhh
cmR3YXJlIHNlY3RvcnMgKDUwMDEwOCBNQikNCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIFBy
b3RlY3QgaXMgb2ZmDQpzZCAyOjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAw
MA0Kc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6
IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBDQorIGRkIGlmPS9kZXYvc2Rh
IGJzPTE2Mzg0IGNvdW50PTEgc2tpcD04Mzg4NjA3DQpkZDogcmVhZGluZyBgL2Rldi9zZGEn
OiBJbnB1dC9vdXRwdXQgZXJyb3INCjArMCByZWNvcmRzIGluDQowKzAgcmVjb3JkcyBvdXQN
CjAgYnl0ZXMgKDAgQikgY29waWVkLCAwLjE1Mzk3NiBzLCAwLjAga0Ivcw0KKyBkbWVzZyAt
Yw0KYXRhMy4wMDogZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rp
b24gMHgwDQphdGEzLjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDoy
MDplMDpmZjpmZi8wMDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgMTYzODQgaW4NCiAgICAg
ICAgIHJlcyA1MS8wNDoyMDplMDpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEg
KGRldmljZSBlcnJvcikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAw
OiBlcnJvcjogeyBBQlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0
YTM6IEVIIGNvbXBsZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgw
IFNFcnIgMHgwIGFjdGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4w
MDogY21kIGM4LzAwOjIwOmUwOmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSAx
NjM4NCBpbg0KICAgICAgICAgcmVzIDUxLzA0OjIwOmUwOmZmOmZmLzAwOjAwOjAwOjAwOjAw
L2VmIEVtYXNrIDB4MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkg
RVJSIH0NCmF0YTMuMDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBm
b3IgVURNQS8zMw0KYXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFz
ayAweDAgU0FjdCAweDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3Rh
dCAweDI1DQphdGEzLjAwOiBjbWQgYzgvMDA6MjA6ZTA6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAv
ZWYgdGFnIDAgZG1hIDE2Mzg0IGluDQogICAgICAgICByZXMgNTEvMDQ6MjA6ZTA6ZmY6ZmYv
MDA6MDA6MDA6MDA6MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBz
dGF0dXM6IHsgRFJEWSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAw
OiBjb25maWd1cmVkIGZvciBVRE1BLzMzDQphdGEzOiBFSCBjb21wbGV0ZQ0KYXRhMy4wMDog
ZXhjZXB0aW9uIEVtYXNrIDB4MCBTQWN0IDB4MCBTRXJyIDB4MCBhY3Rpb24gMHgwDQphdGEz
LjAwOiBCTURNQSBzdGF0IDB4MjUNCmF0YTMuMDA6IGNtZCBjOC8wMDoyMDplMDpmZjpmZi8w
MDowMDowMDowMDowMC9lZiB0YWcgMCBkbWEgMTYzODQgaW4NCiAgICAgICAgIHJlcyA1MS8w
NDoyMDplMDpmZjpmZi8wMDowMDowMDowMDowMC9lZiBFbWFzayAweDEgKGRldmljZSBlcnJv
cikNCmF0YTMuMDA6IHN0YXR1czogeyBEUkRZIEVSUiB9DQphdGEzLjAwOiBlcnJvcjogeyBB
QlJUIH0NCmF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMzMNCmF0YTM6IEVIIGNvbXBs
ZXRlDQphdGEzLjAwOiBleGNlcHRpb24gRW1hc2sgMHgwIFNBY3QgMHgwIFNFcnIgMHgwIGFj
dGlvbiAweDANCmF0YTMuMDA6IEJNRE1BIHN0YXQgMHgyNQ0KYXRhMy4wMDogY21kIGM4LzAw
OjIwOmUwOmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIHRhZyAwIGRtYSAxNjM4NCBpbg0KICAg
ICAgICAgcmVzIDUxLzA0OjIwOmUwOmZmOmZmLzAwOjAwOjAwOjAwOjAwL2VmIEVtYXNrIDB4
MSAoZGV2aWNlIGVycm9yKQ0KYXRhMy4wMDogc3RhdHVzOiB7IERSRFkgRVJSIH0NCmF0YTMu
MDA6IGVycm9yOiB7IEFCUlQgfQ0KYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURNQS8zMw0K
YXRhMzogRUggY29tcGxldGUNCmF0YTMuMDA6IGV4Y2VwdGlvbiBFbWFzayAweDAgU0FjdCAw
eDAgU0VyciAweDAgYWN0aW9uIDB4MA0KYXRhMy4wMDogQk1ETUEgc3RhdCAweDI1DQphdGEz
LjAwOiBjbWQgYzgvMDA6MjA6ZTA6ZmY6ZmYvMDA6MDA6MDA6MDA6MDAvZWYgdGFnIDAgZG1h
IDE2Mzg0IGluDQogICAgICAgICByZXMgNTEvMDQ6MjA6ZTA6ZmY6ZmYvMDA6MDA6MDA6MDA6
MDAvZWYgRW1hc2sgMHgxIChkZXZpY2UgZXJyb3IpDQphdGEzLjAwOiBzdGF0dXM6IHsgRFJE
WSBFUlIgfQ0KYXRhMy4wMDogZXJyb3I6IHsgQUJSVCB9DQphdGEzLjAwOiBjb25maWd1cmVk
IGZvciBVRE1BLzMzDQpzZCAyOjA6MDowOiBbc2RhXSBSZXN1bHQ6IGhvc3RieXRlPTB4MDAg
ZHJpdmVyYnl0ZT0weDA4DQpzZCAyOjA6MDowOiBbc2RhXSBTZW5zZSBLZXkgOiAweGIgW2N1
cnJlbnRdIFtkZXNjcmlwdG9yXQ0KRGVzY3JpcHRvciBzZW5zZSBkYXRhIHdpdGggc2Vuc2Ug
ZGVzY3JpcHRvcnMgKGluIGhleCk6DQogICAgICAgIDcyIDBiIDAwIDAwIDAwIDAwIDAwIDBj
IDAwIDBhIDgwIDAwIDAwIDAwIDAwIDAwIA0KICAgICAgICAwZiBmZiBmZiBlMCANCnNkIDI6
MDowOjA6IFtzZGFdIEFTQz0weDAgQVNDUT0weDANCmVuZF9yZXF1ZXN0OiBJL08gZXJyb3Is
IGRldiBzZGEsIHNlY3RvciAyNjg0MzU0MjQNCmF0YTM6IEVIIGNvbXBsZXRlDQpzZCAyOjA6
MDowOiBbc2RhXSA5NzY3NzMxNjggNTEyLWJ5dGUgaGFyZHdhcmUgc2VjdG9ycyAoNTAwMTA4
IE1CKQ0Kc2QgMjowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYNCnNkIDI6MDow
OjA6IFtzZGFdIE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwDQpzZCAyOjA6MDowOiBbc2RhXSBX
cml0ZSBjYWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBw
b3J0IERQTyBvciBGVUENCnNkIDI6MDowOjA6IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBo
YXJkd2FyZSBzZWN0b3JzICg1MDAxMDggTUIpDQpzZCAyOjA6MDowOiBbc2RhXSBXcml0ZSBQ
cm90ZWN0IGlzIG9mZg0Kc2QgMjowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAg
MDANCnNkIDI6MDowOjA6IFtzZGFdIFdyaXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hl
OiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZVQQ0KKyBzZXEgMSAxIDMNCisg
cmVhZCBpDQorKyBleHByIDMzNTU0NDMyIC0gMQ0KKyBkZCBpZj0vZGV2L3NkYSBicz00MDk2
IGNvdW50PTEgc2tpcD0zMzU1NDQzMQ0KZGQ6IHJlYWRpbmcgYC9kZXYvc2RhJzogSW5wdXQv
b3V0cHV0IGVycm9yDQowKzAgcmVjb3JkcyBpbg0KMCswIHJlY29yZHMgb3V0DQowIGJ5dGVz
ICgwIEIpIGNvcGllZCwgMC4yODY3MjMgcywgMC4wIGtCL3MNCisgcmVhZCBpDQorKyBleHBy
IDMzNTU0NDMyIC0gMg0KKyBkZCBpZj0vZGV2L3NkYSBicz00MDk2IGNvdW50PTIgc2tpcD0z
MzU1NDQzMA0KZGQ6IHJlYWRpbmcgYC9kZXYvc2RhJzogSW5wdXQvb3V0cHV0IGVycm9yDQox
KzAgcmVjb3JkcyBpbg0KMSswIHJlY29yZHMgb3V0DQo0MDk2IGJ5dGVzICg0LjEga0IpIGNv
cGllZCwgMC4zMDQ0NzUgcywgMTMuNSBrQi9zDQorIHJlYWQgaQ0KKysgZXhwciAzMzU1NDQz
MiAtIDMNCisgZGQgaWY9L2Rldi9zZGEgYnM9NDA5NiBjb3VudD0zIHNraXA9MzM1NTQ0MjkN
CjMrMCByZWNvcmRzIGluDQozKzAgcmVjb3JkcyBvdXQNCjEyMjg4IGJ5dGVzICgxMiBrQikg
Y29waWVkLCAwLjAwNTI5MzIyIHMsIDIuMyBNQi9zDQorIHJlYWQgaQ0KKysgZXhwciAzMzU1
NDQzMiAtIDMNCisgZGQgaWY9L2Rldi9zZGEgYnM9NDA5NiBjb3VudD0xMDAgc2tpcD0zMzU1
NDQyOQ0KMTAwKzAgcmVjb3JkcyBpbg0KMTAwKzAgcmVjb3JkcyBvdXQNCjQwOTYwMCBieXRl
cyAoNDEwIGtCKSBjb3BpZWQsIDAuMDA1NTE5NjYgcywgNzQuMiBNQi9zDQorIHNlcSAxIDEg
MTcNCisgcmVhZCBpDQorKyBleHByIDI2ODQzNTQ1NiAtIDENCisgZGQgaWY9L2Rldi9zZGEg
YnM9NTEyIGNvdW50PTEgc2tpcD0yNjg0MzU0NTUNCmRkOiByZWFkaW5nIGAvZGV2L3NkYSc6
IElucHV0L291dHB1dCBlcnJvcg0KMCswIHJlY29yZHMgaW4NCjArMCByZWNvcmRzIG91dA0K
MCBieXRlcyAoMCBCKSBjb3BpZWQsIDAuMjg3OCBzLCAwLjAga0Ivcw0KKyByZWFkIGkNCisr
IGV4cHIgMjY4NDM1NDU2IC0gMg0KKyBkZCBpZj0vZGV2L3NkYSBicz01MTIgY291bnQ9MiBz
a2lwPTI2ODQzNTQ1NA0KZGQ6IHJlYWRpbmcgYC9kZXYvc2RhJzogSW5wdXQvb3V0cHV0IGVy
cm9yDQowKzAgcmVjb3JkcyBpbg0KMCswIHJlY29yZHMgb3V0DQowIGJ5dGVzICgwIEIpIGNv
cGllZCwgMC4yOTAzMjEgcywgMC4wIGtCL3MNCisgcmVhZCBpDQorKyBleHByIDI2ODQzNTQ1
NiAtIDMNCisgZGQgaWY9L2Rldi9zZGEgYnM9NTEyIGNvdW50PTMgc2tpcD0yNjg0MzU0NTMN
CmRkOiByZWFkaW5nIGAvZGV2L3NkYSc6IElucHV0L291dHB1dCBlcnJvcg0KMCswIHJlY29y
ZHMgaW4NCjArMCByZWNvcmRzIG91dA0KMCBieXRlcyAoMCBCKSBjb3BpZWQsIDAuMjg4NTIz
IHMsIDAuMCBrQi9zDQorIHJlYWQgaQ0KKysgZXhwciAyNjg0MzU0NTYgLSA0DQorIGRkIGlm
PS9kZXYvc2RhIGJzPTUxMiBjb3VudD00IHNraXA9MjY4NDM1NDUyDQpkZDogcmVhZGluZyBg
L2Rldi9zZGEnOiBJbnB1dC9vdXRwdXQgZXJyb3INCjArMCByZWNvcmRzIGluDQowKzAgcmVj
b3JkcyBvdXQNCjAgYnl0ZXMgKDAgQikgY29waWVkLCAwLjI4OTQ1NiBzLCAwLjAga0Ivcw0K
KyByZWFkIGkNCisrIGV4cHIgMjY4NDM1NDU2IC0gNQ0KKyBkZCBpZj0vZGV2L3NkYSBicz01
MTIgY291bnQ9NSBza2lwPTI2ODQzNTQ1MQ0KZGQ6IHJlYWRpbmcgYC9kZXYvc2RhJzogSW5w
dXQvb3V0cHV0IGVycm9yDQowKzAgcmVjb3JkcyBpbg0KMCswIHJlY29yZHMgb3V0DQowIGJ5
dGVzICgwIEIpIGNvcGllZCwgMC4yODk1MDQgcywgMC4wIGtCL3MNCisgcmVhZCBpDQorKyBl
eHByIDI2ODQzNTQ1NiAtIDYNCisgZGQgaWY9L2Rldi9zZGEgYnM9NTEyIGNvdW50PTYgc2tp
cD0yNjg0MzU0NTANCmRkOiByZWFkaW5nIGAvZGV2L3NkYSc6IElucHV0L291dHB1dCBlcnJv
cg0KMCswIHJlY29yZHMgaW4NCjArMCByZWNvcmRzIG91dA0KMCBieXRlcyAoMCBCKSBjb3Bp
ZWQsIDAuMjg5NDE3IHMsIDAuMCBrQi9zDQorIHJlYWQgaQ0KKysgZXhwciAyNjg0MzU0NTYg
LSA3DQorIGRkIGlmPS9kZXYvc2RhIGJzPTUxMiBjb3VudD03IHNraXA9MjY4NDM1NDQ5DQpk
ZDogcmVhZGluZyBgL2Rldi9zZGEnOiBJbnB1dC9vdXRwdXQgZXJyb3INCjArMCByZWNvcmRz
IGluDQowKzAgcmVjb3JkcyBvdXQNCjAgYnl0ZXMgKDAgQikgY29waWVkLCAwLjI4OTQyMSBz
LCAwLjAga0Ivcw0KKyByZWFkIGkNCisrIGV4cHIgMjY4NDM1NDU2IC0gOA0KKyBkZCBpZj0v
ZGV2L3NkYSBicz01MTIgY291bnQ9OCBza2lwPTI2ODQzNTQ0OA0KZGQ6IHJlYWRpbmcgYC9k
ZXYvc2RhJzogSW5wdXQvb3V0cHV0IGVycm9yDQowKzAgcmVjb3JkcyBpbg0KMCswIHJlY29y
ZHMgb3V0DQowIGJ5dGVzICgwIEIpIGNvcGllZCwgMC4yODk0ODIgcywgMC4wIGtCL3MNCisg
cmVhZCBpDQorKyBleHByIDI2ODQzNTQ1NiAtIDkNCisgZGQgaWY9L2Rldi9zZGEgYnM9NTEy
IGNvdW50PTkgc2tpcD0yNjg0MzU0NDcNCmRkOiByZWFkaW5nIGAvZGV2L3NkYSc6IElucHV0
L291dHB1dCBlcnJvcg0KMSswIHJlY29yZHMgaW4NCjErMCByZWNvcmRzIG91dA0KNTEyIGJ5
dGVzICg1MTIgQikgY29waWVkLCAwLjMwOTQ0NCBzLCAxLjcga0Ivcw0KKyByZWFkIGkNCisr
IGV4cHIgMjY4NDM1NDU2IC0gMTANCisgZGQgaWY9L2Rldi9zZGEgYnM9NTEyIGNvdW50PTEw
IHNraXA9MjY4NDM1NDQ2DQpkZDogcmVhZGluZyBgL2Rldi9zZGEnOiBJbnB1dC9vdXRwdXQg
ZXJyb3INCjIrMCByZWNvcmRzIGluDQoyKzAgcmVjb3JkcyBvdXQNCjEwMjQgYnl0ZXMgKDEu
MCBrQikgY29waWVkLCAwLjMxNzQyNiBzLCAzLjIga0Ivcw0KKyByZWFkIGkNCisrIGV4cHIg
MjY4NDM1NDU2IC0gMTENCisgZGQgaWY9L2Rldi9zZGEgYnM9NTEyIGNvdW50PTExIHNraXA9
MjY4NDM1NDQ1DQpkZDogcmVhZGluZyBgL2Rldi9zZGEnOiBJbnB1dC9vdXRwdXQgZXJyb3IN
CjMrMCByZWNvcmRzIGluDQozKzAgcmVjb3JkcyBvdXQNCjE1MzYgYnl0ZXMgKDEuNSBrQikg
Y29waWVkLCAwLjMwNTQ3NSBzLCA1LjAga0Ivcw0KKyByZWFkIGkNCisrIGV4cHIgMjY4NDM1
NDU2IC0gMTINCisgZGQgaWY9L2Rldi9zZGEgYnM9NTEyIGNvdW50PTEyIHNraXA9MjY4NDM1
NDQ0DQpkZDogcmVhZGluZyBgL2Rldi9zZGEnOiBJbnB1dC9vdXRwdXQgZXJyb3INCjQrMCBy
ZWNvcmRzIGluDQo0KzAgcmVjb3JkcyBvdXQNCjIwNDggYnl0ZXMgKDIuMCBrQikgY29waWVk
LCAwLjMwNTU0MiBzLCA2Ljcga0Ivcw0KKyByZWFkIGkNCisrIGV4cHIgMjY4NDM1NDU2IC0g
MTMNCisgZGQgaWY9L2Rldi9zZGEgYnM9NTEyIGNvdW50PTEzIHNraXA9MjY4NDM1NDQzDQpk
ZDogcmVhZGluZyBgL2Rldi9zZGEnOiBJbnB1dC9vdXRwdXQgZXJyb3INCjUrMCByZWNvcmRz
IGluDQo1KzAgcmVjb3JkcyBvdXQNCjI1NjAgYnl0ZXMgKDIuNiBrQikgY29waWVkLCAwLjMw
NTQzOCBzLCA4LjQga0Ivcw0KKyByZWFkIGkNCisrIGV4cHIgMjY4NDM1NDU2IC0gMTQNCisg
ZGQgaWY9L2Rldi9zZGEgYnM9NTEyIGNvdW50PTE0IHNraXA9MjY4NDM1NDQyDQpkZDogcmVh
ZGluZyBgL2Rldi9zZGEnOiBJbnB1dC9vdXRwdXQgZXJyb3INCjYrMCByZWNvcmRzIGluDQo2
KzAgcmVjb3JkcyBvdXQNCjMwNzIgYnl0ZXMgKDMuMSBrQikgY29waWVkLCAwLjMwNTQ3NiBz
LCAxMC4xIGtCL3MNCisgcmVhZCBpDQorKyBleHByIDI2ODQzNTQ1NiAtIDE1DQorIGRkIGlm
PS9kZXYvc2RhIGJzPTUxMiBjb3VudD0xNSBza2lwPTI2ODQzNTQ0MQ0KZGQ6IHJlYWRpbmcg
YC9kZXYvc2RhJzogSW5wdXQvb3V0cHV0IGVycm9yDQo3KzAgcmVjb3JkcyBpbg0KNyswIHJl
Y29yZHMgb3V0DQozNTg0IGJ5dGVzICgzLjYga0IpIGNvcGllZCwgMC4zMDU0NzkgcywgMTEu
NyBrQi9zDQorIHJlYWQgaQ0KKysgZXhwciAyNjg0MzU0NTYgLSAxNg0KKyBkZCBpZj0vZGV2
L3NkYSBicz01MTIgY291bnQ9MTYgc2tpcD0yNjg0MzU0NDANCmRkOiByZWFkaW5nIGAvZGV2
L3NkYSc6IElucHV0L291dHB1dCBlcnJvcg0KOCswIHJlY29yZHMgaW4NCjgrMCByZWNvcmRz
IG91dA0KNDA5NiBieXRlcyAoNC4xIGtCKSBjb3BpZWQsIDAuMzA1NDk4IHMsIDEzLjQga0Iv
cw0KKyByZWFkIGkNCisrIGV4cHIgMjY4NDM1NDU2IC0gMTcNCisgZGQgaWY9L2Rldi9zZGEg
YnM9NTEyIGNvdW50PTE3IHNraXA9MjY4NDM1NDM5DQoxNyswIHJlY29yZHMgaW4NCjE3KzAg
cmVjb3JkcyBvdXQNCjg3MDQgYnl0ZXMgKDguNyBrQikgY29waWVkLCAwLjAwNTg3IHMsIDEu
NSBNQi9zDQorIHJlYWQgaQ0KKysgZXhwciAyNjg0MzU0NTYgLSAxNw0KKyBkZCBpZj0vZGV2
L3NkYSBicz01MTIgY291bnQ9MTAwIHNraXA9MjY4NDM1NDM5DQoxMDArMCByZWNvcmRzIGlu
DQoxMDArMCByZWNvcmRzIG91dA0KNTEyMDAgYnl0ZXMgKDUxIGtCKSBjb3BpZWQsIDAuMDAy
Mzc0MjcgcywgMjEuNiBNQi9zDQpwYzp+IyBleGl0DQpleGl0DQoKU2NyaXB0IGRvbmUgb24g
VGh1IDE1IE1heSAyMDA4IDAzOjQ4OjQyIEFNIEpTVAo=
--------------020805000607020302000709--
