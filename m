From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [QUESTION] ATA: abnormal status 0x80 on port 0xCC07
Date: Wed, 7 Feb 2007 01:54:32 +0100
Message-ID: <6bffcb0e0702061654x4ed237c1mdb619b9ab513283c@mail.gmail.com>
References: <6bffcb0e0702031044v601e4fc3icf859544af292789@mail.gmail.com>
	 <45C8EAAD.5000905@googlemail.com>
	 <6bffcb0e0702061557r2ba51186ra33a428e1a1f051@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030481AbXBGAyf@vger.kernel.org>
In-Reply-To: <6bffcb0e0702061557r2ba51186ra33a428e1a1f051@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 07/02/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 06/02/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
[..]
> > I'll revert this patch.
> >
> > commit 7a0f1c8a4b1052da7efc7715e2e557255b632712
> > Author: Lennert Buytenhek <buytenh@wantstofly.org>
> > Date:   Mon Jan 29 13:28:47 2007 +0100
> >
> >     ata_if_xfermask() word 51 fix
> >
> >     If word 53 bit 1 isn't set, the maximum PIO mode is indicated by
> >     the upper 8 bits of word 51, not the lower 8 bits.  Fixes PIO mode
> >     detection on old Compact Flash cards.
> >
> >     Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> >     Signed-off-by: Jeff Garzik <jeff@garzik.org>
> >
>
> It's not this patch. Maybe this one?
>
> commit 49c8042996c84f0df6c49ea2e28a7ef38cd7d773
> Author: Brian King <brking@linux.vnet.ibm.com>
> Date:   Tue Jan 30 11:32:26 2007 -0600
>
>     libata: Initialize nbytes for internal sg commands
>
>     Some LLDDs, like ipr, use nbytes and pad_len to determine
>     the total data transfer length of a command. Make sure
>     nbytes gets initialized for internally generated commands.
>
>     Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cf70702..667acd2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1250,6 +1250,7 @@ unsigned ata_exec_internal_sg(struct ata
>
>                 ata_sg_init(qc, sg, n_elem);
>                 qc->nsect = buflen / ATA_SECT_SIZE;
> +               qc->nbytes = buflen;
>         }
>
>         qc->private_data = &wait;
>
> It has something to do with SCSI commands.

Kernel still hangs...

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
