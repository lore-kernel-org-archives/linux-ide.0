From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Tue, 05 Oct 2004 09:27:08 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096932428.9539.117.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <1096851939.9516.53.camel@gaston> <1096852823.9539.61.camel@gaston>
	 <200410042335.37109.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:7560 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268700AbUJDXcP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2004 19:32:15 -0400
In-Reply-To: <200410042335.37109.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Tue, 2004-10-05 at 07:35, Bartlomiej Zolnierkiewicz wrote:

> Maybe indeed cluttering PCI layer or arch includes with
> information needed only by IDE driver is better...

In this case it is. This is a platform provided information that
is of use of drivers that are platform agnostic. It's always a good
thing to keep platform specific stuff in the platform code outside
of drivers that are generic if we can...

Ben.
 

