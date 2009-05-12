From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13286] dma_timer_expiry: DMA status (0x21)
Date: Tue, 12 May 2009 18:42:57 GMT
Message-ID: <200905121842.n4CIgvma012916@demeter.kernel.org>
References: <bug-13286-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43612 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbZELSm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 14:42:56 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4CIgvrQ012917
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2009 18:42:57 GMT
In-Reply-To: <bug-13286-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13286





--- Comment #1 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-05-12 18:42:56 ---
On Tuesday 12 May 2009 08:35:53 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13286
> 
>            Summary: dma_timer_expiry: DMA status (0x21)
>            Product: IO/Storage
>            Version: 2.5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: IDE
>         AssignedTo: io_ide@kernel-bugs.osdl.org
>         ReportedBy: fibre_optic@go2.pl
>         Regression: No
> 
> 
> Hello,
> 
> I have Dell Optiplex with ide->CF-Flash card interface. This configuration
> works well with 2.6.27.21 but it generates the following messages on 2.6.29.3:
> ...
> hda: dma_timer_expiry: DMA status (0x21)
> hda: DMA timeout error
> ...
> 
> Here you have more data, if you need something more please let me know.
> 
> PS
> 
> This issue takes place with 2.6.28 too.

Does 2.6.27.21 use DMA?

Is this system equipped with on-board IDE->CF adapter,
or is it an add-on one?

Does this adapter support DMA at the hardware level
(some adapters don't have DMA lines)?

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
