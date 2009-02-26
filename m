From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA support for 4k sector size
Date: Wed, 25 Feb 2009 19:17:08 -0500
Message-ID: <yq1k57egigr.fsf@sermon.lab.mkp.net>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	<49A5D76A.3010301@zytor.com> <yq11vtmhy0x.fsf@sermon.lab.mkp.net>
	<49A5DAE7.3060409@zytor.com> <yq1skm2giwa.fsf@sermon.lab.mkp.net>
	<49A5DDF7.9070301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:32846 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZBZASb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 19:18:31 -0500
In-Reply-To: <49A5DDF7.9070301@zytor.com> (H. Peter Anvin's message of "Wed\, 25 Feb 2009 16\:10\:31 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:

hpa> That's ridiculously stupid.  All you need is an offset parameter,
hpa> which can be flipped at will.  Now, flipping it will obviously
hpa> scramble all data, but there is absolutely no reason why it
hpa> shouldn't be possible to instantaneously flip it back and forth.

I'm just quoting what I was told a few months ago.  I'm not
participating in IDEMA and for all I know that approach could have
changed again.

I'll ask one of my contacts to find out what the current status is...

-- 
Martin K. Petersen	Oracle Linux Engineering
