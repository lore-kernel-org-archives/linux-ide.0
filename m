From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Mon, 16 Nov 2009 03:13:48 -0500
Message-ID: <4B0109BC.1020204@pobox.com>
References: <20091113192429.4dfc9c39@infradead.org>	<4AFFB65F.3020201@kernel.org>	<4AFFBB75.7050601@pobox.com>	<20091115094630.1785b5ca@infradead.org>	<4B004328.8060807@kernel.org>	<20091115102334.1396eea6@infradead.org>	<4B0047CB.5080509@kernel.org>	<20091115103313.4691924d@infradead.org>	<4B00B034.5010908@kernel.org>	<20091115180058.55caa36f@infradead.org>	<4B00B5D0.4010707@kernel.org> <20091115215531.23edcf5e@infradead.org> <4B00EDAC.4080904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35363 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbZKPIN6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 03:13:58 -0500
In-Reply-To: <4B00EDAC.4080904@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On 11/16/2009 01:14 AM, Tejun Heo wrote:
> Hello,
>
> Arjan van de Ven wrote:
>> sigh. so I moved all the generic logic generic, and left the ahci
>> specific code specific to ahci. I put the logic there where it was
>> easy to implement, and there where the other link power management
>> controls are (in sysfs). If that's not good enough, I'm out of my skills
>> in the libata world to be honest, and would like to ask you to implement
>> that instead. let me know what sysfs looks like and I'll adjust
>> powertop to it....
>
> The reason why we have sysfs attributes which should have been at link
> layer at host was that it originally was for ahci alpm which is host
> specific feature which got extended to something somewhat generic.
> Now another pm feature which should belong to link is added to host
> following the precedence.
>
> Then again, it's also true that nobody really cares about ATA PM
> features enough during past couple of years so I really don't want to
> prevent the feature you're trying to add.  It would be best if there's
> someone who would pick it up and implement proper infrastructure but
> well that doesn't seem to be happening anytime soon.
>
> So, I don't know.  That's the concern I have but I don't want to nack
> your change either.  One thing is at least make those functions take
> ata_link isntead of ata_port as there's nothing port specific about
> those.  Jeff, what do you think?

Well,

- these are link-level features
- libata lacks a link-level sysfs API
- we need a link-level sysfs API (ata_transport, anyone?)

The ugly alternative has always been to hack in something at the host level.

In term of internal data structures, the v3 patch putting the stats into 
struct ata_link is definitely the right thing to do.  I would also put 
the accounting_enabled variable in there, as non-AHCI implementations, 
polling or not, seem highly likely to need that.

	Jeff



