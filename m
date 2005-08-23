From: Fabian Knittel <fabian.knittel@avona.com>
Subject: Re: Problems with Promise SATAII TX4
Date: Tue, 23 Aug 2005 14:58:06 +0200
Message-ID: <430B1D5E.9070201@avona.com>
References: <20050330001007.GA16954@cebitec.uni-bielefeld.de> <430404A5.7060000@avona.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.rz.uni-karlsruhe.de ([129.13.185.217]:25829 "EHLO
	smtp1.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S932161AbVHWM6R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Aug 2005 08:58:17 -0400
Received: from fsi-pc1.fsmi.local ([10.14.1.1]:43218 ident=Debian-exim)
	by fsmi-s1.fs.uni-karlsruhe.de with esmtp (Exim 4.50 #1 (Debian))
	id 1E7YLp-0001mp-7F
	for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2005 14:58:01 +0200
Received: from fsi-cl224.fsmi.local ([10.14.1.224]:32804 helo=am-nb01.am.local)
	by fsi-pc1.fsmi.local with esmtp (Exim 4.50 #1 (Debian))
	id 1E7YLP-00021o-BV
	for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2005 14:57:35 +0200
Received: from [127.0.0.1] (helo=[127.0.0.1])
	by am-nb01.am.local with esmtp (Exim 3.35 #1 (Debian))
	id 1E7YLv-0000vu-00
	for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2005 14:58:07 +0200
In-Reply-To: <430404A5.7060000@avona.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I wrote:
> I'm experiencing problems with my Promise SATAII TX4 controller, quite
> similar to what Kim reported a few months ago.
> 
> Using a fresh linux-2.6.12.5 upstream kernel to boot into a rescue shell
> (so there's no distribution specific stuff going on, nothing else
> loaded, etc.), I can access my three connected Maxtor 120GB drives just
> fine, as long as I do so individually.
[...]
>>Attached devices:
>>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>  Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
>>  Type:   Direct-Access                    ANSI SCSI revision: 05
>>Host: scsi1 Channel: 00 Id: 00 Lun: 00
>>  Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
>>  Type:   Direct-Access                    ANSI SCSI revision: 05
>>Host: scsi3 Channel: 00 Id: 00 Lun: 00
>>  Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
>>  Type:   Direct-Access                    ANSI SCSI revision: 05

OK, apparently it's somewhat hardware related after all. I've added a
Seagate drive (Model: ST3120827AS, Rev: 3.42) and reading from this
drive together with two of the Maxtor drives (any two of the three)
currently works without problems (for now).

Switching ports and cables doesn't change anything, so it's not related
to that.

But how can that be? The individual drives don't reveal any problems and
(as reported in my previous mail) the drives worked seamlessly for a few
weeks ...

I'll have to do some more testing and this is probably off-topic by now,
so I'll stop with the noise now.

Fabian
