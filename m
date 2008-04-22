From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Wed, 23 Apr 2008 00:00:12 +0900
Message-ID: <480DFD7C.2030206@gmail.com>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi> <480DE3C4.5@ru.mvista.com> <480DE6F5.8060403@gmail.com> <480DE9E8.2070809@ru.mvista.com> <480DEB1F.5060500@gmail.com> <480DF7B7.9030000@rtr.ca> <480DF876.7070800@gmail.com> <480DF9BD.1080104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.243]:27812 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169AbYDVPAd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 11:00:33 -0400
Received: by ag-out-0708.google.com with SMTP id 35so3350205aga.10
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2008 08:00:33 -0700 (PDT)
In-Reply-To: <480DF9BD.1080104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
>> Ah.. that means we have the whole naming thing wrong.  Yewwww....
> ..
> 
> I suppose.   If we were needlessly pedantic, then perhaps
> the libata-bmdma.c should be renamed to libata-sff.c,
> and the libata-sff.c should be renamed libata-tf.c
> 
> But there's probably been a document or two since then,
> where the SFF folks have documented the TF interfaces, too.

Fingers and toes and whatever else crossed.

> So.. whatever.  :)

Yeah, that's the spirit.  :-)

-- 
tejun
