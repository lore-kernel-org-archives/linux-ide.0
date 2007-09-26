From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Wed, 26 Sep 2007 08:19:12 -0600
Message-ID: <46FA6A60.2000700@gmail.com>
References: <46F7FBCB.4030803@gmail.com> <46F9E2CB.9000002@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060406000509040009080407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:10575 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbXIZOTU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 10:19:20 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1466095nze
        for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 07:19:19 -0700 (PDT)
In-Reply-To: <46F9E2CB.9000002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060406000509040009080407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Would it also be possible for you to send along 'hdparm --Istdout'
> output for your config disk thingy, /dev/sdd ?

Sure, just don't ask me what it is!  (I've generally assumed that
writing to it would be a bad idea.)

Berck

--------------060406000509040009080407
Content-Type: text/plain;
 name="hdparmthingy"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparmthingy"


/dev/sdd:
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 3030 3030 3030 315f 5f5f 5f5f
5f5f 5f5f 5f30 5f45 0003 3e00 0004 5247
4c31 3033 3634 436f 6e66 6967 2020 4469
736b 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8001
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0101 0280 0000 0000 0407
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0201 0000 0000 0000
007e 001b 0068 5060 4000 0000 1000 4000
407f 0000 0000 0000 fffe 0000 c0fe 0000
0000 0000 0000 0000 0002 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0017 2040
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 b4a5

--------------060406000509040009080407--
