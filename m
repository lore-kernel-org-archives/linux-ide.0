From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Serial ATA (SATA) for Linux status report
Date: Wed, 03 Dec 2003 18:51:42 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FCE770E.8090309@pobox.com>
References: <20031203204445.GA26987@gtf.org> <1070494030.15415.111.camel@slurv.pasop.tomt.net> <3FCE737C.1080105@pobox.com> <20031203234907.GA4184@tron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8867 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262491AbTLCXv7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Dec 2003 18:51:59 -0500
In-Reply-To: <20031203234907.GA4184@tron.at>
List-Id: linux-ide@vger.kernel.org
To: Othmar Pasteka <pasteka@kabsi.at>
Cc: linux-ide@vger.kernel.org

Othmar Pasteka wrote:
> hi,
> 
> On Wed, Dec 03, 2003 at 06:36:28PM -0500, Jeff Garzik wrote:
> 
>>Alas, there is no hotplug support in the ICH5 or ICH5-R SATA hardware.
>>
>>One could argue there is "coldplug" support in that hardware -- disable 
>>the entire interface, including any active devices, then re-enable and 
>>re-scan -- but it's a bit of a hack.  If there's enough demand, I could 
>>write some code for that.  It would involve something like
>>
>>	# /sbin/sata off
>>	{ plug in or remove a device }
>>	# /sbin/sata on
>>
>>You really, really, really don't want to actually unplug a SATA drive 
>>while it's active, on ICH5 hardware.
> 
> 
> are there chipsets which support SATA hot plugging? afaik sata is
> supposed to be hotplugable.


_Most_ SATA chipsets support hotplugging.  ICH5 is unique in that it 
does not.

	Jeff



