From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 10/15] ata: pata_pxa: remove the dmaengine compat need
Date: Tue, 24 Apr 2018 13:04:07 +0200
Message-ID: <2592887.EUCMT0tEEq@amdc3058>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
        <CGME20180421193220epcas1p37073b0047d529bcc888233af6200ae35@epcas1p3.samsung.com>
        <87sh7oxsn8.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sh7oxsn8.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday, April 21, 2018 09:32:11 PM Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > As the pxa architecture switched towards the dmaengine slave map, the
> > old compatibility mechanism to acquire the dma requestor line number and
> > priority are not needed anymore.
> >
> > This patch simplifies the dma resource acquisition, using the more
> > generic function dma_request_slave_channel().
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Bartlomiej, could I have your ack please ?

Sure.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
