From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc5] libata: add HTS541616J9SA00 to NCQ blacklist
Date: Mon, 25 Jun 2007 13:29:15 +0900
Message-ID: <467F449B.1040200@gmail.com>
References: <fa.sspu6LOivd/touNtS2IsMKPqHa0@ifi.uio.no> <fa.19XJG1Asdp1zwcWLxolIH6F+5lY@ifi.uio.no> <467EC909.9040006@shaw.ca> <467F2495.3080509@gmail.com> <467F286B.40607@gmail.com> <467F2ADF.1040600@shaw.ca> <467F2D53.2000202@gmail.com> <467F3AE2.7010606@vc.cvut.cz> <467F3EF6.4000907@gmail.com> <467F4031.8000406@shaw.ca> <467F42F3.1000609@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:46819 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbXFYE3V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 00:29:21 -0400
Received: by py-out-1112.google.com with SMTP id u77so1527793pyb
        for <linux-ide@vger.kernel.org>; Sun, 24 Jun 2007 21:29:20 -0700 (PDT)
In-Reply-To: <467F42F3.1000609@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, enricoss@tiscali.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Petr Vandrovec wrote:
>>> Hmmm... The last one (HTS541612J9SA00) is taken directly from hdparm
>>> output, and I think I verified the patch with the reporter.  Hmm... Can
>>> anyone verify these module strings?
>>
>> Could well be that they've started attaching Hitachi to the ID strings
>> now.. In the past it hasn't seemed to have been Hitachi's (and IBM's
>> before that) practice to have it there, but maybe they see the
>> advantage of being able to figure out who made the drive now :-)
> 
> Perhaps ones sold directly by Hitachi are Hitachi, while ones sold
> through OEMs are no-name?

I dunno but I doubt they care that much about the model string but one
way or the other we might have to do pattern matching on HTS541* anyway.

-- 
tejun
