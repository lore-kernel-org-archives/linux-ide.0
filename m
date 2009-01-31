From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.29-rc libata sff 32bit PIO regression
Date: Sat, 31 Jan 2009 19:57:17 +0300
Message-ID: <498482ED.9090800@ru.mvista.com>
References: <Pine.LNX.4.64.0901211322010.15945@blonde.anvils>	<20090126191151.18b094e6@lxorguk.ukuu.org.uk>	<49846A36.5000708@ru.mvista.com> <20090131160601.5159579d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36927 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752447AbZAaQ5Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 11:57:24 -0500
In-Reply-To: <20090131160601.5159579d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Jeff Garzik <jgarzik@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>> +	if (pdev->device == PCI_DEVICE_ID_AMD_VIPER_7411) /* FIFO is broken */
>>> +		fifo = 0;
>>> +
>>> +	/* On the later chips the read prefetch bits become no-op bits */
>>> +	pci_read_config_byte(pdev, 0x41, &r);
>>> +	r &= ~fifobit[ap->port_no];
>>>   
>>>       
>>   Why not:
>>
>>        r &= ~fifo;
>>     
>
> Because then it wouldn't clear the bits if they were set already and we
> wanted them off!
>   

   Ah, missed the modification of 'fifo'... :-<

MBR, Sergei


