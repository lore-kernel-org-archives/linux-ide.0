From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Tue, 12 Jun 2007 23:11:18 +0400
Message-ID: <466EEFD6.9030001@ru.mvista.com>
References: <20070221011922.GA1777@freefall.freebsd.org> <200702210244.53514.bzolnier@gmail.com> <3063A690-4E3D-4A6E-A7DC-3E624121FBB8@freebsd.org> <200702210342.20775.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h151.mvista.com ([63.81.120.155]:38505 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750778AbXFLTJd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jun 2007 15:09:33 -0400
In-Reply-To: <200702210342.20775.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>>On Feb 20, 2007, at 5:44 PM, Bartlomiej Zolnierkiewicz wrote:

>>>On Wednesday 21 February 2007 02:19, Suleiman Souhlal wrote:

>>>>It can be changed via /proc/ide/hd?/settings.

>>>Why do we need to change IDE DMA timeout dynamically?

>>I've used it to test error recovery (for example).

> Seems quite useable for developers but I would prefer not to
> expose it in production kernels for end users.

    It seems that I have counter example of a customer asking if this timeout 
can be done configurable. :-)
    BTW, why the timeout is so damn long? 2*WAIT_CMD is 20 secs, and if DMA is 
not complete or interrupt pending, it may wait 10 more secs...

> Thanks,
> Bart

MBR, Sergei
