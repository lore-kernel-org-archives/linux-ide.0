From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Subject: Re: [PATCH] speed up SATA
Date: Sat, 27 Mar 2004 21:40:29 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040328044029.GB1984@bounceswoosh.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:11438 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262100AbUC1Ej6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 23:39:58 -0500
Content-Disposition: inline
In-Reply-To: <40661049.1050004@yahoo.com.au>
List-Id: linux-ide@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sun, Mar 28 at  9:37, Nick Piggin wrote:
>I think 32MB is too much. You incur latency and lose
>scheduling grainularity. I bet returns start diminishing
>pretty quickly after 1MB or so.

32-MB requests are the best for raw throughput.

~15ms to land at your target location, then pure 50-60MB/sec for the .5
seconds it takes to finish the operation. (media limited at that point)

Sure, there's more latency, but I guess that is application dependant.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

