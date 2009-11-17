From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH -2nd repost 1/1] ATA: pata_via, fix double put on isa
 bridge
Date: Mon, 16 Nov 2009 22:17:47 -0500
Message-ID: <4B0215DB.2010301@pobox.com>
References: <1257351063-5616-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50930 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbZKQDRo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 22:17:44 -0500
In-Reply-To: <1257351063-5616-1-git-send-email-jirislaby@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/04/2009 11:11 AM, Jiri Slaby wrote:
> In via_init_one, when via_isa_bridges iterator reaches
> PCI_DEVICE_ID_VIA_ANON and last but one via_isa_bridges bridge is
> found but rev doesn't match, pci_dev_put(isa) is called twice.
>
> Do pci_dev_put only once.
>
> Signed-off-by: Jiri Slaby<jirislaby@gmail.com>
> Cc: Jeff Garzik<jgarzik@pobox.com>
> ---
>   drivers/ata/pata_via.c |   10 ++++------
>   1 files changed, 4 insertions(+), 6 deletions(-)

applied


