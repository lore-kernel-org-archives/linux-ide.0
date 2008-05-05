From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: Add Intel SCH PATA Support
Date: Mon, 05 May 2008 19:01:24 +0400
Message-ID: <481F2144.5000409@ru.mvista.com>
References: <20080505172356.636649e6@dxy.sh.intel.com>	<481EE284.2010708@ru.mvista.com> <20080505224420.44730838@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41070 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754380AbYEEPB6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 May 2008 11:01:58 -0400
In-Reply-To: <20080505224420.44730838@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alek Du wrote:

>>>(US15W, US15L, UL11L) PATA controller support.

>>    From the Intel's documentation I got the impression that the part numbers
>>start with AF82 (82 being the usual Intel's chip number prefix).

> From documents I got, no 82xxx part number assigned. The formal names for SCH are
> just like US15W, US15L and UL11L.

    Look into the spec. update, "Identification Information" section.

>>    You shouldn't enable prefetch for ATAPI deives I think -- look at what
>>ata_piix does...

> Why? 

    Prefetch usually doesn't work with ATAPI devices since the prefetch logic 
operates in units of 512-byte sectors and not all ATAPI data transfers are a 
multiple of 512 bytes.

MBR, Sergei
