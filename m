From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 10:37:14 +0900
Message-ID: <446A7E4A.1080003@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:24541 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751076AbWEQBhV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 21:37:21 -0400
Received: by wr-out-0506.google.com with SMTP id 70so400684wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 18:37:20 -0700 (PDT)
In-Reply-To: <446A88DF.5060705@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Ric Wheeler wrote:
> 
> (Trying to keep up ;-))
> 
> Is there still value in testing your last patch?
> 

The result should be the same, so it's not really necessary.  But, just 
in case, sticking that patch when you test the barrier would be nice so 
that things can be verified again.

Thanks for testing.

-- 
tejun
