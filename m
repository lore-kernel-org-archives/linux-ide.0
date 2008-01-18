From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add enclosure management support
Date: Thu, 17 Jan 2008 20:55:50 -0500
Message-ID: <47900726.4000409@garzik.org>
References: <20080115164417.4a5e2789@appleyard> <1200610243.3255.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50600 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760099AbYARBzx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Jan 2008 20:55:53 -0500
In-Reply-To: <1200610243.3255.47.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-ide@vger.kernel.org

James Bottomley wrote:
> One of the things we really need to do is to get some type of generic
> enclosure support.  I note that ahci support three standard eclosure
> management protocols (SAF-TE, SES-2, SFF-8485 SGPIO) as well as the one
> proprietary one you've chosen to implement.  Is that because no-one in
> the field has actually connected AHCI up to anything supporting one of
> the standard protocols?

NVIDIA posted SGPIO support, FWIW...

	Jeff


