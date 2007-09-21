From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 2
Date: Fri, 21 Sep 2007 03:57:34 +0100
Message-ID: <20070921025734.GA6434@srcf.ucam.org>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org> <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46F3322D.5090407@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Sep 21, 2007 at 11:53:33AM +0900, Tejun Heo wrote:

> Maybe just letting both events in is the best idea.  It's not like two
> duplicate events are gonna break anything and I don't think many vendors
> are gonna implement separate mechanism when the default SATA phy based
> one works.

Works for me. Unrelatedly, is it expected that the EH take some time 
attempting to revalidate the port before finally deciding that the drive 
has gone? I seem to lose 15 seconds or so to that, which is more 
irritating on PATA systems where it tends to block the channel.

(Quite why HP put their hotswap optical drives on the same PATA channel 
as the internal drive is somewhat beyond me, but...)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
