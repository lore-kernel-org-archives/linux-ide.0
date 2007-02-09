From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) piix/slc90e66: more tuneproc() fixing
Date: Fri, 09 Feb 2007 18:46:39 +0300
Message-ID: <45CC975F.5070002@ru.mvista.com>
References: <200702062214.28136.sshtylyov@ru.mvista.com> <58cb370e0702061747u2bf64993ic5feab867f13d628@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55450 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946600AbXBIPqr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Feb 2007 10:46:47 -0500
In-Reply-To: <58cb370e0702061747u2bf64993ic5feab867f13d628@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>> The tuneproc() method in both these drivers failed to set the drive's 
>> own speed.
>> Fix this by renaming the function and "wrapping around it" the new 
>> tuneproc()
>> method.  While at it, convert the rest of the PIO setup code into 
>> proper C. :-)

>> Warning: this has only been compile tested (but we are in the merge 
>> window
>> already anyway :-).

> I tested it quickly on ICH4.

>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    Could you replace it with updated version I'm going to send today?
I've overlooked one change...

MBR, Sergei
