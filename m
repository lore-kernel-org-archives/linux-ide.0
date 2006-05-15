From: Tejun Heo <htejun@gmail.com>
Subject: Re: question about boot time drive initialization
Date: Mon, 15 May 2006 22:52:36 +0900
Message-ID: <446887A4.1060904@gmail.com>
References: <4466DE81.2040006@gmail.com>	 <311601c90605140929s5fe919efk69c59bd5f61fee7d@mail.gmail.com>	 <4467DE65.7000701@gmail.com>	 <c70ff3ad0605150338j2f9aef2j40ced2c7e95594ed@mail.gmail.com>	 <4468611E.1000907@gmail.com> <c70ff3ad0605150608h60d69592uadb0abd7ee2eaf62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.204]:46780 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964907AbWEONwm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 09:52:42 -0400
Received: by nz-out-0102.google.com with SMTP id l8so29045nzf
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 06:52:41 -0700 (PDT)
In-Reply-To: <c70ff3ad0605150608h60d69592uadb0abd7ee2eaf62@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

saeed bishara wrote:
>> Hmmm.. weird.  That's not what I'm seeing.  AHCI reports command issue
>> failure if something goes wrong while transmitting D2H fis for a command
> you mean H2D, don't you?

Yeap.

>> (probably when it sees R_ERR).  If I issue SRST shortly after power-on,
>> AHCI fails SRST due to command issue failure.  So, it seems that the
>> device rejects SRST before it transmits the first FIS34.
> 
> there is also the possiblity that the AHCI doesn't issue the FIS34 as
> long as the BSY bit in the Status shadow register is set. so it's not
> the disk fault. I have taken a look at the AHCI spec, and found that
> you need to use the Commnad List Override (CLO) feature in order to
> send FIS while BSY is set. do you use that ?

AHCI driver does CLO if necessary before issuing SRST, so I don't think 
CLO is the issue here.

-- 
tejun
