From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: ahci enclosure management led sync
Date: Tue, 28 Oct 2008 00:40:06 -0400
Message-ID: <490697A6.7000304@garzik.org>
References: <20081016142619.GA8282@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57052 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbYJ1EkJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 00:40:09 -0400
In-Reply-To: <20081016142619.GA8282@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, tj@kernel.org

David Milburn wrote:
> Synchronize ahci_sw_activity and ahci_sw_activity_blink with ata_port lock.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> --- 
>  drivers/ata/ahci.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

applied


