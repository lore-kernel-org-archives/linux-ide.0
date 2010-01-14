From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: cleanup ata_sff_interrupt()
Date: Thu, 14 Jan 2010 12:38:40 -0500
Message-ID: <4B4F56A0.6060606@garzik.org>
References: <4B4ECCCD.1040902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:36819 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229Ab0ANRim (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 12:38:42 -0500
Received: by qyk32 with SMTP id 32so4134823qyk.4
        for <linux-ide@vger.kernel.org>; Thu, 14 Jan 2010 09:38:42 -0800 (PST)
In-Reply-To: <4B4ECCCD.1040902@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 01/14/2010 02:50 AM, Tejun Heo wrote:
> host->ports[i] is never NULL if i<  host->n_ports and non-NULL return
> from ata_qc_from_tag() guarantees that the returned qc is active.
> Drop unnecessary tests.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-sff.c |   17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)

This is more #upstream material, don't you think?  We are pretty deep 
into -rc at this point.

(headed out for the weekend, fyi)

	Jeff



