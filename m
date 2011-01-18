From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Why is only one command issue per time in AHCI driver?
Date: Tue, 18 Jan 2011 03:46:57 -0500
Message-ID: <4D355381.7040509@garzik.org>
References: <AANLkTin5=NiZn6ZWZ=r-XS0v_Utrf6dpTb_YzCay-PJM@mail.gmail.com> <4D2F3A86.3010503@garzik.org> <AANLkTikV-VWpy0XKpMUvurp86dRAOWUUNEQP5OkvfCso@mail.gmail.com> <4D2FE384.4090405@gmail.com> <AANLkTikZc3KWEyDBfML2yxnkSX+7U-aUBJjZSSSPYPqb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36687 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1ARIrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 03:47:03 -0500
Received: by qwa26 with SMTP id 26so5635966qwa.19
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2011 00:47:02 -0800 (PST)
In-Reply-To: <AANLkTikZc3KWEyDBfML2yxnkSX+7U-aUBJjZSSSPYPqb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: seedrubbish@gmail.com
Cc: Robert Hancock <hancockrwd@gmail.com>, =?UTF-8?B?576F56eJ6Yie?= <luobingjiun@gmail.com>, linux-ide@vger.kernel.org

On 01/18/2011 02:56 AM, Seed wrote:
> Hi Robert,
>
> On Fri, Jan 14, 2011 at 4:47 PM, Robert Hancock<hancockrwd@gmail.com>  wrote:
>> That sounds like the I/O pattern doesn't result in any concurrent transfers
>> being executed. What kind of workload is this running?
>>
>
> Do you have any suggestion about how to can get such a workload?

Use multiple threads.


