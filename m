From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: How to mount a CD created on Vista?
Date: Mon, 19 May 2008 22:58:14 +0100
Message-ID: <4831F7F6.9090909@superbug.co.uk>
References: <482598B7.9020402@superbug.co.uk> <4825C0CB.3010109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:2771 "EHLO
	anchor-post-36.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764236AbYESV6Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 17:58:16 -0400
In-Reply-To: <4825C0CB.3010109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lasse Makholm <lasse.makholm@gmail.com>
Cc: linux-ide@vger.kernel.org

Lasse Makholm wrote:
> James Courtier-Dutton wrote:
>> Hi,
>>
>> I have places a sample CD image at the following URL.
>> It just has test files on it so anyone can copy it to test.
>> I would like linux to be able to mount these types of CDs.
>>
>> http://james.dutton.googlepages.com/vista-cd-test.iso
>>
>> Can anyone help
> 
> It's probably a UDF 2.5 image...
> 
> See this post:
> http://www.linuxquestions.org/questions/linux-general-1/reading-dvd-burnt-with-vista-614956/#post3061599 
> 
> 
> There are patches available:
> http://sourceforge.net/tracker/?group_id=295&atid=300295
> 
> Whether or not that'll do the trick, I don't know...
> 
> /Lasse
> 

Unfortunately not. I tried the patch, but the kernel just complains with:
[ 1160.223615] attempt to access beyond end of device
[ 1160.223622] loop0: rw=0, want=1260, limit=1256
[ 1160.223645] attempt to access beyond end of device
[ 1160.223650] loop0: rw=0, want=1260, limit=1256
[ 1160.223666] UDF-fs: No partition found (1)



The .iso has text in it like the following:
OSTA Compressed Unicode
OSTA UDF Compliant
UDF Virtual Partition
UDF Volume Set

In case that helps at all.



