From: "Roland" <devzero@web.de>
Subject: Re: pata_winbond doesn`t unregister from sysfs - bug?
Date: Fri, 4 Jan 2008 23:07:18 +0100
Message-ID: <00f201c84f20$062d77d0$6b02a8c0@bui.materna.com>
References: <85735256@web.de> <20080104154917.6ba7c548@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:60305 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbYADWUu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 17:20:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

here you go!
http://bugzilla.kernel.org/show_bug.cgi?id=9687


----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <devzero@web.de>
Cc: <linux-ide@vger.kernel.org>; <bzolnier@gmail.com>
Sent: Friday, January 04, 2008 4:49 PM
Subject: Re: pata_winbond doesn`t unregister from sysfs - bug?


> On Fri, 04 Jan 2008 14:52:25 +0100
> devzero@web.de wrote:
>
>> Hi,
>>
>> this looks like a bug to me (see below)
>> happens on 2.6.24rc6 and i came across this by chance...
>>
>> i`m here on notebook with vmware only, so i cannot test if this happens 
>> on real hardware, too.
>> maybe someone can try "modprobe pata_winbond" twice and see if this is 
>> reproduceable....
>
> Thanks - can you put this in bugzilla and assign it to me so it doesn't
> get lost. That looks like the winbond driver isn't releasing resources
> somewhere 

