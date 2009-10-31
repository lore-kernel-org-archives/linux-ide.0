From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Does ICH9M support eSATA Port Multiplier?
Date: Sat, 31 Oct 2009 11:02:29 -0600
Message-ID: <4AEC6DA5.9090603@gmail.com>
References: <4AE9EEA3.1040404@aon.at> <4AEA2D16.50701@gmail.com> <4AEB6458.20401@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:38030 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbZJaRC2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 13:02:28 -0400
Received: by ywh40 with SMTP id 40so3492290ywh.33
        for <linux-ide@vger.kernel.org>; Sat, 31 Oct 2009 10:02:33 -0700 (PDT)
In-Reply-To: <4AEB6458.20401@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org

On 10/30/2009 04:10 PM, Peter Klotz wrote:
> Robert Hancock wrote:
>>> Can I enable it somehow maybe by using a module option?
>>
>> No module parameter for that, you'd have to hack the code in ahci.c to
>> force the option on. No guarantees it's going to work if the
>> controller doesn't report the capability, though.
>
> Could you please give me a hint what to change in ahci.c?
>
> I would like to try and see what happens.

Based on the version in Linus' git, you'd likely want to add to 
ahci_save_initial_config something like:

cap |= HOST_CAP_PMP;

>
> Could such a hack damage the hardware?

Not likely. It's not impossible that data loss could result though, 
better back up important files first..
