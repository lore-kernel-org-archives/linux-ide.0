From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: not full working ata_piix
Date: Wed, 25 Nov 2009 07:16:19 -0500
Message-ID: <4B0D2013.8030901@pobox.com>
References: <931603659.20091125091656@gmx.de> <20091125104312.76d1b986@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57205 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758451AbZKYMQW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Nov 2009 07:16:22 -0500
In-Reply-To: <20091125104312.76d1b986@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gorgone <gorgone@gmx.de>, linux-ide@vger.kernel.org

On 11/25/2009 05:43 AM, Alan Cox wrote:
>>      00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller (rev 01)
>>      00:1f.2 0106: 8086:27c1 (rev 01)
>
> This should be handled by the AHCI driver under the SATA configuration
> options.

Agreed/correct.  Also, CONFIG_IDE needs to be disabled.

	Jeff




