From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [PATCH] Export ahci eSATA attribute
Date: Fri, 12 Nov 2010 10:04:14 -0500
Message-ID: <4CDD576E.4070705@cfl.rr.com>
References: <4CDB63E7.1040106@cfl.rr.com> <4CDB79CA.6000606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exhub016-3.exch016.msoutlookonline.net ([207.5.72.226]:7222
	"EHLO EXHUB016-3.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932382Ab0KLPOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Nov 2010 10:14:14 -0500
In-Reply-To: <4CDB79CA.6000606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On 11/11/2010 12:06 AM, Jeff Garzik wrote:
> hmmm, I don't think we need a libata-wide flag just for an AHCI-specific
> attribute.  Certainly eSATA exists elsewhere, but so far this is just
> for print-out purposes, and so, seems wasteful.

Good point, and I actually realized that the bit in question is already
exposed via the ahci_port_cmd attribute, so never mind about the patch.
 I just need to figure out how to get udev to look at that bit in that
attribute and flag the disk as external in the udevdb now.
