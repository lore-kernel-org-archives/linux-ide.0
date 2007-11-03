From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: suppress two warnings
Date: Sat, 03 Nov 2007 08:48:12 -0400
Message-ID: <472C6E0C.106@pobox.com>
References: <20071031145332.01529b7d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35144 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbXKCMsQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:48:16 -0400
In-Reply-To: <20071031145332.01529b7d.sfr@canb.auug.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Stephen Rothwell wrote:
> drivers/ata/libata-core.c:768: warning: 'ata_lpm_enable' defined but not used
> drivers/ata/libata-core.c:784: warning: 'ata_lpm_disable' defined but not used
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/ata/libata-core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

applied


