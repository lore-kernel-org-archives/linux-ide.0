From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: [PATCH] ata: pata_at91.c bugfix for initial_timing
 initialisation
Date: Mon, 28 Mar 2011 17:01:15 +0400
Message-ID: <1301317275.29670.3.camel@homepc>
References: <1301313545-22730-1-git-send-email-plyatov@gmail.com>
	 <4D906C40.6040104@ru.mvista.com>
Reply-To: plyatov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46511 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1C1NBV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2011 09:01:21 -0400
In-Reply-To: <4D906C40.6040104@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Dear Sergei and Eric,

It's so stupid from my side to send broken patch, but it happens :-)

Please, look at new my e-mails with subjects:
* "[PATCH v4 1/2] ata: pata_at91.c bugfix for initial_timing
initialisation"
* "[PATCH v4 2/2] ata: pata_at91.c bugfix for high master clock"

Best regards!
--
Igor Plyatov

> Hello.
> 
> Igor Plyatov wrote:
> 
> > The "struct ata_timing" must contain 10 members, but ".dmack_hold" member was
> > forgotten for "initial_timing" initialisation. This patch fixes such a problem.
> 
> > Signed-off-by: Igor Plyatov <plyatov@gmail.com>
> > ---
> >  drivers/ata/pata_at91.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> > diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> > index 0da0dcc..d1aaeb5 100644
> > --- a/drivers/ata/pata_at91.c
> > +++ b/drivers/ata/pata_at91.c
> > @@ -49,8 +49,9 @@ struct at91_ide_info {
> >  	void __iomem *alt_addr;
> >  };
> >  
> > -static const struct ata_timing initial_timing =
> > -	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
> > +static const struct ata_timing initial_timing = {
> > +	XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0
> > +};
> 
>     Frankly, I don't see any difference.
> 
> WBR, Sergei


