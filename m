From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] sata_dwc_460ex: fix burst transaction length
Date: Thu, 7 Apr 2016 20:37:59 +0300
Message-ID: <CAHp75VeDRY93cAzLtwf_er_jGvt8D4HAcNxQuywc8KhvaWjP1g@mail.gmail.com>
References: <1459982695-32394-1-git-send-email-chunkeey@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1459982695-32394-1-git-send-email-chunkeey@googlemail.com>
Sender: stable-owner@vger.kernel.org
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 7, 2016 at 1:44 AM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> According to DesignWare DW_ahb_dmac Databook page 159,
> both SRC_MSIZE and DEST_MSIZE values "are not related to
> AHB bus mater HBURST bus".
>
> The hardware uses these values as a unit of TR_WIDTHs.
> As both TR_WIDTHs are hardcoded to 4 Bytes, the MSIZEs
> should be 16, so the burst transaction length will be:
> 64 Bytes.

Thanks for the patch.

Yes, M=C3=A5ns and I have a branch [1] to bring this driver working bac=
k.
This change is there already.
I would appreciate if you can test this on bare metal.

[1] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fsata

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
>  drivers/ata/sata_dwc_460ex.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460e=
x.c
> index 2fc1516..52f0614 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -58,7 +58,8 @@
>  #define NO_IRQ         0
>  #endif
>
> -#define AHB_DMA_BRST_DFLT      64      /* 16 data items burst length=
*/
> +#define AHB_DMA_BRST_DFLT      64
> +#define BRST_TRANS_LEN_DFLT    16
>
>  enum {
>         SATA_DWC_MAX_PORTS =3D 1,
> @@ -381,8 +382,8 @@ static struct dma_async_tx_descriptor *dma_dwc_xf=
er_setup(struct ata_queued_cmd
>         }
>
>         sconf.direction =3D qc->dma_dir;
> -       sconf.src_maxburst =3D AHB_DMA_BRST_DFLT;
> -       sconf.dst_maxburst =3D AHB_DMA_BRST_DFLT;
> +       sconf.src_maxburst =3D BRST_TRANS_LEN_DFLT;
> +       sconf.dst_maxburst =3D BRST_TRANS_LEN_DFLT;
>         sconf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>         sconf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>
> --
> 2.8.0.rc3
>



--=20
With Best Regards,
Andy Shevchenko
