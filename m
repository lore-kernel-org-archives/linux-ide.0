From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: Fix the iordy methods
Date: Fri, 09 Mar 2007 09:23:15 -0500
Message-ID: <45F16DD3.6080703@garzik.org>
References: <20070308232259.661e1564@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56599 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767319AbXCIOXR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 09:23:17 -0500
In-Reply-To: <20070308232259.661e1564@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> This alone isn't sufficient to save the universe from prehistoric disks
> and controllers but it is a first important step. Split off a separate
> function to provide a mode filter when controller iordy is not available.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied patch and associated trailing whitespace


