From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH resend] ARM: at91/ide: remove unsused at91-ide Kconfig entry
Date: Tue, 5 Feb 2013 15:05:42 +0100
Message-ID: <CAMgPeKX4ej6L+TDjsST8wur1JyaoHngtqGXAq4rQY3CfeQ-msA@mail.gmail.com>
References: <1352892034-18871-1-git-send-email-jhovold@gmail.com>
	<1360072415-6594-1-git-send-email-jhovold@gmail.com>
	<alpine.LNX.2.00.1302051459090.2260@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:45688 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab3BEOFn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2013 09:05:43 -0500
In-Reply-To: <alpine.LNX.2.00.1302051459090.2260@pobox.suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 5, 2013 at 2:59 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 5 Feb 2013, Johan Hovold wrote:
>
>> Commit cf844751fb25e ("ARM: at91: drop ide driver in favor of the pata
>> one") removed the at91-ide driver but did not remove the Kconfig entry.
>>
>> Signed-off-by: Johan Hovold <jhovold@gmail.com>
>> ---
>>
>> Resend of patch first posted mid-November with trivial added as CC. Perhaps it
>> can go in via the AT91-folks, otherwise?
>
> It doesn't seem to have reached trivial@kernel.org back then.

No, I forgot to add trivial last time.

> I am taking it now, thanks.

Thanks,
Johan
