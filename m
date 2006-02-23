From: "0602@eq.cz" <0602@eq.cz>
Subject: Re: regarding ata_piix initialization trouble
Date: Thu, 23 Feb 2006 11:41:17 +0100
Message-ID: <43FD914D.1020300@eq.cz>
References: <43FD6794.8020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cesky-hosting.cz ([81.0.238.178]:24282 "EHLO
	mail.cesky-hosting.cz") by vger.kernel.org with ESMTP
	id S1750968AbWBWKk2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Feb 2006 05:40:28 -0500
In-Reply-To: <43FD6794.8020902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun <htejun@gmail.com>
Cc: Jean-Fran?ois Stenuit <jfs@keytradebank.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun wrote:
> Hello, Jean & 0602.
> 
> I was digging ICH docs to reimplement ata_piix initialization and found 
> out that 6300ESB lists high bits (the present bits) of PCS register as 
> reserved. But they indiciate that the bits might change anytime just as 
> in other docs. I think something went wrong with those bits in that 
> particular chipset and Intel decided to ignore the bits.
> 
> I'm wondering whether your problems are related to this. Can you guys 
> please run 'lspci -n' on your machines which had the piix initialization 
> trouble and report the result here?
> 
> Thanks a lot.
> 

Hi,

here is the result:
00:00.0 Class 0600: 8086:3592 (rev 0c)
00:00.1 Class ff00: 8086:3593 (rev 0c)
00:02.0 Class 0604: 8086:3595 (rev 0c)
00:03.0 Class 0604: 8086:3596 (rev 0c)
00:1c.0 Class 0604: 8086:25ae (rev 02)
00:1e.0 Class 0604: 8086:244e (rev 0a)
00:1f.0 Class 0601: 8086:25a1 (rev 02)
00:1f.2 Class 0101: 8086:25a3 (rev 02)
00:1f.3 Class 0c05: 8086:25a4 (rev 02)
02:00.0 Class 0200: 11ab:4361 (rev 17)
03:07.0 Class 0100: 11ab:6081 (rev 07)
04:02.0 Class 0300: 1002:4752 (rev 27)
04:03.0 Class 0200: 8086:1076 (rev 05)

Regards,

r.
