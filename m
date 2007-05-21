From: Jeff Garzik <jeff@garzik.org>
Subject: Re: something strange in libata-core.c for kernel 2.6.22-rc3
Date: Mon, 21 May 2007 05:41:40 -0400
Message-ID: <46516954.6030608@garzik.org>
References: <fa.MCe9nCgx+WnsHp+weZyM9LiDF0s@ifi.uio.no> <fa.rv8/6n3uBnAIoUHHNUW3eR7cJd8@ifi.uio.no> <fa.LXy58QwLlPXDhsfVUU9kEfA3QbI@ifi.uio.no> <fa.Ldjy2OubeKomZD0OV2gRm/wpUFo@ifi.uio.no> <46515983.6030206@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38781 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbXEUJlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 05:41:45 -0400
In-Reply-To: <46515983.6030206@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, l.genoni@oltrelinux.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Stupid BIOS crap like that is largely the reason why I am reluctant to 
merge pata_acpi.  There is a lot of knowledge like this yet to be 
discovered.

I would feel far more comfortable disassembling the AML like you are 
doing...

	Jeff



