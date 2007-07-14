From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI driver prints "D2H reg with I during NCQ" message, what
 is it?
Date: Sat, 14 Jul 2007 13:12:22 +0900
Message-ID: <46984D26.5080807@gmail.com>
References: <46979A3A.2090005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:17235 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbXGNEMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 00:12:31 -0400
Received: by py-out-1112.google.com with SMTP id d32so1163151pye
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 21:12:30 -0700 (PDT)
In-Reply-To: <46979A3A.2090005@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> I see this on boot with kernels 2.6.22.1 and 2.6.20.15:
> 
>      ata1: D2H reg with I during NCQ, this message won't be printed again
> 
> But I can't find anything that tells me what it means, or whether
> it's a real problem.

That's your firmware transmitting unnecessary D2H Reg FIS during NCQ
command phase.  It's minor protocol violation which can be ignored.  No
need to worry.

-- 
tejun
