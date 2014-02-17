From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] pata_imx: Use devm_ioremap_resource() to simplify
 code
Date: Tue, 18 Feb 2014 02:12:32 +0300
Message-ID: <53029760.9050407@cogentembedded.com>
References: <1392674757-1788-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:55605 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaBQWMf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Feb 2014 17:12:35 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so11684816lbj.17
        for <linux-ide@vger.kernel.org>; Mon, 17 Feb 2014 14:12:34 -0800 (PST)
In-Reply-To: <1392674757-1788-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On 02/18/2014 01:05 AM, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>

> Using devm_ioremap_resource() can lead to code simplication, as we don't need
> to explicitily check for error returned by platform_get_resource().

> Also, no need to print an error message when devm_ioremap_resource() fails,
> as the OOM code code will shout loudly on such condition.

    Not only OOM code, the function itself will cuss loudly too. :-)

WBR, Sergei

