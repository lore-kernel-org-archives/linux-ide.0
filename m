From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Strict checking for identify reporting
Date: Fri, 31 Aug 2007 05:35:28 -0400
Message-ID: <46D7E0E0.5070203@garzik.org>
References: <20070822233143.46a36026@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45106 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140AbXHaJfa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:35:30 -0400
In-Reply-To: <20070822233143.46a36026@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The ATA specifications require checks on certain flags before assuming
> the validity of other data. Go through the methods and correct those
> needing extra checks. Also note limits on ata_id_major_version with
> respect to ATA-1 and ATA-2. Correct the 32bit PIO check.
> 
> Wants to sit in -mm for a bit in case of a screwup on my part that I
> didn't hit on the test drives and also in case someone, somewhere has
> a drive that gets it wrong.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


