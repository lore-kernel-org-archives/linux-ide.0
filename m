From: Mark Lord <mlord@pobox.com>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Sun, 23 Jun 2013 17:27:52 -0400
Message-ID: <51C76858.4060906@pobox.com>
References: <20130623101940.GA4448@amd.pavel.ucw.cz> <20130623112133.GA4837@amd.pavel.ucw.cz> <CAJBHPoj5hgp97=JH8UKX+Ty8TF9_ySQUYU6AnqcRjuLy5A-PcQ@mail.gmail.com> <20130623190003.GA6714@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab3FWVlX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jun 2013 17:41:23 -0400
In-Reply-To: <20130623190003.GA6714@amd.pavel.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcus Overhagen <marcus.overhagen@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, tj@kernel.org

On 13-06-23 03:00 PM, Pavel Machek wrote:
>
> Thanks for the hint. (Insert rant about hdparm documentation
> explaining that it is bad idea, but not telling me _why_ is it bad
> idea. Can I expect cache consistency issues after that, or is it just
> simple "you are writing to the disk without any checks"? Plus, I guess
> documentation should mention what sector number is. I guess sectors
> are 512bytes for the old drives, but is it 512 or 4096 for new
> drives?)

For ATA, use the "logical sector size".
For all existing drives out there, that's a 512 byte unit.

> ...but it does not do the trick :-(. It behaves strangely as if it was
> still cached somewhere. Do I need to turn off the write back cache?

No, it works just fine.  You probably have more than one bad sector.
After you see a read failure, run "smartctl -a" and look at the error
logs to see what sector the drive is choking on.

Or just low-level format it all with "hdparm --security-erase".

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
