From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci_platform: make structs static
Date: Fri, 14 Dec 2012 09:39:10 -0500
Message-ID: <50CB3A0E.2010206@pobox.com>
References: <1354779860-8655-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55954 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2LNOjN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2012 09:39:13 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so4024451vcd.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2012 06:39:13 -0800 (PST)
In-Reply-To: <1354779860-8655-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>

On 12/06/2012 02:44 AM, Brian Norris wrote:
> These structs are used only for ahci_platform.c, so they should be
> static. Thanks to Fengguang for the (automated) suggestion.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> ---
>   drivers/ata/ahci_platform.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

applied



