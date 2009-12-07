From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates for 2.6.33
Date: Mon, 07 Dec 2009 11:39:31 -0500
Message-ID: <4B1D2FC3.4090003@garzik.org>
References: <20091206210752.GA19268@havoc.gtf.org> <4B1D02F9.4000503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:61936 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934829AbZLGQj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 11:39:26 -0500
In-Reply-To: <4B1D02F9.4000503@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On 12/07/2009 08:28 AM, Sergei Shtylyov wrote:
> Hello.
>
> Jeff Garzik wrote:
>
>> Nothing world-shakingly-notable. Notable notables:
>
>> - TRIM work from Christoph and mkp, to make SSD life a bit better
>> - PATA fixes and updates from Bart and Alan
>> - long overdue removal of 'experimental' tag from PATA driver submenu
>> in Kconfig
>> - various bug fixes and minor updates
>
>> Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>> upstream-linus
>
>> to receive the following updates:
>
> [...]
>
>> Alan Cox (6):
>> pata_via: Blacklist some combinations of Transcend Flash and via
>> pata_sis: Implement MWDMA for the UDMA 133 capable chips
>
> Unfortunately, this patch contains a coding mistake. Probably too late
> to correct it now though Linus hasn't pulled as yet...

Well, absence of a push does not necessarily imply absence of a pull :) 
  In fact it seems pretty normal these days that Linus collects a bunch 
of pull requests, and then pushes them out later all in one batch.

But we can revert, absolutely, given the feedback from you and Bart...

	Jeff




