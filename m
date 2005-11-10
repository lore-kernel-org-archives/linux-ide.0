From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] pmac ide doesn't properly cleanup hwif when
	releasing controller
Date: Thu, 10 Nov 2005 22:13:17 +1100
Message-ID: <1131621197.24637.180.camel@gaston>
References: <20051029044852.1a518908@Tatooine.r3z0>
	 <1130623795.29054.179.camel@gaston>
	 <58cb370e0511010820p77bd47c9wa566f3d356291733@mail.gmail.com>
	 <1130878823.29054.449.camel@gaston>
	 <58cb370e0511020005q27acb8fdg16acb1f307fafe7b@mail.gmail.com>
	 <1130926888.20136.21.camel@gaston>
	 <58cb370e0511100256n6fed6267v4c14b92dbd41680f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:12728 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750749AbVKJLPg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2005 06:15:36 -0500
In-Reply-To: <58cb370e0511100256n6fed6267v4c14b92dbd41680f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-ide@vger.kernel.org

On Thu, 2005-11-10 at 11:56 +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi Ben,
> 
> Thibaut's change is fine with me so unless you've better one I would
> like to merge it for 2.6.15.

Yup, go for it !

Thanks,
Ben.


