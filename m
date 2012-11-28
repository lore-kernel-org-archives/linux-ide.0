From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_cs5536: add quirk for broken udma
Date: Wed, 28 Nov 2012 12:43:39 -0500
Message-ID: <50B64D4B.6020109@pobox.com>
References: <1349797992-32611-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51683 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab2K1Rnm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2012 12:43:42 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so9857430qcr.19
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2012 09:43:41 -0800 (PST)
In-Reply-To: <1349797992-32611-1-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-ide@vger.kernel.org, mkp@mkp.net

On 10/09/2012 11:53 AM, Christian Gmeiner wrote:
> I am working on a device which uses the cs5536 pata driver. There
> are some broken hardware revisions out in the field, which can be
> detected via DMI. On older versions with an embedded BIOS I
> used libata.dma=0 to disable dma completely.
> Now we are switching to a coreboot/seabios based BIOS where we
> have DMI support and so I think its a good idea to get rid of
> all those hacky kernel parameters as the same image
> is used other devices where libata.dma=0 is not a good idea.
>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>   drivers/ata/pata_cs5536.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)

applied



