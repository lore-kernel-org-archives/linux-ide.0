From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: CD and dvd devices not recognized
Date: Thu, 22 Mar 2007 12:37:29 +0000
Message-ID: <20070322123729.14f11b96@lxorguk.ukuu.org.uk>
References: <45F873AC.6010204@gmail.com>
	<200703172107.42107.bzolnier@gmail.com>
	<45FD0F68.7090207@gmail.com>
	<200703181610.33714.bzolnier@gmail.com>
	<45FE7DCC.3000507@ru.mvista.com>
	<45FEE5EB.9020909@gmail.com>
	<4600BA1C.7060300@tw.ibm.com>
	<4600F45C.3000303@gmail.com>
	<46021CDA.3070807@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52366 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030519AbXCVLmW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 07:42:22 -0400
In-Reply-To: <46021CDA.3070807@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, YUP <yupadmin@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>

> We have two possible solutions here:
> a. Patch Ubuntu, such that the incorrect INQUIRY is fixed.
> b. Patch kernel, such that the AOpen drives are blacklisted.
>    Each INQUIRY is inspected for the blacklisted drives.
>    If the INQUIRY looks wrong, the INQUIRY is rejected.
> 
> I guess a. is the preferred solution...

We have two problems here

#1 Ubuntu got the inquiry command wrong

#2 Until now we considered "INQUIRY" a safe command for SG_IO passthrough.

We can't really take INQUIRY out of SG_IO so do we decide its the
hardware vendors problem or do something cleverer in the filters ?

Alan
