From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for Nov 9 (build errors summary)
Date: Wed, 09 Nov 2011 11:23:21 -0800
Message-ID: <4EBAD329.1020309@xenotime.net>
References: <20111109135826.7f8270fb7151cf7939998942@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111109135826.7f8270fb7151cf7939998942@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, x86 maintainers <x86@kernel.org>, Greg KH <gregkh@suse.de>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
List-Id: linux-ide@vger.kernel.org

On 11/08/2011 06:58 PM, Stephen Rothwell wrote:
> Hi all,


1.  on i386, when CONFIG_SMP is not enabled:

arch/x86/built-in.o: In function `hpet_setup_msi_irq':
hpet.c:(.text+0x12114): undefined reference to `arch_setup_hpet_msi'
hpet.c:(.text+0x12123): undefined reference to `destroy_irq'
arch/x86/built-in.o: In function `hpet_msi_capability_lookup':
hpet.c:(.text+0x121fb): undefined reference to `create_irq_nr'
arch/x86/built-in.o:(.data+0x314): undefined reference to `native_setup_msi_irqs'
arch/x86/built-in.o:(.data+0x318): undefined reference to `native_teardown_msi_irq'
drivers/built-in.o: In function `dmar_set_interrupt':
(.text+0x6307a): undefined reference to `create_irq'
drivers/built-in.o: In function `dmar_set_interrupt':
(.text+0x630a3): undefined reference to `arch_setup_dmar_msi'
drivers/built-in.o: In function `dmar_set_interrupt':
(.text+0x630c0): undefined reference to `destroy_irq'
drivers/built-in.o: In function `free_dmar_iommu':
(.text+0x65e19): undefined reference to `destroy_irq'

2.  When ATA_SFF is enabled but ATA_BMDMA is not enabled:

drivers/ata/libata-sff.c: In function 'ata_pci_init_one':
drivers/ata/libata-sff.c:2538:3: error: implicit declaration of function 'ata_pci_bmdma_prepare_host'
drivers/ata/libata-sff.c:2549:40: error: 'ata_bmdma_interrupt' undeclared (first use in this function)

3.  on x86_64:

ERROR: "intel_iommu_gfx_mapped" [drivers/char/agp/intel-gtt.ko] undefined!

4.  when CONFIG_NET is not enabled:

drivers/staging/et131x/et131x.c:5489:12: error: 'et131x_pci_setup' undeclared here (not in a function)

patch should be in Greg's to-apply queue.



-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
