From: Marc Singer <elf@buici.com>
Subject: overriding ioops
Date: Sat, 5 Jun 2004 13:19:53 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040605201953.GA14917@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:26007 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261939AbUFEUTy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jun 2004 16:19:54 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I know that you me to do this differently that I did in 2.6.4.  I need
to override the hwif->OUTB (et, all) functions.  Do I implement my own
version of the default_hwif_ function?  

