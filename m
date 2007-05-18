From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Fri, 18 May 2007 22:39:05 +1000 (EST)
Message-ID: <830792.81640.qm@web52605.mail.re2.yahoo.com>
References: <46482771.4080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52605.mail.re2.yahoo.com ([206.190.48.208]:46342 "HELO
	web52605.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752330AbXERMjI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 May 2007 08:39:08 -0400
In-Reply-To: <46482771.4080602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:
> Srihari Vijayaraghavan wrote:
> > --- Tejun Heo <htejun@gmail.com> wrote:
[...]
> > Can the Skymaster S3132, based on Sil3132,
> > (http://umart.net/au/product_info.php?cPath=21_211&products_id=106108) do
> 64
> > bit DMA on Linux?
> 
> Yeah, sil3124/32 can do 64bit alright.

Sorry, I couldn't quite convince myself wasting a little bit of money on that.
Temptation is hard to resist though.

> Maybe you can cc the ATI person here if you know the address.

Will do. Need to write a good story :-).
 
> > PS: FWIW, SB600 with your ahci fix has been working fine for the past
> week.
> > Thank you for that.
> 
> Great.

(I got the clue from yours, thanks for that) Actually, here's a crude one I'm
using for 2.6.22-rc:
--- a/drivers/ata/ahci.c        Thu May 17 20:02:36 2007 -0700
+++ b/drivers/ata/ahci.c        Fri May 18 22:17:27 2007 +1000
@@ -1563,6 +1563,7 @@ static int ahci_configure_dma_masks(stru
 static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
 {
        int rc;
+       using_dac = 0;

        if (using_dac &&
            !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {



      ___________________________________________________________________________________
How would you spend $50,000 to create a more sustainable environment in Australia?  Go to Yahoo!7 Answers and share your idea.
http://advision.webevents.yahoo.com/aunz/lifestyle/answers/y7ans-babp_reg.html

