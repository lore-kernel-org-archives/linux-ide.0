From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 11:58:33 -0500
Message-ID: <479F5B39.1000708@garzik.org>
References: <200801272122.21823.gene.heskett@gmail.com> <200801281413.21347.gene.heskett@gmail.com> <20080129074127.5699afcf.valdyn@gmail.com> <200801291004.12565.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55158 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbYA2Q6f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 11:58:35 -0500
In-Reply-To: <200801291004.12565.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Florian Attenberger <valdyn@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Gene Heskett wrote:
> Does anyone know why my dvdwriter isn't being assigned a '/dev/sdx' number 
> when dmesg says its found ok at ata2.00?  I've turned on an option that says 
> something about using the bios for device access this build, but I'll be 
> surprised if that's it. :)

I think you mean /dev/scdx not /dev/sdx.  Make sure you have the 'sr' 
driver compiled and load (CONFIG_BLK_DEV_SR).

The bios-for-dev-access thing definitely won't help, and may hurt (by 
taking over the device you wanted to test).

	Jeff


