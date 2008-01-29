From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9845] New: libata still broken for Pegasos on
 2.6.24
Date: Tue, 29 Jan 2008 13:42:14 -0800
Message-ID: <20080129134214.69b7b5bc.akpm@linux-foundation.org>
References: <bug-9845-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41891 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987AbYA2VmZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 16:42:25 -0500
In-Reply-To: <bug-9845-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bugme-daemon@bugzilla.kernel.org, morgoth6@gmail.com

On Tue, 29 Jan 2008 12:56:37 -0800 (PST)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9845
> 
>            Summary: libata still broken for Pegasos on 2.6.24
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.24
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PPC-32
>         AssignedTo: platform_ppc-32@kernel-bugs.osdl.org
>         ReportedBy: morgoth6@gmail.com
> 
> 
> As 2.6.24 contains fix for pata_via on Pegasos I decide to give a try to this
> version. Unfortunatly it seems it is still broken. Quick look on dmesg from
> faulty boot shows both channels are configured to use IRQ 14 and this is not
> correct in this case.
> 
> ....
> ata1: PATA max UDMA/100 cmd 0x1000 ctl 0x100c bmdma 0x1020 irq 14^
> ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x101c bmdma 0x1028 irq 14^
> ....
> 
> libata works fine on 2.6.23 when using patch
> https://bugzilla.redhat.com/attachment.cgi?id=167747. Reported also
> https://bugzilla.redhat.com/show_bug.cgi?id=430802
> 

Gargh.  How does one go from
https://bugzilla.redhat.com/attachment.cgi?id=167747 back to the bug to
which it is attached?

