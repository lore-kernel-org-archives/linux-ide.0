From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: delay on switching between NCQ and non-NCQ commands
Date: Tue, 20 Feb 2007 11:02:49 -0500
Message-ID: <45DB1BA9.20501@garzik.org>
References: <45DA43F6.80201@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44219 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965223AbXBTQCv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 11:02:51 -0500
In-Reply-To: <45DA43F6.80201@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Allen Martin <AMartin@nvidia.com>

Robert Hancock wrote:
> This patch appears to solve some problems with commands timing out in
> cases where an NCQ command is immediately followed by a non-NCQ command
> (or possibly vice versa). This is a rather ugly solution, but until we
> know more about why this is needed, this is about all we can do.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied


