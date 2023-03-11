Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97696C61DA4
	for <linux-ide@archiver.kernel.org>; Sat, 11 Mar 2023 21:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCKVjZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 11 Mar 2023 16:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKVjZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2023 16:39:25 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A4384C6CF;
        Sat, 11 Mar 2023 13:39:24 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id A15B77A0158;
        Sat, 11 Mar 2023 22:39:23 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] pata_parport: fix possible memory leak
Date:   Sat, 11 Mar 2023 22:39:21 +0100
User-Agent: KMail/1.9.10
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dan Carpenter <error27@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3ab89ddc-cb60-47c4-86ad-cdad94a8a3d7@kili.mountain> <2223c1dc-1869-a307-e5da-772cb27b34e5@omp.ru> <202303112211.57761.linux@zary.sk>
In-Reply-To: <202303112211.57761.linux@zary.sk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303112239.21234.linux@zary.sk>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Saturday 11 March 2023 22:11:57 Ondrej Zary wrote:
> On Saturday 11 March 2023 21:23:25 Sergey Shtylyov wrote:
> > On 3/11/23 11:19 PM, Sergei Shtylyov wrote:
> > 
> > >> When ida_alloc() fails, "pi" is not freed although the misleading
> > >> comment says otherwise.
> > >> Move the ida_alloc() call up so we really don't have to free it.
> > 
> >    Wait, but don't we still need to call kfree() in pi_init_one()?
> 
> If it fails at device_register, the dev.release is already set to
> pata_parport_dev_release which does the kfree(). put_device() should call
> it. If it fails later, device_unregister() should do it.  

But I see that the ida_free() at the end of pi_init_one() is wrong. It uses pi->dev.id but pi is either uninitialized or already freed.
  
-- 
Ondrej Zary
