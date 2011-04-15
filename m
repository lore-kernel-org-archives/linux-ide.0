From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] libata: Implement ATA_FLAG_NO_DIPM and apply it to
 mcp65
Date: Fri, 15 Apr 2011 03:32:00 -0400
Message-ID: <4DA7F470.8040804@pobox.com>
References: <20110316101425.GB1752@htj.dyndns.org> <20110316101455.GC1752@htj.dyndns.org> <4DA7F1BB.8050905@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49922 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab1DOHcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Apr 2011 03:32:05 -0400
Received: by gwaa18 with SMTP id a18so1013315gwa.19
        for <linux-ide@vger.kernel.org>; Fri, 15 Apr 2011 00:32:04 -0700 (PDT)
In-Reply-To: <4DA7F1BB.8050905@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Andy Whitcroft <apw@canonical.com>

On 04/15/2011 03:20 AM, Stefan Bader wrote:
> On 03/16/2011 11:14 AM, Tejun Heo wrote:
>> NVIDIA mcp65 familiy of controllers cause command timeouts when DIPM
>> is used.  Implement ATA_FLAG_NO_DIPM and apply it.
>>
>> This problem was reported by Stefan Bader in the following thread.
>>
>
> Just wondering what happened to this. Were there objections or just fell through
> some cracks somehow?

hrm... that should have been queued a long time ago.  Sorry about that.

	Jeff



