From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 11:30:09 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40677C21.7070807@yahoo.com.au>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org> <40667734.8090203@yahoo.com.au> <20040328203357.GB6405@bounceswoosh.org> <20040328205917.GF6405@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:51864 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262536AbUC2BaM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 20:30:12 -0500
In-Reply-To: <20040328205917.GF6405@bounceswoosh.org>
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Eric D. Mudama wrote:

>
> Er, forgot about the queue depth of only 2...
>
> Even in that case, you'll more than likely still get better throughput
> with a single 32-MB command...  If you send a pair of queued commands
> down, and the 2nd one is chosen, there's no reason that the first one
> won't get starved until the very end of the request, which would have
> bad latency on that command.
>

Well strictly, you send them one after the other. So unless you
have something similar to our anticipatory scheduler or plugging
mechanism, the drive should attack the first one first, shouldn't
it?


