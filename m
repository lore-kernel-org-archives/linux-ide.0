From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: hdparm ATA Security Options return errors
Date: Wed, 19 Oct 2005 17:20:34 +0200
Message-ID: <43566442.3000602@gmx.de>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de> <4353E257.5060104@gmx.de> <43540A36.2080404@rtr.ca> <4355FC28.2020704@gmx.de> <4356624A.2000307@rtr.ca>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:24532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751047AbVJSPUy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2005 11:20:54 -0400
In-Reply-To: <4356624A.2000307@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>

Mark Lord wrote:
> thomas schorpp wrote:
> 
>> Mark Lord wrote:
>>
>>> I think the entire set of ATA security patches that were
>>> sent to me for hdparm are bogus -- I lack the setup here
>>> to try them, but another kind person is preparing patches
>>> for hdparm to fix them.
> 
> 
> hdparm-6.3 is now out, with working security commands.
> 
> But there is still a bug deep in the IDE taskfile code
> that sometimes causes problems.  Someday I might have time
> to dig deeper into the kernel and fix that issue.
> 
> -ml
> -

wow! You guys are fast :) ill test and report next days.

also diggin in taskfile stuff next weeks

