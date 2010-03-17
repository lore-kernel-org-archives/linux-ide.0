From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: pp->active_link is not reliable when FBS is enabled
Date: Wed, 17 Mar 2010 15:59:15 -0400
Message-ID: <4BA13493.3040002@pobox.com>
References: <1268734135.3515.4.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43495 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854Ab0CQT7S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 15:59:18 -0400
Received: by gwaa12 with SMTP id a12so456714gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2010 12:59:17 -0700 (PDT)
In-Reply-To: <1268734135.3515.4.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: linux-ide@vger.kernel.org

On 03/16/2010 06:08 AM, Shane Huang wrote:
> pp->active_link is not reliable when FBS is enabled.
> Both PORT_SCR_ACT and PORT_CMD_ISSUE should be checked
> because mixed NCQ and non-NCQ commands may be in flight.
>
> Signed-off-by: Shane Huang<shane.huang@amd.com>
> ---
>   drivers/ata/ahci.c |   23 +++++++++++++++++------
>   1 files changed, 17 insertions(+), 6 deletions(-)

applied #upstream-fixes


