From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Fastboot revisited: Asynchronous function calls
Date: Mon, 5 Jan 2009 13:21:45 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901051317450.3057@localhost.localdomain>
References: <20090104092430.7ffd2c41@infradead.org> <alpine.LFD.2.00.0901041009060.3179@localhost.localdomain> <20090104103104.6fdda9f2@infradead.org> <alpine.LFD.2.00.0901041038570.3179@localhost.localdomain> <20090104110559.306186c4@infradead.org>
 <20090105162125.093b4adf@lxorguk.ukuu.org.uk> <20090105131350.66408a4f@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20090105131350.66408a4f@infradead.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, mingo@elte.hu, fweisbec@gmail.com, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org



On Mon, 5 Jan 2009, Arjan van de Ven wrote:
>
> ok I had that enabled somehow....

Well, it's not just "somehow".

It's the x86 def_config value, and it's also the default in at least the 
Fedora kernels.

Probably for a very good - although these days probably historical - 
reason: on older hardware, it really wasn't all that unusual to have the 
serial port at other interrupts.

And Alan may point to the help text, but that doesn't really matter since 
everybody clearly ignores it, and it's not what has been tested.

But yeah, we probably should disable it at least for modern machines. And 
even if it doesn't autodetect the irq, "setserial" hopefully still does 
work (and was always required for some machines anyway)

			Linus
