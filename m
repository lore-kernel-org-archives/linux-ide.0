From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [KJ] Re: [PATCH] drivers/ide/cs5520.c : Use the DMA_{64,
	32}BIT_MASK constants
Date: Thu, 10 Mar 2005 17:30:12 +0100
Message-ID: <58cb370e050310083053a0e495@mail.gmail.com>
References: <20050308133358.GA5311@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79057958929800565=="
In-Reply-To: <20050308133358.GA5311@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.osdl.org>
List-Help: <mailto:kernel-janitors-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=subscribe>
Sender: kernel-janitors-bounces@lists.osdl.org
Errors-To: kernel-janitors-bounces@lists.osdl.org
To: Tobias Klauser <tklauser@nuerscht.ch>
Cc: kernel-janitors@lists.osdl.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--===============79057958929800565==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Mar 2005 14:33:58 +0100, Tobias Klauser <tklauser@nuerscht.ch> wrote:
> Hello,

Hi,

> Description: Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h
> when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
> See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

only DMA_32BIT_MASK constant is used in the patch
 
> Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
> 
> --- linux-2.6.11.orig/drivers/ide/pci/cs5520.c  2005-03-02 12:50:39.000000000 +0100
> +++ linux-2.6.11/drivers/ide/pci/cs5520.c       2005-03-03 11:46:46.000000000 +0100
> @@ -227,7 +227,7 @@ static int __devinit cs5520_init_one(str
>                 return 1;
>         }
>         pci_set_master(dev);
> -       if (pci_set_dma_mask(dev, 0xFFFFFFFF)) {
> +       if (pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
>                 printk(KERN_WARNING "cs5520: No suitable DMA available.\n");
>                 return -ENODEV;
>         }

You need to include <linux/dma-mapping.h> explicitly
or build will fail for some architectures, i.e. please see:
http://linus.bkbits.net:8080/linux-2.5/cset@41d833427yYZzu6TxydNrr5z6f02cg?nav=index.html|src/|src/drivers|src/drivers/ide|related/drivers/ide/setup-pci.c

Bartlomiej

--===============79057958929800565==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/kernel-janitors

--===============79057958929800565==--
