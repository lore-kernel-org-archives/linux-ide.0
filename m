From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
Date: Mon, 15 Aug 2005 16:17:10 -0400
Message-ID: <4300F846.8030404@emc.com>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com> <4300E83F.1090401@emc.com> <20050815200637.GA15871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:48531 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S964933AbVHOUPD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Aug 2005 16:15:03 -0400
In-Reply-To: <20050815200637.GA15871@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>

Greg KH wrote:
>>Hmm, I did build it before submitting, saw not even a warning.  So I 
>>just rebuilt it again to verify, and same thing.  Why would my tree work 
>>and not yours?  config file?
> 
> 
> You don't have MSI enabled in yours :(

Yup, you're right.  Sorry about that.  The patch I sent @15:23 today 
should be all set now.

BR
