From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: ata1: COMRESET failed
Date: Tue, 08 Jan 2013 20:57:29 +0100
Message-ID: <50EC7A29.9000105@suse.cz>
References: <508A7A8A.7030908@suse.cz> <50BC8A1C.8070805@suse.cz> <20121203115734.GA32243@liondog.tnic> <20130107172425.GD5954@liondog.tnic> <50EB770A.4090302@intel.com> <50EC070C.2090101@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:55641 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab3AHT5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2013 14:57:37 -0500
In-Reply-To: <50EC070C.2090101@suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Shane Huang <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 01/08/2013 12:46 PM, Jiri Slaby wrote:
> On 01/08/2013 02:31 AM, Aaron Lu wrote:
>> On 01/08/2013 01:24 AM, Borislav Petkov wrote:
>>> Adding some more people.
>>>
>>> Aaron, Shane, do you guys have any ideas? I've been seeing something
>>> similar on an AMD desktop box recently and Jiri sees it on a laptop with
>>> an SSD.
>>
>> I've seen a similar problem on a bug report recently for a Crucial SSD,
>> and upgrading the disk's firmware fixed the problem:
>> https://bugzilla.kernel.org/show_bug.cgi?id=49701
>>
>> If the controller has problem, it should have problems for all kinds of
>> disks attached to it. So possible to test with other disks, Jiri?
> 
> Yes, I tested a normal spinning disk and it does not happen with that.
> This happens only with this Intel SSD: SSDSA2M080G2GC
> 
> So I will try to investigate how to upgrade the firmware and will report.

Yes, updating the firmware from 2CV102HD to 2CV102M3 indeed helped...
Thanks for the tip.

-- 
js
suse labs
