From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: make ide_pci_check_iomem() actually work
Date: Tue, 08 Apr 2008 16:38:31 +0400
Message-ID: <47FB6747.2050301@ru.mvista.com>
References: <200804072027.17520.sshtylyov@ru.mvista.com> <200804072246.40223.bzolnier@gmail.com> <47FB5ADF.20608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:40018 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751653AbYDHMjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 08:39:12 -0400
In-Reply-To: <47FB5ADF.20608@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hi, I just wrote:

>>> This function didn't actually check if a given BAR is in I/O space 
>>> because of
>>> using the bogus PCI_BASE_ADDRESS_IO_MASK (which equals ~3) to test 
>>> the resource
>>> flags instead of IORESOURCE_IO -- fix this, make ide_hwif_configure() 
>>> check the
>>> results failing if necessary, and move the printk() call to the 
>>> failure path.

>> This change is OK in itself but I worry that ide_pci_check_iomem() may 
>> now
>> return "false" errors (bogus PCI_BASE_ADDRESS_IO_MASK check resulted 
>> in MEM
>> resources always surviving ide_pci_check_iomem() calls before the fix) 
>> for
>> some host drivers (siimage, scc_pata...) resulting in failed 
>> initialization.

>    The SiI chips do have normal I/O resources at BAR0..BAR3. As for 
> scc_pata, the control should not even get there because BAR0..BAR3 are 
> *not* IDE command/control block bases on this chip (BAR0/1 are 
> control/DMA bases if you look into setup_mmio_scc()) but they are 
> treated as such by the code immediately following ide_pci_check_iomem() 
> calls in ide_hwif_configure(), i.e. we might have an error here. The 
> same can be said about the PowerMAC driver which has all its MMIO 
> registers at BAR0.

>> How's about removing this dead/broken function instead for now?

>    If we indeed have a MMIO problem here, it's not in this function but 
> in its callers.

     Looks like we actually have this problem with scc_pata -- it calls 
ide_setup_pci_device() which should lead to calling ide_hwif_configure(). But 
this is broken since this call chain expects a normal PCI IDE controller with 
BAR0..BAR3 either non-existant or being primary/secondary port bases in I/O space.

>> Thanks,
>> Bart

>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

WBR, Sergei
