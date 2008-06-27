From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata and DMA quirks
Date: Fri, 27 Jun 2008 09:54:54 +0100
Message-ID: <20080627095454.665b7229@lxorguk.ukuu.org.uk>
References: <1214548895.8011.526.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40869 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751283AbYF0JMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 05:12:47 -0400
In-Reply-To: <1214548895.8011.526.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

> a) =EF=BB=BFFor any ATAPI DMA, If the transfer size is not a multiple=
 of 16
> bytes, switch to PIO for this command.

Old IDE does this internally. Tejun has done a lot of this stuff for th=
e
ATAPI layer in libata. See the check_atapi_dma method (example at
it821x_check_atapi_dma with a size rule)

> b) Double buffer all ATAPI DMA reads. They allocate a 128K DMA buffer
> and limit all requests to 128K. Then, they route all incoming DMAs to
> that buffer and copy back to the original buffer on completion.

That seems pretty icky. For overrun space on the standard SFF controlle=
rs
we just tack padding on the end of the DMA sg list.

> The comments in the code seem to indicate this has to do with "alignm=
ent
> restrictions", unfortunately, I have no more infos so I don't know wh=
at
> the actual underlying HW issues are.

Quite a bit of hardware has rules about the internal FIFO being fed in
internal burst sized chunks, especially older devices. For ATA that isn=
't
usually a problem, for ATAPI it is.

> I could use some tips as to how to implement these in the libata driv=
er.
> For a) I'm not sure about either overriding qc_prep or qc_issue and w=
hat
> would be the consequence of changing tf.protocol there ? Among others=
,

You can't just change the protocol, you must change the command issued.

> For b) I should be able to completely hide that within my qc_prep and
> completion, by silently using a different DMA target. I suppose I can
> use tf.command =3D=3D ATA_CMD_ID_ATAPI to differenciate with ATA comm=
ands.

if (ata_is_atapi(prot))

> How do I set the max request size with the block layer tho from a lib=
ata
> sub-driver ?

Set max_sectors for the disk in your dev_config method

See it821x_dev_config for a simple example

