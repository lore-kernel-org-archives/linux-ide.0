From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add notation that the Asus W5F laptop has a short cable
 instead of 80-wire.
Date: Wed, 04 Apr 2007 02:02:46 -0400
Message-ID: <46133F86.8070006@garzik.org>
References: <117513012716-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41595 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992674AbXDDGCs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 02:02:48 -0400
In-Reply-To: <117513012716-git-send-email-robbat2@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org

Robin H. Johnson wrote:
> The Asus W5F laptop uses a short cable instead of the 80-wire style, and thus
> needs to be in the ich_laptop special cases for correct detection and support
> of UDMA/100 for the hard drive. I noticed this because I have the W5F laptop,
> and was tracing apparent slowness.
> 
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> ---
>  drivers/ata/ata_piix.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

applied


