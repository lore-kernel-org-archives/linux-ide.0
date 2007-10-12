From: msundius@u1.netgate.com
Subject: Re: Re: AHCI: using bios after linux
Date: Fri, 12 Oct 2007 18:27:26 +0000 (GMT)
Message-ID: <20071012182726.37EFB4702DA@web2mail.com>
Reply-To: msundius@u1.netgate.com
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from texas4.legendum.com ([67.15.197.40]:43052 "EHLO web2mail.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbXJLS10 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Oct 2007 14:27:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: msundius@sundius.com, xuxiang_ins@yahoo.com, linux-ide@vger.kernel.org

--------------------------------------------------
Here is a message for you from http://web2mail.com
The easy way to read and send POP email on the web
--------------------------------------------------





> You want the chip docs for the specific AHCI controller you need to work

> with. For the Intel ones at least yo've got a chance to reconfigure them.

> However you will need to know what the BIOS expects.

> 

> You may well also find that if you use a BIOS that supports AHCI (and can

> set the controller to AHCI) you can use INT13 to talk to the controller

> in AHCI mode.

> 

> I don't think its a good idea, and I would be tempted to try and remove

> that set of calls and fire them via an application in Linux before

> calling kexec, but in theory yes you can probably put the device back

> into legacy mode.

> 

> Alan

> 

> 

Hi Alan,



Thanks for your reply. I'll just add a couple of requirements since I

didn't explain fully:



1) our goal is to use linux to do some pre Windows work and then set the 

machine down right at the piont where BIOS kicks off the MBR. i.e.

we want to be somewhat invisable to the whole boot process. Thus,

we really can't eliminate the BIOS calls, as the MBR and ntloader still

rely on BIOS.



2) as we are trying to sell this, we want it to work on all (or most)machines. 

so we have to support everything :]. Though, I guess Intel is a good

place to start.



3) related to #1 above, we want to be invisable. so we're not looking to

switch from AHCI (to legacy), we are looking to continue in whatever mode

the BIOS started in. Thus we just want BIOS to be able to handle int13 calls

after the Linux AHCI driver has run (this works when BIOS is setup in 

legacy mode initially).



I wonder if there is a way to query the state, pre-Linux, of the AHCI hardware

so that we could put it back, post-Linux; Or if it is a matter of

putting it in a "reset" state of somesort.. I just have not gotten far enough

to understad the hardware well enough to understand what things the 

BIOS might be confused about.



your suggestion of "you want the chip docs" is right on. I've seen the

ICHx data sheets, I'm wondering if there are any other docs such as app notes

or other (system) software manuals for that part? that is that the manual

that you are talking about? specifically could you point me to any other you

might know about?



Finally, I have been told that this is a bad idea before and to some extent

I agree with you. that's not really my descision tho, we're all just soldiers

in this fight arn't we :[



Thanks so much for your help.




