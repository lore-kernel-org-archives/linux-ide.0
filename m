From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Fri, 25 Feb 2005 13:22:05 +0800
Message-ID: <421EB5FD.6040200@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com> <421D41C2.3030909@pobox.com> <421D663B.5050107@tw.ibm.com> <421D679B.7020508@pobox.com> <421D7727.4030408@tw.ibm.com> <421D78A2.8090103@pobox.com> <421D7BD2.7030309@tw.ibm.com> <421D86CA.3010606@pobox.com> <421EB13F.4000503@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:25591 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262528AbVBYFWX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 00:22:23 -0500
In-Reply-To: <421EB13F.4000503@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>


Albert Lee wrote:
> 
>   Rediff'ed against 2.6.11-rc5 + C/H/S patches.
> Attached please find the revised patch for your review.
> 

I forgot to mention. The correct title, as indicated by Mark, should be:
"Issue INITIALIZE DEVICE PARAMETERS for pre-ATA4 or CHS only devices"


Albert


