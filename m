From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: libata equivalent for hdX=remap63
Date: Sun, 02 Sep 2007 16:18:50 +0600
Message-ID: <46DA8E0A.2020503@ums.usu.ru>
References: <46DA73B5.5010107@ums.usu.ru> <20070902104645.0c6b291c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4.usu.ru ([194.226.235.39]:54461 "EHLO relay4.usu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157AbXIBKRm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2007 06:17:42 -0400
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 8A3A517F38
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 16:20:16 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id D441217F38
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 16:20:14 +0600 (YEKST)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 74C2BA7EBA
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 16:17:38 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 08E62A7E95
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 16:17:38 +0600 (YEKST)
In-Reply-To: <20070902104645.0c6b291c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Mauelshagen@RedHat.com

Alan Cox wrote:
> On Sun, 02 Sep 2007 14:26:29 +0600
> "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
>
>   
>> Hello,
>>
>> sorry if this is a FAQ, but googling for "libata remap63" gives nothing 
>> useful.
>>
>> Some old computers need software like "Ontrack Disk Manager" in order to 
>> see large disks in the other OS. The way to deal with such setup in 
>> Linux was to add "hdX=remap63" to the kernel arguments. However, I 
>> cannot find the equivalent of this option in the new libata-based 
>> drivers. Could you please show how to migrate such systems to libata 
>> without removing the disk manager?
>>     
>
> The remap63 hack is ancient. Since the kernel acquired device mapper its
> also unneccessary as you can use device mapper to set up a 63 sector
> offset volume.
>
> I'm amazed anyone is still using it but the right way to handle it on a
> vaguely modern system isn't more kernel hacks but to teach dmraid to
> handle it. If you've got an example of what the layout looks like
> (especially if there is a way to autodetect it) then talk to Heinz (cc'd)
> about getting it added to dmraid.
>   

Thanks Alan,

this is actually not my system, but a system of a user of my Live CD. I 
already asked him to mail me the first megabyte of his hard disk, but 
let me wait 24 hours for a reply. Would this information be enough for 
adding support for this into dmraid?

As for autodetection, I am really not sure. The user says that kernels 
prior to 2.5.70 had this autodetection built-in.

-- 
Alexander E. Patrakov
