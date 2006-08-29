From: Tejun Heo <htejun@gmail.com>
Subject: Re: Some questions about new EH in libata
Date: Tue, 29 Aug 2006 11:16:36 +0900
Message-ID: <44F3A384.4080505@gmail.com>
References: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>	 <44EA91A8.5090309@gmail.com> <8202f4270608281751v7cddfdddo28ba1b86eb43e60f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:43032 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932103AbWH2CQn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 22:16:43 -0400
Received: by py-out-1112.google.com with SMTP id n25so2679701pyg
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 19:16:43 -0700 (PDT)
In-Reply-To: <8202f4270608281751v7cddfdddo28ba1b86eb43e60f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Fajun Chen wrote:
>> You can use SCSI userscan interface.
>>
> Is this a scsi command? I looked at scsi spec and haven't found it
> yet. I know how to initiate user scan from proc or sysfs,

Yeap, that's what I meant.

> but there is
> no way to know the result of user scan through proc or sysfs.  I'm
> looking for a way to check when a pata drive is back online after a
> power cycle. May I issue userscan periodically until its result
> indicates pata drive is available?

Hmmm.. When new devices are attached, hotplug events are generated.  I 
think that's the only way to get any result back, so when it fails, 
there's no indication.  Periodically repeating userscan request should 
be fine although it may result in an extra reset after successfully 
detecting the device.  That shouldn't hurt too much.

-- 
tejun
