From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotswap problem on vt8251 with ahci driver
Date: Thu, 08 Mar 2007 17:19:38 +0900
Message-ID: <45EFC71A.3040303@gmail.com>
References: <1173185839.3778.14.camel@anja>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:5377 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030221AbXCHITi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 03:19:38 -0500
Received: by wr-out-0506.google.com with SMTP id 58so716771wri
        for <linux-ide@vger.kernel.org>; Thu, 08 Mar 2007 00:19:37 -0800 (PST)
In-Reply-To: <1173185839.3778.14.camel@anja>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aalderd.boac@wanadoo.nl
Cc: linux-ide@vger.kernel.org

Hello,

Aalderd Bouwman wrote:
> As you see, when I turned on the Barracuda 7200.9 drive the ide channel
> will not work correctly. This also happens when I turned on the
> Barracuda ES drive.
> 
> It doesn't sense setting the jumper on the drive on 1,5 Gb/s operation.
> 
> This happens not with the Maxtor drive and a Barracuda 7200.10 drive I
> have.

I'm sorry but just don't play with hotplug on via.  If you really want
hotplug, get a proper ahci controller or a sil/sil24.

-- 
tejun
