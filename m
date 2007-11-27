From: "Mikael Starvik" <mikael.starvik@axis.com>
Subject: RE: [PATCH 7/21] ide-cris: don't override ide_register_hw() result
Date: Tue, 27 Nov 2007 14:18:48 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66804C40242@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668055FDB15@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:45779 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbXK0NTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 08:19:08 -0500
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668055FDB15@exmail1.se.axis.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Sergei Shtylyov' <sshtylyov@ru.mvista.com>, 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <mikael.starvik@axis.com>

Acked-by: Mikael Starvik <starvik@axis.com>

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com] 
Sent: Tuesday, November 27, 2007 1:58 PM
To: Bartlomiej Zolnierkiewicz
Cc: linux-ide@vger.kernel.org; Mikael Starvik
Subject: Re: [PATCH 7/21] ide-cris: don't override ide_register_hw() result


Bartlomiej Zolnierkiewicz wrote:

> * Don't override ide_register_hw() result and check if there is a hwif
>   available to use.

> * MAX_HWIFS is user configurable nowadays so replace it by hard-coded
value.

> * Remove the comment about ide_hwifs[].

> Cc: Mikael Starvik <starvik@axis.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

