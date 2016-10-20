From: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Thu, 20 Oct 2016 17:47:22 +0200
Message-ID: <20161020154722.GH22012@rric.localdomain>
References: <1473088905-27670-1-git-send-email-hch@lst.de>
 <1473088905-27670-2-git-send-email-hch@lst.de>
 <20160906163946.GB24268@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160906163946.GB24268@htj.duckdns.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: Auger Eric <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-ide@vger.kernel.org, dan.j.williamps@intel.com, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 06.09.16 12:39:46, Tejun Heo wrote:
> On Mon, Sep 05, 2016 at 05:21:45PM +0200, Christoph Hellwig wrote:
> > Use the new pci_alloc_irq_vectors API to allocate MSI-X and MSI vectors.
> > The big advantage over the old code is that we can use the same API for
> > MSI and MSI-X, and that we don't need to store the MSI-X vector mapping
> > in driver-private data structures.
> > 
> > This first conversion keeps the probe order as-is: MSI-X multi vector,
> > MSI multi vector, MSI single vector, MSI-X single vector and last a
> > single least legacy interrupt line.  There is one small change of
> > behavior: we now check the "MSI Revert to Single Message" flag for
> > MSI-X in addition to MSI.
> > 
> > Because the API to find the Linux IRQ number for a MSI/MSI-X vector
> > is PCI specific, but libahaci is bus-agnostic I had to a
> > get_irq_vector function pointer to struct ahci_host_priv.  The
> > alternative would be to move the multi-vector case of ahci_host_activate
> > to ahci.c and just call ata_host_activate directly from the others
> > users of ahci_host_activate.
> 
> Applied to libata/for-4.9 after pulling in the mainline.

Hm, this broke SATA on ThunderX. Log below.

I could not yet look into this closer but reverting this patch
helped:

 0b9e2988ab22 ahci: use pci_alloc_irq_vectors

-Robert




[   14.940982] ata1.00: qc timeout (cmd 0x27)
[   14.941017] ata2.00: qc timeout (cmd 0x27)
[   14.941021] ata2.00: failed to read native max address (err_mask=0x4)
[   14.941023] ata2.00: HPA support seems broken, skipping HPA handling
[   14.961969] ata1.00: failed to read native max address (err_mask=0x4)
[   14.968401] ata1.00: HPA support seems broken, skipping HPA handling
[   15.405004] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   15.437004] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   20.573007] ata2.00: qc timeout (cmd 0xef)
[   20.573037] ata1.00: qc timeout (cmd 0xef)
[   20.573041] ata1.00: failed to enable AA (error_mask=0x4)
[   20.573044] ata1: limiting SATA link speed to 3.0 Gbps
[   20.591691] ata2.00: failed to enable AA (error_mask=0x4)
[   20.597083] ata2: limiting SATA link speed to 3.0 Gbps
[   21.037003] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   21.043861] ata1.00: ATA-8: WDC WD5003ABYZ-011FA0, 01.01S03, max UDMA/133
[   21.050647] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   21.061007] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   21.067683] ata2.00: ATA-8: WDC WD5003ABYZ-011FA0, 01.01S03, max UDMA/133
[   21.074468] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   36.444979] ata1.00: qc timeout (cmd 0xef)
[   36.445011] ata2.00: qc timeout (cmd 0xef)
[   36.445014] ata2.00: failed to set xfermode (err_mask=0x4)
[   36.445016] ata2.00: disabled
[   36.445026] ata2: hard resetting link
[   36.465268] ata1.00: failed to set xfermode (err_mask=0x4)
[   36.470750] ata1.00: disabled
[   36.473718] ata1: hard resetting link
[   36.909003] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   36.915184] ata2: EH complete
[   36.941013] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   36.947196] ata1: EH complete
[   36.960294] Freeing unused kernel memory: 1024K (fffffe0001f70000 -
fffffe0002070000)

../..

[  161.266664] dracut-initqueue[624]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  161.793311] dracut-initqueue[624]: Warning: dracut-initqueue timeout
- starting timeout scripts
[  162.309073] dracut-initqueue[624]: Warning: dracut-initqueue timeout
- starting timeout scripts
