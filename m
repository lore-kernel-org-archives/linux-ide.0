From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Fri, 25 Jun 2010 23:45:54 -0400
Message-ID: <4C2577F2.4030005@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C245E50.7090701@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

On 06/25/2010 03:44 AM, Tejun Heo wrote:
> I still think calling unexpect_irq() from ata_qc_complete() is correct
> as ata_qc_complete() is always a good indicator of completion events.

No, it's not.  ata_qc_complete() is an indicator that _one_ completion 
event occurred, not _all_ completion events for that port.

Converting drivers to use ata_qc_complete_multiple() completely misses 
the point:  ata_qc_complete_multiple() is doing exactly the same thing 
as those drivers:  calling ata_qc_complete() in a loop.

ata_qc_complete() is -- as its name implies -- completing a single qc. 
Your patch introduces an unconditional controller-wide unexpect_irq() 
call.  It's a layering violation.

You can trivially trace through ata_qc_complete_multiple() after patch 
#11 is applied, and see the result...  for $N completion bits passed to 
ata_qc_complete_multiple(), you call
	unexpect_irq()
	expect_irq()
in rapid succession $N times, once for each ata_qc_complete() call in 
the loop of ata_qc_complete_multiple().  For something that is not 
needed for modern SATA controllers.

The preferred solution would be something that only touches legacy 
controllers, namely:

*) create ata_port_complete(), with the implementation

	ata_qc_complete()
	unexpect_irq()

*) then call ata_port_complete() in the legacy code that needs 
unexpect_irq()

We don't want to  burden modern SATA drivers with the overhead of 
dealing with silly PATA/SATA1 legacy irq nastiness, particularly the 
ugliness of calling

	unexpect_irq() + expect_irq()

for a number of NCQ commands, in a tight loop!

	Jeff
