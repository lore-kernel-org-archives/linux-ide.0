From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] aec62xx: kill speedproc() method wrapper (take
 2)
Date: Sat, 09 Jun 2007 14:05:00 +0400
Message-ID: <466A7B4C.2010509@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200705282244.54862.bzolnier@gmail.com> <46657E21.8090804@ru.mvista.com> <200706081422.10662.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:7271 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750808AbXFIKDO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 06:03:14 -0400
In-Reply-To: <200706081422.10662.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>There's no reason to have the speedproc() method wrapper for the two quite
>>>>different chip families, so just get rid of it.

>>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>>---
>>>>Tthis version of the patch properly installs the speedproc() method.
>>>>Again, the patch has only been compile tested...

>>>applied after fixing the following trivial reject (not a problem
>>>but I thought I would let you know in case I missed something):

>>    Yes, you did. I've also recast the patch killing init_dma() method. Do I 
>>need to resend it?

> Please do.

    Just have resent it privately.

MBR, Sergei
