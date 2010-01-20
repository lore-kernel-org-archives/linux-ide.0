From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/2] libata: cleanup ata_sff_interrupt()
Date: Wed, 20 Jan 2010 14:29:00 -0500
Message-ID: <4B57597C.8000309@garzik.org>
References: <4B550EF8.1000009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:48707 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab0ATT3D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 14:29:03 -0500
Received: by gxk9 with SMTP id 9so6486065gxk.8
        for <linux-ide@vger.kernel.org>; Wed, 20 Jan 2010 11:29:03 -0800 (PST)
In-Reply-To: <4B550EF8.1000009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 01/18/2010 08:46 PM, Tejun Heo wrote:
> host->ports[i] is never NULL if i<  host->n_ports and non-NULL return
> from ata_qc_from_tag() guarantees that the returned qc is active.
> Drop unnecessary tests.
>
> Superflous () dropped as suggested by Sergei.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> ---
>   drivers/ata/libata-sff.c |   17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)

applied


