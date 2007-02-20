From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/5] sata_nv: Add CPB register info to error_handler output
Date: Tue, 20 Feb 2007 11:06:33 -0500
Message-ID: <45DB1C89.4040602@garzik.org>
References: <45DA4887.1060705@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44319 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965291AbXBTQGe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 11:06:34 -0500
In-Reply-To: <45DA4887.1060705@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Robert Hancock wrote:
> When error handling occurs with pending commands, output the contents
> of the next CPB count and next CPB index registers as well as the others,
> since these may be useful for debugging.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied 1-5.  Thanks for splitting it up.


