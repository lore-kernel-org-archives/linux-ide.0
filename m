From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix MAP VALUE interpretation for for ICH6/7
Date: Mon, 19 Dec 2005 14:42:31 +0900
Message-ID: <43A64847.4010202@gmail.com>
References: <20051218081707.GA4129@htj.dyndns.org> <43A64738.4090402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:29193 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030274AbVLSFmh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:42:37 -0500
Received: by zproxy.gmail.com with SMTP id 13so1222880nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 21:42:36 -0800 (PST)
In-Reply-To: <43A64738.4090402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Unlike their older siblings, ICH6 and 7 use different scheme for MAP
>> VALUE.  This patch makes ata_piix interpret MV properly on ICH6/7.
> 
> 
> Patch is OK, if tested has verified borne this out?
> 
> If this is not just a documentation error, it sounds like some of the 
> ata_piix problems could be attributed to this.  We intentionally drive 
> SATA and PATA differently...
> 

The patch worked for me.  :-)

-- 
tejun
