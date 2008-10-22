From: Valerio Passini <valerio.passini@unicam.it>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Wed, 22 Oct 2008 16:45:22 +0200
Message-ID: <200810221645.22289.valerio.passini@unicam.it>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <20081022155025S.fujita.tomonori@lab.ntt.co.jp> <9ea470500810220427w30485f0fs5017c2da08fd1796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.unicam.it ([193.204.8.1]:35871 "HELO unicam.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751174AbYJVOqT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 10:46:19 -0400
In-Reply-To: <9ea470500810220427w30485f0fs5017c2da08fd1796@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org


> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 13265a8..6943462 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1251,8 +1251,14 @@ static void cdrom_do_block_pc(ide_drive_t
> *drive, struct request *rq)
>  		 */
>  		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
>  		if ((unsigned long)buf & alignment || rq->data_len & alignment
> -		    || object_is_on_stack(buf))
> +		    || object_is_on_stack(buf)) {
> +			printk(KERN_ERR "Disabling dma for ATA_PC, "
> +			       "queue_dma_alignment: 0x%x, q->dma_pad_mask: 0x%x,"
> +			       "buf: %p, rq->data_len: 0x%x, on_stack: %d\n",
> +			       queue_dma_alignment(q), q->dma_pad_mask, buf,
> +			       rq->data_len, object_is_on_stack(buf));
>  			drive->dma = 0;
> +		}
>  	}
>  }

Hi Boris, please send me patches already formatted to be applied by patch 
program, because the substitution of spaces with tabs and other indentation 
characters requires a lot of time and it has never worked (or explain me how 
to make it work :))

Anyhow, I have given a look to the patch compared to the original file. Is it 
possible to apply to plain 2.6.27 kernel? From a brief look, it is very 
different from 2.6.27 ide-cd.c file and maybe I need to download the 
development branch of the kernel with GIT to apply it or a more recent 
subversion like 2.6.27.2.

Waiting for you.

P.S: I have received messages from bugzilla, but I have subscribed to this 
mailing list on Fujita's suggestion just to ease communication. What do you 
prefer between bugzilla and linux-ide? 
