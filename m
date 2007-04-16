From: aps21121@comcast.net
Subject: Driver update for CentOS 4.4 2.6.9.-42.0.10
Date: Mon, 16 Apr 2007 21:55:28 +0000
Message-ID: <041620072155.3617.4623F0D00008BD1400000E212200737478CECDCECECD9C9F0E@comcast.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:55525 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030981AbXDPVza (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2007 17:55:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

PS 
Sorry forgot to send a subject with my last email

A little more info:
For the default CentOS4.4 kernel (2.6.9.-42.0.10) kept up2date using yum
from dmesg: libata version is  1.20

for latest kernel.org 
libata version is 2.00

so to reword questions:
1)  How would I use the latest CentOS 4.4 (2.6.9.x kernel)
    but also add the ;atest fixes in libata version 2.0

2) Any chance CentOS will include the latest libata 2.0 in normal kernel updates
    so I could just run "yum update kernel*"
   instead of compiling a  custom kernel

Thanks again for your time,
Al Smith



 -------------- Original message ----------------------
From: aps21121@comcast.net
> Dear Mr Garzik,
> 
> Thanks so much for all the time(unpaid?) 
> you've put in developing drivers
> 
> My problems specifically concerns a Promise ESATA 300 TX2plus
> which is bundled with the Seagate 300GB eSATA drive 
> -easily available via CompUSA and major reatailers.
> (If Seagate doesn't hire you - they are crazy!)
> 
> I'm running CentOS4.4 with latest kernel updates
> currently 2.6.9-42.0.10EL
> 
> I've seen other people with same timeout problems
> but after compiling the latest kernel 2.6.20.7,
> I get no more errors, so I know you've been busy fixing it
> -but also get other errors (not concerning the drive or you're fixes)
> 
> Problem is how to I apply whatever fixes you've made
> to the latest CentOS4.4 2.6.9-42.0.10 kernel
> since I can't run my custom 2.6.20.7 kernel yet
> 
> 1) Will CentOS(RedHat - equiv)  be upgrading their kernel to
>    include you're fixes in the current 2.6.9-x kernel?
> 
> 2)Can you give me a link or howto on using the latest
>  CentOS 4.4 kernel but also adding whatever fixes you've made
> 
> Thanks,
> Al Smith

