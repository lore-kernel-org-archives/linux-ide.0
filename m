From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: question about boot time drive initialization
Date: Mon, 15 May 2006 16:08:32 +0300
Message-ID: <c70ff3ad0605150608h60d69592uadb0abd7ee2eaf62@mail.gmail.com>
References: <4466DE81.2040006@gmail.com>
	 <311601c90605140929s5fe919efk69c59bd5f61fee7d@mail.gmail.com>
	 <4467DE65.7000701@gmail.com>
	 <c70ff3ad0605150338j2f9aef2j40ced2c7e95594ed@mail.gmail.com>
	 <4468611E.1000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:15728 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932398AbWEONIc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 09:08:32 -0400
Received: by wr-out-0506.google.com with SMTP id i32so844031wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 06:08:32 -0700 (PDT)
In-Reply-To: <4468611E.1000907@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> Hmmm.. weird.  That's not what I'm seeing.  AHCI reports command issue
> failure if something goes wrong while transmitting D2H fis for a command
you mean H2D, don't you?

> (probably when it sees R_ERR).  If I issue SRST shortly after power-on,
> AHCI fails SRST due to command issue failure.  So, it seems that the
> device rejects SRST before it transmits the first FIS34.

there is also the possiblity that the AHCI doesn't issue the FIS34 as
long as the BSY bit in the Status shadow register is set. so it's not
the disk fault. I have taken a look at the AHCI spec, and found that
you need to use the Commnad List Override (CLO) feature in order to
send FIS while BSY is set. do you use that ?
