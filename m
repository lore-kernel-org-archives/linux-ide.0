From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Tue, 17 Jan 2006 15:19:47 +0100
Message-ID: <43CCFD03.2060605@keyaccess.nl>
References: <200601131909.07981.pvrusb2@toplitzer.net> <58cb370e0601170517v6fe68992ma5bdc67d5eb1e6f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:41380 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932510AbWAQOSb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jan 2006 09:18:31 -0500
In-Reply-To: <58cb370e0601170517v6fe68992ma5bdc67d5eb1e6f1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Helmut Toplitzer <pvrusb2@toplitzer.net>, linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

Bartlomiej Zolnierkiewicz wrote:

> On 1/13/06, Helmut Toplitzer <pvrusb2@toplitzer.net> wrote:

>> I've got a question about a small experiment I made:
>> I tried to find out the transfer-rate of my hd by useing
>> hdparm -t /dev/hda
>> and got changing transferrates starting from
>>
>> 37MB/s with CPU not utilized
>> 55MB/s with CPU 100% utilized

[ ... ]

>> 22MB/s with ehci-hcd loaded and a device already initilized
>> 55MB/s with ehci-hcd loaded and CPU 100% utilized
>> (see log1/log2)
> 
> As discussed in this thread:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111765523627674&w=2
> 
> It seems that the problem is caused by flakey USB chipset
> thus IDE folks cannot do much about it, sorry.

Indeed. It seems VIA EHCI controllers are quite simply terminally 
broken. And Helmut is also seeing problems with a soundcard.

Helmut, I believe it would be better if you could try the first of these 
tests without the VIA USB2 controller even plugged in and then see if 
you still get that effect.

(Bartlomiej, note by the way that in my case it's not a VIA southbridge 
but an AMD756, although I believe that might be quite similar to old VIA 
southbridges in so far as that VIA looked at that one)

>> So it looks like CPU/USB/IDE is in some interaction. Any
>> ideas what to do against this. My current kernel is
>> 2.6.15

As said, if you can be bothered, taking the VIA EHCI controller out of 
the picture would be interesting. Personally, I only experience the 
throughput drop with ehci-loaded and in use or used, fixed by unloading 
ehci-hcd so I can't test more than that, but I wouldn't be terribly 
surprised if completely taking out the USB controller would solve other 
problems as well. As clear by now, that chip is doing some _very_ 
strange things to the bus.

Rene.
