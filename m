From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 08/12] ide: remove no longer needed IDE_HFLAG[_FORCE]_LEGACY_IRQS
Date: Mon, 19 Jan 2009 15:36:10 +0100
Message-ID: <9ea470500901190636g366767bt2b40917b2d2718f9@mail.gmail.com>
References: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
	 <20090119141443.27613.89085.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:48567 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZASOgL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:36:11 -0500
In-Reply-To: <20090119141443.27613.89085.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 19, 2009 at 3:14 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:

[.. ]

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1347,10 +1347,6 @@ enum {
>        IDE_HFLAG_ERROR_STOPS_FIFO      = (1 << 19),
>        /* serialize ports */
>        IDE_HFLAG_SERIALIZE             = (1 << 20),
> -       /* use legacy IRQs */
> -       IDE_HFLAG_LEGACY_IRQS           = (1 << 21),
> -       /* force use of legacy IRQs */
> -       IDE_HFLAG_FORCE_LEGACY_IRQS     = (1 << 22),
>        /* host is TRM290 */
>        IDE_HFLAG_TRM290                = (1 << 23),
>        /* use 32-bit I/O ops */

maybe contigious numbering of the enums here?

-- 
Regards/Gruss,
Boris
