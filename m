From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: 2.6.17-rc4 + libata-pata Oops while reloading pata_amd module
Date: Fri, 26 May 2006 13:39:06 +0800
Message-ID: <4476947A.3020003@tw.ibm.com>
References: <20060524165006.GC12022@harddisk-recovery.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:36027 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030476AbWEZFjQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 May 2006 01:39:16 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4Q5dFed010218
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 01:39:15 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4Q5dFCM186250
	for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 23:39:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4Q5dEDu028252
	for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 23:39:15 -0600
In-Reply-To: <20060524165006.GC12022@harddisk-recovery.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, rene.herman@keyaccess.nl, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>

Erik Mouw wrote:
> Hi Alan,
> 
> I got this Oops while reloading the pata_amd module:
> 
<snip>
> 
> The machine is an Asus A7M266-D dual Athlon board with only a single
> CPU installed running Debian stable on NFS root.
> 
> How to recreate:
> 
> - Fully modular scsi and libata, root on NFS
> - rmmod pata_amd
> - modprobe pata_amd
> 
> Works with any drive I've tried.
> 
> 

Hi Erik,

Unicorn Chang (on cc list) is working on a patch for this problem.
Will submit the patch later.

--
albert

