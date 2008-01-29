From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Tue, 29 Jan 2008 11:28:13 -0500
Message-ID: <479F541D.1070800@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org>	 <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>	 <478DD615.1050309@garzik.org> <47944A51.2090504@gmail.com>	 <4796BCEB.1090207@garzik.org> <c70ff3ad0801290051r46ec047fg410d28e8093a8fe0@mail.gmail.com> <479F523A.2010807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51622 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754414AbYA2Q2S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 11:28:18 -0500
In-Reply-To: <479F523A.2010807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: saeed bishara <saeed.bishara@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> saeed bishara wrote:
>> Hi Jeff,
>>  what is the status of this patch?
>> I'd like to have this patch, and a second part that adds support for
>> the SoC devices, to be merged into 2.6.25. please note that my patch
>> collides with Mark's patches, I don't mind to rebase mine above Mark's
>> patches, but, in that case I need to wait till you ack the later ones.
>> right?
> ..
> 
> It would be great if you could do that, and it would help Jeff immensely.
> 
> I think Jeff is in Australia right now, at linux.conf.au for the week,
> so he is going to be slow responding to patches and stuff now.

Thanks for the backstop :)  Not in Australia, just learning to take 
weekends off, like my wife tells me to :)

BTW, in order to avoid having to resend the sata_mv NCQ patchset, I'm 
going to order that in front of saeed's patch.  At this point saeed's 
single patch is easier to rediff than a ~15 patch series, most certainly.

	Jeff




