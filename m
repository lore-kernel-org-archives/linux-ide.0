From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] ata_piix: improve combined mode handling
Date: Fri, 03 Mar 2006 15:53:24 -0500
Message-ID: <4408ACC4.2070907@pobox.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48530 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932210AbWCCUxb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 15:53:31 -0500
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org, Jason Gaston <jason.d.gaston@intel.com>

Tejun Heo wrote:
> I couldn't find datasheets for ESB2 and ICH8, so I assumed ESB2 is
> similar to ICH6, ICH8 to ICH6 and ICH8M to ICH6M.  Is this correct?

That would be my guess.  Best bet would be to email Jason Gaston (CC'd), 
as he's the person who has been submitted PCI ID patches from Intel.


> Jeff, I'm trying to implement SCR access on ICH6/7's on top of these
> changes and have a question about libata-bmdma.c::ata_pci_init_one().
> ata_piix needs its own version of this function as it should try to
> map ABAR for SCR (and fall back if it fails), so I'm trying to factor
> functions out of ata_pci_init_one() and call them from ata_piix.
> 
> ata_pci_init_one() currently uses two separate probe_ent for each port
> if the controller is in legacy mode, which makes the ports use
> separate host_set and thus separate spin locks.  Do they need to use
> separate spinlocks?  Or are there other reasons legacy initialization
> is done this way?

They are two totally independent ports and irqs, when in legacy mode.  I 
would turn that question around on you:  why do you feel the need to 
serialize two independent irqs with a single spinlock?  ;-)

On a side note, if you are poking in this area, also consider a related 
problem:  PATA ports on SATA controllers.  Promise, SiS, ULi and VIA all 
need some way to support programming the PATA port, but right now the 
probe_ent/port_info stuff makes it difficult to have two separate 
classes of ports, with two vastly different capabilities.


> Oh.. Another question.  When you were talking about getting PCS bits
> wrong before [3], were you talking about port map (like port 1 and 3
> map to primary master/slave) or is there something else PCS + MAP
> doesn't cover?

In the ICH6 and ICH7 docs, both PCS and MAP registers are peppered with 
"(mobile only)" and "(desktop only)" comments.

	Jeff


