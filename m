From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [libata-dev#upstream-fixes RESEND] libata-sff: fix spurious IRQ
 handling
Date: Tue, 23 Mar 2010 10:15:20 -0400
Message-ID: <4BA8CCF8.5060108@garzik.org>
References: <4BA7253F.8070500@kernel.org> <4BA82BDF.2070308@garzik.org> <4BA83458.6010003@kernel.org> <4BA8C57D.7030502@garzik.org> <4BA8C8D7.6040209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43684 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab0CWOPZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Mar 2010 10:15:25 -0400
Received: by pwi5 with SMTP id 5so3339982pwi.19
        for <linux-ide@vger.kernel.org>; Tue, 23 Mar 2010 07:15:25 -0700 (PDT)
In-Reply-To: <4BA8C8D7.6040209@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, b3nton@gmail.com, petr.uzel@centrum.cz, "Rafael J. Wysocki" <rjw@sisk.pl>

On 03/23/2010 09:57 AM, Tejun Heo wrote:
> Hello, Jeff.
>
> On 03/23/2010 10:43 PM, Jeff Garzik wrote:
>> Still corrupted and not working...  Because it is an important fix, I
>> manually applied it by recreating the patch, chunk by chunk.
>
> It was TB's text flowed setting which behaves differnetly in the new
> version.  The RE-RESEND I sent later is okay.  Sorry about the
> trouble.

Strange; I received the resend, but not the re-resend.  I am worried 
that my mail setup is behaving strangely, too.  I download all email 
from gmail to TB via IMAP, these days.

	Jeff




