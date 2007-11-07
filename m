From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9320] New: PATA scan: ACPI Exception
 AE_AML_PACKAGE_LIMIT... is beyond end of object
Date: Wed, 7 Nov 2007 14:07:54 -0800
Message-ID: <20071107140754.becad267.akpm@linux-foundation.org>
References: <bug-9320-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38203 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758630AbXKGWIA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 17:08:00 -0500
In-Reply-To: <bug-9320-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, bruinjm@xs4all.nl, "Rafael J. Wysocki" <rjw@sisk.pl>

> On Wed,  7 Nov 2007 13:35:00 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=9320
> 
>            Summary: PATA scan: ACPI Exception AE_AML_PACKAGE_LIMIT... is
>                     beyond end of object
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: Linux version 2.6.24-rc2
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: acpi_other@kernel-bugs.osdl.org
>         ReportedBy: bruinjm@xs4all.nl
> 
> 
> Most recent kernel where this bug did not occur: 
>   I rebuild daily, if rebuild script does not fail. The last errorless boot
> was on october 29. The first boot after this was october 31
> 
> Distribution: slack
> Hardware Environment: 
> 
> VIA C7, CN700 IDE interface: VT82C586A/B/VT82C686/A/B/VT823x/A/C 
> Diskless PXE boot
> 
> Software Environment:
> Problem Description:
> 
> dmesg:
> ata3: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf900 irq 14
> ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf908 irq 15
> ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (0FFFFFFFF) is
> beyond end of object [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.PATA.GTM_]
> (Node c1c0b420), AE_AML_PACKAGE_LIMIT
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.PATA.CHN0._GTM] (Node c1c0b228), AE_AML_PACKAGE_LIMIT
> ata3: ACPI get timing mode failed (AE 0x300d)
> ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (0FFFFFFFF) is
> beyond end of object [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.PATA.GTM_]
> (Node c1c0b420), AE_AML_PACKAGE_LIMIT
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.PATA.CHN1._GTM] (Node c1c0b330), AE_AML_PACKAGE_LIMIT
> ata4: ACPI get timing mode failed (AE 0x300d)
> 

Seems to be another post-2.6.23 regression.  Is it an acpi thing or an ata
thing, of just something which the new acpi+ata stuff exposed??

