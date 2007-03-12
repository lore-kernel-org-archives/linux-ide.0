From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv error with smartctl access
Date: Mon, 12 Mar 2007 16:30:03 +0900
Message-ID: <45F5017B.1040809@gmail.com>
References: <45F07930.6000102@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:39564 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965238AbXCLHaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 03:30:04 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1583296wxd
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 00:30:02 -0700 (PDT)
In-Reply-To: <45F07930.6000102@sauce.co.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <richard@sauce.co.nz>
Cc: linux-ide@vger.kernel.org

Richard Scobie wrote:
> Hi,
> 
> This may already be addressed, but in case anyone is interested.
> 
> Fedora Core 6 2.6.19-1.2911.6.5, NVIDIA MCP55 based board using sata_nv.
> 
> When querying a drive using smartctl and SMART is not enabled on the
> drive, I get the following error:
> 
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
> ata3: EH complete
[--snip--]
> This does not seem to cause any problems and once SMART is enabled,
> there are no more errors.

Yeah, that's just libata reporting that a command has failed, which is
expected in your case.  Maybe libata should shut up on passthru
commands.  Right, we're currently not honoring REQ_QUIET, but SG doesn't
seem to support that flag either.

Anyways, it's safe to ignore the messages.

-- 
tejun
