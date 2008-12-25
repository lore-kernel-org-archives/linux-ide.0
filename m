From: Badalian Vyacheslav <slavon@bigtelecom.ru>
Subject: Re[retry]: Red leds at harddisk bays on SR1530HSH after update to
 2.6.27.x
Date: Thu, 25 Dec 2008 09:34:49 +0300
Message-ID: <49532989.5090508@bigtelecom.ru>
References: <494A34CA.9030906@bigtelecom.ru> <20081219223246.b0aea84d.akpm@linux-foundation.org> <494EF9A1.90002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.bigtelecom.ru ([87.255.0.61]:53185 "EHLO
	mail.bigtelecom.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYLYGex (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Dec 2008 01:34:53 -0500
In-Reply-To: <494EF9A1.90002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


>> (cc linux-ide)
>>
>> On Thu, 18 Dec 2008 14:32:26 +0300 Badalian Vyacheslav <slavon@bigtelecom.ru> wrote:
>>
>>     
>>> Hello all.
>>> After update from 2.6.26 to 2.6.27 all leds at drive bays now red.
>>> SATA controller in AHCI mode.
>>> Platform is Intel SR1530HSH
>>>
>>> Config attached.
>>>
>>> Any patches for test? Any ideas? Any other info needed? Or i must go to
>>> bugtracker? ;)
>>>       
>
> Does ahci.ahci_em_messages=0 help?
>
>   

No. All leds is turned off. No green led at bay with hard disk.
