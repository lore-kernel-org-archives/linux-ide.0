From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a
 SoC"
Date: Thu, 29 Sep 2016 11:58:02 +0200
Message-ID: <20160929095802.GA24034@mtj.duckdns.org>
References: <1475027172-21012-1-git-send-email-yuantian.tang@nxp.com>
 <20160929085525.GE11087@mtj.duckdns.org>
 <DB6PR0402MB2837BA24F4CB8D137FA16574F0CE0@DB6PR0402MB2837.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33744 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754661AbcI2J6K (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Sep 2016 05:58:10 -0400
Received: by mail-yw0-f195.google.com with SMTP id g192so2744132ywh.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2016 02:58:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2837BA24F4CB8D137FA16574F0CE0@DB6PR0402MB2837.eurprd04.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Y.T. Tang" <yuantian.tang@nxp.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Thu, Sep 29, 2016 at 09:07:18AM +0000, Y.T. Tang wrote:
> In reality, customer will not get any ls2080a v1.0 soc. Neither
> apply to any products. If blacklisting v2.0, we need to check the
> soc version which is not suitable in the driver.  Anyway, reverting
> this commit won't create any side effect.

Can you please include this in the commit description?

Thanks.

-- 
tejun
