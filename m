From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 3/4] libata: interrupt driven pio for libata-core
Date: Wed, 28 Sep 2005 12:09:03 -0400
Message-ID: <433AC01F.5040708@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com> <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:19172 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751095AbVI1QJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2005 12:09:11 -0400
In-Reply-To: <433912FB.9000606@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

applied patches 3-4 to 'irq-pio' branch of libata-dev.git.

After verifying that EVERY driver continues to work, we can merge this 
upstream.  This change will need a lot of testing.

Also, note that adding support for READ/WRITE MULTIPLE SECTORS would be 
nice.  This will involve slight changes to the PIO code, and a SET 
MULTIPLE MODE command during probe time.

Thanks for working on this!


