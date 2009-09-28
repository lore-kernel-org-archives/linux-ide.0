From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Mon, 28 Sep 2009 16:36:08 -0400
Message-ID: <4AC11E38.4050703@garzik.org>
References: <20090917204935.GA7432@havoc.gtf.org> <200909202305.06199.bzolnier@gmail.com> 	<8b5805ff0909211936s4968d11fnd3e6604d38e31c79@mail.gmail.com> 	<200909281734.11090.bzolnier@gmail.com> <8b5805ff0909281320x57660c0cvb6e72290c6781a99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44432 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbZI1UgL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Sep 2009 16:36:11 -0400
In-Reply-To: <8b5805ff0909281320x57660c0cvb6e72290c6781a99@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jung-Ik (John) Lee" <jilee@google.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@google.com>, Gwendal Gringo <gwendal@google.com>

On 09/28/2009 04:20 PM, Jung-Ik (John) Lee wrote:
>> Thanks, your patch looks good to me but since there are still some
>> leftover issues left we would also need something like the incremental
>> patch below:
>
> [resending - bounced back from -ide, -kernel]
>
> your patch below looks good to me.


By convention, you should reply to a patch such as Bart's, and provide 
an explicit line of text that may be pasted into the patch at merge time:

Acked-by: Your Name <your@email.address>

