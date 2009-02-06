From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 06 Feb 2009 13:55:59 +0300
Message-ID: <498C173F.4000908@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <200902041547.44149.stf_xl@wp.pl> <4989BC8B.4010105@ru.mvista.com> <200902051601.50822.stf_xl@wp.pl> <498B0F22.3090403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16605 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753949AbZBFK4E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 05:56:04 -0500
In-Reply-To: <498B0F22.3090403@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Hello, I wrote:

>>    Can you answer the simple question: why we should try to support 
>> two incompatible chips with a single driver? Because the driver name 
>> will be shorter? :-)
>
>> Very funny. I think patch adding RM9200 support to this driver will 
>> have less
>> than 50 lines changeset,  whereas writing new driver would be about 
>> 500 lines.
>
>    This approach is so broken-minded that I'm just out words to argue 
> any more.
>    Let's then support say all the PCI IDE chipsets with the single 
> driver (actully, there was a driver that tried to support 2 
> incompatible Promise chip families but it got split finally).

   To say the truth, there are stil at least 2 examples of such drivers: 
hpt366 and aec6210. While the former is justified by the bogus chip 
identification poilicy used by the vendor, the latter has no 
justification at all.

MBR, Sergei


