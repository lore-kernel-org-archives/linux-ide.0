From: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
Date: Fri, 06 Aug 2004 11:23:41 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408061623.i76GNfDa016095@falcon10.austin.ibm.com>
References: <4112E2D7.9020606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pixpat.austin.ibm.com ([192.35.232.241]:5114 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S268155AbUHFQYP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Aug 2004 12:24:15 -0400
In-reply-to: <4112E2D7.9020606@pobox.com> 
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brett Russ <russb@emc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>


On Thu, 05 Aug 2004 21:45:59 EDT, Jeff Garzik wrote:
>ATAPI works too.....  assuming your CD/DVD drive never encounters a 
>CHECK CONDITION requiring REQUEST SENSE to be issued...  ;-)

  Heh.  Where should one start looking to get this enabled?  I have to
  admit that I have given the code only a few minutes viewing.

++doug
