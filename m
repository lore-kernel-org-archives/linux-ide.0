From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 13:59:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040328205917.GF6405@bounceswoosh.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org> <40667734.8090203@yahoo.com.au> <20040328203357.GB6405@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040328203357.GB6405@bounceswoosh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org


Er, forgot about the queue depth of only 2...

Even in that case, you'll more than likely still get better throughput
with a single 32-MB command...  If you send a pair of queued commands
down, and the 2nd one is chosen, there's no reason that the first one
won't get starved until the very end of the request, which would have
bad latency on that command.

Even worse, would be it getting force-promoted in the middle of the
rest of the 32MB chunk due to an approaching internal timeout, and
therefore interrupting a 31-MB sequential read to do a 1MB read.

However, most of this is silly... 32 1MB requests will be way faster
than 32,000 1LBA requests, etc... in general, bigger requests = better
throughput for all but a few specific workloads that I can think of
off the top of my head.  (lots of simultaneous stream workloads with
very low latency requirements per-stream, for example)

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org
