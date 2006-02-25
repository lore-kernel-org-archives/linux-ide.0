From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] sata_sil: clean up and add errata/workaround documentation
Date: Sat, 25 Feb 2006 17:07:15 -0500
Message-ID: <4400D513.2010309@pobox.com>
References: <11408431501105-git-send-email-htejun@gmail.com> <4400074F.3020005@pobox.com> <44000914.4050207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:23440 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751876AbWBYWHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2006 17:07:19 -0500
In-Reply-To: <44000914.4050207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, hellan@acm.org, Carlos.Pardo@siliconimage.com, Raymond.Liu@siliconimage.com

Tejun Heo wrote:
> Hmmm... I don't know. You know I'm not a big fan of docbook docs mainly 
> because of accessibility. It's your call. Anyways, it would be nice to 
> keep up-to-date information regarding libata hardware quirks in some 
> easily-accessible place (wiki?).

The docbook docs are a great place to keep such information, since they 
are archived all over the place, available even to disconnected users.

It is quite easy to do "make htmldocs" and get that posted on 
linux-ata.org, if people would like...

	Jeff


