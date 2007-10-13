From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: 2.6.23-mm1
Date: Sat, 13 Oct 2007 20:05:19 +0200
Message-ID: <64bb37e0710131105m7c64fca0kb71f3955170e8bec@mail.gmail.com>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	 <20071012013729.ada2127b.akpm@linux-foundation.org>
	 <64bb37e0710130101y7fb8e4c0lf214fd821e8305ed@mail.gmail.com>
	 <4710A407.3070000@garzik.org>
	 <64bb37e0710130503haa66d6eu93e75ecdc78ac866@mail.gmail.com>
	 <4710B7C5.5050403@garzik.org>
	 <64bb37e0710130732p303547e3n54cfa9dac34c53b5@mail.gmail.com>
	 <64bb37e0710130740u78613f83wbd4f43d073bbe13d@mail.gmail.com>
	 <64bb37e0710130813le68c48dve36f8473b197b84b@mail.gmail.com>
	 <47110500.8050503@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:62427 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762197AbXJMSFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 14:05:21 -0400
Received: by py-out-1112.google.com with SMTP id u77so2210235pyb
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 11:05:20 -0700 (PDT)
In-Reply-To: <47110500.8050503@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

On 10/13/07, Jeff Garzik <jeff@garzik.org> wrote:
> Torsten Kaiser wrote:
> > 3 boots, all worked. So I'm very sure that was the bug, but I will now
> > do a little load testing...
> >
> > The only strange thing about 2.6.23-mm1 is, that it takes ~4 second
> > more to boot.
>
> So, you basically applied the attached patch?
>
> Yeah, absence of qc_defer for an NCQ-capable chip would do it.

Yes. The system seems to work correctly now.

The only thing I noted during load testing (updating Gentoo ==
compiling and installing) was, that there seems to be memory leak.
After ~2h 2.5 of my 4Gb where gone. But there where to many things
going on to pinpoint it... (NFSv4 over eth1394?)

> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index cf5c85e..240a892 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -554,6 +554,7 @@ static const struct ata_port_operations nv_swncq_ops = {
>         .bmdma_start            = ata_bmdma_start,
>         .bmdma_stop             = ata_bmdma_stop,
>         .bmdma_status           = ata_bmdma_status,
> +       .qc_defer               = ata_std_qc_defer,
>         .qc_prep                = nv_swncq_qc_prep,
>         .qc_issue               = nv_swncq_qc_issue,
>         .freeze                 = nv_mcp55_freeze,
>
>
