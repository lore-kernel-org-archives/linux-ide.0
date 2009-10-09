From: Christian Pernegger <pernegger@gmail.com>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Fri, 9 Oct 2009 04:22:47 +0200
Message-ID: <bb145bd20910081922t1bf6ec91m5a5c7b32d6f7722d@mail.gmail.com>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>
	 <4ACB3741.2030101@gmail.com> <1254852272.1471.172.camel@giskard>
	 <4ACBA33C.7090606@rtr.ca> <1254873978.1471.463.camel@giskard>
	 <1254879618.1471.525.camel@giskard> <4ACC076F.7020000@rtr.ca>
	 <1255020134.30440.698.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:5151 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760203AbZJICXy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Oct 2009 22:23:54 -0400
Received: by ey-out-2122.google.com with SMTP id 4so1391910eyf.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Oct 2009 19:22:47 -0700 (PDT)
In-Reply-To: <1255020134.30440.698.camel@giskard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bernie Innocenti <bernie@codewiz.org>
Cc: linux-ide@vger.kernel.org

> Our prayers have not been answered :-(
>
> I tried several things:

Since we seem to be in a similar boat, can you trigger the error only
via RAID resync or also via badblocks or somesuch on all disks in
parallel?

Thanks,

C.
