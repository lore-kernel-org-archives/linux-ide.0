From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 2
Date: Fri, 21 Sep 2007 04:12:45 +0100
Message-ID: <20070921031245.GA6628@srcf.ucam.org>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org> <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46F33597.1000307@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Sep 21, 2007 at 12:08:07PM +0900, Tejun Heo wrote:

> Yeah, that's the intended behavior.  SATA PHY link can break from time
> to time (have ever seen a SATA storage box going through ECC testing?
> PHY goes offline as soon as you begin to hit it with some EM pulses) and
> you don't really wanna lose your root partition over power fluctuation.

In this case we explicitly know that it's in response to a hotplug event 
(well, either that or the firmware is on impressive crack). Would it be 
possible to communicate that in order to avoid the revalidation?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
