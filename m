From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/23] libata-sff: introduce ata_sff_init/exit() and ata_sff_port_init()
Date: Mon, 17 May 2010 23:00:45 -0400
Message-ID: <4BF202DD.6010900@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-12-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44031 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab0ERDAt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 23:00:49 -0400
Received: by gyg13 with SMTP id 13so2571704gyg.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 20:00:48 -0700 (PDT)
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

applied


