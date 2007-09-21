From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 2
Date: Fri, 21 Sep 2007 12:08:07 +0900
Message-ID: <46F33597.1000307@gmail.com>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org> <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070921025734.GA6434@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> On Fri, Sep 21, 2007 at 11:53:33AM +0900, Tejun Heo wrote:
> 
>> Maybe just letting both events in is the best idea.  It's not like two
>> duplicate events are gonna break anything and I don't think many vendors
>> are gonna implement separate mechanism when the default SATA phy based
>> one works.
> 
> Works for me. Unrelatedly, is it expected that the EH take some time 
> attempting to revalidate the port before finally deciding that the drive 
> has gone? I seem to lose 15 seconds or so to that, which is more 
> irritating on PATA systems where it tends to block the channel.
> 
> (Quite why HP put their hotswap optical drives on the same PATA channel 
> as the internal drive is somewhat beyond me, but...)

Yeah, that's the intended behavior.  SATA PHY link can break from time
to time (have ever seen a SATA storage box going through ECC testing?
PHY goes offline as soon as you begin to hit it with some EM pulses) and
you don't really wanna lose your root partition over power fluctuation.

I'm thinking about improving EH such that it doesn't hold up the bus for
the whole period.  It will be needed for PMP too.  However, for now,
that's the expected behavior.

Thanks.

-- 
tejun
