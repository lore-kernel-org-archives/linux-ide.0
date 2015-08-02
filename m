From: Tomer Barletz <barletz@gmail.com>
Subject: Re: [PATCH] Check return code from pdc20621_i2c_read()
Date: Sun, 2 Aug 2015 10:55:58 -0700
Message-ID: <CAO-S75DznUxvYg9RPcDOaw1H8XK8MuXxFGOARVt-5OtW2_RJnA@mail.gmail.com>
References: <1438510340-21568-1-git-send-email-barletz@gmail.com>
	<55BDFA5C.3040506@cogentembedded.com>
	<CAO-S75CRyh=FPbeTJMZWiYTvpd_wn57f4eGQgOHW2p16+9ANhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34088 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbHBRz7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Aug 2015 13:55:59 -0400
In-Reply-To: <CAO-S75CRyh=FPbeTJMZWiYTvpd_wn57f4eGQgOHW2p16+9ANhQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Re-sending in plain-text.

On Sun, Aug 2, 2015 at 4:09 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

>    Please use pr_err() instead. And "0x%d" makes no sense at all, please use "%#x" instead.
>

Yeah, not sure what I was drinking before writing this 0x%d thing...

Regarding the pr_err() - it is not used at all in this file, and
printk() is used instead. Wouldn't it be better to leave it with
printk for this change, then have another change that replaces
printk()s with pr_err()s?


--Tomer


On Sun, Aug 2, 2015 at 10:53 AM, Tomer Barletz <barletz@gmail.com> wrote:
>
> On Sun, Aug 2, 2015 at 4:09 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>
>>    Please use pr_err() instead. And "0x%d" makes no sense at all, please
>> use "%#x" instead.
>>
>
> Yeah, not sure what I was drinking before writing this 0x%d thing...
>
> Regarding the pr_err() - it is not used at all in this file, and printk() is
> used instead. Wouldn't it be better to leave it with printk for this change,
> then have another change that replaces printk()s with pr_err()s?
>
> --Tomer
>
