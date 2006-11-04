From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: recommendations for a *stable* sata card
Date: Sat, 04 Nov 2006 11:26:07 +0100
Message-ID: <1162635967.3603.18.camel@localhost>
References: <1161503045.29634.74.camel@localhost>
	 <87f94c370610231452v44e50535rff4345a8a5762207@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.first.fraunhofer.de ([194.95.169.2]:5115 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S965248AbWKDK0S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Nov 2006 05:26:18 -0500
Received: from webmail.hansenet.de (e178147051.adsl.alicedsl.de [85.178.147.51])
	(authenticated bits=0)
	by mail.first.fraunhofer.de (8.13.8/8.13.8) with ESMTP id kA4AQCPE051069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sat, 4 Nov 2006 11:26:13 +0100 (CET)
	(envelope-from kernel@nn7.de)
In-Reply-To: <87f94c370610231452v44e50535rff4345a8a5762207@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>

On Mon, 2006-10-23 at 17:52 -0400, Greg Freemyer wrote:
> On 10/22/06, Soeren Sonnenburg <kernel@nn7.de> wrote:
>         Dear all,
>         
>         do you think the issue below will be resolved in the near
>         future ? If
>         not I would better buy a new sata stand-a-lone card which is
>         known to
>         work flawlessly (including error corrections) - which one ?? 
>         
> For a stable / tested card see Tejun's reply
> 
> http://article.gmane.org/gmane.linux.ide/11760
> 
> Also see the status matrix at:
> http://linux-ata.org/driver-status.html#matrix
> 
> FYI: Tejun Heo has been the primary author of the major Error Handling
> rewrite that was introduced into the vanilla kernel with 2.6.18.

So I purchased a dawicontrol 154 (Sil3114) plugged it into the last
remaining pci slot. Although on the same irq as the promise controller
it survived 2 days of torture without *any* trouble. The very same test
done on a promise controller crashes this machine in minutes...

Simply don't use promise products if you need stability.

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
