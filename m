From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: add device ID for 82801JI sata controller
Date: Tue, 14 Jul 2009 22:43:12 -0400
Message-ID: <4A5D4240.9020701@garzik.org>
References: <20090626154411.GB6433@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46562 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbZGOCoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Jul 2009 22:44:54 -0400
In-Reply-To: <20090626154411.GB6433@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

David Milburn wrote:
> From: Mark Goodwin <mgoodwin@redhat.com>
> 
> Add device ID for Intel 82801JI SATA AHCI controller.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/ata/ahci.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

applied


