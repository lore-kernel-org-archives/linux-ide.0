From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4] libata: implement ata_dev_init()
Date: Mon, 13 Mar 2006 18:25:21 +0900
Message-ID: <20060313092521.GA2091@htj.dyndns.org>
References: <11421469551948-git-send-email-htejun@gmail.com> <11421469552851-git-send-email-htejun@gmail.com> <20060313061926.GA30429@htj.dyndns.org> <44152CBD.3010405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:64570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932389AbWCMJZ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 04:25:26 -0500
Received: by zproxy.gmail.com with SMTP id 13so1280024nzn
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 01:25:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44152CBD.3010405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Mon, Mar 13, 2006 at 03:26:37AM -0500, Jeff Garzik wrote:
> NAK:
> 
> 1) the devices are embedded with ata_port, and so all static 
> initialization should be done in ata_host_init().  It's only called once 
> for each device, as you say, anyway...  no need to separate it from the 
> rest of the struct ata_port initialization AFAICS.

I was mainly thinking of hotplug cases.  dev liftime becomes different
form ap lifetime in hotplug cases, so it needs reinitialization before
recycling.  I guess it can wait till we actually do hotplug.  I'll
drop this patch.

> 2) there is no need to memset() [unless you are re-initializing, I suppose]

ditto.

-- 
tejun
