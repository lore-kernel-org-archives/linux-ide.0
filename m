From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Very old IDE hard drive (240 MB) detected as 1.1 TB
Date: Sat, 14 Feb 2009 22:35:18 +0000 (GMT)
Message-ID: <alpine.LFD.1.10.0902142228410.651@ftp.linux-mips.org>
References: <200902131428.40212.hanno@hboeck.de> <499584FC.2050104@gmail.com> <200902141352.24277.hanno@hboeck.de> <4996C563.9090900@ru.mvista.com> <4996D443.4060103@rtr.ca> <alpine.LFD.1.10.0902141526310.651@ftp.linux-mips.org>
 <4996E924.3060600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([213.58.128.207]:36094 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZBNWfT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 17:35:19 -0500
Received: from localhost.localdomain ([127.0.0.1]:34987 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S20578371AbZBNWfS (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Sat, 14 Feb 2009 22:35:18 +0000
In-Reply-To: <4996E924.3060600@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark Lord <liml@rtr.ca>, =?ISO-8859-15?Q?Hanno_B=F6ck?= <hanno@hboeck.de>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

Hi Sergei,

> > not explicit about how words 57 and 58 were meant to be ordered and some
> > manufacturers interpreted it one and some the other way.
> 
>   However, the drive vendors should've really thought better before reporting
> capacity in *middle-endian* format. :-)

 Oh, come on!  Don't accuse everyone of thinking.  Besides, someone had to 
try that reverse-pdp-endian mode, didn't they? ;)

  Maciej
