From: Boris Derzhavets <bderzhavets@yahoo.com>
Subject: Re: Re: Help interpreting AHCI failure messages
Date: Mon, 22 Dec 2008 12:02:28 -0800 (PST)
Message-ID: <828110.2815.qm@web56103.mail.re3.yahoo.com>
References: <155156.61197.qm@web56105.mail.re3.yahoo.com>
Reply-To: bderzhavets@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0201083974=="
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <155156.61197.qm@web56105.mail.re3.yahoo.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-ide@vger.kernel.org

--===============0201083974==
Content-Type: multipart/alternative; boundary="0-1754690857-1229976148=:2815"

--0-1754690857-1229976148=:2815
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, you testing Linux version 2.6.28-rc8-tip. Disregard message bellow.

--- On Mon, 12/22/08, Boris Derzhavets <bderzhavets@yahoo.com> wrote:
From: Boris Derzhavets <bderzhavets@yahoo.com>
Subject: Re: [Xen-devel] Re: Help interpreting AHCI failure messages
To: "Andrew Lyon" <andrew.lyon@gmail.com>
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>, "Xen-devel" <xen-devel@lists.x=
ensource.com>, "Jeff Garzik" <jeff@garzik.org>, "Linux Kernel Mailing List"=
 <linux-kernel@vger.kernel.org>, "IDE/ATA development list" <linux-ide@vger=
.kernel.org>, "Gerd Hoffmann" <kraxel@redhat.com>
Date: Monday, December 22, 2008, 2:56 PM

> I am going to try Xen 3.3.1 rc4
> Andy

Maybe i misunderstood intend. I guess it is :-
test Xen failure to detect SATA Drives attached to South Bridge
running in AHCI mode

Just in case , hardware config:-C2D E8400, 8GB RAM , ASUS P5K Premium/WIFI =
(P35+ICH9R(AHCI Bios Setup)),
2x250 Seagate Barracuda (SATA II) (no raid)

Xen 3.3.1-RC4 port to CentOS 5.2=A0=A0 with no problems:-

