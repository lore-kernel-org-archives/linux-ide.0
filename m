From: Micha <micha-1@fantasymail.de>
Subject: ide-cd dvd problem...
Date: Wed, 22 Dec 2004 21:36:10 +0100
Message-ID: <200412222136.10940.micha-1@fantasymail.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:50117 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262032AbULVUgN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2004 15:36:13 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


with kernel 2.6.9 I had the following problem:
watching some (not all) dvds allways breaks with libdvdread giving the error 
"can't seek to block x" (x > 2000000). After trying the dvd with windows 
(sigh) and it worked, I googled and found the keyword ide-scsi together with 
this error. I change to ide-scsi emulation for my dvd-rom and now the dvd 
works. 
Now, this can be a bug of libdvdread or the ide-cd system.  Is this some know 
issue? I thought ide-scsi is deprecated in 2.6. ?
(maybe the list for libdvdread would be the right one, sorry if so...)

cheers
 Michael

