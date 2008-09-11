From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4] libata: Implement disk shock protection support
Date: Thu, 11 Sep 2008 15:01:00 +0200
Message-ID: <48C9168C.4090101@gmail.com>
References: <87wshzplvk.fsf@denkblock.local>	<20080829211345.4355.89284.stgit@denkblock.local>	<48B913E6.1000104@gmail.com> <87k5dym5t9.fsf@denkblock.local>	<48BA638B.2030001@gmail.com> <87ej45mlp3.fsf@denkblock.local>	<48BA969C.4060207@gmail.com> <87abetmaap.fsf@denkblock.local>	<48BBA8D1.8020604@gmail.com> <87myirly1p.fsf@denkblock.local>	<48BC1BB8.2030007@gmail.com> <87fxoh0yil.fsf@denkblock.local>	<48BFA528.2040305@gmail.com> <87ej3zrf3o.fsf@denkblock.local>	<48C0F2F8.1040308@gmail.com> <87ej3snm3s.fsf@denkblock.local>	<48C7DC55.30002@gmail.com> <8763p3ol55.fsf@denkblock.local>	<48C82CB1.2070308@gmail.com> <871vzrogpz.fsf@denkblock.local>	<48C850AA.2030409@gmail.com> <87k5diq35g.fsf@denkblock.local> <48C91458.7090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:23441 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYIKNC2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Sep 2008 09:02:28 -0400
Received: by ti-out-0910.google.com with SMTP id b6so245309tic.23
        for <linux-ide@vger.kernel.org>; Thu, 11 Sep 2008 06:02:26 -0700 (PDT)
In-Reply-To: <48C91458.7090503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ah.. just one more thing.

I think it would be easier on the application if the written timeout
value is cropped if it's over the maximum instead of failing the
write.

Thanks.

-- 
tejun
