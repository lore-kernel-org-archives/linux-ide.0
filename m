From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Sun, 07 Oct 2007 23:55:32 -0300
Message-ID: <47099C24.3010504@mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-01.mandic.com.br ([200.225.81.132]:54431 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbXJHDCX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 23:02:23 -0400
Received: from 200-203-34-74.paemt705.dsl.brasiltelecom.net.br (HELO [192.168.1.33]) (48XWxNa1pNTK2sTAy2aVop5Ok6I=@[200.203.34.74])
          (envelope-sender <renatoyamane@mandic.com.br>)
          by smtp-01.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 8 Oct 2007 02:55:42 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: miquels@cistron.nl

Hi for all,
I use Kernel 2.6.22.9 with CFS-v22 patch under Debian Etch.

I cc Miquel because he is commented in man page of shutdown utilitie.

When I shutdown my laptop, I see some warnings after "Will be halt now". 
This message is something about "Spindown error" (this message is very 
fast and I can't read all warnings, and don't found it on logs).

I read in www.linux-ata.org/shutdown.html that is about shutdown utilitie.

So, my questions is:
- This is dangerous? Can damage something?
- How can I help to fix this warning?

I use ata_piix, and please keep me on cc because I don't subscribe this 
mail list.

Regards,
Renato
