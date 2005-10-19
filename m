From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm ATA Security Options return errors
Date: Wed, 19 Oct 2005 11:12:10 -0400
Message-ID: <4356624A.2000307@rtr.ca>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de> <4353E257.5060104@gmx.de> <43540A36.2080404@rtr.ca> <4355FC28.2020704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:3520 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751083AbVJSPMK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Oct 2005 11:12:10 -0400
In-Reply-To: <4355FC28.2020704@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: t.schorpp@gmx.de
Cc: linux-ide@vger.kernel.org

thomas schorpp wrote:
> Mark Lord wrote:
> 
>>I think the entire set of ATA security patches that were
>>sent to me for hdparm are bogus -- I lack the setup here
>>to try them, but another kind person is preparing patches
>>for hdparm to fix them.

hdparm-6.3 is now out, with working security commands.

But there is still a bug deep in the IDE taskfile code
that sometimes causes problems.  Someday I might have time
to dig deeper into the kernel and fix that issue.

-ml
