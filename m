From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before slave_data
Date: Tue, 08 Feb 2011 16:38:28 +0300
Message-ID: <4D514754.30203@ru.mvista.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>	<20110208130701.19709cc6@lxorguk.ukuu.org.uk>	<AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com> <20110208132518.300bb098@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59010 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab1BHNjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 08:39:44 -0500
In-Reply-To: <20110208132518.300bb098@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 08-02-2011 16:25, Alan Cox wrote:

>>>> We may need to set SITRE before programming slave_data.

>>> Do you have a documentation cite for this or is it random fiddling with a
>>> driver you can't test ?

>> It is good to enable SITRE register before programming it and all
>> Intel controllers

> That sounds like someone quoting religion. Documentation cite please.

    SLC90E66 datasheet only says that SIDETIM register has no effect without 
SITRE bit set.

WBR, Sergei
