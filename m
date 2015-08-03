From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_sx4: Check return code from pdc20621_i2c_read()
Date: Mon, 3 Aug 2015 22:19:10 +0300
Message-ID: <55BFBEAE.6030707@cogentembedded.com>
References: <55BF8E29.6000200@cogentembedded.com>
 <1438627595-17126-1-git-send-email-barletz@gmail.com>
 <55BFB87C.1010405@cogentembedded.com>
 <CAO-S75BnJJvNsEN3xFrtO9xO=4=UnwJeL6UHLeMbOaSyjk4Htw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33890 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbHCTTN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2015 15:19:13 -0400
Received: by lbqc9 with SMTP id c9so57806330lbq.1
        for <linux-ide@vger.kernel.org>; Mon, 03 Aug 2015 12:19:11 -0700 (PDT)
In-Reply-To: <CAO-S75BnJJvNsEN3xFrtO9xO=4=UnwJeL6UHLeMbOaSyjk4Htw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/03/2015 10:04 PM, Tomer Barletz wrote:

    Please don't top-post.

> I see how it makes sense to add a tab to align with the previous line
> of code, as it will always look similar in all editors, no matter how
> their tab character is set up to be.
> However, adding more tabs will just mess up editors that are not set
> up with 8-space width tabs.

> Is this a bug in checkpatch.pl, or are we saying everyone should have
> their editor set to 8-spaces width tabs?

    The latter. :-)

MBR, Sergei

