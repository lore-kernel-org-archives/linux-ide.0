From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Thu, 12 Nov 2009 19:25:00 -0500
Message-ID: <4AFCA75C.8000101@pobox.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>	 <4AF8F363.3010806@rtr.ca> <200911101651.24912.bzolnier@gmail.com>	 <84144f020911100808y55f5bfa2v5c203b356583a7b5@mail.gmail.com>	 <4AFB3C9D.4020609@rtr.ca> <a4c8a6d00911111450y7e451071h3f0ede0a1003678b@mail.gmail.com> <4AFC9FEC.8030304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41371 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883AbZKMAZD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Nov 2009 19:25:03 -0500
In-Reply-To: <4AFC9FEC.8030304@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Thiago Farina <tfransosi@gmail.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/12/2009 06:53 PM, Mark Lord wrote:
> Thiago Farina wrote:
>> On Wed, Nov 11, 2009 at 8:37 PM, Mark Lord <liml@rtr.ca> wrote:
>>> Looks like unnecessary churn and obfuscation to me.
>>
>> Obfuscation? Are you saying that just because you wrote this code? So
>> what is the usage of a macro? I think you are having a defensive
>> position here.
> ..
>
> No, actually I believe Jeff wrote that particular line of code.

You know, Linus actually invented a command for people who enjoy this 
game...  ;)

	git blame drivers/ata/sata_mv.c

shows each line of code, and metadata about each line such as commit id 
and author name.

	Jeff




