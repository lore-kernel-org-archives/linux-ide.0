From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH]: atiixp : Enabling UDMA5 on IXP200
Date: Thu, 13 Oct 2005 19:58:08 +0200
Message-ID: <58cb370e0510131058g23e956a8m7bb0a82d8f670ce6@mail.gmail.com>
References: <434A583D.2030401@seanodes.com> <434E79BC.308@seanodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:50653 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932143AbVJMR6M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Oct 2005 13:58:12 -0400
Received: by nproxy.gmail.com with SMTP id n15so182814nfc
        for <linux-ide@vger.kernel.org>; Thu, 13 Oct 2005 10:58:08 -0700 (PDT)
In-Reply-To: <434E79BC.308@seanodes.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Velu Erwan <erwan@seanodes.com>
Cc: linux-ide@vger.kernel.org

Hi,

I've seen your patch but I'm still thinking how to solve this problem
because we can't just check for PCI device ID as it is a PATA controller
(I guess that there is some PATA-SATA bridge on this particular
motherboard).  One possible fix is to check if device is SATA using
<linux/ata.h>:ata_id_is_sata() but I don't know how reliable it is,
I need to check both ATA and SATA specs).

Bartlomiej

On 10/13/05, Velu Erwan <erwan@seanodes.com> wrote:
> I've just sent this patch a few days ago but nobody seems to be
> interested in testing it nor integrating it.
> What could I do to help this process ?
> Regards,
> Erwan
