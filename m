From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/23] libata-sff: introduce ata_sff_init/exit() and ata_sff_port_init()
Date: Wed, 19 May 2010 13:37:25 -0400
Message-ID: <4BF421D5.4040900@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-12-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52928 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab0ESRh3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 13:37:29 -0400
Received: by gwaa20 with SMTP id a20so1968675gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 10:37:28 -0700 (PDT)
In-Reply-To: <1273520507-32459-12-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> In preparation of proper SFF/BMDMA separation, introduce
> ata_sff_init/exit() and ata_sff_port_init().  These functions
> currently don't do anything.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-core.c |   23 +++++++++++++++++------
>   drivers/ata/libata-sff.c  |   23 +++++++++++++++++++++++
>   drivers/ata/libata.h      |   10 ++++++++++
>   3 files changed, 50 insertions(+), 6 deletions(-)

applied 9-16


