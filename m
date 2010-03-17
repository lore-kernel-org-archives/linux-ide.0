From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: use BIOS date in broken_suspend
 list
Date: Wed, 17 Mar 2010 13:48:01 -0400
Message-ID: <4BA115D1.5010507@garzik.org>
References: <4B9ED5D2.2030805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:52982 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0CQRsD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 13:48:03 -0400
Received: by mail-pz0-f200.google.com with SMTP id 38so1041510pzk.33
        for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2010 10:48:03 -0700 (PDT)
In-Reply-To: <4B9ED5D2.2030805@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable@kernel.org, tigerfishdaisy@gmail.com

On 03/15/2010 08:50 PM, Tejun Heo wrote:
> HP is recycling both DMI_PRODUCT_NAME and DMI_BIOS_VERSION making
> ahci_broken_suspend() trigger for later products which are not
> affected by the original problems.  Match BIOS date instead of version
> and add references to bko's so that full information can be found
> easier later.
>
> This fixes http://bugzilla.kernel.org/show_bug.cgi?id=15462
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: tigerfishdaisy@gmail.com
> ---
>   drivers/ata/ahci.c |   28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)

applied #upstream-fixes


