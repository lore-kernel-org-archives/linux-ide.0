From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/4] libata: ACPI checks for 80wire cable
Date: Thu, 16 Aug 2007 02:37:44 -0400
Message-ID: <46C3F0B8.5090402@garzik.org>
References: <20070726183728.429122ba@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49031 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760567AbXHPGhs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 02:37:48 -0400
In-Reply-To: <20070726183728.429122ba@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> We can make use of this on the pata_amd driver as many Nvidia devices
> don't have reliable cable detect.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied 3-4


