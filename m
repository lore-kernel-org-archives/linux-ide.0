From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: revert use of notifiers for now
Date: Fri, 09 Mar 2007 07:50:53 -0500
Message-ID: <45F1582D.2050005@garzik.org>
References: <45F0A40A.4050508@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55690 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767230AbXCIMu6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:50:58 -0500
In-Reply-To: <45F0A40A.4050508@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, s0348365@sms.ed.ac.uk

Robert Hancock wrote:
> Commit 721449bf0d51213fe3abf0ac3e3561ef9ea7827a added support for using the
> ADMA notifier bits to determine which commands to check for completion.
> However there have been reports that this causes command timeouts in 
> certain
> cases. This is still being investigated. In addition, apparently the 
> notifiers
> won't work if ADMA is disabled on the other port as a result of an ATAPI 
> device
> being connected, and we don't handle this case properly.
> 
> For now, just restore the previous behavior of checking all active commands
> to see if they are complete, without relying on the notifiers.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied to #upstream-fixes


