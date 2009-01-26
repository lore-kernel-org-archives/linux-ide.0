From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Switching from (deprecated) IDE driver -> SATA (PATA support)
Date: Tue, 27 Jan 2009 02:36:40 +0300
Message-ID: <497E4908.9060705@ru.mvista.com>
References: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan> <20090125110742.4ba54c0b@lxorguk.ukuu.org.uk> <alpine.DEB.1.10.0901250705300.6888@p34.internal.lan> <alpine.DEB.1.10.0901250715030.10379@p34.internal.lan> <20090126220210.GB26064@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:7460 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752966AbZAZXgr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 18:36:47 -0500
In-Reply-To: <20090126220210.GB26064@csclub.uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, xfs@oss.sgi.com

Hello.

Lennart Sorensen wrote:

>> It comes with one :)
>> # xfs_admin -u  /dev/sdd2
>> UUID = 77ae4251-631f-4656-a365-c5723f5c5da8
>>
>> Will try to use this to boot; however, I'd prefer the labels over the 
>> UUID, wish there was an easy way to set it.
>>     
>
> I prefer UUIDs.
>
> Much mroe likely to have the same label on multiple drives than the same
> UUID.

   For example, CentOS 4.3 went crazy in such case, being unable to 
mount anything but root IIRC.

MBR, Sergei


