From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 0/4] pata_cmd64x: interrupt handling
Date: Sun, 11 Mar 2012 22:35:11 +0300
Message-ID: <4F5CFE6F.4040406@mvista.com>
References: <201203112217.30704.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54698 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab2CKSgB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2012 14:36:01 -0400
Received: by bkcik5 with SMTP id ik5so2118573bkc.19
        for <linux-ide@vger.kernel.org>; Sun, 11 Mar 2012 11:36:00 -0700 (PDT)
In-Reply-To: <201203112217.30704.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello.

On 03/11/2012 10:17 PM, Sergei Shtylyov wrote:

>     Here's long postponed series of patches to the 'pata_cmd64x' driver
> which should bring its interrupt handling code on the same "level"
> that the IDE 'cmd64x' driver has.

> Patch 1 prepares grounds for patch 2.
> Patch 2 is equivalent to the commit 66602c83dcb6a5d82772d88ae7a32cd4a1213528
> (cmd64x: use interrupt status from MRDMODE register (take 2)).
> Patch 3 is equivalent to the commit 30e5ffc368ff7d96fbc7a51ede10809642b0a6df
> (cmd64x: implement clear_irq() method (take 2)).
> Patch 4 is equivalent to the commit 628df2f33d99dace08838779d8a02bf1deaff100
> (cmd64x: implement test_irq() method).

    Looks like the server from which I sent patches got into black lists again, 
so Jeff wouldn't receive the patches into his mailbox. Please scan the list for 
them, Jeff, as the time for 3.4 merge window is nigh...

WBR, Sergei
