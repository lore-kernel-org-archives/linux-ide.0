From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Mon, 4 Aug 2008 09:36:46 -0500 (GMT-05:00)
Message-ID: <6738527.1217860606852.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:51686 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756955AbYHDOhG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 10:37:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, blward@micron.com

Thank you for your response, Tejun.  We have figured some things out since I first e-mailed.  We have been using IOMeter running on a remote Windows system which connects to a Dynamo module running on the Linux target.  The Dynamo module uses a file open command with an O_DIRECT flag to minimize the effects of caching.  Unfortunately, this causes the IO to be totally synchronous which is kinda bad for this type of benchmarking.

I have another question for you.  Where can I find information on how to get the AHCI driver to recognize our new AHCI controller?

Thank you!
Bob

-----Original Message-----
>From: Tejun Heo <tj@kernel.org>
>Sent: Jul 31, 2008 11:06 PM
>To: the4hoffmans@earthlink.net
>Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, blward@micron.com
>Subject: Re: Issue with AHCI driver
>
>the4hoffmans@earthlink.net wrote:
>> Sorry about the multiple e-mails Jeff, but our IT group has seen fit
>> to deny me the ability to send e-mail to vger.kernel.org so I'm
>> trying again from my own personal account. 
>> -------------------------------------------------------------------
>> 
>> 
>> My name is Bob Hoffman.  I am a software engineer for Micron
>> Technology in Minneapolis.  I have been working on AHCI drivers.  We
>> recently installed kernel build 2.6.19.0 (unpatched) of Linux on an
>> Intel motherboard system which includes the ICH9 SATA controller.  We
>> have been running some benchmarks and found that the SATA harddrives
>> looked slow.  When I attached a SATA analyzer it shows that we are
>> only getting one command "in flight" or "outstanding" at a time, and
>> it is always slot (or tag) zero.  The AHCI driver doesn't seem to be
>> taking advantage of the 32 deep queue.
>> 
>> I checked the queue depth using the info at
>> http://linux-ata.org/faq.html#io32 and it shows "NCQ (depth 31/32)".
>> I'm wondering if there is something else I need to know.
>> 
>> I've copied our "Linux guru", Bob Ward, who knows more about the
>> kernel stuff than I do.
>> 
>> Thank you for any help you can provide. Bob (Hoffman) ; ) -- To
>> unsubscribe from this list: send the line "unsubscribe linux-ide" in 
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>> 
>
>What kind of workload are you testing?  If you're doing multiple random
>IOs, using deadline io scheduler will give you a better result.  Can't
>say whether that would help on any realistic workload tho.
>
>-- 
>tejun

