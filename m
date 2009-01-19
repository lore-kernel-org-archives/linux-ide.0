From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 22:53:11 +0300
Message-ID: <4974DA27.90709@ru.mvista.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain> <4974CA81.1050506@ru.mvista.com> <20090119184951.35a52184@lxorguk.ukuu.org.uk> <200901192012.51422.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:60719 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752624AbZASTwj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 14:52:39 -0500
In-Reply-To: <200901192012.51422.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>    Tried looking at how in*()/out*() are defined on x86?

>>Tried looking at how ide_mm_inb is defined on x86

>>>>It's already making function calls, without the benefit of inlining and

>>>    I'm afraid you're wrong here.

>>I'm afraid you are the one who is wrong. The IDE layer is duplicating a
>>generic level of indirection with its own code - purely because IDE
>>pre-dates that core functionality. The whole IDE layer indirection can go
>>away because Linux has caught up with the needs of the IDE layer.

> I wish it would be so simple as I would have removed the said indirection
> long time ago.  Unfortunately:

> - not all archs support ioread() & co.

> - there is still issue with cache aliasing on some CPUs

    Yep, look at MIPS for an example.

> Thanks,
> Bart

MBR, Sergei
