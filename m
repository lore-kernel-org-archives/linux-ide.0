From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Subject: RE: linux-2.4.28 released
Date: Wed, 24 Nov 2004 17:57:46 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF062D0B5@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:55968 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S262537AbUKXJBH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Nov 2004 04:01:07 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>

Sorry for not writing you soon.

Jeff Garzik wrote:

> >>PATA and SATA (DMA doesn't work for PATA, in split-driver 
> configuration),
> >>and there is no split-driver to worry about.
> >>
> >>I think there may need to be some code to prevent the IDE 
> driver from
> >>claiming the legacy ISA ports.
> > 
> > 
> > Its called "request_resource". If you want the resource 
> claim it. IDE will
> > be a good citizen.
> 
> That's what the quirk does.  libata still needs to find out 
> who obtained the resource, not blindly grab it (and fail).

I also think so. 

It may be unavoidable one that ata_piix does not work. 
But, it is a problem that a DMA transfer does not enable by piix. 
Don't you think so?
--
Haruo
