From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for CHS only devices
Date: Wed, 23 Feb 2005 17:50:00 +0100
Message-ID: <58cb370e050223085039cb0731@mail.gmail.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com>
	 <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.206]:28834 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261500AbVBWQuD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2005 11:50:03 -0500
Received: by wproxy.gmail.com with SMTP id 68so1613522wra
        for <linux-ide@vger.kernel.org>; Wed, 23 Feb 2005 08:50:03 -0800 (PST)
In-Reply-To: <421C6840.7090903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>

Hi,

[ generic comment about PATA support in libata, yes wrong thread 8) ]

I think that at one point libata and IDE drivers should be merged.
Yes, this is doable and I plan to prove it soon (this shouldn't be so
hard nowadays :-).  I really don't want to have two PATA drivers in
the tree with subtle differences (i.e. CHS handling) when one would
work in some cases (i.e. 4 Promise controllers) and the second one
in other cases (i.e. ATAPI support).  I'm sure you get the point.

Cheers,
Bartlomiej
