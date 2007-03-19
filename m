From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Tue, 20 Mar 2007 00:02:03 +0100
Message-ID: <45FF166B.8000303@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:59811 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965388AbXCSXCQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 19:02:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1424400uga
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 16:02:14 -0700 (PDT)
In-Reply-To: <45FE7DCC.3000507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

Hi Sergei,

Well, I checked pata_pdc2027x.c code and found that code completely 
rewrited. For unexperienced user it is not so easy to apply.


Yarema


>    There used to be Albert's patch enabling ATAPIT DMA in this driver:
> 
>    http://marc.info/?l=linux-ide&m=111027913608663
> 
> Oh my, that was 2 years ago, and all slipped thru the cracks... :-)

