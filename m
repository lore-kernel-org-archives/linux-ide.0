From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: [PATCH v2] ata: pata_at91.c bugfix for high master clock
Date: Sun, 12 Dec 2010 22:02:59 +0300
Message-ID: <1292180579.8737.12.camel@homepc>
References: <1292099846-24528-1-git-send-email-plyatov@gmail.com>
	 <4D04D2E2.20100@ru.mvista.com>
Reply-To: plyatov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D04D2E2.20100@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com, nicolas.ferre@atmel.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, christian.glindkamp@taskit.de, ryan@bluewatersys.com, pgsellmann@portner-elektronik.at
List-Id: linux-ide@vger.kernel.org

Dear Sergei,

> Hello.
> 
> On 11-12-2010 23:37, Igor Plyatov wrote:
> 
> > The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> > and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> > lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
> > does not detect ATA device.
> 
> > Signed-off-by: Igor Plyatov<plyatov@gmail.com>
> [...]

Please use more descriptive comments, because it is not clear what you
mean here. Maybe here you just cut a text...
It is so strange to cut such small amount of text and I does not have
any idea why here is "[...]" exists.

> > diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> > index 0da0dcc..a462405 100644
> > --- a/drivers/ata/pata_at91.c
> > +++ b/drivers/ata/pata_at91.c
> [...]

The same as above. Nobody are able to read you mind on the distance :-)

> > @@ -50,7 +52,7 @@ struct at91_ide_info {
> >   };
> >
> >   static const struct ata_timing initial_timing =
> > -	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
> > +	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 0, 600, 0};
> 
>     BTW, you haven't described this in the changelog...

Here is just a typo fixed for the ata_timing structure. This typo does
not have influence on the driver operation, but I do not like to leave
such a negligible problem as it is.

> WBR, Sergei

Best regards!
--
Igor Plyatov
