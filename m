From: Christoph Hellwig <hch@lst.de>
Subject: Re: use pci_alloc_irq_vectors issues
Date: Mon, 17 Oct 2016 14:02:34 +0200
Message-ID: <20161017120234.GA14105@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com> <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com> <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com> <20161017103442.GA12240@lst.de> <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Thanks a lot!  I think the current check on when to fall back from
the multi-MSI to the single-MSI case is too narrow and we should
just always fall back.

Can you see if the patch below fixes your issue (revert the debug patch
first, please)?

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11c..b4b8004 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1436,13 +1436,6 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	}
 
 	/*
-	 * -ENOSPC indicated we don't have enough vectors.  Don't bother trying
-	 * a single vectors for any other error:
-	 */
-	if (nvec < 0 && nvec != -ENOSPC)
-		return nvec;
-
-	/*
 	 * If the host is not capable of supporting per-port vectors, fall
 	 * back to single MSI before finally attempting single MSI-X.
 	 */
