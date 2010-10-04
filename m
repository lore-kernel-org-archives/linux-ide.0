From: Tejun Heo <htejun@gmail.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Mon, 04 Oct 2010 11:18:03 +0200
Message-ID: <4CA99BCB.8080904@gmail.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com> <4C9CA673.4090104@teksavvy.com> <4C9D33C0.8050900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab0JDJSJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2010 05:18:09 -0400
Received: by fxm14 with SMTP id 14so1560204fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 04 Oct 2010 02:18:08 -0700 (PDT)
In-Reply-To: <4C9D33C0.8050900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Seed <seedrubbish@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

On 09/25/2010 01:26 AM, Robert Hancock wrote:
>> And here's an example of the bug, which should work (as a demo)
>> for most folks out there with the same controller ahci / JMB360:
>>
>> Here, I'll use hdparm to do a "set acoustic" command
>> on a drive which does NOT have the "Acoustic Management" feature set.
>> Just look for the fd fd fd strings in the returned data,
>> and notice how the final IDENTIFY at the end works, but returns
>> bad ATA status 0x51 from the stale result_tf:
> 
> The d2h_fis area is supposed to be updated by the controller with
> the last FIS received from the device. Maybe this controller just
> isn't doing that for some reason?

Hmm... one possibility is that the controller takes some time to
update the area and the driver is reading it off too early.  Maybe
adding a delay would resolve the issue?  Mark, do you know whether
this problem is isolated to JMB360?

Thanks.

-- 
tejun
