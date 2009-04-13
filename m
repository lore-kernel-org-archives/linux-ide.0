From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH] sata_mv: increate the IORDY timeout for the soc
	controllers
Date: Mon, 13 Apr 2009 10:13:48 +0300
Message-ID: <c70ff3ad0904130013n319510c4w5ae071076717f2bd@mail.gmail.com>
References: <20090411160815.GA10995@deprecation.cyrius.com>
	 <49E1FCBC.5010101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:7599 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbZDMHNu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 03:13:50 -0400
Received: by fg-out-1718.google.com with SMTP id e12so604698fga.17
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2009 00:13:48 -0700 (PDT)
In-Reply-To: <49E1FCBC.5010101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org

On Sun, Apr 12, 2009 at 5:37 PM, Mark Lord <liml@rtr.ca> wrote:
> Martin Michlmayr wrote:
>>
>> From: Saeed Bishara <saeed@marvell.com>

>
> I want to see somebody actually test/verify that
> this works with PIO/MWDMA2 devices (eg. CF cards) first.
>
> Test results?
PIO mode is always used, at least for the identify command. the patch
works and needed for the Kirkwood SoC which runs at 200KHz.


saeed
