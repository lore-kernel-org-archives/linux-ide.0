From: Gary Poppitz <poppitzg@iomega.com>
Subject: new sata_sis.c file
Date: Mon, 28 Feb 2005 08:31:08 -0700
Message-ID: <1834e00e828e13c6c43b5dd98fd1f4c6@iomega.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Received: from email-mx1.iomega.com ([147.178.1.72]:40078 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261655AbVB1QDL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 11:03:11 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id 8B4A519A0
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 09:03:10 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id 7FFE56D5
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 16:03:10 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Looks like SIS updated their sata_sis.c file but did not bother to  
update its revision level. Jeff, would you add this to the current dev  
build?



Begin forwarded message:

> From: "Dan Greve" <grevedan@hotmail.com>
> Date: February 25, 2005 9:59:52 AM MST
> To: poppitzg@iomega.com, linux-ide@vger.kernel.org
> Subject: RE: Secondary port on SiS 965
>
> I've been successful in using both ports on the 965L rev 01  
> controller, currently running a 2.6.11-rc3 patched kernel.  What  
> version of sata_sis.c are you using?
>
> I'm using the latest sata_sis.c (v 0.5) driver from SIS available at
>
> http://download.sis.com/download_step2.php? 
> id=155881&agree=1&country=USA
>

