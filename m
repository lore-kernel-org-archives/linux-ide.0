From: Darren Stevens <darren@stevens-zone.net>
Subject: Re: pata_atiixp regression in 4.11-rc1
Date: Tue, 28 Mar 2017 16:56:20 +0100 (BST)
Message-ID: <49ce56a03f0.6ac59ea0@auth.smtp.1and1.co.uk>
References: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
 <20170327175550.GB13353@htj.duckdns.org>
 <49cdecb0846.6a8a0888@auth.smtp.1and1.co.uk>
 <d9c9cb23-e67f-779d-240d-e02f7d87e405@gmail.com>
 <20170328155846.GB28157@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:54931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdC1Q7G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2017 12:59:06 -0400
In-Reply-To: <20170328155846.GB28157@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Markku Pesonen <tourula@gmail.com>, linux-ide@vger.kernel.org

Hello Tejun

On 28/03/2017, Tejun Heo wrote:
> One way or the other, there's a reported case of secondary port being
> used, so we can't mark it dummy no matter what the datasheet says.  If
> whether the port is marked dummy or not matter much, we can try to do
> finer grained blacklisting or try to do something smarter.

The best option is just not to check the SB7xx series (patch to follow), as
AMD added this ability to these chips.

This is my bad, I thought the early SB700 docs I had were correct - sorry.

Regards
Darren

PS I've adjusted my mailer settings, hopefully this one will work.

