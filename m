From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Sat, 26 Jun 2010 05:16:01 -0400
Message-ID: <4C25C551.8000404@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C2577F2.4030005@garzik.org> <4C25BAD2.4070705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C25BAD2.4070705@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

On 06/26/2010 04:31 AM, Tejun Heo wrote:
> Well, it can indicte the start of cluster of completions, which is the
> necessary information anyway.  From the second call on, it's a simple
> flag test and return.  I doubt it will affect anything even w/ high
> performance SSDs but please read on.

Yes, and your patch calls unexpect_irq() at the _start_ of a cluster of 
completions.  That is nonsensical, because it reflects the /opposite/ of 
the present ATA bus state, when multiple commands are in flight.


> ata_qc_complete_multiple() call [un]expect_irq() only once by
> introducing an internal completion function w/o irq expect handling,
> say ata_qc_complete_raw() and making both ata_qc_complete() and
> ata_qc_complete_multiple() simple wrapper around it w/ irq expect
> handling.

Yes, this fixes problem, but it is better to create a wrapper path for 
the legacy PATA/SATA1 that uses irq-expecting, and a fast path for 
modern controllers that do not use it.


> On 06/26/2010 05:45 AM, Jeff Garzik wrote:
>> We don't want to  burden modern SATA drivers with the overhead of
>> dealing with silly PATA/SATA1 legacy irq nastiness, particularly the
>> ugliness of calling
>
> I think we're much better off applying it to all the drivers.  IRQ
> expecting is very cheap and scalable and there definitely are plenty
> of IRQ delivery problems with modern controllers although their
> patterns tend to be different from legacy ones.  Plus, it will also be
> useful for power state predictions.

Modern SATA/SAS controllers, and their drivers, already have well 
defined methods of acknowledging interrupts, even unexpected ones, in 
ways that do not need this core manipulation.  This is over-engineering, 
punishing all modern chipsets moving forward regardless of their design, 
by unconditionally requiring this behavior of all libata drivers.

Just like the rest of libata's layered driver architecture, it should be 
straightforward to apply this only to SFF/BMDMA chipsets, then tackle 
odd cases as needs arise.

Modern controllers acknowledge interrupts sanely, and always "expect" an 
interrupt when you include interrupt events like hotplug, even if the 
ATA bus itself is idle.  There is no need to burden the millions of ahci 
users with irq-expecting, for example.

With regards to power state predictions, it is only useful if you are 
accurately reflecting the ATA bus state (idle or not) at all times.  As 
mentioned above, this patch clearly creates a condition where 
unexpect_irq() is called when commands remain in flight, and libata is 
expecting further command completions.

IOW, patch #11 says "we are not expecting irq" when we are.

At least a halfway sane approach would be to track bus-idle status, and 
trigger useful code when that status changes (idle->active or 
active->idle).  Perhaps LED, power state, and irq-expecting could all 
use such a triggering mechanism.

	Jeff
