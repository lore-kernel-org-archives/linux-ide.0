From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: kill old private BMDMA helper functions
Date: Fri, 23 Feb 2007 05:37:25 -0500
Message-ID: <45DEC3E5.6030004@garzik.org>
References: <45DBC136.9060103@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44894 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207AbXBWKh1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:37:27 -0500
In-Reply-To: <45DBC136.9060103@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Robert Hancock wrote:
> sata_nv implemented its own copies of the BMDMA helper functions for ADMA,
> since the ADMA BMDMA status registers are PIO while the other registers
> are MMIO, and this was the only way to handle this previously. Now that
> we have iomap support, the standard routines should just work, so use them.
> The only thing we need to override as far as ADMA and BMDMA is the
> post_internal_cmd callback, where we should only call ata_post_internal_cmd
> if we are in port-register mode.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied


