From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] pata_hpt37x: fold 'if' statement into 'switch'
Date: Tue, 18 Jan 2011 20:00:16 -0500
Message-ID: <4D3637A0.5060006@pobox.com>
References: <201101102231.13495.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60886 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1ASBAW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 20:00:22 -0500
Received: by vws16 with SMTP id 16so130232vws.19
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2011 17:00:21 -0800 (PST)
In-Reply-To: <201101102231.13495.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 01/10/2011 02:31 PM, Sergei Shtylyov wrote:
> hpt37x_init_one() has a large *if* statement which should really be folded into
> the *switch* statement that currently constitutes its *else* branch, reducing
> one level of indentation...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree plus 2 patches I posted
> before:
>
> http://marc.info/?l=linux-ide&m=129468455026976
> http://marc.info/?l=linux-ide&m=129468485927420
>
>   drivers/ata/pata_hpt37x.c |   89 ++++++++++++++++++++++------------------------
>   1 file changed, 43 insertions(+), 46 deletions(-)

applied this, and the prereset inherit patch


