From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_fsl: Remove redundant NULL check before kfree
Date: Mon, 04 Mar 2013 17:15:11 -0500
Message-ID: <51351CEF.8070400@pobox.com>
References: <1361747647-29539-1-git-send-email-s.syam@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:40558 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab3CDWVV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 17:21:21 -0500
Received: by mail-qe0-f52.google.com with SMTP id s14so3917441qeb.11
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2013 14:21:21 -0800 (PST)
In-Reply-To: <1361747647-29539-1-git-send-email-s.syam@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-ide@vger.kernel.org

On 02/24/2013 06:14 PM, Syam Sidhardhan wrote:
> kfree on NULL pointer is a no-op.
>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>   drivers/ata/sata_fsl.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

applied



