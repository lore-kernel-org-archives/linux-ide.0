From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 17:21:35 -0500
Message-ID: <41C8A1EF.8040605@pobox.com>
References: <20041221202407.GD2725@artsapartment.org> <41C88F73.2090606@pobox.com> <20041221133056.6a5a3259.akpm@osdl.org> <41C89ADE.1010403@pobox.com> <41C89C63.8090708@osdl.org> <20041221220137.GA5399@havoc.gtf.org> <41C89E03.2080206@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261881AbULUWVn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Dec 2004 17:21:43 -0500
In-Reply-To: <41C89E03.2080206@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, ahaas@airmail.net, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Randy.Dunlap wrote:
> Jeff Garzik wrote:
> 
>> On Tue, Dec 21, 2004 at 01:57:55PM -0800, Randy.Dunlap wrote:
>>
>>> But the real question to me (other than "will some old-style
>>> initializers be deprecated by gcc in the future?") is
>>
>>
>>
>> Note that the code in question did not use initializers at all,
>> so that's an unrelated issue.
>>
>> The code was, and remains, compliant to C99 standards.
> 
> 
> It looks to me like it used unnamed initializers, not named ones,
> and not the gcc-specific ones that we have a need to move away
> from.

Sorry, that's what I meant, yes.

	Jeff



