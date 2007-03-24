From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [3/5] 2.6.21-rc4: known regressions (v2)
Date: Sat, 24 Mar 2007 12:02:30 -0600
Message-ID: <m1slbu4j0p.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<20070323185022.GQ752@stusta.de> <46055A3B.6050107@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49745 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbXCXSHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Mar 2007 14:07:19 -0400
In-Reply-To: <46055A3B.6050107@m3y3r.de> (Thomas Meyer's message of "Sat, 24
	Mar 2007 18:04:59 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org

Thomas Meyer <thomas@m3y3r.de> writes:

> Adrian Bunk schrieb:
>> Subject    : second suspend to disk in a row results in an oops  (libata?)
>> References : http://lkml.org/lkml/2007/3/17/43
>> Submitter  : Thomas Meyer <thomas@m3y3r.de>
>> Status     : unknown
>>   
>
> The problem is identified: http://lkml.org/lkml/2007/3/22/150

Given the description above I'm a little confused.  Doesn't this
happen every time now?

Or was this happening only the second time before I started my msi
fixes... 

Eric
