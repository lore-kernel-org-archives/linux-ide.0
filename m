From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Via SATA not working here
Date: Tue, 14 Sep 2004 23:57:35 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41474D2F.6060201@wasp.net.au>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au> <20040914094336.GG18257@uvt316-2.ruk.cuni.cz> <311601c90409140803aaa4d31@mail.gmail.com> <20040914175448.GK18257@uvt316-2.ruk.cuni.cz> <4147331A.8040907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:53704 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S269725AbUINT53 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 15:57:29 -0400
In-Reply-To: <4147331A.8040907@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michal 'hramrach' Suchanek <hramrach@centrum.cz>, Eric Mudama <edmudama@gmail.com>, f@uvt316-2.ruk.cuni.cz, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> ahhhhhh, that may be a clue.  If you are attaching a PATA drive via a 
> bridge, that is very different from attaching a SATA drive, in terms of 
> field behavior across the controller spectrum.
> 
> There are limitations on bridges.  Does Brad Campbell's patch (attached) 
> work for you?
> 

I doubt it, thats why I had him compile up and test on a 2.6.5 kernel :p(
Sounds like a similar but different incompatibility.


Brad
