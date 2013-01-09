From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Allow Marvell SATA driver to work with LEDS_TRIGGER_IDE_DISK
Date: Wed, 09 Jan 2013 11:56:52 -0500
Message-ID: <50EDA154.6060407@pobox.com>
References: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:49011 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251Ab3AIQ4z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2013 11:56:55 -0500
In-Reply-To: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joshua Coombs <josh.coombs@gmail.com>
Cc: cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/08/2013 01:16 PM, Joshua Coombs wrote:
> Add a call to the IDE LED Trigger within the Marvell SATA driver to allow
> Marvell SoC devices to show SATA activity via GPIO connected LEDs.
>
> Signed-off-by: Joshua Coombs <josh.coombs@gmail.com>
> ---
>   drivers/ata/sata_mv.c | 3 +++
>   drivers/leds/Kconfig  | 3 +--
>   2 files changed, 4 insertions(+), 2 deletions(-)

NAK.  This is not appropriate at the specific driver level.  This would 
be better implemented at a higher level.



