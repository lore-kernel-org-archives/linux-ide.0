From: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: What's in libata-dev.git
Date: Tue, 12 Sep 2006 10:42:58 +0200
Message-ID: <45067312.7020900@aitel.hist.no>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <4505694D.5020304@garzik.org> <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751338AbWILIqV@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 11 Sep 2006, Jeff Garzik wrote:
>
>   
>> Sergei Shtylyov wrote:
>>     
>>>    It's not likely I'll be able to try it. But I'm absolutely sure that
>>> drive aborted the read commands with the sector count of 0 (i.e. 256
>>> actually). The exact model was IBM DHEA-34331.
>>>    255 sectors actually seems more safe bet.
>>>       
>> This sort of thing should be handled by quirks, depending on the controller
>> and drive.
>>     
>
> Please don't play games with peoples data-safety.
>
> It ios absolutely INCORRECT to think that "things should work as 
> documented, let's fix it up with quirks".
>   
How about a simple and harmless test?
When an IDE disk is accessed for the first time, perhaps when
the partition table is read - issue a 256-sector read and see
what happens.  If it works - fine.  If not, tag the thing as
supporting max 255 sectors.

No wrecking of file systems, and full performance for
the vast majority.

Helge Hafting
