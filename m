From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pata_atiixp: Remove unnecessary parentheses
Date: Tue, 11 Sep 2018 14:49:28 -0700
Message-ID: <CAKwvOdmnF=jizgd5Trmm3HA3QhkxqmdBp0mVt03vTaeP3pXX9Q@mail.gmail.com>
References: <20180911214338.1109-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911214338.1109-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: b.zolnierkie@samsung.com, axboe@kernel.dk, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Sep 11, 2018 at 2:43 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
>
> drivers/ata/pata_atiixp.c:282:19: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/ata/pata_atiixp.c:282:19: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>            ~             ^                              ~
> drivers/ata/pata_atiixp.c:282:19: note: use '=' to turn this equality
> comparison into an assignment
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>                          ^~
>                          =

Yeah, I don't think assignment and conditional checking was implied here.
Thanks for the simple fix.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/ata/pata_atiixp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 4d49fd3c927b..843bb200a1ee 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -279,7 +279,7 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>         const struct ata_port_info *ppi[] = { &info, &info };
>
>         /* SB600 doesn't have secondary port wired */
> -       if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
> +       if (pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE)
>                 ppi[1] = &ata_dummy_port_info;
>
>         return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
