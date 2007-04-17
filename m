From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Tue, 17 Apr 2007 18:09:32 +0400
Message-ID: <4624D51C.8090107@ru.mvista.com>
References: <200704142011.l3EKBBhf025590@harpo.it.uu.se>	<462136AF.9060505@ru.mvista.com> <20070417150725.1f675995@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:60225 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S964935AbXDQOIf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 10:08:35 -0400
In-Reply-To: <20070417150725.1f675995@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

>>>CMD64x is an established name, while PCI-xxx is something
>>>I've never heard of (and it sounds awfully generic).

>>   Specs are available from http://gkernel.sourceforge.net/specs/ -- you can see the names on the first pages.
 
> End users don't read the specs, they read the box, and they seem to have
> been marketed as CMD PCI-064x. So at least keep the CMD in the name so
> people know what is what and can work out the pointless name change

   I wonder how often they look into /proc/ide/cmd64x for starters? :-)

MBR, Sergei
