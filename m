From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [4/9]
Date: Wed, 30 Jun 2004 12:12:24 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1088615544.1906.38.camel@gaston>
References: <200406301725.05181.bzolnier@elka.pw.edu.pl>
	 <1088611825.1921.18.camel@gaston>
	 <200406301916.46181.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:63979 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266788AbUF3RPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2004 13:15:42 -0400
In-Reply-To: <200406301916.46181.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>


> > What if we have a shared interrupt with another device ?
> 
> drive_is_ready() in ide-io.c:ide_intr() handles that.

Right, I figured that out about 5 minutes after sending the mail ;)

Ben.


