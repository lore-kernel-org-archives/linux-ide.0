From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver retries disk errors.
Date: Tue, 31 Aug 2004 15:12:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1093961570.597.2.camel@localhost.localdomain>
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268686AbUHaPR5@vger.kernel.org>
In-Reply-To: <20040831135403.GB2854@bitwizard.nl>
To: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2004-08-31 at 14:54, Rogier Wolff wrote:
> So, can we agree on: 
> 	- might be needed for 
> 		- Floppies?
> 		- MO drives
> 		- older drives

Other random stuff it saves our backside on we don't know about.

> How about we set the num-retries to 1, and increase to 8 for
> "weird devices" (floppy, MO), and older drives. 

Disagree. I want it robust. If you want to set low retry counts then
the user should do so for special cases like forensics.

> I do want to make the num_retries thing a configurable parameter,
> should the autodetect get it wrong: We get drives that we want to
> recover without the kernel-level retries...

Making it configurable is good, but I can't help feeling that this
belongs at the block layer - I wonder what Jens thinks, it might well
have to be done by the driver because only the driver knows enough but
the ioctl/config option ought to be common.

> (still: I argue that you need to consider a "retry-works" error as an
> early warning that your media is going bad, and you need to get your
> data off ASAP! If the kernel silently retries and succeeds, the user
> won't notice a thing and continue using the drive (or MO media) until
> the error becomes irrecoverable. I recommend we put the retry at the
> user level. As in "person behind keyboard".)

M/O media retries generally do the right thing and have the right
effect. If you want to know if your drive is failing use SMART and ask
the drive

Remember: Storage appliance not disk. Treat it like a storage
appliance and you'll get better results.

Alan
