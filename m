From: Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH] ARM{26} IDE cleanups
Date: Wed, 21 Apr 2004 01:42:10 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040421014210.6256e8f1.spyro@f2s.com>
References: <200404202335.59291.bzolnier@elka.pw.edu.pl>
	<20040420233323.F16428@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from i-194-106-33-237.freedom2surf.net ([194.106.33.237]:34961 "EHLO
	i-194-106-33-237.freedom2surf.net") by vger.kernel.org with ESMTP
	id S264288AbUDUAm0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Apr 2004 20:42:26 -0400
In-Reply-To: <20040420233323.F16428@flint.arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Tue, 20 Apr 2004 23:33:23 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> How are you handling the different register increments between the
> machines?  Some have registers placed at +4 offsets, others +1.
> Others even +32.
> 
> I don't see any provision for this. 

I agree. having said that Im not asure why the arch code needs to setup IDE anyway - why cant it be done as a driver module?


-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with ketchup.
