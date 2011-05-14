From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Sat, 14 May 2011 15:01:31 -0400
Message-ID: <4DCED18B.1070801@garzik.org>
References: <1303673315.5231.9.camel@mulgrave.site> <1305306118.2611.62.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1305306118.2611.62.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: linux-ide@vger.kernel.org

On 05/13/2011 01:01 PM, James Bottomley wrote:
> On Sun, 2011-04-24 at 14:28 -0500, James Bottomley wrote:
>> currently libata-sff is completely ignoring the enabled/disabled status
>> of the interfaces.  This is a real problem on parisc because if you
>> touch a non responding memory area (i.e. a disabled interface) you crash
>> the box.
>>
>> Fix by checking the CNTRL bits to see if the port is enabled before
>> trying to poke it.
>
> Ping on this.
>
> Since 1/2 is an essential fix to prevent a boot panic on parisc, I can
> just take them through the parisc tree.

It's in libata-dev.git#upstream and #NEXT (linux-next) at present.

	Jeff



