From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Tue, 07 Apr 2009 18:26:55 -0400
Message-ID: <49DBD32F.3090703@garzik.org>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <20090402165117.GQ2661@linux.intel.com> <200904022137.35671.bzolnier@gmail.com> <200904072339.00224.bzolnier@gmail.com> <20090407221554.GA4527@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46398 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbZDGW1C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 18:27:02 -0400
In-Reply-To: <20090407221554.GA4527@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

Matthew Wilcox wrote:
> On Tue, Apr 07, 2009 at 11:38:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
>> I would like to see this merged for -rc1 so I tried to put it altogether
>> and then integrate it over recent IDE and block changes...
> 
> You're missing 1/5 and 2/5.  This patch will crash horribly if you use
> it with a drive which supports TRIM.

For things that need to hit along with the block layer, Bart and I could 
Ack the IDE+libata patches, and Jens could merge all of them.

Or just poke Jens to review and merge the block stuff.  Then the rest 
can go at any time.

	Jeff



