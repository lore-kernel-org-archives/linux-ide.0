From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
Date: Tue, 01 Aug 2006 02:03:11 +0900
Message-ID: <44CE37CF.1010804@gmail.com>
References: <20060728134550.030a0eb8@werewolf.auna.net> <44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net> <44CE2908.8080502@gmail.com> <1154363489.7230.61.camel@localhost.localdomain> <20060731165011.GA6659@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030252AbWGaRDH@vger.kernel.org>
In-Reply-To: <20060731165011.GA6659@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magall?n" <jamagallon@ono.com>, "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Mon, Jul 31, 2006 at 05:31:29PM +0100, Alan Cox wrote:
>> Ar Maw, 2006-08-01 am 01:00 +0900, ysgrifennodd Tejun Heo:
>>> These are patches #110-112.  Andrew, can you drop those patches for the 
>>> time being?  I'm working on integrating those into libata #upstream now. 
>> If you drop the host_set and tuning patches please drop all the PATA
>> stuff and my other patches out. I don't have time to field a second
>> batch of hundreds of "why has my drive stopped working, why is the speed
>> wrong" emails. 
> 
> Didn't realize pata stuff relies on it.
> 
>> It'll be easier just to work outside the -mm tree with all this
>> continued in/out random breakage if people are just going to say "drop
>> xyz patch" rather than actually specifying *what is actually wrong* and
>> getting me to fix the merge (Tejun that last one sentence is a hint ;))
> 
> Okay, took the hint.  Magallon, can you please try the following
> patch?

Hit send a bit too fast.

Alan, the reason why the second port disappeared is a bug in 
init_legacy_mode().  probe_ent->n_ports is fxied to 1 and port_no gets 
incremented while initializing the second port ending up initializing 
part of the third port.

Another problem is that probe_ent/ap->hard_port_no are meaningless. 
hard_port_no is used to get port_no right on legacy cases where index of 
host_set->ports[] doesn't match the actual port_no.  When there is only 
one host_set, port_no should always equal hard_port_no.  For legacy 
hosts, the original code ended up assigning the wrong hard_port_no's.

I killed hard_port_no by s/ap->hard_port_no/ap->port_no/g without 
actually reviewing the usages (man, those are a LOT).  If all pata 
drivers always relied on ap->hard_port_no representing the actual port 
index in the controller, there shouldn't be a problem.  But, just in 
case, please review the change.

If this fixes Magallon's problem and you agree with the fix, I'll break 
it down to two patches and submit'em to you with proper heading and all.

Thanks.  :)

-- 
tejun
