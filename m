From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13286] New: dma_timer_expiry: DMA status (0x21)
Date: Tue, 12 May 2009 20:46:31 +0200
Message-ID: <200905122046.31902.bzolnier@gmail.com>
References: <bug-13286-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:34010 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZELSmw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 14:42:52 -0400
Received: by bwz22 with SMTP id 22so154846bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 12 May 2009 11:42:52 -0700 (PDT)
In-Reply-To: <bug-13286-11633@http.bugzilla.kernel.org/>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

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
