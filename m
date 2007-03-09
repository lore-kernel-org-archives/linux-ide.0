From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil:  First step to removing ->post_set_mode
Date: Fri, 09 Mar 2007 09:22:58 -0500
Message-ID: <45F16DC2.3020901@garzik.org>
References: <20070308230912.4ce2e943@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56590 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767318AbXCIOXB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 09:23:01 -0500
In-Reply-To: <20070308230912.4ce2e943@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Now that we have ata_do_set_mode() available for drivers to use we don't
> actually need ->post_set_mode() as the driver can wrap set_mode nicely
> and do stuff before or after (eg PCMCIA needs before), so we can kill off
> a method in all the structs
> 
> While I was at it I added kernel-doc to the function involved.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, but wish you would quit adding trailing whitespace


