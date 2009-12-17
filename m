From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/6] sata_mv: store the board_idx into the host private
 data
Date: Thu, 17 Dec 2009 01:06:55 -0500
Message-ID: <4B29CA7F.2030001@garzik.org>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com> <1260116782-31714-2-git-send-email-saeed@marvell.com> <1260116782-31714-3-git-send-email-saeed@marvell.com> <1260116782-31714-4-git-send-email-saeed@marvell.com> <1260116782-31714-5-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:52281 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758847AbZLQGG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:06:57 -0500
Received: by yxe17 with SMTP id 17so1660280yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:06:57 -0800 (PST)
In-Reply-To: <1260116782-31714-5-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org

On 12/06/2009 11:26 AM, Saeed Bishara wrote:
> This information will be used int the resume function.
>
> Signed-off-by: Saeed Bishara<saeed@marvell.com>

applied, after fixing build breakage:  the platform resume function was 
not updated by this patch, for the new mv_init_host() signature


