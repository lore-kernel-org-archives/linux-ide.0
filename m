From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Mon, 13 Mar 2006 10:00:37 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B2DACA5@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751971AbWCMCCh@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
List-Id: linux-ide@vger.kernel.org

>width) Address=0000000023FDFFC0
>exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>width) Address=00000000000000B2
>exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 
>width) Address=0000000023FDFFC0
>exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 
>width) Address=0000000023FDFFC0
>exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 
>width) Address=0000000023FDFFC0
>exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>width) Address=00000000000000B2
>
>And then these above four lines (exregion-0185, -0185, -0185, -0290)
>repeat until I reboot.
>

If I understand correctly, it was due to  LEqual(S_AH, 0xA6) awlays
true.
SMM bios code didn't  respond , or respond correctly 
to the request by "store 0x81, APMD"  due to thermal module caused
issue?
I need the acpi trace log before _PTS to see what kind of thermal
related methods got called.

    Method (SMPI, 1, NotSerialized)
    {
        Store (S_AX, Local0)
        Store (0x81, APMD)
        While (LEqual (S_AH, 0xA6))
        {
            Sleep (0x64)
            Store (Local0, S_AX)
            Store (0x81, APMD)
        }
    }
