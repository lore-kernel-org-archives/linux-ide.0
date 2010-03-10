From: Mark Lord <kernel@teksavvy.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 01:08:16 -0500
Message-ID: <4B973750.3050103@teksavvy.com>
References: <4B947393.2050002@kernel.org> <4B965348.3050201@teksavvy.com> <4B96E136.3030001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:18647 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753247Ab0CJGIZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2010 01:08:25 -0500
In-Reply-To: <4B96E136.3030001@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

On 03/09/10 19:00, Tejun Heo wrote:
> On 03/09/2010 10:55 PM, Mark Lord wrote:
>> On 03/07/10 22:48, Tejun Heo wrote:
>> ..
>>> Please note that hdparm is misreporting the alignment offset.  It
>>> should be reporting 512 instead of 256 for offset-by-one drives.
>> ..
>>
>> That issue was fixed quite a while ago.
>> Upgrade your elderly copy of hdparm.
>
> Heh heh, *you* were keeping it from me!  Anyways, is there hdparm
> devel tree published somewhere?  I wandared the SF page for quite a
> bit (which for some reason is very difficult to find things in) but I
> couldn't find one.  If it's not, it might be a good idea to put it on
> SF or git.kernel.org?
..

No tree.  There's just my working copy (private),
and the published versions at SF.

But yes, SF has gotten incredibly more cryptic to use of late,
and I might have to move it somewhere more accessible soon.

Cheers!
