From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: ATA Passthru "status return descriptor" additional length field
Date: Wed, 27 Jul 2005 13:04:03 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D060A7F@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:19726 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S262495AbVG0UEE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2005 16:04:04 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-ide@vger.kernel.org

I have one, but I'm still working with my employer to make sure I'm allowed
to submit it.

Tim

-----Original Message-----
From: John W. Linville [mailto:linville@tuxdriver.com]
Sent: Wednesday, July 27, 2005 10:26 AM
To: Timothy Thelin
Cc: linux-ide@vger.kernel.org
Subject: Re: ATA Passthru "status return descriptor" additional length
field


On Wed, Jul 27, 2005 at 10:13:13AM -0700, Timothy Thelin wrote:

> The libata code sets that field to 14 (the size of the whole status return
> descriptor), but the SAT spec (May 17) shows that field set to 12.  Which
is
> correct?

I'm sure the spec is correct...gotta patch? :-)

John
-- 
John W. Linville
linville@tuxdriver.com
