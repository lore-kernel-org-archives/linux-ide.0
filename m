From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: let users know that Promise PDC42819 support is
 limited 	to SATA devices
Date: Thu, 03 Dec 2009 02:36:58 -0500
Message-ID: <4B176A9A.6010204@garzik.org>
References: <65a6ef750911211707m3cece36fsc464e8e5d9273782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43846 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZLCHgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 02:36:53 -0500
Received: by yxe17 with SMTP id 17so927170yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 02 Dec 2009 23:37:00 -0800 (PST)
In-Reply-To: <65a6ef750911211707m3cece36fsc464e8e5d9273782@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: linux-ide@vger.kernel.org

On 11/21/2009 08:07 PM, Mark Nelson wrote:
> ahci can drive the Promise PDC42819, but obviously it can only use SATA
> disks connected to this controller. The controller can actually support
> SAS disks as well, but we only know how to use it in it's AHCI mode.
>
> Add a message to let users know that because ahci is driving their chip
> they can only use the SATA disks connected to this controller.
>
> Signed-off-by: Mark Nelson<mdnelson8@gmail.com>
> ---
>   drivers/ata/ahci.c |    8 ++++++++
>   1 file changed, 8 insertions(+)

applied


