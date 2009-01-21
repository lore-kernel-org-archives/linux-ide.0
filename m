From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata, devm_*, and MSI ?
Date: Wed, 21 Jan 2009 20:59:04 +0900
Message-ID: <49770E08.6040204@gmail.com>
References: <4975F5C1.8090107@rtr.ca>	 <da824cf30901200944x545431b2va0233abc14e81f9b@mail.gmail.com>	 <497614F5.6000301@rtr.ca> <da824cf30901201051v66ae13c4i3476097ee31db281@mail.gmail.com> <49762BF1.2050101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <49762BF1.2050101@rtr.ca>
Sender: linux-pci-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Grant Grundler <grundler@google.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Mark.

Sorry about slacking off.  Having way too much fun mucking around
assembly code lately.

Mark Lord wrote:
> I believe that other MSI users might want something similar,
> or perhaps Tejun could extend devres to include a pair
> of suitable functions, devm_enable_msi() and  devm_disable_msi().
> Then it would be just automatic for drivers, without any fuss.

devres does handle MSI.  Please take a look at pcim_release() in
drivers/pci/pci.c.  msi/msix enabledness is tracked by
pdev->msi[x]_enabled and if either one was enabled on a managed PCI
device, it would be disabled on driver detach, so there's no reason to
worry about it.

Also, there is no reason for low level driver to dingle with intx.  In
fact, it shouldn't as PCI quirk is supposed to handle all the pretty
quirkiness.  The intx code was there before the quirk code was in
place and no one went after them.  They should go and probably won't
cause any problem in the process.

Thanks.

-- 
tejun
