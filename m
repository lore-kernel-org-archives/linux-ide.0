From: Marc Singer <elf@buici.com>
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Date: Fri, 14 May 2004 10:28:39 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040514172839.GB18884@buici.com>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405141852.25816.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:8841 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261862AbUENR2k
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 13:28:40 -0400
Content-Disposition: inline
In-Reply-To: <200405141852.25816.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 06:52:25PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> This code won't even compile it the current form:
> it uses ide_ioreg_t but I killed all users of ide_ioreg_t
> and obsoleted <asm/hdreg.h> braindamage.

I'm not suprised that it doesn't work.

Please point me to a righteous example.
