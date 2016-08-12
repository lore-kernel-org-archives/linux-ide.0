From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Thu, 11 Aug 2016 21:18:47 -0400
Message-ID: <yq1y442pyx4.fsf@sermon.lab.mkp.net>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
	<1470790829-3793-3-git-send-email-shaun@tancheff.com>
	<CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
	<CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
	<CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
	<CAGnHSE=EnhLwzfuu4wY=WbsA4PJ5tNfwBqErjLL10ea8d3EiGg@mail.gmail.com>
	<yq1lh04rs8z.fsf@sermon.lab.mkp.net>
	<CAGnHSE=u1fPLVt4h_VxnCqHTx_YgyQhPGoiXgkoVd1jhrAogiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36023 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbcHLBTD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 21:19:03 -0400
In-Reply-To: <CAGnHSE=u1fPLVt4h_VxnCqHTx_YgyQhPGoiXgkoVd1jhrAogiw@mail.gmail.com>
	(Tom Yan's message of "Thu, 11 Aug 2016 16:46:31 +0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Shaun Tancheff <shaun.tancheff@seagate.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>

>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:

>> Many drives from different vendors were affected by this. So we'd
>> have to make multi block payloads an explicit opt-in like we did for
>> discard_zeroes_data. However, given that "big" discards are mainly
>> done synchronously when creating filesystems, I am not sure there is
>> any real benefit to this.

Tom> Probably. Perhaps it could make a difference upon deletion of some
Tom> really big files (though the logical sectors used may not be
Tom> continuous anyway).

Nope. And you've got the bio size limit getting in the way as well.

-- 
Martin K. Petersen	Oracle Linux Engineering
