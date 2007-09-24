From: "Peer Chen" <peerchen@gmail.com>
Subject: Re: Re: [PATCH] ahci: Add MCP79 support to AHCI driver
Date: Mon, 24 Sep 2007 10:02:12 +0800
Message-ID: <200709241002079067823@gmail.com>
References: <200709211406065332552@gmail.com>,
 <20070921113908.180cd154@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:11602 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbXIXCCS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 22:02:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1290042rvb
        for <linux-ide@vger.kernel.org>; Sun, 23 Sep 2007 19:02:17 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>

Yes,it's necessary because our RAID controller also use the ahci driver=
=2E

------------------				=20
Peer Chen
2007-09-24

-------------------------------------------------------------
=B7=A2=BC=FE=C8=CB=A3=BAAlan Cox
=B7=A2=CB=CD=C8=D5=C6=DA=A3=BA2007-09-21 18:32:09
=CA=D5=BC=FE=C8=CB=A3=BAPeer Chen
=B3=AD=CB=CD=A3=BAlinux-kernel; linux-ide; akpm; jeff
=D6=F7=CC=E2=A3=BARe: [PATCH] ahci: Add MCP79 support to AHCI driver

On Fri, 21 Sep 2007 14:06:10 +0800
"Peer Chen" <peerchen@gmail.com> wrote:

> Add the MCP79 support to ahci driver.
> The patch base on kernel 2.6.23-rc7

Is this actually needed or as they are standard ahci devices will the
class match get them anyway ?

