From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: complain on spurious completion notifiers
Date: Fri, 23 Feb 2007 05:37:54 -0500
Message-ID: <45DEC402.4030205@garzik.org>
References: <45DD2FBF.1040808@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44931 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213AbXBWKh4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:37:56 -0500
In-Reply-To: <45DD2FBF.1040808@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>

Robert Hancock wrote:
> Recently Tejun wrote a patch to ahci.c to make it raise a HSM violation
> if the drive attempted to complete a tag that wasn't outstanding. We could
> run into the same problem with sata_nv ADMA. This adds code to raise a HSM
> violation error if the controller gives us a notifier tag that isn't
> outstanding, since the drive may be issuing spurious completions.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied


