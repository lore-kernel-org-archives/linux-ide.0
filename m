From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: Remove ugly layering violation
Date: Fri, 09 Mar 2007 07:38:55 -0500
Message-ID: <45F1555F.9030003@garzik.org>
References: <20070307161307.37b1e36f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55578 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767216AbXCIMi6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:38:58 -0500
In-Reply-To: <20070307161307.37b1e36f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> A while ago I modified the libata code so that drivers can return -ENOENT
> for unknown ports not fiddle with the EH flags and print stuff directly.
> Somewhere along the line ata_piix didn't get fully converted.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #upstream-fixes (and I forgot to fix the version number, sigh)


