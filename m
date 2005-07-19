From: Kallol Biswas <kallol@nucleodyne.com>
Subject: RE: MSI question
Date: 19 Jul 2005 07:50:15 -0700
Message-ID: <1121784615.8967.13.camel@driver>
References: <C7AB9DA4D0B1F344BF2489FA165E502409337D9A@orsmsx404.amr.corp.intel.com>
Reply-To: kallol@nucleodyne.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([204.127.202.55]:18667 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261384AbVGSOxk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jul 2005 10:53:40 -0400
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502409337D9A@orsmsx404.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello Long,
          Here are the  steps I had followed:

1) Enabled MSI on the card, also programed the address and data
register.
2) Programmed the bridge  to accept the transaction to the address with
the data and convert them to a MSI interrupt.
3) Changed the pic_ack routine in kernel to acknowledge the MSI
interrupt indication.
4) Changed the isr to return IRQ handled always.

The  PCI-X bus analyzer showed that the card did generate the write
transaction for the interrupt.

The bridge converted the write and set a MSI interrupt indication
on its interrupt status register.

The driver isr got called, then the pic_ack routine cleared the MSI
interrupt indication on the bridge.

At this point, the card put more status to the memory, but no more
MSI transaction.

I did not get time to check if MSI got disabled on the adapter. Not
sure how to re-enable the MSI. I do not have access to the adapter's
manual. I will try to set the MSI enable bit again on config space.

Thanks for help,
Kallol

On Mon, 2005-07-18 at 10:37, Nguyen, Tom L wrote:
> On Saturday, July 09, 2005 5:08 PM, Kallol wrote:
> > The problem is that the card generates the MSI transaction only once.
> I
> > guess we have to enable the card to generate another MSI transaction 
> > again, right?
> 
> Have you verified whether the Promise adapter driver's interrupt service
> routine associated with MSI vector is called once the card generates the
> MSI? Does this driver handle MSI generated from its device
> appropriately? If yes, you can enable the card to generate another MSI
> transaction.
> 
> Thanks,
> Long
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

