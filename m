From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Why is only one command issue per time in AHCI driver?
Date: Tue, 18 Jan 2011 08:43:22 -0600
Message-ID: <AANLkTi=PsjJ2ndCaPowmJjRnjwHzB+xUX-PjReh7L5fx@mail.gmail.com>
References: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com>
	<4D2F3A86.3010503@garzik.org>
	<AANLkTikV-VWpy0XKpMUvurp86dRAOWUUNEQP5OkvfCso@mail.gmail.com>
	<4D2FE384.4090405@gmail.com>
	<AANLkTikZc3KWEyDBfML2yxnkSX+7U-aUBJjZSSSPYPqb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38983 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1AROnX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 09:43:23 -0500
Received: by iyj18 with SMTP id 18so5755669iyj.19
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2011 06:43:22 -0800 (PST)
In-Reply-To: <AANLkTikZc3KWEyDBfML2yxnkSX+7U-aUBJjZSSSPYPqb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: seedrubbish@gmail.com
Cc: =?UTF-8?B?576F56eJ6Yie?= <luobingjiun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Tue, Jan 18, 2011 at 1:56 AM, Seed <seedrubbish@gmail.com> wrote:
> Hi Robert,
>
> On Fri, Jan 14, 2011 at 4:47 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
>> That sounds like the I/O pattern doesn't result in any concurrent transfers
>> being executed. What kind of workload is this running?
>>
>
> Do you have any suggestion about how to can get such a workload?

It depends very much on what you're trying to accomplish. Last time I
checked, even booting the system or doing large sequential I/O would
result in fairly high queue depths. However if you're doing small,
single-threaded I/O, you likely won't see much or any queueing.
