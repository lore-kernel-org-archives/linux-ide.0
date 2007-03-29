From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [3/6] 2.6.21-rc4: known regressions
Date: Thu, 29 Mar 2007 15:33:35 -0700
Message-ID: <200703291533.38002.david-b@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703281359.29009.david-b@pacbell.net> <200703282327.56132.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200703282327.56132.maximlevitsky@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Maxim <maximlevitsky@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, gregkh@suse.de, Ingo Molnar <mingo@elte.hu>, Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, jgarzik@pobox.com, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-ide@vger.kernel.org

On Wednesday 28 March 2007 2:27 pm, Maxim wrote:
> On Wednesday 28 March 2007 22:59:26 David Brownell wrote:

> 	When HPET is active it eats RTC IRQ,

Only when HPET timers 0 and 1 are set up for "Legacy Replacement Mode".
In the more sensible "Standard Mode", they have their own IRQs.


> 	So the only way out is to emulate RTC using HPET,
> 	It is done this way in old rtc driver, rtc-cmos should do the same.

No.  Patches like

  http://marc.info/?l=linux-kernel&m=117219531503973&w=2

should be merged (I hope they're in the 2.6.22 queue!), making
HPET run in "Standard Mode" so that HPET can stop sticking its
fingers in code where they don't belong.


> 	I am also planning to add support of HPET and suspend/resume
> 	for rtc-cmos, but I didn't start this yet. 

It's already got suspend/resume support, and in the 2.6.22 queue
are RTC framework updates which will let the RTC framework replace
a lot more platform-specific RTC support.  (Platform changes can come
later, where they're needed.  ARM for example doesn't need any.)

Once HPET stops using "Legacy Replacement Mode" you won't need to
touch anything in the RTC stack (except maybe the legacy char/rtc.c
driver, removing HPET stuff).

The open issue with suspend/resume support in rtc-cmos relates to
how ACPI wakeup alarms should trigger.  I've not made time to test
those patches.

- Dave
