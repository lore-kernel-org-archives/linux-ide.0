From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA_SIL on IXP425 workaround
Date: Thu, 21 Jan 2010 00:00:02 -0500
Message-ID: <4B57DF52.2030906@garzik.org>
References: <m33a4nfvva.fsf@intrepid.localdomain>	<201001141659.19687.bzolnier@gmail.com>	<20100114192210.62593ead@lxorguk.ukuu.org.uk>	<201001142129.38781.bzolnier@gmail.com> <20100114210050.2c99c2b1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751404Ab0AUFAP@vger.kernel.org>
In-Reply-To: <20100114210050.2c99c2b1@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 01/14/2010 04:00 PM, Alan Cox wrote:
>> I think that you misinterpreted the issue -- according to Krzysztof MMIO
>> works just fine, only 8/16-bit MMIO reads are a problem (please note that
>> using mixed PIO/MMIO access is still a win over pure PIO access and also
>> that sata_sil doesn't support pure non-MMIO operations currently)..
>
> Have we got timing measurements to prove that ?
>>
>> However if it gets fixed in the upstream kernel in some other way I'll
>> simply drop the patch during the next re-base of my tree (I just collect
>> ATA stuff that looks useful/interesting to me and which otherwise may
>> become lost)..
>
> And that's a good thing. The question was aimed at Krzysztof. Really we
> need to keep platform specific weirdness out of core drivers or the
> rapidly turn into a mess.

The lack of 8-/16-byte MMIO access is unfortunately not limited to 
Krzysztof's platform.  Other people have reported the same problem 
specifically with sata_sil (see the archives).

If the driver cannot be converted to all-32-bit accesses, we will need 
to do something like Krzysztof's patch.

	Jeff
