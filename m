From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: LSISAS1068E + WDC WD2002FYPS: I/O error & Sense Key
Date: Wed, 29 Jul 2009 16:07:14 -0400
Message-ID: <20090729200714.GA20706@lifeintegrity.com>
References: <20090727060322.GB27002@lifeintegrity.com> <4A70A64A.2070605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from static-173-48-39-13.bstnma.fios.verizon.net ([173.48.39.13]:45198
	"EHLO lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbZG2UxA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 16:53:00 -0400
Received: from vent.lifeintegrity.com (70-88-222-26-cambridge-ma.hfc.comcastbusiness.net [70.88.222.26])
	by submission.lifeintegrity.com (Postfix) with ESMTPS id 261C9A3CD
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 16:07:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4A70A64A.2070605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2009-07-29T13:43:06, Robert Hancock wrote:
> On 07/27/2009 12:03 AM, Allan Wind wrote:
>> I have a pair of Western Digital RE4-GP (WD2002FYPS) in RAID1 configuration
>> using Linux 2.6.30.3 and seeing the following:
>>
>> [ 4907.485324] end_request: I/O error, dev sdb, sector 3907028974
>
> Are there no error messages before this point? Can you post the full  
> dmesg output from bootup?

Thanks for looking into this, Robert.  I do not see any relevant error 
message before this point, but made the entire 82k dmesg available here:
http://lifeintegrity.com/~allan/dmesg


/Allan
-- 
Allan Wind
Life Integrity, LLC
<http://lifeintegrity.com>

