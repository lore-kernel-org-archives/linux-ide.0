From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Any recommended PATA or SATA chip for kernel 2.6.x ?
Date: Wed, 25 Feb 2004 18:44:04 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040225174404.GA662@merlin.emma.line.org>
References: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51348 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261487AbUBYRoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2004 12:44:08 -0500
Content-Disposition: inline
In-Reply-To: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
List-Id: linux-ide@vger.kernel.org
To: Kyle Wong <kylewong@southa.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 25 Feb 2004, Kyle Wong wrote:

> I found in the market that most PCI IDE card are using "siimage (CMD?),
> HiPoint and IT8212 chip, are they working well with 2.6.x ?

http://kerneltrap.org/node/view/1787

http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/dev/ata/ata-chipset.c?only_with_tag=MAIN#rev1.50

http://docs.freebsd.org/cgi/mid.cgi?402F88AB.8010003
http://docs.freebsd.org/cgi/mid.cgi?200311262104.hAQL4ICN024652
http://docs.freebsd.org/cgi/mid.cgi?40250AF7.3010804
http://docs.freebsd.org/cgi/mid.cgi?4022B5EF.4030807
http://docs.freebsd.org/cgi/mid.cgi?4023BF1C.6020008
