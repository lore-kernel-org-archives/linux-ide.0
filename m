From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiS 180 pata
Date: Mon, 05 Jul 2004 09:43:57 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E95B1D.3080501@pobox.com>
References: <200407051253.47003.ivololeribar@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266096AbUGENoM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2004 09:44:12 -0400
In-Reply-To: <200407051253.47003.ivololeribar@yahoo.it>
List-Id: linux-ide@vger.kernel.org
To: Nicola <ivololeribar@yahoo.it>
Cc: uwe.koziolek@gmx.net, linux-ide@vger.kernel.org

Nicola wrote:
> I have tried to mount it under every possible hd device, as well as sd one.
> I have also read /usr/src/linux/Documentation/ide.txt and tried with various
> ide2=... combinations at boot time, without success.
> 
> 
> Now I'm quite confused. Does the sata_sis module covers only the sata side 

Correct...   as the name implies.

You need to add PCI ids to the SIS IDE driver.

	Jeff



