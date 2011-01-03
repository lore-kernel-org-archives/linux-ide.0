From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Mon, 03 Jan 2011 14:30:07 -0500
Message-ID: <4D2223BF.8090901@canonical.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:54772 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1ACTaL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 14:30:11 -0500
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1PZq6b-0003sV-Jn
	for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 19:30:09 +0000
Received: from c-75-67-45-93.hsd1.nh.comcast.net ([75.67.45.93] helo=[192.168.15.4])
	by hutte.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <peter.petrakis@canonical.com>)
	id 1PZq6b-0006nc-DP
	for linux-ide@vger.kernel.org; Mon, 03 Jan 2011 19:30:09 +0000
In-Reply-To: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

On 12/30/2010 10:58 AM, Greg Freemyer wrote:
> All,
> 
> Per T13/1699-D Revision 4a (from May 2007) word 217 of the identify
> block should be populated with a "1" to identify non-rotating media.
> 
> http://www.t13.org/Documents/UploadedDocuments/docs2007/D1699r4a-ATA8-ACS.pdf
> 
> Does anyone know if that is a reliable field?
> 
> Specifically there are two separate issues:
> 
> 1) Are all devices reporting a 1 in field 217 non-rotating?
> 2) Are all production non-rotating devices populating that field with a 1.
> 
> Is there some other reliable mechanism for identifying a SSD?
> 

Not really, the manufacturer needs to adhere to the spec they're claiming
to honor and we should politely notify them when we find that it's inconsistent.
It's technically a firmware bug if it's ATA-8 and that bit isn't set right.

If you're having trouble identifying SSDs pre ATA-8, you can use this simple
patch I introduced a while back.

http://www.spinics.net/lists/linux-ide/msg38944.html

and blacklist the offending drive into reporting itself as SSD when interrogated
via SCSI.

If you search around, you'll find an earlier thread about quirking SSDs by using
heuristics like search for the word "flash" in the device name and other hints but
the patch set never went anywhere. It's a ugly problem, there's so many devices
out there ahead of the spec that are SSD, with no sure fire way to determine that
they really are. Supporting a full blacklist of them would turn libata-core.c into
a dumping ground for potentially 100s of pre ATA-8 storage devices. I don't think
anyone wants to maintain that.

Peter
