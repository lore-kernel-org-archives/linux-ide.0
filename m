From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata drain fifo on stuck DRQ HSM violation
Date: Fri, 28 Sep 2007 02:48:28 -0700
Message-ID: <46FCCDEC.20200@gmail.com>
References: <46CFA08E.6090604@arbores.ca>	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>	<46DBCB6C.8080206@gmail.com>	<20070905095327.6277d054.akpm@linux-foundation.org>	<46DEE617.4050004@rtr.ca>	<46E0A253.7060803@gmail.com>	<46E154DE.2060602@rtr.ca>	<46FB563A.80108@gmail.com> <20070927193701.6230d77f@the-village.bc.nu> <46FC3D7D.90009@gmail.com> <46FC3FDD.5060201@pobox.com> <46FC423C.2050206@gmail.com> <46FC7B72.2030103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:24145 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758058AbXI1JuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 05:50:11 -0400
Received: by an-out-0708.google.com with SMTP id d31so437573and
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 02:50:11 -0700 (PDT)
In-Reply-To: <46FC7B72.2030103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> Drain up to 512 words from host/bridge FIFO on stuck DRQ HSM violation,
> rather than just getting stuck there forever.
> 
> Signed-Off-By:  Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
