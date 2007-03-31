From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/4] libata: Limit max sector to 240 for TORiSAN DVD drives
Date: Sat, 31 Mar 2007 16:28:21 +0900
Message-ID: <460E0D95.7070006@gmail.com>
References: <460E08AF.8070900@tw.ibm.com> <460E0BF4.2010701@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:41086 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbXCaH22 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 03:28:28 -0400
Received: by wr-out-0506.google.com with SMTP id 76so943183wra
        for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 00:28:28 -0700 (PDT)
In-Reply-To: <460E0BF4.2010701@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> patch 3/4:
>   The TORiSAN drive locks up when max sector == 256.
>   Limit max sector to 240 for TORiSAN DRD-N216 drives.
>   (http://bugzilla.kernel.org/show_bug.cgi?id=6710)
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
