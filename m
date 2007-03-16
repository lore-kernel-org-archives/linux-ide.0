From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 10:33:49 -0400
Message-ID: <45FAAACD.9000902@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	<45F56800.3040104@rtr.ca>	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	<45F5A523.1080500@rtr.ca>	<45FA8D7A.3040504@rtr.ca> <20070316150129.5bd65c9d@lxorguk.ukuu.org.uk> <45FAA692.8080507@rtr.ca> <45FAA86C.5080607@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:3673 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964978AbXCPOdv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:33:51 -0400
In-Reply-To: <45FAA86C.5080607@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
> Mark Lord wrote:
>
>> Ugh.  The drives default to 520 bytes (always),
> 
>    The old IDE drives used to have 4 and 7 byte ECC (seen in ancient 
> Phoenix BIOS).

Yes -- 4-bytes means a 520-byte transfer when using 16-bit words.

The ATA standard specifies a default of 520 bytes,
or a SETFEATURES command to enable a different length.

Here it is from ATA-1:

> 9.9.8 Word 22: ECC bytes available on read/write long commands
> 
> If the contents of this field are set to a value other than 4, the only way
> to use this information is via the Set Features commands.

And again from ATA-3:

> Section 2.1.7:  ... The default length of the vendor specific bytpes associated
> with the READ LONG and WRITE LONG commands is four bytes, but may be changed
> by use of the SET FEATURES command.

It helps to verify stuff like this.   The best ways to do
that are (1) to read the specs, and (2) actually implement
and test the code using both ancient and modern drives on
multiple controllers.  All of which has been done here.

Cheers
