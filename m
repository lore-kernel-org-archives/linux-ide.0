From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: hdparm ATA Security Options return errors
Date: Wed, 19 Oct 2005 10:35:52 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BEBC@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:27268 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1751184AbVJSRf4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2005 13:35:56 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, t.schorpp@gmx.de
Cc: linux-ide@vger.kernel.org


> hdparm-6.3 is now out, with working security commands.
> 
> But there is still a bug deep in the IDE taskfile code
> that sometimes causes problems.  Someday I might have time
> to dig deeper into the kernel and fix that issue.
> 

And what bug is this? (Sorry if you already stated it, I didn't see it while
going through the archives of this conversation).  I use taskfile and have a
vested interest in getting all taskfile bugs fixed.  FYI there was a bug
where pio-out taskfile commands could oops because of a null request
pointer; the patch I submitted for that one should be in the 2.6.14 rc
series now.

Regards,
Tim Thelin
