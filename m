From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: CF flash PATA on libata failure to attach
Date: Tue, 03 Jul 2007 14:13:50 +0800
Message-ID: <4689E91E.5090601@tw.ibm.com>
References: <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca> <46846b72.15588c0a.4c19.ffffeeb9@mx.google.com> <46846E3E.3010606@rtr.ca> <4684b61f.05358c0a.4c8f.30a5@mx.google.com> <20070629101733.GB25064@devserv.devel.redhat.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:59816 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbXGCGN7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 02:13:59 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l636Dw3F013880
	for <linux-ide@vger.kernel.org>; Tue, 3 Jul 2007 02:13:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l636DwGk256608
	for <linux-ide@vger.kernel.org>; Tue, 3 Jul 2007 00:13:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l636DvVc016880
	for <linux-ide@vger.kernel.org>; Tue, 3 Jul 2007 00:13:58 -0600
In-Reply-To: <20070629101733.GB25064@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>
Cc: Alan Cox <alan@redhat.com>, 'Mark Lord' <liml@rtr.ca>, linux-ide@vger.kernel.org, 'Tejun Heo' <htejun@gmail.com>

Alan Cox wrote:
> On Fri, Jun 29, 2007 at 05:34:36PM +1000, Andrew Hall wrote:
> 
>>Further to this the PATA to SATA bridge being used in this case is:
>>
>>http://www.jmicron.com/JM20330.html
>>
>>..as you will see only PIO and UDMA modes are supported.
> 
> 
> In which case their microcontroller in the middle should be masking ident
> bits. Without a way to detect the presence of the device I don't see an
> easy way for us to handle it automatically at all
> 

I didn't test whether MWDMA2 is supported by the JMicron bridge or not.
But I'm sure that the JMicron bridge doesn't mangle the IDENTIFY to
indicat anything about MWDMA unsupported:
(Previous test report:
http://www.spinics.net/lists/linux-ide/msg01514.html)

The Acard ARC-770 bridge from another vendor does mangle the IDENTIFY
data and indicates MWDMA unsupported as Alan advised.

Andrew, maybe you could test if such bridge works with your CF device.
(http://www.acard.com/english/fb0101.jsp?type1_idno=1&type2_idno=17)
--
albert

