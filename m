From: "Grant Grundler" <grundler@google.com>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140, simg 3726
Date: Mon, 4 Aug 2008 13:59:48 -0700
Message-ID: <da824cf30808041359t2047a1abj50ddc4c984509c3@mail.gmail.com>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com>
	 <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org>
	 <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com>
	 <48926F7E.1020807@kernel.org> <48930B2E.9060604@pobox.com>
	 <489336E0.7020409@kernel.org>
	 <788014650808021053y5b5a8e01y62099464cc96d8a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:10926 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866AbYHDVAn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 17:00:43 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id m74L0Eeh009591
	for <linux-ide@vger.kernel.org>; Mon, 4 Aug 2008 22:00:16 +0100
Received: from rv-out-0708.google.com (rvbf25.prod.google.com [10.140.82.25])
	by wpaz13.hot.corp.google.com with ESMTP id m74KxGIh021236
	for <linux-ide@vger.kernel.org>; Mon, 4 Aug 2008 14:00:06 -0700
Received: by rv-out-0708.google.com with SMTP id f25so2602416rvb.18
        for <linux-ide@vger.kernel.org>; Mon, 04 Aug 2008 13:59:48 -0700 (PDT)
In-Reply-To: <788014650808021053y5b5a8e01y62099464cc96d8a4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org

On Sat, Aug 2, 2008 at 10:53 AM, KueiHuan Chen <kueihuan.chen@gmail.com> wrote:
> 2008/8/2 Tejun Heo <tj@kernel.org>:
>> Mark Lord wrote:
>>> I have exactly zero documentation on those chips,
>>> but they are supposedly AHCI compliant.
>>>
>>> Looking in drivers/ata/ahci.c, one can see that the chips are indeed
>>> supported,
>>> and there the AHCI_HFLAG_NO_PMP is *not* set, so one might expect them
>>> to work
>>> with a port-multiplier already.  ?
>>
>> I bet it's more like nobody tried yet.  :-P

I don't think we have. Patch I just posted won't
address this issue either.

grant

>
>
>  Thanks for your explaining, i had tried it already.
>
>  Port multiplier of Silicon image 3726 is not supported from 2.6.24 to
> 2.6.26 with 6121 and 6145 which using ahci.c  : (
>
>  Here is the test envirement:
>
>  Port Multipiler : Silicon image 3726. (Marvell 4140 is not fully
> tested, so i don't listed, but it is the same in arm arch.)
>
>  arch/kernel   2.6.24        2.6.25       2.6.26
>
>  arm            Not Work   Not tested   Not tested
>
>  powerpc     Not Work   Not tested   Not tested
>
>  x86_64       Not Work   Not Work     Not Work
>
>
>  Should we need disable 6121/6145 pmp support in ahci.c until it is
> fully supported?
>
> Thanks a lot.
> --------------------
>
>  Temporal disable pmp support in 6121/6145 until it is fully supported.
>
> Signed-off-by: KueiHuan Chen <khchen@synology.com>
> ---
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ef3e552..ef65ac0 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -420,7 +420,7 @@ static const struct ata_port_info ahci_port_info[] = {
>        /* board_ahci_mv */
>        {
>                AHCI_HFLAGS     (AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_MSI |
> -                                AHCI_HFLAG_MV_PATA),
> +                                AHCI_HFLAG_MV_PATA | AHCI_HFLAG_NO_PMP),
>                .flags          = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>                                  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
>                .pio_mask       = 0x1f, /* pio0-4 */
>
>
> ---
> Thanks,
> KueiHuan-Chen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
