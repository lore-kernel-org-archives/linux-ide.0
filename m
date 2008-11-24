From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ata_pio_need_iordy vs. CF spec. V4.1
Date: Mon, 24 Nov 2008 22:02:46 +0300
Message-ID: <492AFA56.9010508@ru.mvista.com>
References: <492AE6FA.5000809@caviumnetworks.com> <20081124174521.491e727b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:6487 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751682AbYKXTCt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 14:02:49 -0500
In-Reply-To: <20081124174521.491e727b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Daney <ddaney@caviumnetworks.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:

>>Table 22 on page 51 of CF Specification Rev. 4.1 indicates that iordy is 
>>not supported in PIO5 and PIO6.  This seems to be in conflict with the 
>>code in ata_pio_need_iordy, which asserts that it is mandatory in any 
>>mode greater than PIO2.

>>Which is correct?  Or am I misreading something?

> The ATA spec says that modes > PIO2 requires IORDY

> The CFI spec does indeed say PIO5/6 do not use IORDY so probably you
> should tweak that function at least for CFA devices.

    Only for them because there probably used to be PIO5 hard disks in the 
wild and they hardly ignored IORDY...

> Alan

MBR, Sergei
