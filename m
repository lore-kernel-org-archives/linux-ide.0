From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH 19/19] pata_pcmcia: get rid of extra indirection
Date: Mon, 29 Mar 2010 16:15:16 -0400
Message-ID: <4BB10A54.30108@garzik.org>
References: <20100321230617.GA24791@comet.dominikbrodowski.net> <1269212857-25364-19-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57189 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab0C2UPT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Mar 2010 16:15:19 -0400
Received: by vws20 with SMTP id 20so233576vws.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Mar 2010 13:15:18 -0700 (PDT)
In-Reply-To: <1269212857-25364-19-git-send-email-linux@dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org

On 03/21/2010 07:07 PM, Dominik Brodowski wrote:
> We don't need ata_pcmcia_info any more.
>
> CC: linux-ide@vger.kernel.org
> Signed-off-by: Dominik Brodowski<linux@dominikbrodowski.net>
> ---
>   drivers/ata/pata_pcmcia.c |   41 ++++++-----------------------------------
>   1 files changed, 6 insertions(+), 35 deletions(-)

Acked-by: Jeff Garzik <jgarzik@redhat.com>


