From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 21:02:24 +0300
Message-ID: <4974C030.5020509@ru.mvista.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>	<20090119130322.24745.76137.sendpatchset@localhost.localdomain>	<49748B95.9080105@ru.mvista.com>	<200901191523.15240.bzolnier@gmail.com>	<49748E43.4030009@ru.mvista.com> <20090119173701.13fd24c6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:58449 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbZASSBy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 13:01:54 -0500
In-Reply-To: <20090119173701.13fd24c6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>>[ I'm also not happy with the naming but couldn't think of a better one. ]

>>    Legacy perhaps?

> Legacy to most people means either ISA/VLB or the PCI legacy
> compatibility mode so that would be confusing.

    That's what this code is for (minus the MMIO accessors perhaps).

> BTW if you moved to ioreadX you could get rid of almost all the readb/inb
> special casing.

    And burden the driver code with function calls ISO in/out instructions, at 
least on x86. It's somewhat arguable move.

MBR, Sergei
