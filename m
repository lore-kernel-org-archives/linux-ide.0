From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH libata-dev-2.6 1/3] Add CHS support
Date: Sun, 06 Feb 2005 09:41:59 -0500
Message-ID: <42062CB7.2040701@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <4205B886.4070005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from orb.pobox.com ([207.8.226.5]:38830 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261185AbVBFOmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2005 09:42:17 -0500
In-Reply-To: <4205B886.4070005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, "Mudama, Eric" <eric_mudama@Maxtor.com>

Jeff Garzik wrote:
>
> 3) In Promise's GPL'd driver for their SATA (w/ PATA) cards, they 
> unconditionally execute the INITIALIZE DEVICE PARAMETERS command.  I 
> wonder if we should do the same.

That command was *necessary* for certain drives at one time,
which refused all other commands until they received the IDP one.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

