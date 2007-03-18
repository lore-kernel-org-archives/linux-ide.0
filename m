From: Tejun Heo <htejun@gmail.com>
Subject: Re: Loading both the pata_atiixp and the ahci driver causes problems
Date: Sun, 18 Mar 2007 14:41:15 +0900
Message-ID: <45FCD0FB.70507@gmail.com>
References: <45F9C3F5.4070906@redhat.com> <45F9F5F0.3090508@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:33304 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXCRFlV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 01:41:21 -0400
Received: by nz-out-0506.google.com with SMTP id s1so455260nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 22:41:21 -0700 (PDT)
In-Reply-To: <45F9F5F0.3090508@jonmasters.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Masters <jonathan@jonmasters.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Conke Hu <conke.hu@gmail.com>

Jon Masters wrote:
> Chuck Ebbert wrote:
> 
>> If you try to load both the pata_atiixp and the ahci driver
>> (for the same ATI SB600 adapter), very strange things happen.
>> The AHCI driver churns for three minutes or so, spewing
>> messages like this, then nothing works:
>>
>> <6>ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> <4>ata3.00: qc timeout (cmd 0xec)
>> <4>ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> 
>> Shouldn't it be able to tell the device has already been
>> claimed by some other driver?
> 
> One would assume it'd fail to grab the PCI IO ranges twice? I haven't
> looked at the code but I have seen this bug mentioned elsewhere so I
> might well end up having to do that yet :-)

Dunno much about sb600 but ahci and pata_atiixp are probably using
separate IO regions && separate PCI functions.

Conke, care to educate us a bit here?

-- 
tejun
