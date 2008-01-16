From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/5] ata_piix: kill unused constants and flags
Date: Wed, 16 Jan 2008 05:13:06 -0500
Message-ID: <478DD8B2.4030603@garzik.org>
References: <1199439744356-git-send-email-htejun@gmail.com> <11994397441617-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57700 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbYAPKNJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jan 2008 05:13:09 -0500
In-Reply-To: <11994397441617-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: torvalds@linux-foundation.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Kill PIIX_FLAG_SCR, PIIX_PORT_ENABLED and PIIX_PORT_PRESENT.  These
> are unused.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ata_piix.c |   27 +++++++--------------------
>  1 files changed, 7 insertions(+), 20 deletions(-)

applied 1-2


