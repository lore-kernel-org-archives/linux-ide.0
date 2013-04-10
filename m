From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: regarding your patch "AHCI: Support multiple MSIs"
Date: Wed, 10 Apr 2013 16:50:48 +0100
Message-ID: <5165A67802000078000CC2DD@nat28.tlf.novell.com>
References: <51659BDA02000078000CC288@nat28.tlf.novell.com>
 <20130410154202.GA2137@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:32983 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab3DJPut convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-ide@vger.kernel.org:3:1>);
	Wed, 10 Apr 2013 11:50:49 -0400
In-Reply-To: <20130410154202.GA2137@dhcp-26-207.brq.redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: mingo@elte.hu, jgarzik@redhat.com, linux-ide@vger.kernel.org

>>> On 10.04.13 at 17:42, Alexander Gordeev <agordeev@redhat.com> wrote:
> On Wed, Apr 10, 2013 at 04:05:30PM +0100, Jan Beulich wrote:
>> Alexander,
>> 
>> I'm a bit puzzled by the way ahci_init_interrupts() works, when
>> looking at a particular hardware implementation having 6 ports
>> but allowing up to 16 MSIs - obviously, with one IRQ per port,
>> obtaining 8 MSIs would be sufficient in this case, conserving on
>> resources. Is there any reason this can't be done (i.e. by the
>> caller of pci_enable_msi_block_auto() passing in the maximum
>> desired number)?
> 
> There are few points here.
> 
> 1. Some (all?) hardware implementations (i.e. Intel) have stupid
> logic that falls back to single MSI mode as if MRSM bit was set,
> in case # of allocated MSIs is less than # of available MSIs,
> even though # of allocated MSIs >= # of ports. I did not find any
> chips which could perform otherwise and stuck with this simpler
> mode for now.
> 
> 2. I did implement the approach you described - you can look at it
> in my earlier versions of the patchset. But I withdrew the change,
> since an update to the generic MSI code was needed, and it would be
> hard to convince people to accept changes that nobody consumes.
> 
> 3. If you aware of any hardware that is able sending multiple MSIs
> while the condition holds true:
> 	# of ports <= # of allocated MSIs < # of available MSIs
> ...I can revive my changes and post it upstream.

I'll have to see if I can check the two or three capable machines
I have, but considering what you describe I'm sure the same will
apply there. Thanks for explaining!

>> Besides that, would it be possible to tweak things so that
>> /proc/interrupts could show distinct names for the individual
>> IRQs?
> 
> I am not sure what do you mean here. Once a separate MSI vector is
> allocated to a port (to anything in fact) it will show up in
> /proc/interrupts as a distinct record.

They have separate lines, but all say just "ahci" at the end (as
opposed to e.g. all the USB consumed ones, which are nicely
distinguishable).

Jan

