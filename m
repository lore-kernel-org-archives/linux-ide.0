From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_cs5536: add quirk for broken udma
Date: Thu, 15 Nov 2012 23:22:54 -0500
Message-ID: <50A5BF9E.70807@pobox.com>
References: <CAH9NwWfVBg9srhyfUaHxsfBSoSVyLgDgZUPu_iK6fbQC9krH5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48425 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab2KPEW6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2012 23:22:58 -0500
In-Reply-To: <CAH9NwWfVBg9srhyfUaHxsfBSoSVyLgDgZUPu_iK6fbQC9krH5A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mkp@mkp.net

On 11/15/2012 05:03 PM, Christian Gmeiner wrote:
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
>   drivers/ata/pata_cs5536.c | 32 ++++++++++++++++++++++++++++++
> +-
>   1 file changed, 31 insertions(+), 1 deletion(-)

ACK, but patch is word-wrapped-mangled



