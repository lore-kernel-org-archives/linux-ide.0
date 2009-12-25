From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: Long delays while hibernating
Date: Fri, 25 Dec 2009 18:10:45 +0000
Message-ID: <74fd948d0912251010y2bba5bd6nf7aa3a34a7946c31@mail.gmail.com>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>
	 <4B31CAF9.8070104@kernel.org>
	 <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>
	 <4B331C16.4080901@kernel.org>
	 <74fd948d0912240634h621de8b6l746470556da3eb7f@mail.gmail.com>
	 <74fd948d0912240759n72e8c141y6b75f1ee7caadf60@mail.gmail.com>
	 <4B34D2AC.8040908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:61010 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbZLYSKr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Dec 2009 13:10:47 -0500
Received: by ewy19 with SMTP id 19so300065ewy.21
        for <linux-ide@vger.kernel.org>; Fri, 25 Dec 2009 10:10:45 -0800 (PST)
In-Reply-To: <4B34D2AC.8040908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Fri, Dec 25, 2009 at 2:56 PM, Tejun Heo <tj@kernel.org> wrote:
> On 12/25/2009 12:59 AM, Pedro Ribeiro wrote:
>> I just noticed that this patch is for ata_piix. I don't have this
>> module loaded, as I have an ICH9 chip. The module used is ahci. Here
>> is the output of lsmod:
>> http://pastebin.com/m5468985b
>
> Oh... Can you please try this one then?
>
> Thanks.
>
> --
> tejun
>

Sorry, still hangs with this patch :(

This only happens in hibernation... suspend is fine.

Pedro
