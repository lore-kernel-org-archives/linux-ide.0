From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Fri, 23 Jun 2006 17:12:28 +0900
Message-ID: <449BA26C.7050009@gmail.com>
References: <200606210942.33578.boac@wanadoo.nl> <44995139.30808@gmail.com> <200606221500.25056.boac@wanadoo.nl> <449B6583.1090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:49031 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932931AbWFWIMS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jun 2006 04:12:18 -0400
Received: by py-out-1112.google.com with SMTP id z74so650504pyg
        for <linux-ide@vger.kernel.org>; Fri, 23 Jun 2006 01:12:18 -0700 (PDT)
In-Reply-To: <449B6583.1090303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Aalderd Bouwman <aalderd.boac@wanadoo.nl>

Tejun Heo wrote:
[--snip--]
> Bastiaan, I'm shooting in the dark, so please don't hesitate to step in.

Bastiaan, it also seems that AHCI_FLAG_RESET_NEEDS_CLO workaround is not 
necessary anymore after hotplug changes which added 
ATA_FLAG_SKIP_D2H_BSY.  Can you please verify this?

Thanks.

-- 
tejun
