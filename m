From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: convert pata_pdc2027x to the new reset mechanism
Date: Sat, 01 Apr 2006 03:24:52 +0900
Message-ID: <442D73F4.4010508@gmail.com>
References: <442B4C81.4010305@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:27964 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932207AbWCaSY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 13:24:58 -0500
Received: by zproxy.gmail.com with SMTP id o37so994505nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 10:24:58 -0800 (PST)
In-Reply-To: <442B4C81.4010305@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> - Convert pata_pdc2027x to the new reset mechanism (->probe_reset)
> - Increased the version to 0.74
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Looks good.

-- 
tejun
