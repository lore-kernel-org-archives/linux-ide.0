From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9410] New: TOSHIBA MK1637GSX do spurious
 command completion
Date: Mon, 19 Nov 2007 14:14:38 -0800
Message-ID: <20071119141438.09cfd966.akpm@linux-foundation.org>
References: <bug-9410-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34448 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757526AbXKSWOw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 17:14:52 -0500
In-Reply-To: <bug-9410-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lakostis@altlinux.org
Cc: bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

On Mon, 19 Nov 2007 13:21:36 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9410
> 
>            Summary: TOSHIBA MK1637GSX do spurious command completion
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.24-rc2 GIT 8c0863403f109a43d7000b4646da4818220d501f
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: lakostis@altlinux.org
> 
> 
> Most recent kernel where this bug did not occur:
> Distribution: ALTLinux Sisyphus
> Hardware Environment: Dell Inspiron 1520 (see
> http://gentoo-wiki.com/HARDWARE_Dell_Inspiron_1520 for lspci and other details)
> Software Environment: i586 target build. src.rpm images with build config
> available on
> http://www.unsafe.ru/lakostis/RPMS/ALTLinux/kernel-2.6.24/SRPMS.hasher/kernel-image-wks-smp-2.6.24-alt0.4.src.rpm
> Problem Description: 
> 
> $ dmesg
> ....
> ata1.00: exception Emask 0x2 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata1.00: spurious completions during NCQ issue=0x0 SAct=0x1
> FIS=004040a1:00000020
> ata1.00: cmd 60/70:00:83:a6:f0/00:00:04:00:00/40 tag 0 cdb 0x0 data 57344 in
>          res 40/00:34:c3:a7:f0/00:00:04:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: EH complete
> sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> 
> information from smartctl:
> Device Model:     TOSHIBA MK1637GSX
> Serial Number:    77VBT1CRT
> Firmware Version: DL040D
> User Capacity:    160,041,885,696 bytes
> Device is:        Not in smartctl database [for details use: -P showall]
> ATA Version is:   7
> ATA Standard is:  Exact ATA specification draft version not indicated
> Local Time is:    Sun Nov 18 18:54:33 2007 MSK
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> Steps to reproduce:
> 
> compile recent vanilla kernel from GIT with libata support and install
> following drive to NCQ capable SATA controller.
> 
> 

Thanks.  Could you please send that backlisting patch via email to 

Jeff Garzik <jeff@garzik.org>
linux-ide@vger.kernel.org
Andrew Morton <akpm@linux-foundation.org>

?


