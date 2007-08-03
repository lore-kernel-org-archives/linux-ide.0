From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH -mm] libata: add human-readable error value decoding v3
Date: Fri, 03 Aug 2007 19:18:55 -0400
Message-ID: <46B3B7DF.2070302@redhat.com>
References: <46B36D59.7060803@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763651AbXHCXTC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Aug 2007 19:19:02 -0400
In-Reply-To: <46B36D59.7060803@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>

On 08/03/2007 02:00 PM, Robert Hancock wrote:
> This adds human-readable decoding of the ATA status and error registers
> (similar to what drivers/ide does) as well as the SATA Serror register to
> libata error handling output.  This prevents the need to pore through
> standards documents to figure out the meaning of the bits in these
> registers when looking at error reports.  Some bits that drivers/ide
> decoded are not decoded here, since the bits are either command-dependent
> or obsolete, and properly parsing them would add too much complexity.
> 

This is really nice.

Maybe make it configurable, though?
