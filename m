From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: use AC_ERR_TIMEOUT err_mask for time out
Date: Sat, 01 Apr 2006 03:17:10 +0900
Message-ID: <442D7226.6030404@gmail.com>
References: <442CC185.3060200@tw.ibm.com> <442D4561.60705@pobox.com> <442D717A.7080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:16475 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932192AbWCaSRP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 13:17:15 -0500
Received: by zproxy.gmail.com with SMTP id o37so991950nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 10:17:15 -0800 (PST)
In-Reply-To: <442D717A.7080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, IDE Linux <linux-ide@vger.kernel.org>

[--snip--]
> 
> It just isn't worth to successfully complete a command after 30 seconds 
> at the risk of data corruption. If the device/controller times out on 
> most of commands, the combination is unuseable no matter what we do on 
> timeout (one command every 30secs..). If the combination fails 
> occasionally, retrying doesn't take little time and is much safer.

The last sentence should be either 'doesn't take much time' or 'takes 
little time'. Two sentences got fused in my head while writing. :/

-- 
tejun
