From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Subject: RE: MSI question
Date: Mon, 18 Jul 2005 10:37:51 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502409337D9A@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:10124 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261326AbVGRRiE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2005 13:38:04 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kallol@nucleodyne.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Saturday, July 09, 2005 5:08 PM, Kallol wrote:
> The problem is that the card generates the MSI transaction only once.
I
> guess we have to enable the card to generate another MSI transaction 
> again, right?

Have you verified whether the Promise adapter driver's interrupt service
routine associated with MSI vector is called once the card generates the
MSI? Does this driver handle MSI generated from its device
appropriately? If yes, you can enable the card to generate another MSI
transaction.

Thanks,
Long
