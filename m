From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 4/4] libata: allow hyphenated pattern ranges
Date: Mon, 05 Jul 2010 17:47:43 -0400
Message-ID: <4C3252FF.3040501@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com> <4C31EB69.5070903@teksavvy.com> <4C322585.602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:47357 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752837Ab0GEVr6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 17:47:58 -0400
In-Reply-To: <4C322585.602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 05/07/10 02:33 PM, Jeff Garzik wrote:
> On 07/05/2010 10:25 AM, Mark Lord wrote:
>> Enable use of hyphenated pattern ranges in glob_match(), similar to how
>> shell globbing works, and how developers might expect things to work.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>> ---
>>
>> Patch also attached, to get around ongoing mailer issues here.
>> Eventually, glob_match() will move out of libata into lib/string.c or
>> similar.
>
> No issue with correctness... but where is the demonstrated need?
>
> Did someone ask for this?
..

Not specifically.  But since this will eventually end up as a kernel-wide
library function, somebody somewhere will eventually make the reasonable
assumption that it does globbing "in the usual way".

Adding the hyphenated ranges turned out to be almost trivial,
so I added it on and posted the patch.

I could also send you follow-on patches to use that feature
in the ata blacklists, if you like, saving a few more bytes hither and dither.  :)

Speaking of this stuff.. how do we go about moving this function to /lib/strings.c  ?
Can that be done via your git tree?

Thanks