[root@ServerXen mnt]# xm dmesg
=A0__=A0 __=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _____=A0 _____=A0 _=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 _=A0 _=A0=A0=20
=A0\ \/ /___ _ __=A0=A0 |___ / |___ / / |=A0=A0 _ __ ___| || |=A0=20
=A0 \=A0 // _ \ '_ \=A0=A0=A0 |_ \=A0=A0 |_ \ | |__| '__/ __| || |_=20
=A0
 /=A0 \=A0 __/ | | |=A0 ___) | ___) || |__| | | (__|__=A0=A0 _|
=A0/_/\_\___|_| |_| |____(_)____(_)_|=A0 |_|=A0 \___|=A0 |_|=A0=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=20
(XEN) Xen version 3.3.1-rc4 (root@) (gcc version 4.1.2 20071124 (Red Hat 4.=
1.2-42)) Mon Dec 22 10:38:12 EST 2008
(XEN) Latest ChangeSet: Fri Dec 19 15:16:13 2008 +0000 18544:2c83b2d7cd20
(XEN) Command line:=20
(XEN) Video information:
(XEN)=A0 VGA is text mode 80x25, font 8x16
(XEN)=A0 VBE/DDC methods: none; EDID transfer time: 0 seconds
(XEN)=A0 EDID info not retrieved because no DDC retrieval method detected
(XEN) Disc information:
(XEN)=A0
 Found 0 MBR signatures
(XEN)=A0 Found 2 EDD information structures
(XEN) Xen-e820 RAM map:
(XEN)=A0 0000000000000000 - 000000000009ec00 (usable)
(XEN)=A0 000000000009ec00 - 00000000000a0000 (reserved)
(XEN)=A0 00000000000e4000 - 0000000000100000 (reserved)
(XEN)=A0 0000000000100000 - 00000000cff80000 (usable)
(XEN)=A0 00000000cff80000 - 00000000cff8e000 (ACPI data)
(XEN)=A0 00000000cff8e000 - 00000000cffe0000 (ACPI NVS)
(XEN)=A0 00000000cffe0000 - 00000000d0000000 (reserved)
(XEN)=A0 00000000fee00000 - 00000000fee01000 (reserved)
(XEN)=A0 00000000ffe00000 - 0000000100000000 (reserved)
(XEN)=A0 0000000100000000 - 0000000230000000 (usable)
(XEN) System RAM: 8191MB (8387704kB)
(XEN) ACPI: RSDP 000FBB80, 0014 (r0 ACPIAM)
(XEN) ACPI: RSDT CFF80000, 003C (r1 A_M_I_ OEMRSDT=A0 10000730 MSFT=A0=A0=
=A0=A0=A0=A0 97)
(XEN) ACPI: FACP CFF80200, 0084 (r2 A_M_I_
 OEMFACP=A0 10000730 MSFT=A0=A0=A0=A0=A0=A0 97)
(XEN) ACPI: DSDT CFF805C0, 8E13 (r1=A0 A0840 A0840001=A0=A0=A0=A0=A0=A0=A0 =
1 INTL 20060113)
(XEN) ACPI: FACS CFF8E000, 0040
(XEN) ACPI: APIC CFF80390, 006C (r1 A_M_I_ OEMAPIC=A0 10000730 MSFT=A0=A0=
=A0=A0=A0=A0 97)
(XEN) ACPI: MCFG CFF80400, 003C (r1 A_M_I_ OEMMCFG=A0 10000730 MSFT=A0=A0=
=A0=A0=A0=A0 97)
(XEN) ACPI: OEMB CFF8E040, 0081 (r1 A_M_I_ AMI_OEM=A0 10000730 MSFT=A0=A0=
=A0=A0=A0=A0 97)
(XEN) ACPI: HPET CFF893E0, 0038 (r1 A_M_I_ OEMHPET=A0 10000730 MSFT=A0=A0=
=A0=A0=A0=A0 97)
(XEN) ACPI: OSFR CFF89420, 00B0 (r1 A_M_I_ OEMOSFR=A0 10000730 MSFT=A0=A0=
=A0=A0=A0=A0 97)
(XEN) Xen heap: 14MB (14480kB)
(XEN) Domain heap initialised
(XEN) Processor #0 7:7 APIC version 20
(XEN) Processor #1 7:7 APIC version 20
(XEN) IOAPIC[0]:
 apic_id 2, version 32, address 0xfec00000, GSI 0-23
(XEN) Enabling APIC mode:=A0 Flat.=A0 Using 1 I/O APICs
(XEN) Using scheduler: SMP Credit Scheduler (credit)
(XEN) Detected 3005.632 MHz processor.
(XEN) HVM: VMX enabled
(XEN) CPU0: Intel(R) Core(TM)2 Duo CPU=A0=A0=A0=A0 E8400=A0 @ 3.00GHz stepp=
ing 06
(XEN) Booting processor 1/1 eip 8c000
(XEN) CPU1: Intel(R) Core(TM)2 Duo CPU=A0=A0=A0=A0 E8400=A0 @ 3.00GHz stepp=
ing 06
(XEN) Total of 2 processors activated.
(XEN) ENABLING IO-APIC IRQs
(XEN)=A0 -> Using new ACK method
(XEN) checking TSC synchronization across 2 CPUs: passed.
(XEN) Platform timer is 14.318MHz HPET
(XEN) Brought up 2 CPUs
(XEN) I/O virtualisation disabled
(XEN) *** LOADING DOMAIN 0 ***
(XEN)=A0 Xen=A0 kernel: 64-bit, lsb, compat32
(XEN)=A0 Dom0 kernel: 64-bit, lsb, paddr 0xffffffff80200000 -> 0xffffffff80=
5d87ec
(XEN) PHYSICAL
 MEMORY ARRANGEMENT:
(XEN)=A0 Dom0 alloc.:=A0=A0 0000000226000000->0000000228000000 (2022123 pag=
es to be allocated)
(XEN) VIRTUAL MEMORY ARRANGEMENT:
(XEN)=A0 Loaded kernel: ffffffff80200000->ffffffff805d87ec
(XEN)=A0 Init. ramdisk: ffffffff805d9000->ffffffff80d1fa00
(XEN)=A0 Phys-Mach map: ffffffff80d20000->ffffffff81c9d758
(XEN)=A0 Start info:=A0=A0=A0 ffffffff81c9e000->ffffffff81c9e4a4
(XEN)=A0 Page tables:=A0=A0 ffffffff81c9f000->ffffffff81cb2000
(XEN)=A0 Boot stack:=A0=A0=A0 ffffffff81cb2000->ffffffff81cb3000
(XEN)=A0 TOTAL:=A0=A0=A0=A0=A0=A0=A0=A0 ffffffff80000000->ffffffff82000000
(XEN)=A0 ENTRY ADDRESS: ffffffff80200000
(XEN) Dom0 has maximum 2 VCPUs
(XEN) Scrubbing Free RAM: .done.
(XEN) Xen trace buffers: disabled
(XEN) Std. Loglevel: Errors and warnings
(XEN) Guest Loglevel: Nothing
 (Rate-limited: Errors and warnings)
(XEN) Xen is relinquishing VGA console.
(XEN) *** Serial input -> DOM0 (type 'CTRL-a' three times to switch input t=
o Xen)
(XEN) Freed 104kB init memory.

64-bit Solaris 10U6 HVM tested with 2 vcpus OK.
Just several warnings at start up not showed up at Xen 3.3.1-RC3 Dom0.



      _______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel
=0A=0A=0A      
--0-1754690857-1229976148=:2815
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Sorry, you testing Linux version 2.6.28-rc8-tip. Disregard message bellow.<br><br>--- On <b>Mon, 12/22/08, Boris Derzhavets <i>&lt;bderzhavets@yahoo.com&gt;</i></b> wrote:<br><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">From: Boris Derzhavets &lt;bderzhavets@yahoo.com&gt;<br>Subject: Re: [Xen-devel] Re: Help interpreting AHCI failure messages<br>To: "Andrew Lyon" &lt;andrew.lyon@gmail.com&gt;<br>Cc: "Jeremy Fitzhardinge" &lt;jeremy@goop.org&gt;, "Xen-devel" &lt;xen-devel@lists.xensource.com&gt;, "Jeff Garzik" &lt;jeff@garzik.org&gt;, "Linux Kernel Mailing List" &lt;linux-kernel@vger.kernel.org&gt;, "IDE/ATA development list" &lt;linux-ide@vger.
 kernel.org&gt;, "Gerd Hoffmann" &lt;kraxel@redhat.com&gt;<br>Date: Monday, December 22, 2008, 2:56 PM<br><br><div id="yiv452925901"><table border="0" cellpadding="0"
 cellspacing="0"><tbody><tr><td style="font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-size: inherit; line-height: inherit; font-size-adjust: inherit; font-stretch: inherit; -x-system-font: none;" valign="top"><pre>&gt; I am going to try Xen 3.3.1 rc4<br>&gt; Andy<br><br>Maybe i misunderstood intend. I guess it is :-<br>test Xen failure to detect SATA Drives attached to South Bridge<br>running in AHCI mode<br><br>Just in case , hardware config:-</pre>C2D E8400, 8GB RAM , ASUS P5K Premium/WIFI (P35+ICH9R(AHCI Bios Setup)),<br>2x250 Seagate Barracuda (SATA II) (no raid)<br><br>Xen 3.3.1-RC4 port to CentOS 5.2&nbsp;&nbsp; with no problems:-<br><br>[root@ServerXen mnt]# xm dmesg<br>&nbsp;__&nbsp; __&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb
 sp;&nbsp;&nbsp; _____&nbsp; _____&nbsp; _&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _&nbsp; _&nbsp;&nbsp; <br>&nbsp;\ \/ /___ _
 __&nbsp;&nbsp; |___ / |___ / / |&nbsp;&nbsp; _ __ ___| || |&nbsp; <br>&nbsp; \&nbsp; // _ \ '_ \&nbsp;&nbsp;&nbsp; |_ \&nbsp;&nbsp; |_ \ | |__| '__/ __| || |_ <br>&nbsp;
 /&nbsp; \&nbsp; __/ | | |&nbsp; ___) | ___) || |__| | | (__|__&nbsp;&nbsp; _|<br>&nbsp;/_/\_\___|_| |_| |____(_)____(_)_|&nbsp; |_|&nbsp; \___|&nbsp; |_|&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>(XEN) Xen version 3.3.1-rc4 (root@) (gcc version 4.1.2 20071124 (Red Hat 4.1.2-42)) Mon Dec 22 10:38:12 EST 2008<br>(XEN) Latest ChangeSet: Fri Dec 19 15:16:13 2008 +0000 18544:2c83b2d7cd20<br>(XEN) Command line: <br>(XEN) Video information:<br>(XEN)&nbsp; VGA is text mode 80x25, font 8x16<br>(XEN)&nbsp; VBE/DD
 C methods: none; EDID transfer time: 0 seconds<br>(XEN)&nbsp; EDID info not retrieved because no DDC retrieval method detected<br>(XEN) Disc information:<br>(XEN)&nbsp;
 Found 0 MBR signatures<br>(XEN)&nbsp; Found 2 EDD information structures<br>(XEN) Xen-e820 RAM map:<br>(XEN)&nbsp; 0000000000000000 - 000000000009ec00 (usable)<br>(XEN)&nbsp; 000000000009ec00 - 00000000000a0000 (reserved)<br>(XEN)&nbsp; 00000000000e4000 - 0000000000100000 (reserved)<br>(XEN)&nbsp; 0000000000100000 - 00000000cff80000 (usable)<br>(XEN)&nbsp; 00000000cff80000 - 00000000cff8e000 (ACPI data)<br>(XEN)&nbsp; 00000000cff8e000 - 00000000cffe0000 (ACPI NVS)<br>(XEN)&nbsp; 00000000cffe0000 - 00000000d0000000 (reserved)<br>(XEN)&nbsp; 00000000fee00000 - 00000000fee01000 (reserved)<br>(XEN)&nbsp; 00000000ffe00000 - 0000000100000000 (reserved)<br>(XEN)&nbsp; 0000000100000000 - 0000000230000000 (usable)<br>(XEN) System RAM: 8191MB (8387704kB)<br>(XEN) ACPI: RSDP 000FBB80, 0014 (r0 ACPIA
 M)<br>(XEN) ACPI: RSDT CFF80000, 003C (r1 A_M_I_ OEMRSDT&nbsp; 10000730 MSFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97)<br>(XEN) ACPI: FACP CFF80200, 0084 (r2 A_M_I_
 OEMFACP&nbsp; 10000730 MSFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97)<br>(XEN) ACPI: DSDT CFF805C0, 8E13 (r1&nbsp; A0840 A0840001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 INTL 20060113)<br>(XEN) ACPI: FACS CFF8E000, 0040<br>(XEN) ACPI: APIC CFF80390, 006C (r1 A_M_I_ OEMAPIC&nbsp; 10000730 MSFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97)<br>(XEN) ACPI: MCFG CFF80400, 003C (r1 A_M_I_ OEMMCFG&nbsp; 10000730 MSFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97)<br>(XEN) ACPI: OEMB CFF8E040, 0081 (r1 A_M_I_ AMI_OEM&nbsp; 10000730 MSFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97)<br>(XEN) ACPI: HPET CFF893E0, 0038 (r1 A_M_I_ OEMHPET&nbsp; 10000730 MSFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97)<br>(XEN) ACPI: OSFR CFF89420, 00B0 (r1 A_M_I_ OEMOSFR&nbsp; 10000730 MSFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 97)<br>(XEN
 ) Xen heap: 14MB (14480kB)<br>(XEN) Domain heap initialised<br>(XEN) Processor #0 7:7 APIC version 20<br>(XEN) Processor #1 7:7 APIC version 20<br>(XEN) IOAPIC[0]:
 apic_id 2, version 32, address 0xfec00000, GSI 0-23<br>(XEN) Enabling APIC mode:&nbsp; Flat.&nbsp; Using 1 I/O APICs<br>(XEN) Using scheduler: SMP Credit Scheduler (credit)<br>(XEN) Detected 3005.632 MHz processor.<br>(XEN) HVM: VMX enabled<br>(XEN) CPU0: Intel(R) Core(TM)2 Duo CPU&nbsp;&nbsp;&nbsp;&nbsp; E8400&nbsp; @ 3.00GHz stepping 06<br>(XEN) Booting processor 1/1 eip 8c000<br>(XEN) CPU1: Intel(R) Core(TM)2 Duo CPU&nbsp;&nbsp;&nbsp;&nbsp; E8400&nbsp; @ 3.00GHz stepping 06<br>(XEN) Total of 2 processors activated.<br>(XEN) ENABLING IO-APIC IRQs<br>(XEN)&nbsp; -&gt; Using new ACK method<br>(XEN) checking TSC synchronization across 2 CPUs: passed.<br>(XEN) Platform timer is 14.318MHz HPET<br>(XEN) Brought up 2 CPUs<br>(XEN) I/O virtualisation disabled<br>(XEN) *** LOADING DOMAIN 0 ***<b
 r>(XEN)&nbsp; Xen&nbsp; kernel: 64-bit, lsb, compat32<br>(XEN)&nbsp; Dom0 kernel: 64-bit, lsb, paddr 0xffffffff80200000 -&gt; 0xffffffff805d87ec<br>(XEN) PHYSICAL
 MEMORY ARRANGEMENT:<br>(XEN)&nbsp; Dom0 alloc.:&nbsp;&nbsp; 0000000226000000-&gt;0000000228000000 (2022123 pages to be allocated)<br>(XEN) VIRTUAL MEMORY ARRANGEMENT:<br>(XEN)&nbsp; Loaded kernel: ffffffff80200000-&gt;ffffffff805d87ec<br>(XEN)&nbsp; Init. ramdisk: ffffffff805d9000-&gt;ffffffff80d1fa00<br>(XEN)&nbsp; Phys-Mach map: ffffffff80d20000-&gt;ffffffff81c9d758<br>(XEN)&nbsp; Start info:&nbsp;&nbsp;&nbsp; ffffffff81c9e000-&gt;ffffffff81c9e4a4<br>(XEN)&nbsp; Page tables:&nbsp;&nbsp; ffffffff81c9f000-&gt;ffffffff81cb2000<br>(XEN)&nbsp; Boot stack:&nbsp;&nbsp;&nbsp; ffffffff81cb2000-&gt;ffffffff81cb3000<br>(XEN)&nbsp; TOTAL:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffffffff80000000-&gt;ffffffff82000000<br>(XEN)&nbsp; ENTRY ADDRESS: ffffffff80200000<br>(XEN) Dom0 has maximum 2 V
 CPUs<br>(XEN) Scrubbing Free RAM: .done.<br>(XEN) Xen trace buffers: disabled<br>(XEN) Std. Loglevel: Errors and warnings<br>(XEN) Guest Loglevel: Nothing
 (Rate-limited: Errors and warnings)<br>(XEN) Xen is relinquishing VGA console.<br>(XEN) *** Serial input -&gt; DOM0 (type 'CTRL-a' three times to switch input to Xen)<br>(XEN) Freed 104kB init memory.<br><br>64-bit Solaris 10U6 HVM tested with 2 vcpus OK.<br>Just several warnings at start up not showed up at Xen 3.3.1-RC3 Dom0.<br></td></tr></tbody></table><br>

      </div><pre>_______________________________________________<br>Xen-devel mailing list<br>Xen-devel@lists.xensource.com<br>http://lists.xensource.com/xen-devel<br></pre></blockquote></td></tr></table><br>

      
--0-1754690857-1229976148=:2815--


--===============0201083974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--===============0201083974==--
