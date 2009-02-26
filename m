From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 19:07:49 -0500
Message-ID: <yq1skm2giwa.fsf@sermon.lab.mkp.net>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	<49A5D76A.3010301@zytor.com> <yq11vtmhy0x.fsf@sermon.lab.mkp.net>
	<49A5DAE7.3060409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:31598 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZBZAIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 19:08:14 -0500
In-Reply-To: <49A5DAE7.3060409@zytor.com> (H. Peter Anvin's message of "Wed\, 25 Feb 2009 15\:57\:27 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:

hpa> Martin K. Petersen wrote:
>> 
>> Modern Windows aligns the first partition on a 1 MB boundary.
>> 
>> As far as disks go, initially the plan was to have "legacy" branded
>> drives with 63-sector alignment.  But I think that has been abandoned
>> in favor of instant one-time formatting.  I.e. you can pick your
>> poison *once* and that formatting will be done in constant time.  Any
>> subsequent changes to blocking and alignment will require a real
>> low-level format.
>> 

hpa> Why one-time?

It's a compromise to avoid hours of low-level formatting before you can
use a drive.  New drives will come from the factory formatted in a
special way that can be switched instantaneously.  But once you start
writing you're stuck with it.

-- 
Martin K. Petersen	Oracle Linux Engineering
