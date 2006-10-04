From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Thu, 5 Oct 2006 05:02:14 +0900
Message-ID: <20061004200214.GA6664@localhost.Internal.Linux-SH.ORG>
References: <20061004074535.GA7180@localhost.hsdv.com> <A1AC65D6-07AC-42CB-80F1-9621DBCACF83@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:14021 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1030833AbWJDMDy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2006 08:03:54 -0400
Content-Disposition: inline
In-Reply-To: <A1AC65D6-07AC-42CB-80F1-9621DBCACF83@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: girish <girishvg@gmail.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de, ysato@users.sourceforge.jp

On Wed, Oct 04, 2006 at 08:30:36PM +0900, girish wrote:
> question:  where is linux/ide-platform.h header?
> 
answer: there isn't one, as it's not needed. The reason for using
platform devices is so we get _away_ from this ridiculous static set of
definitions for I/O addresses and IRQs that are sprinkled around a lot
of these drivers.
