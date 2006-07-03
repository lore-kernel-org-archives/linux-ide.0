From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil - broke at some point
Date: Mon, 03 Jul 2006 14:44:11 +0900
Message-ID: <44A8AEAB.6080701@gmail.com>
References: <cec86d5f0607022158n713e0d73ue967ecb93eb3b1e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:44732 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751344AbWGCFoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 01:44:08 -0400
Received: by wr-out-0506.google.com with SMTP id 71so563564wri
        for <linux-ide@vger.kernel.org>; Sun, 02 Jul 2006 22:44:07 -0700 (PDT)
In-Reply-To: <cec86d5f0607022158n713e0d73ue967ecb93eb3b1e2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Pfingstmann <jason@pfingstmann.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Jason Pfingstmann wrote:
> I've got a SIL3112-based PCMCIA SATA controller which, I believe,
> worked on my old system (~2.6.11 maybe?  Not sure, don't have it
> anymore - sorry).  I have been trying to get it to work with 2.6.17.1
> (don't see anything major that should effect up through 2.6.17.3, so
> unless requested to, am sticking with this vers (dialup))).  Thanks in
> advance.

VIA chipset?  If so, the following message might be relevant.

http://article.gmane.org/gmane.linux.ide/11733

-- 
tejun
