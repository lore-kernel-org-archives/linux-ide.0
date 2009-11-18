From: Tejun Heo <htejun@gmail.com>
Subject: Re: help with PMP failures
Date: Wed, 18 Nov 2009 17:33:23 +0900
Message-ID: <4B03B153.8050507@gmail.com>
References: <20091116184242.GA22250@merlins.org> <20091116184853.GA23126@merlins.org> <4B0238EC.6060803@kernel.org> <20091117173955.GA19029@merlins.org> <4B0371F4.9060703@gmail.com> <20091118074145.GA24488@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:51066 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbZKRIdX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 03:33:23 -0500
Received: by ywh40 with SMTP id 40so131286ywh.33
        for <linux-ide@vger.kernel.org>; Wed, 18 Nov 2009 00:33:29 -0800 (PST)
In-Reply-To: <20091118074145.GA24488@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hello,

11/18/2009 04:41 PM, Marc MERLIN wrote:
> Didn't know about -a, good call.
> Yep, they do and the times are about consistent with the raid going down
> 
> Not sure if the last 5 errors are enough to give a good clue, or not.
> 
> If I can't quite figure it out, I'll just pop in a 16 port adaptec sata 
> board I recently picked up. It'll take PMP out of the equation if I truly
> have drives returning read / write errors that don't quite seem to show up
> in smart yet.
> 
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   84 51 00 46 59 70 44
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   61 08 00 3f 59 70 40 08  13d+19:41:56.500  WRITE FPDMA QUEUED

All the loggedcommands are write but the one which triggered the
failure was read.  Error value of 0x84 indicates ICRC and ABORT, so
all the logged commands were failed due to transmission failure from
the host.  Hmmm....

-- 
tejun
