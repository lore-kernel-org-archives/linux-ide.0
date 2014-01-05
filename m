From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: HD filesystem integrity issues
Date: Sat, 04 Jan 2014 19:50:29 -0600
Message-ID: <52C8BA65.3070806@gmail.com>
References: <52C49A1C.1000104@earthlink.net> <52C628C7.6040407@gmail.com> <52C62FDA.8080904@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:51954 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaAEBuc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Jan 2014 20:50:32 -0500
Received: by mail-ig0-f176.google.com with SMTP id k19so4283581igc.3
        for <linux-ide@vger.kernel.org>; Sat, 04 Jan 2014 17:50:32 -0800 (PST)
In-Reply-To: <52C62FDA.8080904@earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@earthlink.net>, linux-ide@vger.kernel.org

On 01/02/2014 09:34 PM, Felix Miata wrote:
> On 2014-01-02 21:04 (GMT-0600) Robert Hancock composed:
>
>> Felix Miata wrote:
>
>>> http://fm.no-ip.com/Tmp/Linux/dmsgAZBHD201401.txt is dmesg from a STB
>
>> Have you checked the dmesg output? There would likely be some indication
>> of what happened.
>
> Checked for what exactly? That's why I gave it to the list to look at.
> The only thing I recognized as a problem indication was "running e2fsck
> is recommended".

Is that output from after attempting to run e2fsck? It doesn't appear 
that in this output it has even finished recognizing the USB hard drive 
yet. If the OOM killer kicked in, there should be a bunch of output in 
dmesg about it.

>
>> Given that this thing only has 100MB or so of memory,
>> it seems quite likely that the out-of-memory killer kicked in.
>
> As another responder replied within minutes of my post, and you seem to
> have confirmed. It's what I suspected, but I was able to find any way to
> confirm other than to ask somewhere outside the device's so-called
> support forum.
>
>> This isn't really related to linux-ide, the main Linux kernel mailing
>> list would likely be more suitable.
>
> I was thinking a generic filesystem list, but don't know of one about
> ext2/3/4, and thought this better than a high traffic generic list.

