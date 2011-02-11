From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Fri, 11 Feb 2011 13:38:55 -0500
Message-ID: <4D55823F.5000200@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com>	<20110209153714.558133d7@lxorguk.ukuu.org.uk>	<4D52ECB6.4010408@cfl.rr.com>	<20110209214118.GA7196@atj.dyndns.org>	<4D5332D2.5090701@cfl.rr.com>	<4D534378.3050304@gmail.com>	<20110210091325.GK3770@htj.dyndns.org>	<4D54387F.3030809@cfl.rr.com>	<20110210193124.321b7ad6@lxorguk.ukuu.org.uk>	<4D557D8A.6050607@cfl.rr.com> <20110211182547.2ede69b5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:53536 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab1BKSi6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 13:38:58 -0500
In-Reply-To: <20110211182547.2ede69b5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/11/2011 1:25 PM, Alan Cox wrote:
>> When?  Is there any specific case you can think of?
> 
> Think about a raid volume where it is full disk and then the magic
> autolocking crap guesses wrong, the volume goes partly inaccessible while
> the box is running. Nasty mess.

So a whole disk raid volume that was built with a patched kernel that
always unlocked and therefore invaded the HPA gets upgraded and now the
array won't activate.  So now we have the intersection of two rare
configurations ( most people use partitions rather than the whole disk
), plus an upgrade.  Valid, but quite rare, and of course, they would
get the same problem if they ran the unpatched Linus kernel right now.
Seems to me this rare failure is the fault of using the patched kernel
and invading the HPA in the first place.

So you either leave the kernel as it is today and have this one problem,
or you patch it to always unlock, and get several other problems.
